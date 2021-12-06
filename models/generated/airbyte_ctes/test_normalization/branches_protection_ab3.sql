{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_test_normalization",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('branches_protection_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_branches_hashid',
        'required_status_checks',
    ]) }} as _airbyte_protection_hashid,
    tmp.*
from {{ ref('branches_protection_ab2') }} tmp
-- protection at branches/protection
where 1 = 1

