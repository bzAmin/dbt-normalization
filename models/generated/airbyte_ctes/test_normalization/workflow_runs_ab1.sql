{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_test_normalization",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('test_normalization', '_airbyte_raw_workflow_runs') }}
select
    {{ json_extract_scalar('_airbyte_data', ['total_count'], ['total_count']) }} as total_count,
    {{ json_extract_array('_airbyte_data', ['workflow_runs'], ['workflow_runs']) }} as workflow_runs,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('test_normalization', '_airbyte_raw_workflow_runs') }} as table_alias
-- workflow_runs
where 1 = 1
