with
    contas as (
        select
            num_conta	
            , cod_cliente	
            , cod_agencia
            , cod_colaborador	
            , tipo_conta	
            , cast(data_abertura as date) as data_abertura	
            , saldo_total	
            , saldo_disponivel	
            , cast(data_ultimo_lancamento as date) as data_ultimo_lancamento
        from {{ source("banvic_raw", "contas")}}
    )

select *
from contas