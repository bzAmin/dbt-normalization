{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "test_normalization",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('workflows_workflows_ab3') }}
select
    _airbyte_workflows_hashid,
    id,
    url,
    name,
    path,
    state,
    node_id,
    html_url,
    badge_url,
    created_at,
    updated_at,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_workflows_2_hashid
from {{ ref('workflows_workflows_ab3') }}
-- workflows at workflows/workflows from {{ ref('workflows') }}
where 1 = 1

