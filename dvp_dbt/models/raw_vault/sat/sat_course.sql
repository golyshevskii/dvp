{{
    config(
        schema="vault",
        materialized="incremental",
        indexes=[
            {"columns": ["hashdiff"], "unique": True, "type": "btree"},
            {"columns": ["course_hk"], "type": "btree"},
            {"columns": ["course_tag"], "type": "btree"},
            {"columns": ["course_start_dt"], "type": "btree"},
            {"columns": ["course_end_dt"], "type": "btree"},
            {"columns": ["load_dt"], "type": "btree"},
        ]
    ) 
}}

{%- set yaml_metadata -%}
source_model: "v_stg_course"
src_pk: "course_hk"
src_hashdiff: 
    source_column: "course_hashdiff"
    alias: "hashdiff"
src_payload:
    - "course_tag"
    - "course_title"
    - "course_start_dt"
    - "course_end_dt"
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
