{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_test_normalization",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('branches_ab1') }}
select
    cast(name as {{ dbt_utils.type_string() }}) as name,
    cast(commit as {{ type_json() }}) as commit,
    {{ cast_to_boolean('protected') }} as protected,
    cast(protection as {{ type_json() }}) as protection,
    cast(repository as {{ dbt_utils.type_string() }}) as repository,
    cast(protection_url as {{ dbt_utils.type_string() }}) as protection_url,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('branches_ab1') }}
-- branches
where 1 = 1

