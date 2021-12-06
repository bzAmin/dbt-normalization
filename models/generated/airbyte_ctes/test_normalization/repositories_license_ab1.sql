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
    {{ json_extract_scalar('license', ['key'], ['key']) }} as key,
    {{ json_extract_scalar('license', ['url'], ['url']) }} as url,
    {{ json_extract_scalar('license', ['name'], ['name']) }} as name,
    {{ json_extract_scalar('license', ['node_id'], ['node_id']) }} as node_id,
    {{ json_extract_scalar('license', ['spdx_id'], ['spdx_id']) }} as spdx_id,
    {{ json_extract_scalar('license', ['html_url'], ['html_url']) }} as html_url,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('repositories') }} as table_alias
-- license at repositories/license
where 1 = 1
and license is not null

