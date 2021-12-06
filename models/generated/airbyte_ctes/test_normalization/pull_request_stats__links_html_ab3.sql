{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_test_normalization",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('pull_request_stats__links_html_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte__links_hashid',
        'href',
    ]) }} as _airbyte_html_hashid,
    tmp.*
from {{ ref('pull_request_stats__links_html_ab2') }} tmp
-- html at pull_request_stats/_links/html
where 1 = 1

