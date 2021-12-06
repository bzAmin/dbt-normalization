{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_test_normalization",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('pull_request_stats_head_repo') }}
select
    _airbyte_repo_hashid,
    {{ json_extract_scalar('permissions', ['pull'], ['pull']) }} as pull,
    {{ json_extract_scalar('permissions', ['push'], ['push']) }} as push,
    {{ json_extract_scalar('permissions', ['admin'], ['admin']) }} as admin,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('pull_request_stats_head_repo') }} as table_alias
-- permissions at pull_request_stats/head/repo/permissions
where 1 = 1
and permissions is not null

