{{ config(materialized='table') }}
{{ config(schema='silver') }}


with source_data as (

    select 
        JSON_EXTRACT_SCALAR(runs, '$.workflow_id') AS workflow_id,
        TIMESTAMP(JSON_EXTRACT_SCALAR(runs, '$.run_started_at')) AS run_started_at,
        TIMESTAMP(JSON_EXTRACT_SCALAR(runs, '$.created_at')) AS created_at,
        JSON_EXTRACT_SCALAR(runs, '$.conclusion') AS conclusion,
        TIMESTAMP(JSON_EXTRACT_SCALAR(runs, '$.updated_at')) AS updated_at,
        JSON_EXTRACT_SCALAR(runs, '$.name') AS name,
        JSON_EXTRACT_SCALAR(runs, '$.status') AS status,
        JSON_EXTRACT_SCALAR(runs, '$.repository.name') AS repository
              
        
        
    from {{ source ('internal_tech_kpi_bronze','_airbyte_raw_testsuite_githubaction_workflow_runs')}} cross join UNNEST(JSON_EXTRACT_ARRAY(_airbyte_data, '$.workflow_runs')) as runs
)

select *
from source_data

