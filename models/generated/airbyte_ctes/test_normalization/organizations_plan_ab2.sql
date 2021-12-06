{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_test_normalization",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('organizations_plan_ab1') }}
select
    _airbyte_organizations_hashid,
    cast(name as {{ dbt_utils.type_string() }}) as name,
    cast(seats as {{ dbt_utils.type_bigint() }}) as seats,
    cast(space as {{ dbt_utils.type_bigint() }}) as space,
    cast(filled_seats as {{ dbt_utils.type_bigint() }}) as filled_seats,
    cast(private_repos as {{ dbt_utils.type_bigint() }}) as private_repos,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('organizations_plan_ab1') }}
-- plan at organizations/plan
where 1 = 1

