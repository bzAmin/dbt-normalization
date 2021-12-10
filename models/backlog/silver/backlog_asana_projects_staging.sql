{{ config(materialized='table') }}
{{ config(schema='silver') }}


with source_data as (

    select 
        gid,        
        name,
        JSON_EXTRACT_SCALAR(team, '$.gid') AS team

    from {{ source ('internal_tech_kpi_bronze','backlog_asana_projects')}}

)

select *
from source_data

