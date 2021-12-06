{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "test_normalization",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('repositories_owner_ab3') }}
select
    _airbyte_repositories_hashid,
    id,
    url,
    type,
    login,
    node_id,
    html_url,
    gists_url,
    repos_url,
    avatar_url,
    events_url,
    site_admin,
    gravatar_id,
    starred_url,
    followers_url,
    following_url,
    organizations_url,
    subscriptions_url,
    received_events_url,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_owner_hashid
from {{ ref('repositories_owner_ab3') }}
-- owner at repositories/owner from {{ ref('repositories') }}
where 1 = 1

