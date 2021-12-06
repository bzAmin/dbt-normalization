{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_test_normalization",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('test_normalization', '_airbyte_raw_pull_requests') }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['url'], ['url']) }} as url,
    {{ json_extract('table_alias', '_airbyte_data', ['base'], ['base']) }} as base,
    {{ json_extract_scalar('_airbyte_data', ['body'], ['body']) }} as body,
    {{ json_extract('table_alias', '_airbyte_data', ['head'], ['head']) }} as head,
    {{ json_extract('table_alias', '_airbyte_data', ['user'], ['user']) }} as user,
    {{ json_extract_scalar('_airbyte_data', ['draft'], ['draft']) }} as draft,
    {{ json_extract_scalar('_airbyte_data', ['state'], ['state']) }} as state,
    {{ json_extract_scalar('_airbyte_data', ['title'], ['title']) }} as title,
    {{ json_extract('table_alias', '_airbyte_data', ['_links'], ['_links']) }} as _links,
    {{ json_extract_array('_airbyte_data', ['labels'], ['labels']) }} as labels,
    {{ json_extract_scalar('_airbyte_data', ['locked'], ['locked']) }} as locked,
    {{ json_extract_scalar('_airbyte_data', ['number'], ['number']) }} as number,
    {{ json_extract_scalar('_airbyte_data', ['node_id'], ['node_id']) }} as node_id,
    {{ json_extract('table_alias', '_airbyte_data', ['assignee'], ['assignee']) }} as assignee,
    {{ json_extract_scalar('_airbyte_data', ['diff_url'], ['diff_url']) }} as diff_url,
    {{ json_extract_scalar('_airbyte_data', ['html_url'], ['html_url']) }} as html_url,
    {{ json_extract_array('_airbyte_data', ['assignees'], ['assignees']) }} as assignees,
    {{ json_extract_scalar('_airbyte_data', ['closed_at'], ['closed_at']) }} as closed_at,
    {{ json_extract_scalar('_airbyte_data', ['issue_url'], ['issue_url']) }} as issue_url,
    {{ json_extract_scalar('_airbyte_data', ['merged_at'], ['merged_at']) }} as merged_at,
    {{ json_extract('table_alias', '_airbyte_data', ['milestone'], ['milestone']) }} as milestone,
    {{ json_extract_scalar('_airbyte_data', ['patch_url'], ['patch_url']) }} as patch_url,
    {{ json_extract_scalar('_airbyte_data', ['auto_merge'], ['auto_merge']) }} as auto_merge,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['repository'], ['repository']) }} as repository,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['commits_url'], ['commits_url']) }} as commits_url,
    {{ json_extract_scalar('_airbyte_data', ['comments_url'], ['comments_url']) }} as comments_url,
    {{ json_extract_scalar('_airbyte_data', ['statuses_url'], ['statuses_url']) }} as statuses_url,
    {{ json_extract_array('_airbyte_data', ['requested_teams'], ['requested_teams']) }} as requested_teams,
    {{ json_extract_scalar('_airbyte_data', ['merge_commit_sha'], ['merge_commit_sha']) }} as merge_commit_sha,
    {{ json_extract_scalar('_airbyte_data', ['active_lock_reason'], ['active_lock_reason']) }} as active_lock_reason,
    {{ json_extract_scalar('_airbyte_data', ['author_association'], ['author_association']) }} as author_association,
    {{ json_extract_scalar('_airbyte_data', ['review_comment_url'], ['review_comment_url']) }} as review_comment_url,
    {{ json_extract_array('_airbyte_data', ['requested_reviewers'], ['requested_reviewers']) }} as requested_reviewers,
    {{ json_extract_scalar('_airbyte_data', ['review_comments_url'], ['review_comments_url']) }} as review_comments_url,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('test_normalization', '_airbyte_raw_pull_requests') }} as table_alias
-- pull_requests
where 1 = 1

