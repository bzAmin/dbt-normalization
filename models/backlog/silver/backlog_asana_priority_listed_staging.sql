{{ config(materialized='table') }}
{{ config(schema='silver') }}


with source_data as (

    select 
        f._airbyte_backlog_asana_tasks_hashid,        
        v.gid,
        v.name,
        v.color

    from {{ source ('internal_tech_kpi_bronze','backlog_asana_tasks_custom_fields_enum_value')}} v 
        left join {{ source ('internal_tech_kpi_bronze','backlog_asana_tasks_custom_fields')}} f on v._airbyte_custom_fields_hashid = f._airbyte_custom_fields_hashid


)

select *
from source_data

