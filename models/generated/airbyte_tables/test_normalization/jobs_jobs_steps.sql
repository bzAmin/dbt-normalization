{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "test_normalization",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('jobs_jobs_steps_ab3') }}
select
    _airbyte_jobs_2_hashid,
    name,
    number,
    status,
    conclusion,
    started_at,
    completed_at,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_steps_hashid
from {{ ref('jobs_jobs_steps_ab3') }}
-- steps at jobs/jobs/steps from {{ ref('jobs_jobs') }}
where 1 = 1

