{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_test_normalization",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('workflows_workflows_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_workflows_hashid',
        'id',
        'url',
        'name',
        'path',
        'state',
        'node_id',
        'html_url',
        'badge_url',
        'created_at',
        'updated_at',
    ]) }} as _airbyte_workflows_2_hashid,
    tmp.*
from {{ ref('workflows_workflows_ab2') }} tmp
-- workflows at workflows/workflows
where 1 = 1

