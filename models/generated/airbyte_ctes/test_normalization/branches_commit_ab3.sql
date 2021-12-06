{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_test_normalization",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('branches_commit_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_branches_hashid',
        'sha',
        'url',
    ]) }} as _airbyte_commit_hashid,
    tmp.*
from {{ ref('branches_commit_ab2') }} tmp
-- commit at branches/commit
where 1 = 1

