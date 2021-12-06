{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_test_normalization",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('workflow_runs_workflow_runs_ab1') }}
select
    _airbyte_workflow_runs_hashid,
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(url as {{ dbt_utils.type_string() }}) as url,
    cast(name as {{ dbt_utils.type_string() }}) as name,
    cast(status as {{ dbt_utils.type_string() }}) as status,
    cast(node_id as {{ dbt_utils.type_string() }}) as node_id,
    cast(html_url as {{ dbt_utils.type_string() }}) as html_url,
    conclusion,
    cast(created_at as {{ dbt_utils.type_string() }}) as created_at,
    cast(run_number as {{ dbt_utils.type_bigint() }}) as run_number,
    cast(updated_at as {{ dbt_utils.type_string() }}) as updated_at,
    cast(head_branch as {{ dbt_utils.type_string() }}) as head_branch,
    cast(workflow_id as {{ dbt_utils.type_bigint() }}) as workflow_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('workflow_runs_workflow_runs_ab1') }}
-- workflow_runs at workflow_runs/workflow_runs
where 1 = 1

