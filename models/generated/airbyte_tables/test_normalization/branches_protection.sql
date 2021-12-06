{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "test_normalization",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('branches_protection_ab3') }}
select
    _airbyte_branches_hashid,
    required_status_checks,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_protection_hashid
from {{ ref('branches_protection_ab3') }}
-- protection at branches/protection from {{ ref('branches') }}
where 1 = 1

