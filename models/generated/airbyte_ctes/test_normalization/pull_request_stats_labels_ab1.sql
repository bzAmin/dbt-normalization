{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_test_normalization",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('pull_request_stats') }}
{{ unnest_cte('pull_request_stats', 'pull_request_stats', 'labels') }}
select
    _airbyte_pull_request_stats_hashid,
    {{ json_extract_scalar(unnested_column_value('labels'), ['id'], ['id']) }} as id,
    {{ json_extract_scalar(unnested_column_value('labels'), ['url'], ['url']) }} as url,
    {{ json_extract_scalar(unnested_column_value('labels'), ['name'], ['name']) }} as name,
    {{ json_extract_scalar(unnested_column_value('labels'), ['color'], ['color']) }} as color,
    {{ json_extract_scalar(unnested_column_value('labels'), ['default'], ['default']) }} as {{ adapter.quote('default') }},
    {{ json_extract_scalar(unnested_column_value('labels'), ['node_id'], ['node_id']) }} as node_id,
    {{ json_extract_scalar(unnested_column_value('labels'), ['description'], ['description']) }} as description,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('pull_request_stats') }} as table_alias
-- labels at pull_request_stats/labels
{{ cross_join_unnest('pull_request_stats', 'labels') }}
where 1 = 1
and labels is not null

