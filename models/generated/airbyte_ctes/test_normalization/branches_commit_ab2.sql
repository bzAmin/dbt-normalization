{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_test_normalization",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('branches_commit_ab1') }}
select
    _airbyte_branches_hashid,
    cast(sha as {{ dbt_utils.type_string() }}) as sha,
    cast(url as {{ dbt_utils.type_string() }}) as url,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('branches_commit_ab1') }}
-- commit at branches/commit
where 1 = 1

