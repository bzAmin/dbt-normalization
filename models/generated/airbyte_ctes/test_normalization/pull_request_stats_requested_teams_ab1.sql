{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_test_normalization",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('pull_request_stats') }}
{{ unnest_cte('pull_request_stats', 'pull_request_stats', 'requested_teams') }}
select
    _airbyte_pull_request_stats_hashid,
    {{ json_extract_scalar(unnested_column_value('requested_teams'), ['id'], ['id']) }} as id,
    {{ json_extract_scalar(unnested_column_value('requested_teams'), ['url'], ['url']) }} as url,
    {{ json_extract_scalar(unnested_column_value('requested_teams'), ['name'], ['name']) }} as name,
    {{ json_extract_scalar(unnested_column_value('requested_teams'), ['slug'], ['slug']) }} as slug,
    {{ json_extract_scalar(unnested_column_value('requested_teams'), ['node_id'], ['node_id']) }} as node_id,
    {{ json_extract_scalar(unnested_column_value('requested_teams'), ['privacy'], ['privacy']) }} as privacy,
    {{ json_extract_scalar(unnested_column_value('requested_teams'), ['html_url'], ['html_url']) }} as html_url,
    {{ json_extract_scalar(unnested_column_value('requested_teams'), ['permission'], ['permission']) }} as permission,
    {{ json_extract_scalar(unnested_column_value('requested_teams'), ['description'], ['description']) }} as description,
    {{ json_extract_scalar(unnested_column_value('requested_teams'), ['members_url'], ['members_url']) }} as members_url,
    {{ json_extract_scalar(unnested_column_value('requested_teams'), ['repositories_url'], ['repositories_url']) }} as repositories_url,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('pull_request_stats') }} as table_alias
-- requested_teams at pull_request_stats/requested_teams
{{ cross_join_unnest('pull_request_stats', 'requested_teams') }}
where 1 = 1
and requested_teams is not null

