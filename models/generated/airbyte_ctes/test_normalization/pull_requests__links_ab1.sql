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
    {{ json_extract('table_alias', '_links', ['html'], ['html']) }} as html,
    {{ json_extract('table_alias', '_links', ['self'], ['self']) }} as self,
    {{ json_extract('table_alias', '_links', ['issue'], ['issue']) }} as issue,
    {{ json_extract('table_alias', '_links', ['commits'], ['commits']) }} as commits,
    {{ json_extract('table_alias', '_links', ['comments'], ['comments']) }} as comments,
    {{ json_extract('table_alias', '_links', ['statuses'], ['statuses']) }} as statuses,
    {{ json_extract('table_alias', '_links', ['review_comment'], ['review_comment']) }} as review_comment,
    {{ json_extract('table_alias', '_links', ['review_comments'], ['review_comments']) }} as review_comments,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('pull_requests') }} as table_alias
-- _links at pull_requests/_links
where 1 = 1
and _links is not null

