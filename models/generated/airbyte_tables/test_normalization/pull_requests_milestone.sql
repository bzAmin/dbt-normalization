{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "test_normalization",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('pull_requests_milestone_ab3') }}
select
    _airbyte_pull_requests_hashid,
    id,
    url,
    state,
    title,
    due_on,
    number,
    creator,
    node_id,
    html_url,
    closed_at,
    created_at,
    labels_url,
    updated_at,
    description,
    open_issues,
    closed_issues,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_milestone_hashid
from {{ ref('pull_requests_milestone_ab3') }}
-- milestone at pull_requests/milestone from {{ ref('pull_requests') }}
where 1 = 1

