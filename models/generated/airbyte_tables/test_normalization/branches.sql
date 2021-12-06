{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "test_normalization",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('branches_ab3') }}
select
    name,
    commit,
    protected,
    protection,
    repository,
    protection_url,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_branches_hashid
from {{ ref('branches_ab3') }}
-- branches from {{ source('test_normalization', '_airbyte_raw_branches') }}
where 1 = 1

