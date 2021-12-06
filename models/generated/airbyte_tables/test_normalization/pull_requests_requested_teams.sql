{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "test_normalization",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('pull_requests_requested_teams_ab3') }}
select
    _airbyte_pull_requests_hashid,
    id,
    url,
    name,
    slug,
    parent,
    node_id,
    privacy,
    html_url,
    permission,
    description,
    members_url,
    repositories_url,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_requested_teams_hashid
from {{ ref('pull_requests_requested_teams_ab3') }}
-- requested_teams at pull_requests/requested_teams from {{ ref('pull_requests') }}
where 1 = 1

