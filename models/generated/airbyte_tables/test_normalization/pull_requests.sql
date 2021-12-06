{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "test_normalization",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('pull_requests_ab3') }}
select
    id,
    url,
    base,
    body,
    head,
    user,
    draft,
    state,
    title,
    _links,
    labels,
    locked,
    number,
    node_id,
    assignee,
    diff_url,
    html_url,
    assignees,
    closed_at,
    issue_url,
    merged_at,
    milestone,
    patch_url,
    auto_merge,
    created_at,
    repository,
    updated_at,
    commits_url,
    comments_url,
    statuses_url,
    requested_teams,
    merge_commit_sha,
    active_lock_reason,
    author_association,
    review_comment_url,
    requested_reviewers,
    review_comments_url,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_pull_requests_hashid
from {{ ref('pull_requests_ab3') }}
-- pull_requests from {{ source('test_normalization', '_airbyte_raw_pull_requests') }}
where 1 = 1

