{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_test_normalization",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('jobs_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        array_to_string('jobs'),
        'total_count',
    ]) }} as _airbyte_jobs_hashid,
    tmp.*
from {{ ref('jobs_ab2') }} tmp
-- jobs
where 1 = 1

