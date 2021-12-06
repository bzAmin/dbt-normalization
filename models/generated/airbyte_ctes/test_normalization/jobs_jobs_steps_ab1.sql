{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_test_normalization",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('jobs_jobs') }}
{{ unnest_cte('jobs_jobs', 'jobs', 'steps') }}
select
    _airbyte_jobs_2_hashid,
    {{ json_extract_scalar(unnested_column_value('steps'), ['name'], ['name']) }} as name,
    {{ json_extract_scalar(unnested_column_value('steps'), ['number'], ['number']) }} as number,
    {{ json_extract_scalar(unnested_column_value('steps'), ['status'], ['status']) }} as status,
    {{ json_extract_scalar(unnested_column_value('steps'), ['conclusion'], ['conclusion']) }} as conclusion,
    {{ json_extract_scalar(unnested_column_value('steps'), ['started_at'], ['started_at']) }} as started_at,
    {{ json_extract_scalar(unnested_column_value('steps'), ['completed_at'], ['completed_at']) }} as completed_at,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('jobs_jobs') }} as table_alias
-- steps at jobs/jobs/steps
{{ cross_join_unnest('jobs', 'steps') }}
where 1 = 1
and steps is not null

