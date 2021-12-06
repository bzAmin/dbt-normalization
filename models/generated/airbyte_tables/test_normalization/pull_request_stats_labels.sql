{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "test_normalization",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('pull_request_stats_labels_ab3') }}
select
    _airbyte_pull_request_stats_hashid,
    id,
    url,
    name,
    color,
    {{ adapter.quote('default') }},
    node_id,
    description,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_labels_hashid
from {{ ref('pull_request_stats_labels_ab3') }}
-- labels at pull_request_stats/labels from {{ ref('pull_request_stats') }}
where 1 = 1

