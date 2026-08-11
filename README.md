# Mini ERP + CRM Operations Portal

Full-stack case-study implementation for a wholesale/distribution company. Built with Node.js, TypeScript, Express.js, PostgreSQL, REST APIs, React, HTML, CSS and TypeScript.

## Modules
- JWT authentication with Admin, Sales, Warehouse and Accounts roles
- Customer CRM: CRUD, search, details, follow-up notes
- Product & inventory: CRUD, low-stock alerts, stock movement log
- Sales challans: draft/confirm/cancel, automatic number, multi-product lines, stock validation, product snapshots
- Responsive admin dashboard
- Input validation, HTTP status codes, pagination and filtering
- Docker setup and Postman collection

## Architecture
React SPA -> Express REST API -> PostgreSQL

The backend uses service-style route handlers and PostgreSQL transactions for stock-changing challan confirmation. Environment variables contain secrets/configuration.

## Local setup
### 1. Database
Create PostgreSQL database `mini_erp_crm` and run `backend/sql/schema.sql`, then `backend/sql/seed.sql`.

### 2. Backend
```bash
cd backend
cp .env.example .env
npm install
npm run dev
```
API: `http://localhost:5000/api`

### 3. Frontend
```bash
cd frontend
cp .env.example .env
npm install
npm run dev
```
Frontend: `http://localhost:5173`

## Demo credentials
All seeded accounts use password `Password@123`.
- admin@example.com — Admin
- sales@example.com — Sales
- warehouse@example.com — Warehouse
- accounts@example.com — Accounts

## Production build
Backend: `npm run build && npm start`  
Frontend: `npm run build` and deploy `frontend/dist` to Vercel/Netlify/Render Static Site.

## Deployment
Recommended free setup from the case study: PostgreSQL on Neon/Supabase/Render, backend on Render/Railway/Fly.io, frontend on Vercel/Netlify/Render Static Site. Add the environment variables from each `.env.example` in the hosting dashboard. AWS deployment is optional per the assignment.

## Environment variables
Backend: `PORT`, `DATABASE_URL`, `JWT_SECRET`, `CORS_ORIGIN`  
Frontend: `VITE_API_URL`

## API documentation
Import `docs/postman_collection.json` into Postman. Authentication uses `Authorization: Bearer <token>`.

## Assumptions / limitations
- GST is stored as an optional customer field; tax calculation was not specified, so challans calculate quantity/value only.
- PDF invoice and S3 image upload are not implemented because they are bonus features.
- Role permissions are intentionally simple and mapped to business areas in the brief.
