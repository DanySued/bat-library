/**
 * One-time script to create the `tools` table in Supabase.
 * Run with: SUPABASE_SERVICE_KEY=<your-secret-key> node scripts/create-tools-table.mjs
 *
 * Get your secret key from:
 * https://supabase.com/dashboard/project/hhnxglovthqxansfafeo/settings/api
 * (it starts with sb_secret_ or eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...)
 */

const url = 'https://hhnxglovthqxansfafeo.supabase.co'
const key = process.env.SUPABASE_SERVICE_KEY

if (!key) {
  console.error('Missing SUPABASE_SERVICE_KEY env var.')
  console.error('Usage: SUPABASE_SERVICE_KEY=<key> node scripts/create-tools-table.mjs')
  process.exit(1)
}

const sql = `
create table if not exists tools (
  id               text primary key,
  name             text not null,
  cat              text not null,
  desc             text not null,
  require_admin    boolean not null default false,
  icon             text not null default 'Terminal',
  explanation      text not null default '',
  what_it_does     text[] not null default '{}',
  how_to_use       text[],
  cautions         text[] not null default '{}',
  risk_score       smallint not null default 1 check (risk_score between 1 and 5),
  downloads_seed   integer not null default 0,
  preview          jsonb,
  bat_content      text,
  sort_order       integer not null default 0,
  created_at       timestamptz not null default now()
);

alter table tools enable row level security;

do $$ begin
  if not exists (select 1 from pg_policies where tablename = 'tools' and policyname = 'Public read tools') then
    create policy "Public read tools" on tools for select using (true);
  end if;
  if not exists (select 1 from pg_policies where tablename = 'tools' and policyname = 'Admin insert tools') then
    create policy "Admin insert tools" on tools for insert with check ((auth.jwt() ->> 'email') = 'danysued@gmail.com');
  end if;
  if not exists (select 1 from pg_policies where tablename = 'tools' and policyname = 'Admin update tools') then
    create policy "Admin update tools" on tools for update using ((auth.jwt() ->> 'email') = 'danysued@gmail.com');
  end if;
  if not exists (select 1 from pg_policies where tablename = 'tools' and policyname = 'Admin delete tools') then
    create policy "Admin delete tools" on tools for delete using ((auth.jwt() ->> 'email') = 'danysued@gmail.com');
  end if;
end $$;
`

const res = await fetch(`https://api.supabase.com/v1/projects/hhnxglovthqxansfafeo/database/query`, {
  method: 'POST',
  headers: {
    'Authorization': `Bearer ${key}`,
    'Content-Type': 'application/json',
  },
  body: JSON.stringify({ query: sql }),
})

const body = await res.json().catch(() => res.text())
if (res.ok) {
  console.log('✓ tools table created successfully')
} else {
  console.error('✗ Failed:', JSON.stringify(body, null, 2))
  process.exit(1)
}
