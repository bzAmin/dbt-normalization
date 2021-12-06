{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_test_normalization",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('organizations_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(url as {{ dbt_utils.type_string() }}) as url,
    cast(blog as {{ dbt_utils.type_string() }}) as blog,
    cast(name as {{ dbt_utils.type_string() }}) as name,
    cast(plan as {{ type_json() }}) as plan,
    cast(type as {{ dbt_utils.type_string() }}) as type,
    cast(email as {{ dbt_utils.type_string() }}) as email,
    cast(login as {{ dbt_utils.type_string() }}) as login,
    cast(company as {{ dbt_utils.type_string() }}) as company,
    cast(node_id as {{ dbt_utils.type_string() }}) as node_id,
    cast(html_url as {{ dbt_utils.type_string() }}) as html_url,
    cast(location as {{ dbt_utils.type_string() }}) as location,
    cast(followers as {{ dbt_utils.type_bigint() }}) as followers,
    cast({{ adapter.quote('following') }} as {{ dbt_utils.type_bigint() }}) as {{ adapter.quote('following') }},
    cast(hooks_url as {{ dbt_utils.type_string() }}) as hooks_url,
    cast(repos_url as {{ dbt_utils.type_string() }}) as repos_url,
    cast(avatar_url as {{ dbt_utils.type_string() }}) as avatar_url,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_with_timezone() }}) as created_at,
    cast(disk_usage as {{ dbt_utils.type_bigint() }}) as disk_usage,
    cast(events_url as {{ dbt_utils.type_string() }}) as events_url,
    cast(issues_url as {{ dbt_utils.type_string() }}) as issues_url,
    cast({{ empty_string_to_null('updated_at') }} as {{ type_timestamp_with_timezone() }}) as updated_at,
    cast(description as {{ dbt_utils.type_string() }}) as description,
    {{ cast_to_boolean('is_verified') }} as is_verified,
    cast(members_url as {{ dbt_utils.type_string() }}) as members_url,
    cast(public_gists as {{ dbt_utils.type_bigint() }}) as public_gists,
    cast(public_repos as {{ dbt_utils.type_bigint() }}) as public_repos,
    cast(billing_email as {{ dbt_utils.type_string() }}) as billing_email,
    cast(collaborators as {{ dbt_utils.type_bigint() }}) as collaborators,
    cast(private_gists as {{ dbt_utils.type_bigint() }}) as private_gists,
    cast(twitter_username as {{ dbt_utils.type_string() }}) as twitter_username,
    cast(public_members_url as {{ dbt_utils.type_string() }}) as public_members_url,
    cast(owned_private_repos as {{ dbt_utils.type_bigint() }}) as owned_private_repos,
    cast(total_private_repos as {{ dbt_utils.type_bigint() }}) as total_private_repos,
    {{ cast_to_boolean('has_repository_projects') }} as has_repository_projects,
    {{ cast_to_boolean('members_can_create_pages') }} as members_can_create_pages,
    {{ cast_to_boolean('has_organization_projects') }} as has_organization_projects,
    cast(default_repository_permission as {{ dbt_utils.type_string() }}) as default_repository_permission,
    {{ cast_to_boolean('two_factor_requirement_enabled') }} as two_factor_requirement_enabled,
    {{ cast_to_boolean('members_can_create_public_pages') }} as members_can_create_public_pages,
    {{ cast_to_boolean('members_can_create_repositories') }} as members_can_create_repositories,
    {{ cast_to_boolean('members_can_create_private_pages') }} as members_can_create_private_pages,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('organizations_ab1') }}
-- organizations
where 1 = 1

