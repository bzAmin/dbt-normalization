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
    {{ json_extract_scalar('license', ['key'], ['key']) }} as key,
    {{ json_extract_scalar('license', ['url'], ['url']) }} as url,
    {{ json_extract_scalar('license', ['name'], ['name']) }} as name,
    {{ json_extract_scalar('license', ['node_id'], ['node_id']) }} as node_id,
    {{ json_extract_scalar('license', ['spdx_id'], ['spdx_id']) }} as spdx_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('pull_request_stats_head_repo') }} as table_alias
-- license at pull_request_stats/head/repo/license
where 1 = 1
and license is not null

