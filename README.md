# Análise de Vendas — E-commerce Olist

Análise exploratória de 100 mil pedidos reais de e-commerce brasileiro (2016–2018).  
Projeto desenvolvido para portfólio de Analista de Dados.

## Tecnologias utilizadas
- Python (Pandas) — limpeza e preparação dos dados
- SQL (SQLite) — análise exploratória
- Power BI — dashboard interativo

## Perguntas de negócio respondidas
- Quais produtos mais venderam?
- Qual cliente mais gastou?
- Qual mês teve o maior faturamento?
- Qual vendedor tem maior ticket médio?

## Estrutura do projeto

analise-vendas-olist/
├── data/
│   ├── raw/         → CSVs originais do Kaggle (não modificados)
│   ├── processed/   → Dados limpos gerados pelo Python
│   └── external/    → Dicionário de dados
├── notebooks/       → Código Python (limpeza e análise)
├── sql/             → Queries de análise
├── images/          → Prints do dashboard
└── README.md

## Dashboard
*(em breve)*

## Dataset
[Brazilian E-Commerce Public Dataset by Olist](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)