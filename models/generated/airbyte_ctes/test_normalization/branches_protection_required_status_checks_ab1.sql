{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_test_normalization",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('branches_protection') }}
select
    _airbyte_protection_hashid,
    {{ json_extract_array('required_status_checks', ['contexts'], ['contexts']) }} as contexts,
    {{ json_extract_scalar('required_status_checks', ['enforcement_level'], ['enforcement_level']) }} as enforcement_level,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('branches_protection') }} as table_alias
-- required_status_checks at branches/protection/required_status_checks
where 1 = 1
and required_status_checks is not null

