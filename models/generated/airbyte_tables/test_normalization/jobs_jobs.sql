{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "test_normalization",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('jobs_jobs_ab3') }}
select
    _airbyte_jobs_hashid,
    id,
    url,
    name,
    steps,
    labels,
    run_id,
    status,
    node_id,
    run_url,
    head_sha,
    html_url,
    runner_id,
    conclusion,
    started_at,
    runner_name,
    completed_at,
    check_run_url,
    runner_group_id,
    runner_group_name,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_jobs_2_hashid
from {{ ref('jobs_jobs_ab3') }}
-- jobs at jobs/jobs from {{ ref('jobs') }}
where 1 = 1

