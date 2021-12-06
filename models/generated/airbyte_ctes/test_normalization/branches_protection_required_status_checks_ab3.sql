{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_test_normalization",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('branches_protection_required_status_checks_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_protection_hashid',
        array_to_string('contexts'),
        'enforcement_level',
    ]) }} as _airbyte_required_status_checks_hashid,
    tmp.*
from {{ ref('branches_protection_required_status_checks_ab2') }} tmp
-- required_status_checks at branches/protection/required_status_checks
where 1 = 1

