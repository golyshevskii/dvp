with raw_course as (
    select
    decode(md5(nullif(upper(trim(course_id)), '')), 'hex') as course_hk,
    course_id as course_bk,
    load_dt,
    '2' as record_source
    from raw.raw_course
)
select
rc.course_hk,
rc.course_bk,
rc.load_dt,
rc.record_source
from raw_course rc
left join raw_vault.hub_course hc on rc.course_hk = hc.course_hk
where hc.course_hk is null;
