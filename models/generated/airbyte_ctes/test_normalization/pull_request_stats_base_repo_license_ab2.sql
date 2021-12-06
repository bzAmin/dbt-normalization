{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_test_normalization",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('pull_request_stats_base_repo_license_ab1') }}
select
    _airbyte_repo_hashid,
    cast(key as {{ dbt_utils.type_string() }}) as key,
    cast(url as {{ dbt_utils.type_string() }}) as url,
    cast(name as {{ dbt_utils.type_string() }}) as name,
    cast(node_id as {{ dbt_utils.type_string() }}) as node_id,
    cast(spdx_id as {{ dbt_utils.type_string() }}) as spdx_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('pull_request_stats_base_repo_license_ab1') }}
-- license at pull_request_stats/base/repo/license
where 1 = 1

