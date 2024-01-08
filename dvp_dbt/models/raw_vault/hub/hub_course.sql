{{
    config(
        schema="vault",
        materialized="incremental",
        indexes=[
            {"columns": ["course_hk"], "unique": True, "type": "btree"},
            {"columns": ["course_bk"], "type": "btree"},
            {"columns": ["load_dt"], "type": "btree"},
        ]
    ) 
}}

{% set source_model = ["v_stg_course", "v_stg_student_course_cohort"] %}
{% set src_pk = "course_hk" %}
{% set src_nk = "course_bk::varchar(200)" %}
{% set src_ldts = "load_dt" %}
{% set src_source = "record_source::varchar(10)" %}

{{
    automate_dv.hub(
        src_pk=src_pk,
        src_nk=src_nk,
        src_ldts=src_ldts,
        src_source=src_source, 
        source_model=source_model
    )
}}
