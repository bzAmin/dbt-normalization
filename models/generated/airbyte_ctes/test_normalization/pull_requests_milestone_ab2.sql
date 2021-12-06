{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_test_normalization",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('pull_requests_milestone_ab1') }}
select
    _airbyte_pull_requests_hashid,
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(url as {{ dbt_utils.type_string() }}) as url,
    cast(state as {{ dbt_utils.type_string() }}) as state,
    cast(title as {{ dbt_utils.type_string() }}) as title,
    cast({{ empty_string_to_null('due_on') }} as {{ type_timestamp_with_timezone() }}) as due_on,
    cast(number as {{ dbt_utils.type_bigint() }}) as number,
    cast(creator as {{ type_json() }}) as creator,
    cast(node_id as {{ dbt_utils.type_string() }}) as node_id,
    cast(html_url as {{ dbt_utils.type_string() }}) as html_url,
    cast({{ empty_string_to_null('closed_at') }} as {{ type_timestamp_with_timezone() }}) as closed_at,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_with_timezone() }}) as created_at,
    cast(labels_url as {{ dbt_utils.type_string() }}) as labels_url,
    cast({{ empty_string_to_null('updated_at') }} as {{ type_timestamp_with_timezone() }}) as updated_at,
    cast(description as {{ dbt_utils.type_string() }}) as description,
    cast(open_issues as {{ dbt_utils.type_bigint() }}) as open_issues,
    cast(closed_issues as {{ dbt_utils.type_bigint() }}) as closed_issues,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('pull_requests_milestone_ab1') }}
-- milestone at pull_requests/milestone
where 1 = 1

