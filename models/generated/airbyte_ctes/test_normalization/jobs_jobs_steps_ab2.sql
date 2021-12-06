{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_test_normalization",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('jobs_jobs_steps_ab1') }}
select
    _airbyte_jobs_2_hashid,
    cast(name as {{ dbt_utils.type_string() }}) as name,
    cast(number as {{ dbt_utils.type_bigint() }}) as number,
    cast(status as {{ dbt_utils.type_string() }}) as status,
    cast(conclusion as {{ dbt_utils.type_string() }}) as conclusion,
    cast(started_at as {{ dbt_utils.type_string() }}) as started_at,
    cast(completed_at as {{ dbt_utils.type_string() }}) as completed_at,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('jobs_jobs_steps_ab1') }}
-- steps at jobs/jobs/steps
where 1 = 1

