{{ config(materialized='table') }}
{{ config(schema='gold') }}


with source_data as (

    select         
        arrival_date,
        CAST(install_coding_environment_in_hours as NUMERIC) as install_coding_environment_in_hours,
        CAST(first_pullrequest_in_days as NUMERIC) as first_pullrequest_in_days,
        team,
        metier       
    from {{ref('onboarding_gsheet_onboarding_dev_setup_staging')}}
)

select *
from source_data

