{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_test_normalization",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('pull_requests_base_ab1') }}
select
    _airbyte_pull_requests_hashid,
    cast(ref as {{ dbt_utils.type_string() }}) as ref,
    cast(sha as {{ dbt_utils.type_string() }}) as sha,
    cast(label as {{ dbt_utils.type_string() }}) as label,
    cast(repo_id as {{ dbt_utils.type_bigint() }}) as repo_id,
    cast(user_id as {{ dbt_utils.type_bigint() }}) as user_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('pull_requests_base_ab1') }}
-- base at pull_requests/base
where 1 = 1

