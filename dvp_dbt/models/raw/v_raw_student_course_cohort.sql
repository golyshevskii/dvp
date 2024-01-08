select
    scc.course_id as course_bk,
    upper(trim(scc.course_cohort)) as cohort_bk,
    scc.student_id as student_bk,
    lower(trim(scc.student_email)) as student_email,
    lower(trim(scc.student_username)) as student_username,
    initcap(trim(scc.student_name)) as student_name,
    scc.student_enrollment_dt,
    scc.load_dt
from {{ source('dvp_raw', 'raw_student_course_cohort') }} scc
where scc.load_dt > (
    select coalesce(max(load_dt), '1970-01-01') 
    from {{ source('dvp_raw_vault', 't_link_student_cohort') }}
    )