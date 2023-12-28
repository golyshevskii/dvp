select
    scc.course_id,
    scc.course_cohort,
    scc.student_lms_id,
    scc.student_email,
    scc.student_name,
    scc.student_progress,
    scc.load_dt
from {{ source('dvp_raw', 'raw_student_course_cohort') }} scc;
