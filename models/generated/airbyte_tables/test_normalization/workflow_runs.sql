{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "test_normalization",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('workflow_runs_ab3') }}
select
    total_count,
    workflow_runs,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_workflow_runs_hashid
from {{ ref('workflow_runs_ab3') }}
-- workflow_runs from {{ source('test_normalization', '_airbyte_raw_workflow_runs') }}
where 1 = 1

