perform set_config('lock_timeout', lock_timeout, false); -- 	50ms or so
for i in 1..max_attempts loop
	begin
		execute 'alter table t1 add column n1 int8';
		ddl_completed := true;
		exit;
	exception when lock_not_available then
		raise notice 'ALTER attempts: #% failed', i;
	end;
end loop;
