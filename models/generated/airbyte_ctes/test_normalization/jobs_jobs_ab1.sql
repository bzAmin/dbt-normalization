{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_test_normalization",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('jobs') }}
{{ unnest_cte('jobs', 'jobs', 'jobs') }}
select
    _airbyte_jobs_hashid,
    {{ json_extract_scalar(unnested_column_value('jobs'), ['id'], ['id']) }} as id,
    {{ json_extract_scalar(unnested_column_value('jobs'), ['url'], ['url']) }} as url,
    {{ json_extract_scalar(unnested_column_value('jobs'), ['name'], ['name']) }} as name,
    {{ json_extract_array(unnested_column_value('jobs'), ['steps'], ['steps']) }} as steps,
    {{ json_extract_array(unnested_column_value('jobs'), ['labels'], ['labels']) }} as labels,
    {{ json_extract_scalar(unnested_column_value('jobs'), ['run_id'], ['run_id']) }} as run_id,
    {{ json_extract_scalar(unnested_column_value('jobs'), ['status'], ['status']) }} as status,
    {{ json_extract_scalar(unnested_column_value('jobs'), ['node_id'], ['node_id']) }} as node_id,
    {{ json_extract_scalar(unnested_column_value('jobs'), ['run_url'], ['run_url']) }} as run_url,
    {{ json_extract_scalar(unnested_column_value('jobs'), ['head_sha'], ['head_sha']) }} as head_sha,
    {{ json_extract_scalar(unnested_column_value('jobs'), ['html_url'], ['html_url']) }} as html_url,
    {{ json_extract_scalar(unnested_column_value('jobs'), ['runner_id'], ['runner_id']) }} as runner_id,
    {{ json_extract_scalar(unnested_column_value('jobs'), ['conclusion'], ['conclusion']) }} as conclusion,
    {{ json_extract_scalar(unnested_column_value('jobs'), ['started_at'], ['started_at']) }} as started_at,
    {{ json_extract_scalar(unnested_column_value('jobs'), ['runner_name'], ['runner_name']) }} as runner_name,
    {{ json_extract_scalar(unnested_column_value('jobs'), ['completed_at'], ['completed_at']) }} as completed_at,
    {{ json_extract_scalar(unnested_column_value('jobs'), ['check_run_url'], ['check_run_url']) }} as check_run_url,
    {{ json_extract_scalar(unnested_column_value('jobs'), ['runner_group_id'], ['runner_group_id']) }} as runner_group_id,
    {{ json_extract_scalar(unnested_column_value('jobs'), ['runner_group_name'], ['runner_group_name']) }} as runner_group_name,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('jobs') }} as table_alias
-- jobs at jobs/jobs
{{ cross_join_unnest('jobs', 'jobs') }}
where 1 = 1
and jobs is not null

