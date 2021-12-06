{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_test_normalization",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('pull_requests_milestone') }}
select
    _airbyte_milestone_hashid,
    {{ json_extract_scalar('creator', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('creator', ['url'], ['url']) }} as url,
    {{ json_extract_scalar('creator', ['type'], ['type']) }} as type,
    {{ json_extract_scalar('creator', ['login'], ['login']) }} as login,
    {{ json_extract_scalar('creator', ['node_id'], ['node_id']) }} as node_id,
    {{ json_extract_scalar('creator', ['html_url'], ['html_url']) }} as html_url,
    {{ json_extract_scalar('creator', ['gists_url'], ['gists_url']) }} as gists_url,
    {{ json_extract_scalar('creator', ['repos_url'], ['repos_url']) }} as repos_url,
    {{ json_extract_scalar('creator', ['avatar_url'], ['avatar_url']) }} as avatar_url,
    {{ json_extract_scalar('creator', ['events_url'], ['events_url']) }} as events_url,
    {{ json_extract_scalar('creator', ['site_admin'], ['site_admin']) }} as site_admin,
    {{ json_extract_scalar('creator', ['gravatar_id'], ['gravatar_id']) }} as gravatar_id,
    {{ json_extract_scalar('creator', ['starred_url'], ['starred_url']) }} as starred_url,
    {{ json_extract_scalar('creator', ['followers_url'], ['followers_url']) }} as followers_url,
    {{ json_extract_scalar('creator', ['following_url'], ['following_url']) }} as following_url,
    {{ json_extract_scalar('creator', ['organizations_url'], ['organizations_url']) }} as organizations_url,
    {{ json_extract_scalar('creator', ['subscriptions_url'], ['subscriptions_url']) }} as subscriptions_url,
    {{ json_extract_scalar('creator', ['received_events_url'], ['received_events_url']) }} as received_events_url,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('pull_requests_milestone') }} as table_alias
-- creator at pull_requests/milestone/creator
where 1 = 1
and creator is not null

