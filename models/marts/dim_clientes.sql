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
            , concat(clientes.primeiro_nome, ' ', clientes.ultimo_nome) as nome_cliente
            , contas.tipo_conta
            , contas.saldo_total
            , contas.saldo_disponivel
            , case
            when contas.saldo_disponivel >100000 then 'muito alto'
            when contas.saldo_disponivel >50000 then 'alto'
            when contas. saldo_disponivel >25000 then 'médio'
            when contas. saldo_disponivel <25000 then 'baixo'
            when contas.saldo_disponivel <0 then 'negativo'
            end as perfil_de_atividade
            , contas.data_abertura
            , contas.data_ultimo_lancamento
            , transacao.ultima_data_transacao
            , case 
            when date_diff(date('2023-01-13'), ultima_data_transacao, month) > 6 then 'Inativa'
            else 'Ativa'
            end as status_conta
            , clientes.data_nascimento
            , DATE_DIFF(CURRENT_DATE(), clientes.data_nascimento, YEAR) as idade_cliente
            , agencias.tipo_agencia
        from contas
            left join transacao
                on contas.num_conta = transacao.num_conta
            left join agencias
                on contas.cod_agencia = agencias.cod_agencia
            left join clientes
                on contas.cod_cliente = clientes.cod_cliente
    )

    , idade_media as (
        select 
            cod_cliente
            , medida.nome_cliente
            , medida.tipo_conta
            , medida.saldo_total
            , medida.saldo_disponivel
            , medida.perfil_de_atividade
            , medida.data_abertura
            , tipo_agencia
            , medida.data_ultimo_lancamento
            , medida.ultima_data_transacao
            , medida.status_conta
            , medida.data_nascimento
            , medida.idade_cliente
            , case
            when idade_cliente <20 then 'até 20 anos'
            when idade_cliente >=20 and idade_cliente <30 then '20-29'
            when idade_cliente >=30 and idade_cliente <40 then '30-39'
            when idade_cliente >=40 and idade_cliente <50 then '40-49'
            when idade_cliente >=50 and idade_cliente <60 then '50-59'
            when idade_cliente >=60 then '60+'
            end as media_idade
        from medida
    )

        select *
        from idade_media
