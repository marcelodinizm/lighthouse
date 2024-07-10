with
    agencias as (
        select
            cod_agencia
	        , nome	
            , endereco
	        , cidade
	        , uf
	        , data_abertura
            , tipo_agencia
        from {{ source("banvic_raw", "agencias")}}
    )

select *
from agencias