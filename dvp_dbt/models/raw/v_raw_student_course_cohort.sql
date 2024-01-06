select
    scc.course_id as course_bk,
    upper(trim(scc.course_cohort)) as cohort_bk,
    scc.student_id as student_bk,
    lower(trim(scc.student_email)) as student_email,
    lower(trim(scc.student_username)) as student_username,
    initcap(trim(scc.student_name)) as student_name,
    scc.enrollment_dt,
    scc.load_dt
from {{ source('dvp_raw', 'raw_student_course_cohort') }} scc
