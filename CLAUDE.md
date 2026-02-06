# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Rails 8.1.2 blog application with Ruby 4.0.1. Uses SQLite3, Puma web server, and modern Rails conventions (Stimulus, Turbo, Propshaft asset pipeline).

## Common Commands

```bash
bin/setup              # Install dependencies, prepare database, start server
bin/dev                # Start development server
bin/rails test         # Run all tests
bin/rails test test/models/post_test.rb           # Run single test file
bin/rails test test/models/post_test.rb:10        # Run single test at line
bin/rails test:system  # Run browser/system tests
bin/ci                 # Full CI suite (rubocop, brakeman, bundler-audit, tests)
bin/rubocop            # Linting (Omakase style)
bin/brakeman           # Security analysis
```

## Architecture

**Models and Relationships:**
- `User` has_many `:sessions`, `:posts` (bcrypt authentication)
- `Post` belongs_to `:user`, `:post_category`; has_many `:comments`; has_rich_text `:body`
- `PostCategory` has_many `:posts` (name, pattern columns)
- `Comment` belongs_to `:post`; broadcasts_to `:post` (real-time ActionCable updates)
- `Session` belongs_to `:user` (tracks ip_address, user_agent)

**Post State Machine (AASM):**
- States: `pending` (initial) → `cancelled`, `rejected`, `approved` → `achieved`
- Events: `cancel`, `reject`, `approve`, `achieve`

**Routes:**
- `resources :posts` with nested `resources :comments`
- `resources :post_categories`
- `resource :session` (singular)
- `resources :passwords, param: :token`
- Root: `posts#index`

**Frontend Stack:**
- Importmap (no Node.js build step)
- Stimulus for JavaScript interactivity
- Turbo for SPA-like navigation
- ActionText for rich text editing

## Testing

Uses Minitest with parallel execution. Test helpers in `test/test_helpers/`. Fixtures in `test/fixtures/`.

Key test directories: `test/models/`, `test/controllers/`, `test/system/`

## Code Style

Rubocop with Omakase Rails styling (strict, opinionated). Run `bin/rubocop` before committing.
