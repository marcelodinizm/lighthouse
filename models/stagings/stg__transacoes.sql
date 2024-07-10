with
    transacoes as (
        select
            cod_transacao	
            , num_conta	
            , data_transacao	
            , nome_transacao	
            , valor_transacao
        from {{ source("banvic_raw", "transacoes")}}
    )

select *
from transacoes