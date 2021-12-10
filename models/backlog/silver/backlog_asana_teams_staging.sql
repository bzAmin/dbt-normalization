{{ config(materialized='table') }}
{{ config(schema='silver') }}


with source_data as (

    select 
        gid,        
        name

    from {{ source ('internal_tech_kpi_bronze','backlog_asana_teams')}}

)

select *
from source_data

