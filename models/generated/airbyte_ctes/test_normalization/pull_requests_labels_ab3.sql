{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_test_normalization",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('pull_requests_labels_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_pull_requests_hashid',
        'id',
        'url',
        'name',
        'color',
        boolean_to_string(adapter.quote('default')),
        'node_id',
        'description',
    ]) }} as _airbyte_labels_hashid,
    tmp.*
from {{ ref('pull_requests_labels_ab2') }} tmp
-- labels at pull_requests/labels
where 1 = 1

