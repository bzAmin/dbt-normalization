{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_test_normalization",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('workflow_runs') }}
{{ unnest_cte('workflow_runs', 'workflow_runs', 'workflow_runs') }}
select
    _airbyte_workflow_runs_hashid,
    {{ json_extract_scalar(unnested_column_value('workflow_runs'), ['id'], ['id']) }} as id,
    {{ json_extract_scalar(unnested_column_value('workflow_runs'), ['url'], ['url']) }} as url,
    {{ json_extract_scalar(unnested_column_value('workflow_runs'), ['name'], ['name']) }} as name,
    {{ json_extract_scalar(unnested_column_value('workflow_runs'), ['status'], ['status']) }} as status,
    {{ json_extract_scalar(unnested_column_value('workflow_runs'), ['node_id'], ['node_id']) }} as node_id,
    {{ json_extract_scalar(unnested_column_value('workflow_runs'), ['html_url'], ['html_url']) }} as html_url,
    {{ json_extract('', unnested_column_value('workflow_runs'), ['conclusion']) }} as conclusion,
    {{ json_extract_scalar(unnested_column_value('workflow_runs'), ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar(unnested_column_value('workflow_runs'), ['run_number'], ['run_number']) }} as run_number,
    {{ json_extract_scalar(unnested_column_value('workflow_runs'), ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar(unnested_column_value('workflow_runs'), ['head_branch'], ['head_branch']) }} as head_branch,
    {{ json_extract_scalar(unnested_column_value('workflow_runs'), ['workflow_id'], ['workflow_id']) }} as workflow_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('workflow_runs') }} as table_alias
-- workflow_runs at workflow_runs/workflow_runs
{{ cross_join_unnest('workflow_runs', 'workflow_runs') }}
where 1 = 1
and workflow_runs is not null

