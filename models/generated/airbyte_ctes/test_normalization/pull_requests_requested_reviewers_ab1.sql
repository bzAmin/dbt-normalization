{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_test_normalization",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('pull_requests') }}
{{ unnest_cte('pull_requests', 'pull_requests', 'requested_reviewers') }}
select
    _airbyte_pull_requests_hashid,
    {{ json_extract_scalar(unnested_column_value('requested_reviewers'), ['id'], ['id']) }} as id,
    {{ json_extract_scalar(unnested_column_value('requested_reviewers'), ['url'], ['url']) }} as url,
    {{ json_extract_scalar(unnested_column_value('requested_reviewers'), ['type'], ['type']) }} as type,
    {{ json_extract_scalar(unnested_column_value('requested_reviewers'), ['login'], ['login']) }} as login,
    {{ json_extract_scalar(unnested_column_value('requested_reviewers'), ['node_id'], ['node_id']) }} as node_id,
    {{ json_extract_scalar(unnested_column_value('requested_reviewers'), ['html_url'], ['html_url']) }} as html_url,
    {{ json_extract_scalar(unnested_column_value('requested_reviewers'), ['gists_url'], ['gists_url']) }} as gists_url,
    {{ json_extract_scalar(unnested_column_value('requested_reviewers'), ['repos_url'], ['repos_url']) }} as repos_url,
    {{ json_extract_scalar(unnested_column_value('requested_reviewers'), ['avatar_url'], ['avatar_url']) }} as avatar_url,
    {{ json_extract_scalar(unnested_column_value('requested_reviewers'), ['events_url'], ['events_url']) }} as events_url,
    {{ json_extract_scalar(unnested_column_value('requested_reviewers'), ['site_admin'], ['site_admin']) }} as site_admin,
    {{ json_extract_scalar(unnested_column_value('requested_reviewers'), ['gravatar_id'], ['gravatar_id']) }} as gravatar_id,
    {{ json_extract_scalar(unnested_column_value('requested_reviewers'), ['starred_url'], ['starred_url']) }} as starred_url,
    {{ json_extract_scalar(unnested_column_value('requested_reviewers'), ['followers_url'], ['followers_url']) }} as followers_url,
    {{ json_extract_scalar(unnested_column_value('requested_reviewers'), ['following_url'], ['following_url']) }} as following_url,
    {{ json_extract_scalar(unnested_column_value('requested_reviewers'), ['organizations_url'], ['organizations_url']) }} as organizations_url,
    {{ json_extract_scalar(unnested_column_value('requested_reviewers'), ['subscriptions_url'], ['subscriptions_url']) }} as subscriptions_url,
    {{ json_extract_scalar(unnested_column_value('requested_reviewers'), ['received_events_url'], ['received_events_url']) }} as received_events_url,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('pull_requests') }} as table_alias
-- requested_reviewers at pull_requests/requested_reviewers
{{ cross_join_unnest('pull_requests', 'requested_reviewers') }}
where 1 = 1
and requested_reviewers is not null

