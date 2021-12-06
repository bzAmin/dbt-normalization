{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "test_normalization",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('pull_requests_head_ab3') }}
select
    _airbyte_pull_requests_hashid,
    ref,
    sha,
    label,
    repo_id,
    user_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_head_hashid
from {{ ref('pull_requests_head_ab3') }}
-- head at pull_requests/head from {{ ref('pull_requests') }}
where 1 = 1

