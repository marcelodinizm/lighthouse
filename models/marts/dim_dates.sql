with
    generate_date as (
        select *
        from UNNEST(GENERATE_DATE_ARRAY('2000-01-01', '2050-01-01', INTERVAL 1 DAY)) AS d
    )

    , calendar as (
        select
            FORMAT_DATE('%Y%m%d', d) as id
            , FORMAT_DATE('%F', d) as data_id
            , FORMAT_DATE('%d-%m-%Y', d) AS data_completa
            , EXTRACT(YEAR FROM d) AS ano
            , EXTRACT(WEEK FROM d) AS semano_ano
            , EXTRACT(DAY FROM d) AS dia_ano
            , FORMAT_DATE('%Q', d) as semestre
            , EXTRACT(MONTH FROM d) AS mes
            , FORMAT_DATE('%B', d) as month_name
            , FORMAT_DATE('%w', d) AS dia_da_semana
            , FORMAT_DATE('%A', d) AS day_name
            , (CASE
                WHEN FORMAT_DATE('%A', d) IN ('Sunday', 'Saturday') THEN 'Não'
                ELSE 'Sim'
            END) AS dia_util
        from generate_date
    )

    , dim_dates as (
        select
            id
            , data_id
            , data_completa
            , ano
            , semano_ano
            , dia_ano
            , semestre
            , mes
            , case
                when mes = 1 then 'Janeiro'
                when mes = 2 then 'Fevereiro'
                when mes = 3 then 'Março'
                when mes = 4 then 'Abril'
                when mes = 5 then 'Maio'
                when mes = 6 then 'Junho'
                when mes = 7 then 'Julho'
                when mes = 8 then 'Agosto'
                when mes = 9 then 'Setembro'
                when mes = 10 then 'Outubro'
                when mes = 11 then 'Novembro'
                when mes = 12 then 'Dezembro'
            end as nome_mes
            , dia_da_semana
            , case
                when dia_da_semana = 0 then 'Domingo'
                when dia_da_semana = 1 then 'Segunda'
                when dia_da_semana = 2 then 'Terça'
                when dia_da_semana = 3 then 'Quarta'
                when dia_da_semana = 4 then 'Quinta'
                when dia_da_semana = 5 then 'Sexta'
                when dia_da_semana = 6 then 'Sábado'
            end as nome_dia_da_semana
            , dia_ultil
        from calendar
    )

    select *
    from dim_dates