with
    agencias as (
        select *
        from {{ ref('stg__agencias') }}
    )

    select *
    from agencias
