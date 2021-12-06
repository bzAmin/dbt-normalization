{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_test_normalization",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('workflows') }}
{{ unnest_cte('workflows', 'workflows', 'workflows') }}
select
    _airbyte_workflows_hashid,
    {{ json_extract_scalar(unnested_column_value('workflows'), ['id'], ['id']) }} as id,
    {{ json_extract_scalar(unnested_column_value('workflows'), ['url'], ['url']) }} as url,
    {{ json_extract_scalar(unnested_column_value('workflows'), ['name'], ['name']) }} as name,
    {{ json_extract_scalar(unnested_column_value('workflows'), ['path'], ['path']) }} as path,
    {{ json_extract_scalar(unnested_column_value('workflows'), ['state'], ['state']) }} as state,
    {{ json_extract_scalar(unnested_column_value('workflows'), ['node_id'], ['node_id']) }} as node_id,
    {{ json_extract_scalar(unnested_column_value('workflows'), ['html_url'], ['html_url']) }} as html_url,
    {{ json_extract_scalar(unnested_column_value('workflows'), ['badge_url'], ['badge_url']) }} as badge_url,
    {{ json_extract_scalar(unnested_column_value('workflows'), ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar(unnested_column_value('workflows'), ['updated_at'], ['updated_at']) }} as updated_at,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('workflows') }} as table_alias
-- workflows at workflows/workflows
{{ cross_join_unnest('workflows', 'workflows') }}
where 1 = 1
and workflows is not null

