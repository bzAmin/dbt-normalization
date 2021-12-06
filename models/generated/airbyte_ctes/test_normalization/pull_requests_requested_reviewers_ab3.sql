{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_test_normalization",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('pull_requests_requested_reviewers_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_pull_requests_hashid',
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
    ]) }} as _airbyte_requested_reviewers_hashid,
    tmp.*
from {{ ref('pull_requests_requested_reviewers_ab2') }} tmp
-- requested_reviewers at pull_requests/requested_reviewers
where 1 = 1
