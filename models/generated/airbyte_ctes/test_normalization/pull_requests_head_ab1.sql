{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_test_normalization",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('pull_requests') }}
select
    _airbyte_pull_requests_hashid,
    {{ json_extract_scalar('head', ['ref'], ['ref']) }} as ref,
    {{ json_extract_scalar('head', ['sha'], ['sha']) }} as sha,
    {{ json_extract_scalar('head', ['label'], ['label']) }} as label,
    {{ json_extract_scalar('head', ['repo_id'], ['repo_id']) }} as repo_id,
    {{ json_extract_scalar('head', ['user_id'], ['user_id']) }} as user_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('pull_requests') }} as table_alias
-- head at pull_requests/head
where 1 = 1
and head is not null
