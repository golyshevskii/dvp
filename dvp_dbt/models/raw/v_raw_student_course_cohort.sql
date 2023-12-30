select
    scc.course_id as course_bk,
    upper(trim(scc.course_cohort)) as cohort_bk,
    scc.student_lms_id as student_bk,
    (upper(trim(scc.course_cohort)) || '>' || scc.student_lms_id)::varchar(110) as purchase_bk,
    lower(trim(scc.student_email)) as student_email,
    initcap(trim(scc.student_name)) as student_name,
    scc.student_progress,
    scc.load_dt
from {{ source('dvp_raw', 'raw_student_course_cohort') }} scc
where scc.load_dt > (
    select max(load_dt) from {{ source('dvp_raw_vault', 'hub_purchase') }}
)