{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "test_normalization",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('workflow_runs_workflow_runs_ab3') }}
select
    _airbyte_workflow_runs_hashid,
    id,
    url,
    name,
    status,
    node_id,
    html_url,
    conclusion,
    created_at,
    run_number,
    updated_at,
    head_branch,
    workflow_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_workflow_runs_2_hashid
from {{ ref('workflow_runs_workflow_runs_ab3') }}
-- workflow_runs at workflow_runs/workflow_runs from {{ ref('workflow_runs') }}
where 1 = 1

