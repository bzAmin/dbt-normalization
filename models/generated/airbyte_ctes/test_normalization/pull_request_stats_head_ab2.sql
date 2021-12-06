{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_test_normalization",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('pull_request_stats_head_ab1') }}
select
    _airbyte_pull_request_stats_hashid,
    cast(ref as {{ dbt_utils.type_string() }}) as ref,
    cast(sha as {{ dbt_utils.type_string() }}) as sha,
    cast(repo as {{ type_json() }}) as repo,
    cast(user as {{ type_json() }}) as user,
    cast(label as {{ dbt_utils.type_string() }}) as label,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('pull_request_stats_head_ab1') }}
-- head at pull_request_stats/head
where 1 = 1

