{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_test_normalization",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('jobs_jobs_steps_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_jobs_2_hashid',
        'name',
        'number',
        'status',
        'conclusion',
        'started_at',
        'completed_at',
    ]) }} as _airbyte_steps_hashid,
    tmp.*
from {{ ref('jobs_jobs_steps_ab2') }} tmp
-- steps at jobs/jobs/steps
where 1 = 1

