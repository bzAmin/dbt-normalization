{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_test_normalization",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('branches_protection_required_status_checks_ab1') }}
select
    _airbyte_protection_hashid,
    contexts,
    cast(enforcement_level as {{ dbt_utils.type_string() }}) as enforcement_level,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('branches_protection_required_status_checks_ab1') }}
-- required_status_checks at branches/protection/required_status_checks
where 1 = 1

