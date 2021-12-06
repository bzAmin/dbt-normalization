{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_test_normalization",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('pull_requests_requested_teams_ab1') }}
select
    _airbyte_pull_requests_hashid,
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(url as {{ dbt_utils.type_string() }}) as url,
    cast(name as {{ dbt_utils.type_string() }}) as name,
    cast(slug as {{ dbt_utils.type_string() }}) as slug,
    cast(parent as {{ type_json() }}) as parent,
    cast(node_id as {{ dbt_utils.type_string() }}) as node_id,
    cast(privacy as {{ dbt_utils.type_string() }}) as privacy,
    cast(html_url as {{ dbt_utils.type_string() }}) as html_url,
    cast(permission as {{ dbt_utils.type_string() }}) as permission,
    cast(description as {{ dbt_utils.type_string() }}) as description,
    cast(members_url as {{ dbt_utils.type_string() }}) as members_url,
    cast(repositories_url as {{ dbt_utils.type_string() }}) as repositories_url,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('pull_requests_requested_teams_ab1') }}
-- requested_teams at pull_requests/requested_teams
where 1 = 1
