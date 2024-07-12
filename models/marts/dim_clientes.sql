with 
    transacao as (
        select
        num_conta,
        max(cast(data_transacao as date)) as ultima_data_transacao
        from {{ ref('stg__transacoes') }}
        group by num_conta
    )

    , agencias as (
        select *
        from {{ ref('stg__agencias') }}
    )

    , contas as (
        select *
        from {{ ref('stg__contas') }}
    )  

    , clientes as (
        select *
        from {{ ref('stg__clientes') }}
    )

    , medida as (
        select
            contas.cod_cliente
            , contas.tipo_conta
            , contas.saldo_total
            , contas.saldo_disponivel
            , contas.data_abertura
            , contas.data_ultimo_lancamento
            , transacao.ultima_data_transacao
            , case 
            when date_diff(date('2023-01-13'), ultima_data_transacao, month) > 6 then 'Inativa'
            else 'Ativa'
            end as status_conta
            , clientes.data_nascimento
            , DATE_DIFF(CURRENT_DATE(), clientes.data_nascimento, YEAR) as idade_cliente
        from contas
            left join transacao
                on contas.num_conta = transacao.num_conta
            left join agencias
                on contas.cod_agencia = agencias.cod_agencia
            left join clientes
                on contas.cod_cliente = clientes.cod_cliente
    )

        select *
        from medida

