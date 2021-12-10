{{ config(materialized='table') }}
{{ config(schema='silver') }}


with source_data as (

    select 
        gid,        
        name,
        due_at,
        due_on,
        JSON_EXTRACT_SCALAR(projects[OFFSET(0)], '$.gid') AS project, 
        start_on,
        completed,
        JSON_EXTRACT_SCALAR(workspace, '$.gid') AS workspace,
        created_at,
        JSON_EXTRACT_SCALAR(memberships[OFFSET(0)],'$.section.gid') as section,
        modified_at,
        completed_at,
        approval_status,
        _airbyte_backlog_asana_tasks_hashid
        
        
    from {{ source ('internal_tech_kpi_bronze','backlog_asana_tasks')}}
)

select *
from source_data

