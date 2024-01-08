{{
    config(
        materialized="view"
    ) 
}}

{%- set yaml_metadata -%}
source_model: "v_raw_course"
derived_columns:
    record_source: "!1"
    effective_from: "course_start_dt"
hashed_columns:
    line_hk: "course_line_bk"
    course_hk: "course_bk"
    course_line_hk:
        - "course_line_bk"
        - "course_bk"
    course_hashdiff:
        is_hashdiff: true
        columns:
            - "course_bk"
            - "course_tag"
            - "course_title"
            - "course_end_dt"
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
