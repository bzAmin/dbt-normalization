{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_test_normalization",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('pull_requests') }}
select
    _airbyte_pull_requests_hashid,
    {{ json_extract_scalar('user', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('user', ['url'], ['url']) }} as url,
    {{ json_extract_scalar('user', ['type'], ['type']) }} as type,
    {{ json_extract_scalar('user', ['login'], ['login']) }} as login,
    {{ json_extract_scalar('user', ['node_id'], ['node_id']) }} as node_id,
    {{ json_extract_scalar('user', ['html_url'], ['html_url']) }} as html_url,
    {{ json_extract_scalar('user', ['gists_url'], ['gists_url']) }} as gists_url,
    {{ json_extract_scalar('user', ['repos_url'], ['repos_url']) }} as repos_url,
    {{ json_extract_scalar('user', ['avatar_url'], ['avatar_url']) }} as avatar_url,
    {{ json_extract_scalar('user', ['events_url'], ['events_url']) }} as events_url,
    {{ json_extract_scalar('user', ['site_admin'], ['site_admin']) }} as site_admin,
    {{ json_extract_scalar('user', ['gravatar_id'], ['gravatar_id']) }} as gravatar_id,
    {{ json_extract_scalar('user', ['starred_url'], ['starred_url']) }} as starred_url,
    {{ json_extract_scalar('user', ['followers_url'], ['followers_url']) }} as followers_url,
    {{ json_extract_scalar('user', ['following_url'], ['following_url']) }} as following_url,
    {{ json_extract_scalar('user', ['organizations_url'], ['organizations_url']) }} as organizations_url,
    {{ json_extract_scalar('user', ['subscriptions_url'], ['subscriptions_url']) }} as subscriptions_url,
    {{ json_extract_scalar('user', ['received_events_url'], ['received_events_url']) }} as received_events_url,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('pull_requests') }} as table_alias
-- user at pull_requests/user
where 1 = 1
and user is not null

