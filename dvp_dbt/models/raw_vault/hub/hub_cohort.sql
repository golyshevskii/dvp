{{
    config(
        schema='vault',
        materialized='incremental',
        indexes=[
            {'columns': ['cohort_bk'], 'unique': True, 'type': 'btree'},
            {'columns': ['cohort_hk'], 'type': 'btree'},
            {'columns': ['load_dt'], 'type': 'btree'},
        ]
    ) 
}}

{%- set yaml_metadata -%}
source_model: v_stg_student_course_cohort
src_pk: cohort_hk
src_nk: cohort_bk::varchar(100)
src_ldts: load_dt
src_source: record_source::varchar(10)
{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}

{% set source_model = metadata_dict['source_model'] %}
{% set src_pk = metadata_dict['src_pk'] %}
{% set src_nk = metadata_dict['src_nk'] %}
{% set src_ldts = metadata_dict['src_ldts'] %}
{% set src_source = metadata_dict['src_source'] %}

{{
    automate_dv.hub(
        src_pk=src_pk,
        src_nk=src_nk,
        src_ldts=src_ldts,
        src_source=src_source, 
        source_model=source_model
    )
}}
