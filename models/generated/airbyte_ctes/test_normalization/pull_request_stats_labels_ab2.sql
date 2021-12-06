{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_test_normalization",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('pull_request_stats_labels_ab1') }}
select
    _airbyte_pull_request_stats_hashid,
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(url as {{ dbt_utils.type_string() }}) as url,
    cast(name as {{ dbt_utils.type_string() }}) as name,
    cast(color as {{ dbt_utils.type_string() }}) as color,
    {{ cast_to_boolean(adapter.quote('default')) }} as {{ adapter.quote('default') }},
    cast(node_id as {{ dbt_utils.type_string() }}) as node_id,
    cast(description as {{ dbt_utils.type_string() }}) as description,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('pull_request_stats_labels_ab1') }}
-- labels at pull_request_stats/labels
where 1 = 1

