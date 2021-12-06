{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_test_normalization",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('workflow_runs_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'total_count',
        array_to_string('workflow_runs'),
    ]) }} as _airbyte_workflow_runs_hashid,
    tmp.*
from {{ ref('workflow_runs_ab2') }} tmp
-- workflow_runs
where 1 = 1

