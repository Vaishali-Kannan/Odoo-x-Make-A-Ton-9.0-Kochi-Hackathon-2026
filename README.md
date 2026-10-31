# Brightloop – Full-Stack SaaS Subscription Management System

Brightloop is a production-oriented, full-stack Subscription Management and Recurring Billing SaaS platform built with **Next.js (App Router)**, **TypeScript**, **Tailwind CSS**, **shadcn/ui**, **Supabase PostgreSQL**, and **Vercel Cron**.

---

## 🌟 Key Features

1. **Multi-Role Access Control (RBAC):**
   - **Admin:** Complete system configuration, staff account provisioning, catalog pricing, tax/GST rules, discount coupons, financial reporting, and audit telemetry.
   - **Staff:** Daily operational execution—customer management, quotation proposals, subscription activations, invoice tracking, and manual payment collection.
   - **Customer:** Dedicated self-service portal to browse plans, request quotations, view active subscriptions, download GST invoice PDFs, and inspect payment receipts.

2. **Automated Recurring Billing Engine (Vercel Cron):**
   - Scheduled endpoint: `/api/cron/recurring-billing` protected via `CRON_SECRET`.
   - Calendar-aware date arithmetic supporting daily, weekly, monthly, quarterly, and annual billing intervals with leap year and month-end clamping.
   - Strict period idempotency—prevents duplicate invoice generation.
   - Records execution audit events in `billing_events`.

3. **Dynamic Product & Variant Pricing:**
   - Multi-tier product variants (e.g. Basic Edition ₹0, Odoo Connector Pro ₹560, Enterprise ₹1,000).
   - Real-time calculation: `Final Unit Price = Base Product Price + Variant Additional Price`.

4. **Statutory Tax & GST Calculation:**
   - Centralized tax calculation service supporting CGST (9%), SGST (9%), IGST (18%), and Zero-Rated export rules.
   - Snapshot rate and amount stored directly on invoice lines so historical records remain immutable.

5. **Invoice Lifecycle & Automatic Overdue Detection:**
   - Real-time status transitions: `Draft` → `Confirmed` → `Partially Paid` → `Paid` → `Overdue` → `Cancelled`.
   - Automatic overdue marking when invoices pass due dates with an unpaid balance.
   - Clean printable tax invoice preview and PDF download.

6. **Payment Reconciliation & Gateway Ready:**
   - UPI, Net Banking, Credit Card, and Cheque payment collection.
   - Atomic balance decrements and automated status updates.
   - Idempotent payment webhook endpoint ready for Razorpay / Stripe (`/api/payments/webhook`).

---

## 🛠️ Technology Stack

- **Frontend:** Next.js (App Router), React, TypeScript, Tailwind CSS, Lucide React, Recharts.
- **Backend:** Next.js Server-Side Route Handlers, Zod Validation, Supabase SSR & Service Role Client.
- **Database:** Supabase PostgreSQL with 23 normalized tables, RLS policies, foreign keys, triggers, and seed data.
- **Automation:** Vercel Cron Jobs (`vercel.json`), Vitest test suite.

---

## 📁 Project Architecture & Folder Structure

```
brightloop/
├── supabase/
│   ├── migrations/
│   │   └── 20240101000000_init_brightloop_schema.sql  # All 23 Tables, RLS, Indexes, Triggers
│   ├── seed.sql                                      # Production-grade seed data
│   └── config.toml                                   # Supabase project configuration
├── src/
│   ├── app/
│   │   ├── (auth)/                                   # /login, /register, /forgot-password
│   │   ├── admin/                                    # Admin dashboard & 13 management modules
│   │   ├── staff/                                    # Staff operational console & sub-modules
│   │   ├── portal/                                   # Customer self-service portal
│   │   └── api/                                      # Next.js REST API route handlers
│   ├── components/
│   │   ├── ui/                                       # Reusable Button, Card, Input, Badge, Modal
│   │   ├── layout/                                   # AppShell, Multi-role Sidebar, TopNav
│   │   ├── tables/                                   # Client DataTable with search/pagination
│   │   └── dashboard/                                # Recharts financial analytics, KPI Cards
│   ├── lib/
│   │   ├── supabase/                                 # Browser, Server, and Admin clients
│   │   ├── db/mock-store.ts                          # High-fidelity data store fallback
│   │   ├── validations/                              # Zod input validation schemas
│   │   └── utils/                                    # Calendar billing arithmetic & currencies
│   ├── services/                                     # Core business logic layer
│   └── types/                                        # TypeScript database & API models
├── tests/
│   └── business-logic.test.ts                        # Vitest business rules test suite
├── vercel.json                                       # Vercel daily recurring billing cron
├── .env.example                                      # Environment variables template
└── package.json
```

---

## 🚀 Getting Started Locally

### 1. Install Dependencies
```bash
npm install
```

### 2. Configure Environment Variables
Copy `.env.example` to `.env.local`:
```bash
cp .env.example .env.local
```

### 3. Run Unit & Business Logic Tests
Run the 13 automated business logic tests:
```bash
npm test
```

### 4. Start Development Server
```bash
npm run dev
```
Open [http://localhost:3000](http://localhost:3000) in your browser.

---

## 👥 Demo Personas (One-Click Sign-In on /login)

| Role | Email | Scope |
|---|---|---|
| **Admin** | `admin@brightloop.io` | Full system, Staff invites, Tax rules, System Settings |
| **Staff** | `staff@brightloop.io` | Quotes, Subscriptions, Invoices, Payment collections |
| **Customer** | `customer@acmecorp.com` | Self-Service Portal, Plan upgrades, Invoices & receipts |

---

## ☁️ Vercel Deployment Guide

1. Push the repository to GitHub.
2. In Vercel, import the repository as a Next.js project.
3. Configure the Production Environment Variables in Vercel:
   - `NEXT_PUBLIC_APP_URL`: Your production domain
   - `NEXT_PUBLIC_SUPABASE_URL`: Your Supabase Project URL
   - `NEXT_PUBLIC_SUPABASE_ANON_KEY`: Your Supabase Anonymous Key
   - `SUPABASE_SERVICE_ROLE_KEY`: Your Supabase Service Role Key (Server-only secret)
   - `CRON_SECRET`: Random secure token for Vercel Cron authentication
4. Deploy the project. The scheduled Vercel Cron configured in `vercel.json` will execute daily at `00:00 UTC`.
