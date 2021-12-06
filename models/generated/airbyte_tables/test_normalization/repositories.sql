{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "test_normalization",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('repositories_ab3') }}
select
    id,
    url,
    fork,
    name,
    size,
    owner,
    topics,
    git_url,
    license,
    node_id,
    private,
    ssh_url,
    svn_url,
    archived,
    disabled,
    has_wiki,
    homepage,
    html_url,
    keys_url,
    language,
    tags_url,
    blobs_url,
    clone_url,
    forks_url,
    full_name,
    has_pages,
    hooks_url,
    pulls_url,
    pushed_at,
    teams_url,
    trees_url,
    created_at,
    events_url,
    has_issues,
    issues_url,
    labels_url,
    merges_url,
    mirror_url,
    updated_at,
    visibility,
    archive_url,
    commits_url,
    compare_url,
    description,
    forks_count,
    is_template,
    permissions,
    branches_url,
    comments_url,
    contents_url,
    git_refs_url,
    git_tags_url,
    has_projects,
    releases_url,
    statuses_url,
    assignees_url,
    downloads_url,
    has_downloads,
    languages_url,
    default_branch,
    milestones_url,
    stargazers_url,
    watchers_count,
    deployments_url,
    git_commits_url,
    subscribers_url,
    contributors_url,
    issue_events_url,
    stargazers_count,
    subscription_url,
    collaborators_url,
    issue_comment_url,
    notifications_url,
    open_issues_count,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_repositories_hashid
from {{ ref('repositories_ab3') }}
-- repositories from {{ source('test_normalization', '_airbyte_raw_repositories') }}
where 1 = 1

