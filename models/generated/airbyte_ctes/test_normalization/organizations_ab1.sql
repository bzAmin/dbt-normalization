{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_test_normalization",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('test_normalization', '_airbyte_raw_organizations') }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['url'], ['url']) }} as url,
    {{ json_extract_scalar('_airbyte_data', ['blog'], ['blog']) }} as blog,
    {{ json_extract_scalar('_airbyte_data', ['name'], ['name']) }} as name,
    {{ json_extract('table_alias', '_airbyte_data', ['plan'], ['plan']) }} as plan,
    {{ json_extract_scalar('_airbyte_data', ['type'], ['type']) }} as type,
    {{ json_extract_scalar('_airbyte_data', ['email'], ['email']) }} as email,
    {{ json_extract_scalar('_airbyte_data', ['login'], ['login']) }} as login,
    {{ json_extract_scalar('_airbyte_data', ['company'], ['company']) }} as company,
    {{ json_extract_scalar('_airbyte_data', ['node_id'], ['node_id']) }} as node_id,
    {{ json_extract_scalar('_airbyte_data', ['html_url'], ['html_url']) }} as html_url,
    {{ json_extract_scalar('_airbyte_data', ['location'], ['location']) }} as location,
    {{ json_extract_scalar('_airbyte_data', ['followers'], ['followers']) }} as followers,
    {{ json_extract_scalar('_airbyte_data', ['following'], ['following']) }} as {{ adapter.quote('following') }},
    {{ json_extract_scalar('_airbyte_data', ['hooks_url'], ['hooks_url']) }} as hooks_url,
    {{ json_extract_scalar('_airbyte_data', ['repos_url'], ['repos_url']) }} as repos_url,
    {{ json_extract_scalar('_airbyte_data', ['avatar_url'], ['avatar_url']) }} as avatar_url,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['disk_usage'], ['disk_usage']) }} as disk_usage,
    {{ json_extract_scalar('_airbyte_data', ['events_url'], ['events_url']) }} as events_url,
    {{ json_extract_scalar('_airbyte_data', ['issues_url'], ['issues_url']) }} as issues_url,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['description'], ['description']) }} as description,
    {{ json_extract_scalar('_airbyte_data', ['is_verified'], ['is_verified']) }} as is_verified,
    {{ json_extract_scalar('_airbyte_data', ['members_url'], ['members_url']) }} as members_url,
    {{ json_extract_scalar('_airbyte_data', ['public_gists'], ['public_gists']) }} as public_gists,
    {{ json_extract_scalar('_airbyte_data', ['public_repos'], ['public_repos']) }} as public_repos,
    {{ json_extract_scalar('_airbyte_data', ['billing_email'], ['billing_email']) }} as billing_email,
    {{ json_extract_scalar('_airbyte_data', ['collaborators'], ['collaborators']) }} as collaborators,
    {{ json_extract_scalar('_airbyte_data', ['private_gists'], ['private_gists']) }} as private_gists,
    {{ json_extract_scalar('_airbyte_data', ['twitter_username'], ['twitter_username']) }} as twitter_username,
    {{ json_extract_scalar('_airbyte_data', ['public_members_url'], ['public_members_url']) }} as public_members_url,
    {{ json_extract_scalar('_airbyte_data', ['owned_private_repos'], ['owned_private_repos']) }} as owned_private_repos,
    {{ json_extract_scalar('_airbyte_data', ['total_private_repos'], ['total_private_repos']) }} as total_private_repos,
    {{ json_extract_scalar('_airbyte_data', ['has_repository_projects'], ['has_repository_projects']) }} as has_repository_projects,
    {{ json_extract_scalar('_airbyte_data', ['members_can_create_pages'], ['members_can_create_pages']) }} as members_can_create_pages,
    {{ json_extract_scalar('_airbyte_data', ['has_organization_projects'], ['has_organization_projects']) }} as has_organization_projects,
    {{ json_extract_scalar('_airbyte_data', ['default_repository_permission'], ['default_repository_permission']) }} as default_repository_permission,
    {{ json_extract_scalar('_airbyte_data', ['two_factor_requirement_enabled'], ['two_factor_requirement_enabled']) }} as two_factor_requirement_enabled,
    {{ json_extract_scalar('_airbyte_data', ['members_can_create_public_pages'], ['members_can_create_public_pages']) }} as members_can_create_public_pages,
    {{ json_extract_scalar('_airbyte_data', ['members_can_create_repositories'], ['members_can_create_repositories']) }} as members_can_create_repositories,
    {{ json_extract_scalar('_airbyte_data', ['members_can_create_private_pages'], ['members_can_create_private_pages']) }} as members_can_create_private_pages,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('test_normalization', '_airbyte_raw_organizations') }} as table_alias
-- organizations
where 1 = 1

