{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_test_normalization",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('jobs_jobs_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_jobs_hashid',
        'id',
        'url',
        'name',
        array_to_string('steps'),
        array_to_string('labels'),
        'run_id',
        'status',
        'node_id',
        'run_url',
        'head_sha',
        'html_url',
        'runner_id',
        'conclusion',
        'started_at',
        'runner_name',
        'completed_at',
        'check_run_url',
        'runner_group_id',
        'runner_group_name',
    ]) }} as _airbyte_jobs_2_hashid,
    tmp.*
from {{ ref('jobs_jobs_ab2') }} tmp
-- jobs at jobs/jobs
where 1 = 1

