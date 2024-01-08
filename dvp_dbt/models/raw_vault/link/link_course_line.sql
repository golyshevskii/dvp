{{
    config(
        schema="vault",
        materialized="incremental",
        indexes=[
            {"columns": ["course_line_hk"], "unique": True, "type": "btree"},
            {"columns": ["course_hk"], "type": "btree"},
            {"columns": ["line_hk"], "type": "btree"},
            {"columns": ["load_dt"], "type": "btree"},
        ]
    )
}}

{%- set source_model = "v_stg_course" -%}
{%- set src_pk = "course_line_hk" -%}
{%- set src_fk = ["course_hk", "line_hk"] -%}
{%- set src_ldts = "load_dt" -%}
{%- set src_source = "record_source::varchar(10)" -%}

{{
    automate_dv.link(
        src_pk=src_pk,
        src_fk=src_fk,
        src_ldts=src_ldts,
        src_source=src_source,
        source_model=source_model
    )
}}
