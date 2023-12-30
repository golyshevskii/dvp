{{
    config(
        materialized="view"
    ) 
}}

{%- set yaml_metadata -%}
source_model: v_raw_student_course_cohort
derived_columns:
    record_source: "!LMS"
    start_dt: load_dt
    end_dt: to_date('9999-12-31', 'YYYY-MM-DD')
hashed_columns:
    course_hk: course_bk
    cohort_hk: cohort_bk
    student_hk: student_bk
    course_cohort_hk:
        - course_bk
        - cohort_bk
    student_course_hk:
        - student_bk
        - course_bk
    student_cohort_hk:
        - student_bk
        - cohort_bk
    student_hashdiff:
        is_hashdiff: true
        columns:
            - student_bk
            - student_email
            - student_name
{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}

{% set source_model = metadata_dict["source_model"] %}
{% set derived_columns = metadata_dict["derived_columns"] %}
{% set hashed_columns = metadata_dict["hashed_columns"] %}

{{
    automate_dv.stage(
        include_source_columns=true,
        source_model=source_model,
        derived_columns=derived_columns,
        hashed_columns=hashed_columns
    ) 
}}
