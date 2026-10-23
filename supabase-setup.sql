-- Run once in Supabase > SQL Editor
create table projects(id uuid primary key default gen_random_uuid(),title text not null,description text,category text,image_url text,image_path text,created_at timestamptz default now());
create table site_content(key text primary key,value text);
create table messages(id uuid primary key default gen_random_uuid(),name text,email text,message text,created_at timestamptz default now());
alter table projects enable row level security;alter table site_content enable row level security;alter table messages enable row level security;
create policy "public read projects" on projects for select using(true);
create policy "owner write projects" on projects for all to authenticated using(true) with check(true);
create policy "public read content" on site_content for select using(true);
create policy "owner write content" on site_content for all to authenticated using(true) with check(true);
create policy "anyone sends message" on messages for insert to anon,authenticated with check(true);
create policy "owner reads messages" on messages for select to authenticated using(true);
create policy "owner deletes messages" on messages for delete to authenticated using(true);
insert into storage.buckets(id,name,public) values('portfolio','portfolio',true);
create policy "public view files" on storage.objects for select using(bucket_id='portfolio');
create policy "owner upload files" on storage.objects for insert to authenticated with check(bucket_id='portfolio');
create policy "owner delete files" on storage.objects for delete to authenticated using(bucket_id='portfolio');
