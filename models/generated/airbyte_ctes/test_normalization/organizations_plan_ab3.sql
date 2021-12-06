{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_test_normalization",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('organizations_plan_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_organizations_hashid',
        'name',
        'seats',
        'space',
        'filled_seats',
        'private_repos',
    ]) }} as _airbyte_plan_hashid,
    tmp.*
from {{ ref('organizations_plan_ab2') }} tmp
-- plan at organizations/plan
where 1 = 1

