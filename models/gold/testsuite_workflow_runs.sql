{{ config(materialized='table') }}
{{ config(schema='gold') }}


with source_data as (

    select         
        workflow_id,
        name,
        status,
        repository,
        conclusion,
        timestamp_trunc(run_started_at,day) as day,
        count(workflow_id) as total_execution,
        SUM(TIMESTAMP_DIFF(updated_at, run_started_at, SECOND)) as total_duration  
    from {{ref('testsuite_workflow_runs_staging')}}
    group by name,
        workflow_id,
        name,
        status,
        repository,
        conclusion,
        day
)

select *
from source_data

