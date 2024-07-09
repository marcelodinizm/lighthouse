with
    clientes as (
        select
            cod_cliente
            , primeiro_nome
            , ultimo_nome
            , tipo_cliente
            , data_inclusao
            , cpfcnpj
            , data_nascimento
        from {{ source("banvic_raw", "clientes")}}
    )

select *
from clientes