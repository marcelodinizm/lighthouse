with
    colaboradores as (
        select
            cod_colaborador
            , primeiro_nome
            , ultimo_nome		
            , cpf	
            , data_nascimento	
        from {{ source("banvic_raw", "colaboradores")}}
    )

select *
from colaboradores