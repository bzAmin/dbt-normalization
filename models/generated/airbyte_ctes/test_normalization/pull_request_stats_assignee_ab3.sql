{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_test_normalization",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('pull_request_stats_assignee_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_pull_request_stats_hashid',
        'id',
        'url',
        'type',
        'login',
        'node_id',
        'html_url',
        'gists_url',
        'repos_url',
        'avatar_url',
        'events_url',
        boolean_to_string('site_admin'),
        'gravatar_id',
        'starred_url',
        'followers_url',
        'following_url',
        'organizations_url',
        'subscriptions_url',
        'received_events_url',
    ]) }} as _airbyte_assignee_hashid,
    tmp.*
from {{ ref('pull_request_stats_assignee_ab2') }} tmp
-- assignee at pull_request_stats/assignee
where 1 = 1

