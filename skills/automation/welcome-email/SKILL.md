---
name: welcome-email
description: Send welcome email sequence to new clients. Use when user asks to send welcome emails, onboard new client with emails, or trigger welcome sequence.
allowed-tools: Bash, Read, Write, Edit, Glob, Grep
---

# Welcome Client Emails

## Goal
Send a 3-email welcome sequence from three different team members when a new client signs.

## Scripts
- `./scripts/welcome_client_emails.py` - Send welcome sequence

## Process
1. Receive client info (name, email, company)
2. Send email from founder/lead (welcome, expectations)
3. Send email from technical lead (technical setup)
4. Send email from support lead (support intro)

## Usage

```bash
python3 ./scripts/welcome_client_emails.py \
  --client_name "John Doe" \
  --client_email "john@company.com" \
  --company "Acme Corp"
```

## Email Structure
Each email is personalized with client details and sent from different team members to establish relationships.
