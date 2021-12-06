{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_test_normalization",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('organizations') }}
select
    _airbyte_organizations_hashid,
    {{ json_extract_scalar('plan', ['name'], ['name']) }} as name,
    {{ json_extract_scalar('plan', ['seats'], ['seats']) }} as seats,
    {{ json_extract_scalar('plan', ['space'], ['space']) }} as space,
    {{ json_extract_scalar('plan', ['filled_seats'], ['filled_seats']) }} as filled_seats,
    {{ json_extract_scalar('plan', ['private_repos'], ['private_repos']) }} as private_repos,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('organizations') }} as table_alias
-- plan at organizations/plan
where 1 = 1
and plan is not null

