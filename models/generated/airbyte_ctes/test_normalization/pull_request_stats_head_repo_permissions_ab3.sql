{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_test_normalization",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('pull_request_stats_head_repo_permissions_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_repo_hashid',
        boolean_to_string('pull'),
        boolean_to_string('push'),
        boolean_to_string('admin'),
    ]) }} as _airbyte_permissions_hashid,
    tmp.*
from {{ ref('pull_request_stats_head_repo_permissions_ab2') }} tmp
-- permissions at pull_request_stats/head/repo/permissions
where 1 = 1

