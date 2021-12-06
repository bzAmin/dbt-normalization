{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_test_normalization",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('pull_requests_milestone_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_pull_requests_hashid',
        'id',
        'url',
        'state',
        'title',
        'due_on',
        'number',
        'creator',
        'node_id',
        'html_url',
        'closed_at',
        'created_at',
        'labels_url',
        'updated_at',
        'description',
        'open_issues',
        'closed_issues',
    ]) }} as _airbyte_milestone_hashid,
    tmp.*
from {{ ref('pull_requests_milestone_ab2') }} tmp
-- milestone at pull_requests/milestone
where 1 = 1

