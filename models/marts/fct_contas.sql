with
    contas as (
        select *
        from {{ ref('stg__contas') }}
    )

    , transacao as (
        select *
        from {{ ref('stg__transacoes') }}
    )

    , agencias as (
        select *
        from {{ ref('stg__agencias') }}
    )

    , fato_contas as (
        select
            contas.num_conta
            , contas.cod_cliente	
            , contas.cod_colaborador	
            , contas.tipo_conta		
            , contas.saldo_total	
            , contas.saldo_disponivel	
            , transacao.cod_transacao
            , contas.data_abertura	
            , transacao.data_transacao
            , contas.data_ultimo_lancamento	
            , transacao.nome_transacao	
            , transacao.valor_transacao
            , contas.cod_agencia
            , agencias.tipo_agencia
            , agencias.data_abertura as data_abertura_agencia
            , agencias.uf as uf_agencia
            , agencias.cidade as cidade_agencia
        from contas
        left join transacao
                on  contas.num_conta = transacao.num_conta
        left join agencias
                on contas.cod_agencia = agencias.cod_agencia
        )

        select *
        from fato_contas