{{ config(materialized='table') }}
{{ config(schema='gold') }}


with source_data as (

    select         
        workflow_id,
        name,
        status,
        repository,
        conclusion,
        TIMESTAMP_DIFF(updated_at, run_started_at, SECOND) as duration  
    from {{ref('testsuite_workflow_runs_staging')}}
)

select *
from source_data

