{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "test_normalization",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('pull_request_stats_base_ab3') }}
select
    _airbyte_pull_request_stats_hashid,
    ref,
    sha,
    repo,
    user,
    label,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_base_hashid
from {{ ref('pull_request_stats_base_ab3') }}
-- base at pull_request_stats/base from {{ ref('pull_request_stats') }}
where 1 = 1
