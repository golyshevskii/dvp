select
    upper(trim(c.course_line)) as course_line_bk,
    c.course_id as course_bk,
    upper(trim(c.course_tag)) as course_tag,
    c.course_title,
    c.course_start_dt,
    c.course_end_dt,
    c.load_dt
from {{ source('dvp_raw', 'raw_course') }} c
where c.load_dt > (
    select coalesce(max(load_dt), '1970-01-01') as max_load_dt
    from {{ source('dvp_raw_vault', 'hub_course') }}
    )