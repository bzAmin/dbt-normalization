{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_test_normalization",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('test_normalization', '_airbyte_raw_users') }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['url'], ['url']) }} as url,
    {{ json_extract_scalar('_airbyte_data', ['type'], ['type']) }} as type,
    {{ json_extract_scalar('_airbyte_data', ['login'], ['login']) }} as login,
    {{ json_extract_scalar('_airbyte_data', ['node_id'], ['node_id']) }} as node_id,
    {{ json_extract_scalar('_airbyte_data', ['html_url'], ['html_url']) }} as html_url,
    {{ json_extract_scalar('_airbyte_data', ['gists_url'], ['gists_url']) }} as gists_url,
    {{ json_extract_scalar('_airbyte_data', ['repos_url'], ['repos_url']) }} as repos_url,
    {{ json_extract_scalar('_airbyte_data', ['avatar_url'], ['avatar_url']) }} as avatar_url,
    {{ json_extract_scalar('_airbyte_data', ['events_url'], ['events_url']) }} as events_url,
    {{ json_extract_scalar('_airbyte_data', ['site_admin'], ['site_admin']) }} as site_admin,
    {{ json_extract_scalar('_airbyte_data', ['gravatar_id'], ['gravatar_id']) }} as gravatar_id,
    {{ json_extract_scalar('_airbyte_data', ['starred_url'], ['starred_url']) }} as starred_url,
    {{ json_extract_scalar('_airbyte_data', ['organization'], ['organization']) }} as organization,
    {{ json_extract_scalar('_airbyte_data', ['followers_url'], ['followers_url']) }} as followers_url,
    {{ json_extract_scalar('_airbyte_data', ['following_url'], ['following_url']) }} as following_url,
    {{ json_extract_scalar('_airbyte_data', ['organizations_url'], ['organizations_url']) }} as organizations_url,
    {{ json_extract_scalar('_airbyte_data', ['subscriptions_url'], ['subscriptions_url']) }} as subscriptions_url,
    {{ json_extract_scalar('_airbyte_data', ['received_events_url'], ['received_events_url']) }} as received_events_url,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('test_normalization', '_airbyte_raw_users') }} as table_alias
-- users
where 1 = 1

