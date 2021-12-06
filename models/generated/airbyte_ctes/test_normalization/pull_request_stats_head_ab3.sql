{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_test_normalization",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('pull_request_stats_head_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_pull_request_stats_hashid',
        'ref',
        'sha',
        'repo',
        'user',
        'label',
    ]) }} as _airbyte_head_hashid,
    tmp.*
from {{ ref('pull_request_stats_head_ab2') }} tmp
-- head at pull_request_stats/head
where 1 = 1

