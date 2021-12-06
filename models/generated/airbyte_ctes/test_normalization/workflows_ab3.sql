{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_test_normalization",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('workflows_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        array_to_string('workflows'),
        'total_count',
    ]) }} as _airbyte_workflows_hashid,
    tmp.*
from {{ ref('workflows_ab2') }} tmp
-- workflows
where 1 = 1

