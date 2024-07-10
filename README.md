# Projeto DBT - Lighthouse

## Introdução

Este projeto DBT é utilizado para gerenciar e transformar dados do nosso Data Warehouse em BigQuery.
O objetivo é criar modelos organizados, documentados e otimizados para análise de dados, com intuito
de responder ao desafio do processo seletivo Lighthouse.

## Estrutura do Projeto

A estrutura do projeto DBT está organizada da seguinte forma:

- **models/**: Contém todos os modelos SQL do DBT.
  - **staging/**: Modelos de preparação (staging) que carregam dados brutos e aplicam transformações básicas.
  - **marts/**: Modelos de dados organizados por áreas de negócio ou assuntos, incluindo tabelas fato e dimensões.
  - **intermediate/**: Modelos intermediários que auxiliam na criação de modelos complexos.
- **tests/**: Testes de qualidade de dados para garantir a integridade e precisão dos dados transformados.
- **data/**: Arquivos de dados estáticos utilizados no projeto.
- **macros/**: Macros SQL personalizadas.
- **analysis/**: Análises SQL que não são modelos, mas são utilizadas para exploração e validação de dados.

## Configuração

Para configurar o projeto DBT, siga os seguintes passos:

1. Clone o repositório:
    ```sh
    git clone <git@github.com:marcelodinizm/lighthouse.git>
    cd <lighthouse>
    ```

2. Instale o DBT:
    ```sh
    pip install dbt-bigquery
    ```

3. Configure o perfil DBT (`profiles.yml`) com suas credenciais do BigQuery:
    ```yaml
    lighthouse:
      target: dev
      outputs:
        dev:
          type: bigquery
          method: service-account
          project: <SEU_PROJETO>
          dataset: <SEU_DATASET>
          keyfile: <CAMINHO_PARA_ARQUIVO_JSON>
          threads: 4
          timeout_seconds: 300
          location: <LOCALIZAÇÃO>
          priority: interactive
    ```

## Como Executar o Projeto

Para executar o projeto DBT, utilize os seguintes comandos:

1. Compilar e executar todos os modelos:
    ```sh
    dbt run
    ```

2. Executar testes de dados:
    ```sh
    dbt test
    ```

3. Gerar a documentação do projeto:
    ```sh
    dbt docs generate
    ```

4. Visualizar a documentação:
    ```sh
    dbt docs serve
    ```

## Modelos Importantes

### `fct_contas`
Tabela fato que contém informações detalhadas das contas, transações associadas, e dados das agências.

### `dim_colaboradores`
Tabela dimensão que contém informações dos colaboradores e as agências associadas.

## Testes e Validações

Utilizamos o DBT para realizar testes de integridade e qualidade dos dados. Estes testes estão localizados no diretório `tests/` e são executados com o comando `dbt test`.

## Contribuição

Para contribuir com este projeto, siga os passos abaixo:

1. Faça um fork do repositório.
2. Crie uma nova branch para sua feature/bugfix:
    ```sh
    git checkout -b minha-feature
    ```
3. Faça suas alterações e adicione testes adequados.
4. Envie suas alterações:
    ```sh
    git push origin minha-feature
    ```
5. Abra um Pull Request detalhando suas mudanças.

## Licença

Este projeto está licenciado sob a Licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.
