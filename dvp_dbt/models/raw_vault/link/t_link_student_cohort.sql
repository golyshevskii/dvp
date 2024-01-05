{{
    config(
        schema="vault",
        materialized="incremental",
        indexes=[
            {"columns": ["student_cohort_hk"], "unique": True, "type": "btree"},
            {"columns": ["student_hk"], "type": "btree"},
            {"columns": ["cohort_hk"], "type": "btree"},
            {"columns": ["enrollment_dt"], "type": "btree"},
            {"columns": ["load_dt"], "type": "btree"},
        ]
    )
}}

{%- set source_model = "v_stg_student_course_cohort" -%}
{%- set src_pk = "student_cohort_hk" -%}
{%- set src_fk = ["student_hk", "cohort_hk"] -%}
{%- set src_eff = "enrollment_dt" -%}
{%- set src_ldts = "load_dt" -%}
{%- set src_source = "record_source::varchar(10)" -%}

{{
    automate_dv.t_link(
        source_model=source_model,
        src_pk=src_pk,
        src_fk=src_fk,
        src_eff=src_eff,
        src_ldts=src_ldts,
        src_source=src_source
    )
}}
