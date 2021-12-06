{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "test_normalization",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('pull_request_stats_base_repo_permissions_ab3') }}
select
    _airbyte_repo_hashid,
    pull,
    push,
    admin,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_permissions_hashid
from {{ ref('pull_request_stats_base_repo_permissions_ab3') }}
-- permissions at pull_request_stats/base/repo/permissions from {{ ref('pull_request_stats_base_repo') }}
where 1 = 1

