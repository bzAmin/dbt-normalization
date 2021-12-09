{{ config(materialized='view') }}
{{ config(schema='gold') }}


with source_data as (

    select         
        *        
    from {{ref('onboarding_gsheet_onboarding_dev_setup')}}
)

select *
from source_data
