{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_test_normalization",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('jobs_jobs_ab1') }}
select
    _airbyte_jobs_hashid,
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(url as {{ dbt_utils.type_string() }}) as url,
    cast(name as {{ dbt_utils.type_string() }}) as name,
    steps,
    labels,
    cast(run_id as {{ dbt_utils.type_bigint() }}) as run_id,
    cast(status as {{ dbt_utils.type_string() }}) as status,
    cast(node_id as {{ dbt_utils.type_string() }}) as node_id,
    cast(run_url as {{ dbt_utils.type_string() }}) as run_url,
    cast(head_sha as {{ dbt_utils.type_string() }}) as head_sha,
    cast(html_url as {{ dbt_utils.type_string() }}) as html_url,
    cast(runner_id as {{ dbt_utils.type_bigint() }}) as runner_id,
    cast(conclusion as {{ dbt_utils.type_string() }}) as conclusion,
    cast(started_at as {{ dbt_utils.type_string() }}) as started_at,
    cast(runner_name as {{ dbt_utils.type_string() }}) as runner_name,
    cast(completed_at as {{ dbt_utils.type_string() }}) as completed_at,
    cast(check_run_url as {{ dbt_utils.type_string() }}) as check_run_url,
    cast(runner_group_id as {{ dbt_utils.type_bigint() }}) as runner_group_id,
    cast(runner_group_name as {{ dbt_utils.type_string() }}) as runner_group_name,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('jobs_jobs_ab1') }}
-- jobs at jobs/jobs
where 1 = 1

