{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "test_normalization",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('pull_requests__links_comments_ab3') }}
select
    _airbyte__links_hashid,
    href,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_comments_hashid
from {{ ref('pull_requests__links_comments_ab3') }}
-- comments at pull_requests/_links/comments from {{ ref('pull_requests__links') }}
where 1 = 1

