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
    {{ json_extract_scalar('milestone', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('milestone', ['url'], ['url']) }} as url,
    {{ json_extract_scalar('milestone', ['state'], ['state']) }} as state,
    {{ json_extract_scalar('milestone', ['title'], ['title']) }} as title,
    {{ json_extract_scalar('milestone', ['due_on'], ['due_on']) }} as due_on,
    {{ json_extract_scalar('milestone', ['number'], ['number']) }} as number,
    {{ json_extract('table_alias', 'milestone', ['creator'], ['creator']) }} as creator,
    {{ json_extract_scalar('milestone', ['node_id'], ['node_id']) }} as node_id,
    {{ json_extract_scalar('milestone', ['html_url'], ['html_url']) }} as html_url,
    {{ json_extract_scalar('milestone', ['closed_at'], ['closed_at']) }} as closed_at,
    {{ json_extract_scalar('milestone', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('milestone', ['labels_url'], ['labels_url']) }} as labels_url,
    {{ json_extract_scalar('milestone', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('milestone', ['description'], ['description']) }} as description,
    {{ json_extract_scalar('milestone', ['open_issues'], ['open_issues']) }} as open_issues,
    {{ json_extract_scalar('milestone', ['closed_issues'], ['closed_issues']) }} as closed_issues,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('pull_request_stats') }} as table_alias
-- milestone at pull_request_stats/milestone
where 1 = 1
and milestone is not null

