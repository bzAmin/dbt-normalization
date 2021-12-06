{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_test_normalization",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('pull_request_stats') }}
{{ unnest_cte('pull_request_stats', 'pull_request_stats', 'assignees') }}
select
    _airbyte_pull_request_stats_hashid,
    {{ json_extract_scalar(unnested_column_value('assignees'), ['id'], ['id']) }} as id,
    {{ json_extract_scalar(unnested_column_value('assignees'), ['url'], ['url']) }} as url,
    {{ json_extract_scalar(unnested_column_value('assignees'), ['type'], ['type']) }} as type,
    {{ json_extract_scalar(unnested_column_value('assignees'), ['login'], ['login']) }} as login,
    {{ json_extract_scalar(unnested_column_value('assignees'), ['node_id'], ['node_id']) }} as node_id,
    {{ json_extract_scalar(unnested_column_value('assignees'), ['html_url'], ['html_url']) }} as html_url,
    {{ json_extract_scalar(unnested_column_value('assignees'), ['gists_url'], ['gists_url']) }} as gists_url,
    {{ json_extract_scalar(unnested_column_value('assignees'), ['repos_url'], ['repos_url']) }} as repos_url,
    {{ json_extract_scalar(unnested_column_value('assignees'), ['avatar_url'], ['avatar_url']) }} as avatar_url,
    {{ json_extract_scalar(unnested_column_value('assignees'), ['events_url'], ['events_url']) }} as events_url,
    {{ json_extract_scalar(unnested_column_value('assignees'), ['site_admin'], ['site_admin']) }} as site_admin,
    {{ json_extract_scalar(unnested_column_value('assignees'), ['gravatar_id'], ['gravatar_id']) }} as gravatar_id,
    {{ json_extract_scalar(unnested_column_value('assignees'), ['starred_url'], ['starred_url']) }} as starred_url,
    {{ json_extract_scalar(unnested_column_value('assignees'), ['followers_url'], ['followers_url']) }} as followers_url,
    {{ json_extract_scalar(unnested_column_value('assignees'), ['following_url'], ['following_url']) }} as following_url,
    {{ json_extract_scalar(unnested_column_value('assignees'), ['organizations_url'], ['organizations_url']) }} as organizations_url,
    {{ json_extract_scalar(unnested_column_value('assignees'), ['subscriptions_url'], ['subscriptions_url']) }} as subscriptions_url,
    {{ json_extract_scalar(unnested_column_value('assignees'), ['received_events_url'], ['received_events_url']) }} as received_events_url,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('pull_request_stats') }} as table_alias
-- assignees at pull_request_stats/assignees
{{ cross_join_unnest('pull_request_stats', 'assignees') }}
where 1 = 1
and assignees is not null

