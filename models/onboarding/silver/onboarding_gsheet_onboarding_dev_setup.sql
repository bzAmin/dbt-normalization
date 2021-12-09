{{ config(materialized='table') }}
{{ config(schema='silver') }}


with source_data as (

    select         
        PARSE_DATE('%Y/%m/%d',  arrival_date) AS arrival_date,
        install_coding_environment_in_hours AS install_coding_environment_in_hours,
        first_pullrequest_in_days AS first_pullrequest_in_days,
        team AS team,
        metier AS metier
        
    from {{ source ('internal_tech_kpi_bronze','onboarding_gsheet_onboarding_dev_setup')}}
)

select *
from source_data

