{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_test_normalization",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('pull_request_stats__links_ab1') }}
select
    _airbyte_pull_request_stats_hashid,
    cast(html as {{ type_json() }}) as html,
    cast(self as {{ type_json() }}) as self,
    cast(issue as {{ type_json() }}) as issue,
    cast(commits as {{ type_json() }}) as commits,
    cast(comments as {{ type_json() }}) as comments,
    cast(statuses as {{ type_json() }}) as statuses,
    cast(review_comment as {{ type_json() }}) as review_comment,
    cast(review_comments as {{ type_json() }}) as review_comments,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('pull_request_stats__links_ab1') }}
-- _links at pull_request_stats/_links
where 1 = 1

