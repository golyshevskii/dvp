with raw_course as (
    select
    decode(md5(nullif(concat(
    	coalesce(nullif(upper(trim(course_line)), ''), '^^'), '||',
    	coalesce(nullif(upper(trim(course_id)), ''), '^^')
    ), '^^||^^')), 'hex') as course_line_hk,
    decode(md5(nullif(upper(trim(course_id)), '')), 'hex') as course_hk,
    decode(md5(nullif(upper(trim(course_line)), '')), 'hex') as line_hk,
    load_dt,
    '2' as record_source
    from raw.raw_course
)
select
rc.course_line_hk,
rc.course_hk,
rc.line_hk,
rc.load_dt,
rc.record_source
from raw_course rc
left join raw_vault.link_course_line lcl on rc.course_line_hk = lcl.course_line_hk
where lcl.course_line_hk is null;
