{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "test_normalization",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('repositories_license_ab3') }}
select
    _airbyte_repositories_hashid,
    key,
    url,
    name,
    node_id,
    spdx_id,
    html_url,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_license_hashid
from {{ ref('repositories_license_ab3') }}
-- license at repositories/license from {{ ref('repositories') }}
where 1 = 1

