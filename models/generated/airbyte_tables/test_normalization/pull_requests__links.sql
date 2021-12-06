{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "test_normalization",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('pull_requests__links_ab3') }}
select
    _airbyte_pull_requests_hashid,
    html,
    self,
    issue,
    commits,
    comments,
    statuses,
    review_comment,
    review_comments,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte__links_hashid
from {{ ref('pull_requests__links_ab3') }}
-- _links at pull_requests/_links from {{ ref('pull_requests') }}
where 1 = 1

