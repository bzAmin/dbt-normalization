{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_test_normalization",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('pull_requests_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'url',
        'base',
        'body',
        'head',
        'user',
        boolean_to_string('draft'),
        'state',
        'title',
        '_links',
        array_to_string('labels'),
        boolean_to_string('locked'),
        'number',
        'node_id',
        'assignee',
        'diff_url',
        'html_url',
        array_to_string('assignees'),
        'closed_at',
        'issue_url',
        'merged_at',
        'milestone',
        'patch_url',
        boolean_to_string('auto_merge'),
        'created_at',
        'repository',
        'updated_at',
        'commits_url',
        'comments_url',
        'statuses_url',
        array_to_string('requested_teams'),
        'merge_commit_sha',
        'active_lock_reason',
        'author_association',
        'review_comment_url',
        array_to_string('requested_reviewers'),
        'review_comments_url',
    ]) }} as _airbyte_pull_requests_hashid,
    tmp.*
from {{ ref('pull_requests_ab2') }} tmp
-- pull_requests
where 1 = 1

