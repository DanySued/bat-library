-- BAT Library — Supabase schema
-- Project: bat-library (connect via VITE_SUPABASE_URL / VITE_SUPABASE_ANON_KEY)

-- ─── Tables ────────────────────────────────────────────────────────────────────

create table if not exists downloads (
  tool_id  text primary key,
  count    integer not null default 0
);

create table if not exists saved_tools (
  user_id  uuid    not null references auth.users(id) on delete cascade,
  tool_id  text    not null,
  primary key (user_id, tool_id)
);

-- ─── RPC ───────────────────────────────────────────────────────────────────────

-- Called by DownloadsContext.recordDownload() on every download click.
-- Upserts a row for the tool and increments the count atomically.
create or replace function increment_download(p_tool_id text)
returns void language plpgsql as $$
begin
  insert into downloads (tool_id, count)
  values (p_tool_id, 1)
  on conflict (tool_id)
  do update set count = downloads.count + 1;
end;
$$;

-- ─── Row-Level Security ────────────────────────────────────────────────────────

-- downloads: anyone can read; only the RPC (service role) writes
alter table downloads enable row level security;
create policy "Public read downloads"  on downloads for select using (true);

-- saved_tools: users can only see/modify their own rows
alter table saved_tools enable row level security;
create policy "Users read own saves"   on saved_tools for select using (auth.uid() = user_id);
create policy "Users insert own saves" on saved_tools for insert with check (auth.uid() = user_id);
create policy "Users delete own saves" on saved_tools for delete using (auth.uid() = user_id);

-- ─── Auth providers (configured in Supabase dashboard) ─────────────────────────
-- Email/password: enabled
-- Google OAuth:   enabled  (redirectTo: window.location.origin)
-- GitHub OAuth:   enabled  (redirectTo: window.location.origin)
