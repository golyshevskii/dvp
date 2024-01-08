{{
    config(
        schema="vault",
        materialized="incremental",
        indexes=[
            {"columns": ["line_hk"], "unique": True, "type": "btree"},
            {"columns": ["course_line_bk"], "type": "btree"},
            {"columns": ["load_dt"], "type": "btree"},
        ]
    ) 
}}

{% set source_model = "v_stg_course" %}
{% set src_pk = "line_hk" %}
{% set src_nk = "course_line_bk::varchar(50)" %}
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
