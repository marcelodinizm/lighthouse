with
    colaborador_agencia as (
        select
	        cod_colaborador
            , cod_agencia
        from {{ source("banvic_raw", "colaborador_agencia")}}
    )

select *
from colaborador_agencia