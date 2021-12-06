{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_test_normalization",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('workflow_runs_workflow_runs_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_workflow_runs_hashid',
        'id',
        'url',
        'name',
        'status',
        'node_id',
        'html_url',
        'conclusion',
        'created_at',
        'run_number',
        'updated_at',
        'head_branch',
        'workflow_id',
    ]) }} as _airbyte_workflow_runs_2_hashid,
    tmp.*
from {{ ref('workflow_runs_workflow_runs_ab2') }} tmp
-- workflow_runs at workflow_runs/workflow_runs
where 1 = 1

