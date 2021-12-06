{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_test_normalization",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('branches') }}
select
    _airbyte_branches_hashid,
    {{ json_extract('table_alias', 'protection', ['required_status_checks'], ['required_status_checks']) }} as required_status_checks,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('branches') }} as table_alias
-- protection at branches/protection
where 1 = 1
and protection is not null

