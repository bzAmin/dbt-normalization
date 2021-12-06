{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_test_normalization",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('repositories') }}
select
    _airbyte_repositories_hashid,
    {{ json_extract_scalar('permissions', ['pull'], ['pull']) }} as pull,
    {{ json_extract_scalar('permissions', ['push'], ['push']) }} as push,
    {{ json_extract_scalar('permissions', ['admin'], ['admin']) }} as admin,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('repositories') }} as table_alias
-- permissions at repositories/permissions
where 1 = 1
and permissions is not null

