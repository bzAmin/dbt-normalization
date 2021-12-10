{{ config(materialized='table') }}
{{ config(schema='silver') }}


with source_data as (

    select 
        t.gid as task_id,
        t.name as task_name,   
        s.name as priority,
        s.color

    from {{ref('backlog_asana_priority_listed_staging')}} s 
        left join {{ref('backlog_asana_tasks_staging')}} t 
        on s._airbyte_backlog_asana_tasks_hashid = t._airbyte_backlog_asana_tasks_hashid


)

select *
from source_data

