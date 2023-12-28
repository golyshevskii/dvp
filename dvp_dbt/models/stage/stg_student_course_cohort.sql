{{
    config(
        materialized='view'
    ) 
}}

{%- set yaml_metadata -%}
source_model:
    dvp_raw: "raw_student_course_cohort"
derived_columns:
    record_source: "!LMS"
    effective_from_dt: load_dt
hashed_columns:
    course_hk: course_id
    cohort_hk: course_cohort
    student_hk: student_lms_id
    purchase_hk:
        - course_cohort
        - student_lms_id
    student_hashdiff:
        is_hashdiff: true
        columns:
            - student_lms_id
            - student_email
            - student_name
{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}

{% set source_model = metadata_dict['source_model'] %}
{% set derived_columns = metadata_dict['derived_columns'] %}
{% set hashed_columns = metadata_dict['hashed_columns'] %}

{{
    automate_dv.stage(
        include_source_columns=true,
        source_model=source_model,
        derived_columns=derived_columns,
        hashed_columns=hashed_columns
    ) 
}}