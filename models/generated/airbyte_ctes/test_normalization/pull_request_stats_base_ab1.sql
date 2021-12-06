{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_test_normalization",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('pull_request_stats') }}
select
    _airbyte_pull_request_stats_hashid,
    {{ json_extract_scalar('base', ['ref'], ['ref']) }} as ref,
    {{ json_extract_scalar('base', ['sha'], ['sha']) }} as sha,
    {{ json_extract('table_alias', 'base', ['repo'], ['repo']) }} as repo,
    {{ json_extract('table_alias', 'base', ['user'], ['user']) }} as user,
    {{ json_extract_scalar('base', ['label'], ['label']) }} as label,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('pull_request_stats') }} as table_alias
-- base at pull_request_stats/base
where 1 = 1
and base is not null

