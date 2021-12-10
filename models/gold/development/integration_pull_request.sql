{{ config(materialized='table') }}
{{ config(schema='gold') }}


with source_data as (

    select         
        id,
        state,
        title,
        repository,
        TIMESTAMP_DIFF(merged_at, created_at, SECOND) as duration  
    from {{ref('integration_pull_request_staging')}}
)

select *
from source_data

