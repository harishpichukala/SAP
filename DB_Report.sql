select id,start_time,end_time,status,sum(b_Size) as "Size in GB" from (select c.backup_id as id ,c.sys_start_time as start_time,c.sys_end_time as end_time,c.state_name as status,round(f.backup_size/1024/1024/1024,2) as b_Size
from m_backup_catalog_files f, m_backup_catalog c where
f.source_type_name in ('volume','topology') and f.service_type_name in ('indexserver','nameserver','xsengine')
and c.backup_id = f.backup_id
and c.entry_type_name in ('complete data backup','incremental data backup')
order by f.backup_id desc) group by id,start_time,end;