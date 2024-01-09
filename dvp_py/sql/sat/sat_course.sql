with raw_course as (
    select
    decode(md5(nullif(upper(trim(course_id)), '')), 'hex') as course_hk,
    decode(md5(concat(
    	coalesce(nullif(upper(trim(course_id)), ''), '^^'), '||',
    	coalesce(nullif(upper(trim(course_end_dt::varchar)), ''), '^^'), '||',
    	coalesce(nullif(upper(trim(course_tag)), ''), '^^'), '||',
    	coalesce(nullif(upper(trim(course_title)), ''), '^^')
    	)), 'hex') as hashdiff,
    course_tag,
    course_title,
    course_start_dt,
    course_end_dt,
    load_dt,
    '2' as record_source
    from raw.raw_course
)
select
rc.course_hk,
rc.hashdiff,
rc.course_tag,
rc.course_title,
rc.course_start_dt,
rc.course_end_dt,
rc.load_dt,
rc.record_source
from raw_course rc
left join raw_vault.sat_course sc on rc.hashdiff = sc.hashdiff
where sc.hashdiff is null;
