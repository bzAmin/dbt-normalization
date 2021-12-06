{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_test_normalization",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('pull_request_stats_head_repo_license_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_repo_hashid',
        'key',
        'url',
        'name',
        'node_id',
        'spdx_id',
    ]) }} as _airbyte_license_hashid,
    tmp.*
from {{ ref('pull_request_stats_head_repo_license_ab2') }} tmp
-- license at pull_request_stats/head/repo/license
where 1 = 1

