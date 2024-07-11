with
    transacoes as (
        select
            cod_transacao	
            , num_conta	
            , cast(data_transacao as date) as data_transacao
            , nome_transacao
            , case
                when nome_transacao LIKE 'Pix%' then 'PIX'
                when nome_transacao LIKE 'DOC%' then 'DOC'
                when nome_transacao LIKE 'TED%' then 'TED'
                when nome_transacao LIKE '%boleto' then 'BOLETO'
                when nome_transacao LIKE '%espécie' then 'DINHEIRO'
                when nome_transacao LIKE 'Saque%' then 'DINHEIRO'
                when nome_transacao LIKE 'Compra%' then 'CARTÃO'
                when nome_transacao LIKE 'Estorno%' then 'CARTÃO'
                when nome_transacao LIKE '%CC%' then 'CONTA CORRENTE'
            end as tipo_transacao
            , valor_transacao
        from {{ source("banvic_raw", "transacoes")}}
    )


select *
from transacoes