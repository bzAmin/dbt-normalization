{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "test_normalization",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('pull_requests_labels_ab3') }}
select
    _airbyte_pull_requests_hashid,
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
from {{ ref('pull_requests_labels_ab3') }}
-- labels at pull_requests/labels from {{ ref('pull_requests') }}
where 1 = 1

