{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_test_normalization",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('pull_request_stats_requested_teams_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_pull_request_stats_hashid',
        'id',
        'url',
        'name',
        'slug',
        'node_id',
        'privacy',
        'html_url',
        'permission',
        'description',
        'members_url',
        'repositories_url',
    ]) }} as _airbyte_requested_teams_hashid,
    tmp.*
from {{ ref('pull_request_stats_requested_teams_ab2') }} tmp
-- requested_teams at pull_request_stats/requested_teams
where 1 = 1

