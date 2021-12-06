{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "test_normalization",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('organizations_plan_ab3') }}
select
    _airbyte_organizations_hashid,
    name,
    seats,
    space,
    filled_seats,
    private_repos,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_plan_hashid
from {{ ref('organizations_plan_ab3') }}
-- plan at organizations/plan from {{ ref('organizations') }}
where 1 = 1

