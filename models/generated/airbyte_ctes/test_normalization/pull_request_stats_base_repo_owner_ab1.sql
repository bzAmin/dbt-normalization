{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_test_normalization",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('pull_request_stats_base_repo') }}
select
    _airbyte_repo_hashid,
    {{ json_extract_scalar('owner', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('owner', ['url'], ['url']) }} as url,
    {{ json_extract_scalar('owner', ['type'], ['type']) }} as type,
    {{ json_extract_scalar('owner', ['login'], ['login']) }} as login,
    {{ json_extract_scalar('owner', ['node_id'], ['node_id']) }} as node_id,
    {{ json_extract_scalar('owner', ['html_url'], ['html_url']) }} as html_url,
    {{ json_extract_scalar('owner', ['gists_url'], ['gists_url']) }} as gists_url,
    {{ json_extract_scalar('owner', ['repos_url'], ['repos_url']) }} as repos_url,
    {{ json_extract_scalar('owner', ['avatar_url'], ['avatar_url']) }} as avatar_url,
    {{ json_extract_scalar('owner', ['events_url'], ['events_url']) }} as events_url,
    {{ json_extract_scalar('owner', ['site_admin'], ['site_admin']) }} as site_admin,
    {{ json_extract_scalar('owner', ['gravatar_id'], ['gravatar_id']) }} as gravatar_id,
    {{ json_extract_scalar('owner', ['starred_url'], ['starred_url']) }} as starred_url,
    {{ json_extract_scalar('owner', ['followers_url'], ['followers_url']) }} as followers_url,
    {{ json_extract_scalar('owner', ['following_url'], ['following_url']) }} as following_url,
    {{ json_extract_scalar('owner', ['organizations_url'], ['organizations_url']) }} as organizations_url,
    {{ json_extract_scalar('owner', ['subscriptions_url'], ['subscriptions_url']) }} as subscriptions_url,
    {{ json_extract_scalar('owner', ['received_events_url'], ['received_events_url']) }} as received_events_url,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('pull_request_stats_base_repo') }} as table_alias
-- owner at pull_request_stats/base/repo/owner
where 1 = 1
and owner is not null

