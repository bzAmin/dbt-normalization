{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_test_normalization",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('pull_request_stats_base_repo_owner_ab1') }}
select
    _airbyte_repo_hashid,
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(url as {{ dbt_utils.type_string() }}) as url,
    cast(type as {{ dbt_utils.type_string() }}) as type,
    cast(login as {{ dbt_utils.type_string() }}) as login,
    cast(node_id as {{ dbt_utils.type_string() }}) as node_id,
    cast(html_url as {{ dbt_utils.type_string() }}) as html_url,
    cast(gists_url as {{ dbt_utils.type_string() }}) as gists_url,
    cast(repos_url as {{ dbt_utils.type_string() }}) as repos_url,
    cast(avatar_url as {{ dbt_utils.type_string() }}) as avatar_url,
    cast(events_url as {{ dbt_utils.type_string() }}) as events_url,
    {{ cast_to_boolean('site_admin') }} as site_admin,
    cast(gravatar_id as {{ dbt_utils.type_string() }}) as gravatar_id,
    cast(starred_url as {{ dbt_utils.type_string() }}) as starred_url,
    cast(followers_url as {{ dbt_utils.type_string() }}) as followers_url,
    cast(following_url as {{ dbt_utils.type_string() }}) as following_url,
    cast(organizations_url as {{ dbt_utils.type_string() }}) as organizations_url,
    cast(subscriptions_url as {{ dbt_utils.type_string() }}) as subscriptions_url,
    cast(received_events_url as {{ dbt_utils.type_string() }}) as received_events_url,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('pull_request_stats_base_repo_owner_ab1') }}
-- owner at pull_request_stats/base/repo/owner
where 1 = 1

