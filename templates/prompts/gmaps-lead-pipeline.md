# Prompt: Google Maps lead generation pipeline

Paste this prompt to have Claude Code build the complete GMaps lead scraping +
contact enrichment pipeline from scratch. It encodes all the learnings from a real
production build — edge cases, schema, deduplication, error rates, cost targets.

---

## The prompt

```
Build me an end-to-end Google Maps lead generation pipeline with these specs:

## Goal
Scrape businesses from Google Maps, enrich each with deep contact extraction from
their websites, and save to a Google Sheet that grows over time with deduplication.

## Architecture

### Layer 1: Google Maps scraping
- Use Apify actor `compass/crawler-google-places` (APIFY_API_TOKEN in .env)
- Accept dynamic search queries: "plumbers in Austin TX"
- Accept --limit parameter for number of results
- Return: name, address, phone, website, rating, reviews, place_id, google_maps_url

### Layer 2: Website contact extraction
For each business with a website:
1. HTTP fetch main page (use httpx, not requests)
2. Convert HTML to markdown (html2text library)
3. Fetch up to 5 additional pages matching these patterns (priority order):
   /contact, /about, /team, /contact-us, /about-us, /our-team, /staff, /people,
   /meet-the-team, /leadership, /management, /founders, /who-we-are, /company,
   /meet-us, /our-story, /the-team, /employees, /directory, /locations, /offices
4. Search DuckDuckGo HTML for `"{business name}" owner email contact` and include
   snippets + first relevant result page
5. Combine all content, send to Claude Haiku for structured extraction

### Layer 3: Claude extraction schema
```json
{
  "emails": ["all email addresses found"],
  "phone_numbers": ["all phone numbers"],
  "addresses": ["physical addresses"],
  "social_media": {
    "facebook": "url or null",
    "twitter": "url or null",
    "linkedin": "url or null",
    "instagram": "url or null",
    "youtube": "url or null",
    "tiktok": "url or null"
  },
  "owner_info": {
    "name": "owner/founder name",
    "title": "their position",
    "email": "direct email",
    "phone": "direct phone",
    "linkedin": "personal linkedin"
  },
  "team_members": [{"name", "title", "email", "phone", "linkedin"}],
  "business_hours": "operating hours",
  "additional_contacts": ["WhatsApp, Calendly, etc."]
}
```

### Layer 4: Google Sheets integration
- gspread with OAuth credentials (credentials.json exists)
- Create sheet with headers on first run, append to existing via --sheet-url
- Deduplication: lead_id = MD5 hash of "name|address"
- Track metadata: scraped_at, search_query, pages_scraped, search_enriched,
  enrichment_status

## Technical requirements

### Error handling
- ~10-15% of sites return 403/503 — handle gracefully, save lead with GMaps data
  only
- Facebook URLs always return 400 — skip them in web search results
- Some sites have broken DNS — catch and mark as error
- Claude sometimes returns dicts instead of strings (business_hours, etc.) — use a
  stringify_value() helper

### Performance
- ThreadPoolExecutor for parallel website enrichment (default 3 workers)
- Max 5 contact pages per site
- Truncate content to 50K chars before sending to Claude
- Use DuckDuckGo HTML search (html.duckduckgo.com/html/) — free, doesn't block

### Output schema (36 columns)
lead_id, scraped_at, search_query, business_name, category, address, city, state,
zip_code, country, phone, website, google_maps_url, place_id, rating, review_count,
price_level, emails, additional_phones, business_hours, facebook, twitter, linkedin,
instagram, youtube, tiktok, owner_name, owner_title, owner_email, owner_phone,
owner_linkedin, team_contacts, additional_contact_methods, pages_scraped,
search_enriched, enrichment_status

## File structure
- execution/scrape_google_maps.py       — standalone GMaps scraper
- execution/extract_website_contacts.py — standalone website contact extractor
- execution/gmaps_lead_pipeline.py      — main orchestration script
- directives/gmaps_lead_generation.md   — documentation

## CLI interface
```bash
# Basic
python3 execution/gmaps_lead_pipeline.py --search "plumbers in Austin TX" --limit 10

# Append to existing sheet
python3 execution/gmaps_lead_pipeline.py \
    --search "roofers in Austin TX" --limit 50 \
    --sheet-url "https://docs.google.com/spreadsheets/d/..."
```

## Build loop (important)
Build iteratively with real testing:
1. Build Google Maps scraper, test with --limit 3
2. Build website contact extractor, test on a single URL
3. Build orchestration pipeline, test end-to-end with --limit 5
4. Fix bugs (there will be edge cases)
5. Run full test with --limit 10

Do NOT just write code and stop. Run it, observe errors, fix them, iterate until:
- The command runs without errors
- 10 leads appear in the Sheet with populated contact fields
- Running the same command again shows "No new leads to add (all duplicates)"
- The directive documents all learnings

## Cost targets
- Apify: ~$0.01–0.02 per business
- Claude Haiku: ~$0.002 per extraction
- Total: ~$0.015–0.025 per lead

Now build it.
```
