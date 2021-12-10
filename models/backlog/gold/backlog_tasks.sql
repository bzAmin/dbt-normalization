{{ config(materialized='table') }}
{{ config(schema='gold') }}


with source_data as (

    select
        distinct
        t.gid as gid,
        t.name as name,
        p.name as project,
        s.name as section,
        t.completed_at,
        t.created_at,
        ts.name as team,
        ps.priority as priority,
        ps.color as color
    from ((({{ref('backlog_asana_tasks_staging')}} t 
        left join {{ref('backlog_asana_projects_staging')}} p on t.project = p.gid) 
        left join {{ref('backlog_asana_sections_staging')}} s on t.section = s.gid) 
        left join {{ref('backlog_asana_teams_staging')}} ts on p.team = ts.gid)
        inner join {{ref('backlog_asana_priority_staging')}} ps on ps.task_id = t.gid 

)

select *
from source_data

