{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_test_normalization",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('pull_requests_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(url as {{ dbt_utils.type_string() }}) as url,
    cast(base as {{ type_json() }}) as base,
    cast(body as {{ dbt_utils.type_string() }}) as body,
    cast(head as {{ type_json() }}) as head,
    cast(user as {{ type_json() }}) as user,
    {{ cast_to_boolean('draft') }} as draft,
    cast(state as {{ dbt_utils.type_string() }}) as state,
    cast(title as {{ dbt_utils.type_string() }}) as title,
    cast(_links as {{ type_json() }}) as _links,
    labels,
    {{ cast_to_boolean('locked') }} as locked,
    cast(number as {{ dbt_utils.type_bigint() }}) as number,
    cast(node_id as {{ dbt_utils.type_string() }}) as node_id,
    cast(assignee as {{ type_json() }}) as assignee,
    cast(diff_url as {{ dbt_utils.type_string() }}) as diff_url,
    cast(html_url as {{ dbt_utils.type_string() }}) as html_url,
    assignees,
    cast({{ empty_string_to_null('closed_at') }} as {{ type_timestamp_with_timezone() }}) as closed_at,
    cast(issue_url as {{ dbt_utils.type_string() }}) as issue_url,
    cast({{ empty_string_to_null('merged_at') }} as {{ type_timestamp_with_timezone() }}) as merged_at,
    cast(milestone as {{ type_json() }}) as milestone,
    cast(patch_url as {{ dbt_utils.type_string() }}) as patch_url,
    {{ cast_to_boolean('auto_merge') }} as auto_merge,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_with_timezone() }}) as created_at,
    cast(repository as {{ dbt_utils.type_string() }}) as repository,
    cast({{ empty_string_to_null('updated_at') }} as {{ type_timestamp_with_timezone() }}) as updated_at,
    cast(commits_url as {{ dbt_utils.type_string() }}) as commits_url,
    cast(comments_url as {{ dbt_utils.type_string() }}) as comments_url,
    cast(statuses_url as {{ dbt_utils.type_string() }}) as statuses_url,
    requested_teams,
    cast(merge_commit_sha as {{ dbt_utils.type_string() }}) as merge_commit_sha,
    cast(active_lock_reason as {{ dbt_utils.type_string() }}) as active_lock_reason,
    cast(author_association as {{ dbt_utils.type_string() }}) as author_association,
    cast(review_comment_url as {{ dbt_utils.type_string() }}) as review_comment_url,
    requested_reviewers,
    cast(review_comments_url as {{ dbt_utils.type_string() }}) as review_comments_url,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('pull_requests_ab1') }}
-- pull_requests
where 1 = 1

