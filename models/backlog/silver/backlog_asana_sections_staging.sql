{{ config(materialized='table') }}
{{ config(schema='silver') }}


with source_data as (

    select 
        gid,        
        name,
        JSON_EXTRACT_SCALAR(project, '$.gid') AS project

    from {{ source ('internal_tech_kpi_bronze','backlog_asana_sections')}}

)

select *
from source_data

