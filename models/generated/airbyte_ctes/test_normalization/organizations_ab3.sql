{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_test_normalization",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('organizations_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'url',
        'blog',
        'name',
        'plan',
        'type',
        'email',
        'login',
        'company',
        'node_id',
        'html_url',
        'location',
        'followers',
        adapter.quote('following'),
        'hooks_url',
        'repos_url',
        'avatar_url',
        'created_at',
        'disk_usage',
        'events_url',
        'issues_url',
        'updated_at',
        'description',
        boolean_to_string('is_verified'),
        'members_url',
        'public_gists',
        'public_repos',
        'billing_email',
        'collaborators',
        'private_gists',
        'twitter_username',
        'public_members_url',
        'owned_private_repos',
        'total_private_repos',
        boolean_to_string('has_repository_projects'),
        boolean_to_string('members_can_create_pages'),
        boolean_to_string('has_organization_projects'),
        'default_repository_permission',
        boolean_to_string('two_factor_requirement_enabled'),
        boolean_to_string('members_can_create_public_pages'),
        boolean_to_string('members_can_create_repositories'),
        boolean_to_string('members_can_create_private_pages'),
    ]) }} as _airbyte_organizations_hashid,
    tmp.*
from {{ ref('organizations_ab2') }} tmp
-- organizations
where 1 = 1

