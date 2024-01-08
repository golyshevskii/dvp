{{
    config(
        schema="vault",
        materialized="incremental",
        indexes=[
            {"columns": ["hashdiff"], "unique": True, "type": "btree"},
            {"columns": ["student_hk"], "type": "btree"},
            {"columns": ["student_email"], "type": "btree"},
            {"columns": ["load_dt"], "type": "btree"},
        ]
    ) 
}}

{%- set yaml_metadata -%}
source_model: "v_stg_student_course_cohort"
src_pk: "student_hk"
src_hashdiff: 
    source_column: "student_hashdiff"
    alias: "hashdiff"
src_payload:
    - "student_email"
    - "student_username"
    - "student_name"
src_ldts: "load_dt"
src_source: "record_source::varchar(10)"
{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}

{{
    automate_dv.sat(
        source_model=metadata_dict["source_model"],
        src_pk=metadata_dict["src_pk"],
        src_hashdiff=metadata_dict["src_hashdiff"],
        src_payload=metadata_dict["src_payload"],
        src_ldts=metadata_dict["src_ldts"],
        src_source=metadata_dict["src_source"]
    )
}}
