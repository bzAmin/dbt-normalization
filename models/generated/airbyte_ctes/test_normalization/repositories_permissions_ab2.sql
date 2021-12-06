{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_test_normalization",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('repositories_permissions_ab1') }}
select
    _airbyte_repositories_hashid,
    {{ cast_to_boolean('pull') }} as pull,
    {{ cast_to_boolean('push') }} as push,
    {{ cast_to_boolean('admin') }} as admin,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('repositories_permissions_ab1') }}
-- permissions at repositories/permissions
where 1 = 1

