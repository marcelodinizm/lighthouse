with
    colaboradores as (
        SELECT *
        FROM {{ ref('stg__colaboradores') }}
    )

    , colaborador_agencia as (
        SELECT *
        FROM {{ ref('stg__colaborador_agencia') }}
    )

    , dim_colaborador as (
    SELECT
        colaboradores.cod_colaborador
        , concat(colaboradores.primeiro_nome, ' ', colaboradores.ultimo_nome) as nome_colaborador
        , colaboradores.cpf as cpf_colaborador
        , colaboradores.data_nascimento as data_nascimento_colaborador
        , colaborador_agencia.cod_agencia
    FROM colaboradores
    LEFT JOIN colaborador_agencia
        ON colaboradores.cod_colaborador = colaborador_agencia.cod_colaborador
    )

    select *
    from dim_colaborador