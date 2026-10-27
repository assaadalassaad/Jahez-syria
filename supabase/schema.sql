-- Run this script in Supabase SQL Editor for the Jahez project.
create extension if not exists pgcrypto;
create table if not exists public.service_listings (
 id uuid primary key default gen_random_uuid(),
 title text not null check (char_length(title) between 1 and 100),
 category text not null,
 city text not null,
 description text default '',
 phone text not null,
 price text,
 created_at timestamptz not null default now()
);
create table if not exists public.service_requests (
 id uuid primary key default gen_random_uuid(),
 title text not null check (char_length(title) between 1 and 100),
 category text not null,
 city text not null,
 description text default '',
 phone text not null,
 created_at timestamptz not null default now()
);
alter table public.service_listings enable row level security;
alter table public.service_requests enable row level security;
drop policy if exists "Public can read listings" on public.service_listings;
create policy "Public can read listings" on public.service_listings for select to anon, authenticated using (true);
drop policy if exists "Public can create listings" on public.service_listings;
create policy "Public can create listings" on public.service_listings for insert to anon, authenticated with check (true);
drop policy if exists "Public can read requests" on public.service_requests;
create policy "Public can read requests" on public.service_requests for select to anon, authenticated using (true);
drop policy if exists "Public can create requests" on public.service_requests;
create policy "Public can create requests" on public.service_requests for insert to anon, authenticated with check (true);
grant select, insert on public.service_listings to anon, authenticated;
grant select, insert on public.service_requests to anon, authenticated;
