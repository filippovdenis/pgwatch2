select /* pgwatch2_generated */
  (extract(epoch from now()) * 1e9)::int8 as epoch_ns,
  numbackends,
  xact_commit,
  xact_rollback,
  blks_read,
  blks_hit,
  tup_returned,
  tup_fetched,
  tup_inserted,
  tup_updated,
  tup_deleted,
  conflicts,
  temp_files,
  temp_bytes,
  deadlocks,
  blk_read_time,
  blk_write_time,
  extract(epoch from (now() - pg_postmaster_start_time()))::int8 as postmaster_uptime_s,
  checksum_failures,
  extract(epoch from (now() - checksum_last_failure))::int8 as checksum_last_failure_s,
  case when pg_is_in_recovery() then 1 else 0 end as in_recovery_int,
  system_identifier::text as tag_sys_id,
  session_time::int8,
  active_time::int8,
  idle_in_transaction_time::int8,
  sessions,
  sessions_abandoned,
  sessions_fatal,
  sessions_killed
from
  pg_stat_database, pg_control_system()
where
  datname = current_database();
