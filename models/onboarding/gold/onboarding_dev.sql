{{ config(materialized='table') }}
{{ config(schema='gold') }}


with source_data as (

    select         
        *        
    from {{ref('onboarding_gsheet_onboarding_dev_setup_staging')}}
)

select *
from source_data

