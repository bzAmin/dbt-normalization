{{ config(materialized='table') }}
{{ config(schema='silver') }}


with source_data as (

    select 
        id,
        state,
        title,
        closed_at,
        merged_at, 
        created_at,
        repository,
        updated_at

        
    from {{ source ('internal_tech_kpi_bronze','pull_requests')}}
)

select *
from source_data

