# CLAUDE.md — Projeto Análise de Vendas Olist

## Contexto do Projeto

Portfolio de análise de dados completo usando dataset real do marketplace brasileiro Olist.
Desenvolvido por Henrique (henriquec0889@gmail.com) para portfólio de Analista de Dados Júnior.

**Dataset:** 100 mil pedidos reais do Olist (2016–2018), disponível no Kaggle.
**Repositório GitHub:** https://github.com/henriquec0889/analise-vendas-olist

---

## Stack Tecnológica

| Etapa | Ferramenta |
|---|---|
| Limpeza e merge | Python 3.12 + Pandas (Jupyter Notebook no VS Code) |
| Análise | SQL via SQLite em memória (pandas + sqlite3) |
| Análise externa | DBeaver Community Edition (cliente SQL desktop) |
| Visualização | Power BI (fase pendente) |
| Versionamento | Git + GitHub |
| Editor | VS Code com extensão Jupyter da Microsoft |
| Kernel Jupyter | Python 3.12.10 Global Env |

---

## Estrutura de Pastas

```
analise-vendas-olist/
├── data/
│   ├── raw/          9 CSVs originais do Kaggle — NUNCA modificar
│   ├── processed/    olist_limpo.csv gerado pelo notebook 01
│   └── external/     reservado para dados externos
├── notebooks/
│   ├── 01_limpeza.ipynb       Limpeza, merge e export
│   └── 02_analise_sql.ipynb   8 perguntas de negócio em SQL
├── sql/
│   └── queries_negocio.sql    Queries documentadas para DBeaver
├── images/           prints do dashboard Power BI (pendente)
├── CLAUDE.md         este arquivo
├── README.md         documentação pública do projeto
└── anotacoes_estudo.md  (no .gitignore — notas pessoais)
```

---

## Arquivos de Dados

### Raw (não sobem pro GitHub — no .gitignore)

| Arquivo | Tamanho | Descrição |
|---|---|---|
| olist_orders_dataset.csv | 17 MB | Pedidos — tabela principal (99.441 linhas) |
| olist_order_items_dataset.csv | 15 MB | Itens por pedido (112.650 linhas) |
| olist_customers_dataset.csv | 9 MB | Clientes (99.441 linhas) |
| olist_order_payments_dataset.csv | 6 MB | Pagamentos (103.886 linhas) |
| olist_order_reviews_dataset.csv | 14 MB | Avaliações dos clientes |
| olist_products_dataset.csv | 2 MB | Produtos (32.951 linhas) |
| olist_sellers_dataset.csv | 171 KB | Vendedores (3.095 linhas) |
| olist_geolocation_dataset.csv | 60 MB | Coordenadas por CEP (não usado no merge) |
| product_category_name_translation.csv | 3 KB | Tradução PT→EN das categorias |

### Processed

- `olist_limpo.csv` — resultado do merge de 6 tabelas + reviews
- Formato final: ~117.601 linhas × 34+ colunas
- Não sobe pro GitHub (arquivo grande, gerado pelo código)

---

## Regras de Limpeza (Notebook 01)

1. **Orders:** converter 5 colunas de data de `object` → `datetime64[ns]`
2. **Products:** preencher 610 nulos de categoria com `'sem_categoria'`, nulos numéricos com mediana
3. **Reviews:** agrupar por `order_id` (média do `review_score`) para evitar duplicatas no merge
4. **Merge:** inner join para orders→items→customers→products→sellers→payments, left join para reviews
5. **Validação:** checar shape final e número de pedidos únicos após merge

---

## Perguntas de Negócio (Notebook 02 + SQL)

| # | Pergunta | Principal Resultado |
|---|---|---|
| 1 | Top 10 categorias por vendas | cama_mesa_banho (11.650 vendas) |
| 2 | Top 10 clientes por gasto | 1º cliente: R$ 109.312 |
| 3 | Top 10 meses por faturamento | Novembro/2017: R$ 1,55 M |
| 4 | Top 10 vendedores por ticket médio | Até R$ 4.400 (mín. 10 pedidos) |
| 5 | Estados por volume de pedidos | SP: 40.500 pedidos (34,5% do total) |
| 6 | Meios de pagamento | Cartão de crédito: 72,2% dos pedidos |
| 7 | Nota média por categoria | Análise de satisfação por produto |
| 8 | Performance de entrega | % pedidos no prazo vs atrasados |

---

## Problemas Identificados e Soluções

| Problema | Solução Aplicada |
|---|---|
| Reviews ignorada no merge | Adicionada com left join (media do review_score) |
| Sem validação após merge | Célula de validação adicionada no notebook 01 |
| Query pagamentos com duplicatas | Usar DISTINCT order_id no COUNT |
| Sem requirements.txt | Arquivo criado com versões das dependências |
| README incompleto | Reescrito com instruções de reprodução |
| .claude/ não ignorado pelo git | Adicionado ao .gitignore |

---

## Como Reproduzir o Projeto

```bash
# 1. Clonar o repositório
git clone https://github.com/henriquec0889/analise-vendas-olist.git
cd analise-vendas-olist

# 2. Baixar o dataset do Kaggle
# Link: https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce
# Extrair os CSVs em data/raw/

# 3. Instalar dependências
pip install -r requirements.txt

# 4. Rodar os notebooks em ordem
# VS Code: abrir notebooks/ e rodar com "Run All"
# Ordem: 01_limpeza.ipynb → 02_analise_sql.ipynb
```

---

## Status das Fases

| Fase | Status |
|---|---|
| 1. Estrutura + GitHub | Completo |
| 2. Limpeza de dados | Completo |
| 3. Análise SQL (8 perguntas) | Completo |
| 4. Dashboard Power BI | Pendente |

---

## Convenções de Commit

- `feat:` — algo novo adicionado
- `fix:` — correção de bug
- `docs:` — atualização de documentação
- Commits sem Co-Authored-By (apenas henriquec0889 como autor)

---

## Próximos Passos

1. Criar dashboard Power BI usando `data/processed/olist_limpo.csv`
2. Adicionar screenshots do dashboard em `images/`
3. Atualizar README com link do Power BI publicado
4. Configurar perfil do Kaggle e linkar no LinkedIn
5. Incluir análise geográfica usando `olist_geolocation_dataset.csv`

---

## Informações do Ambiente

- OS: Windows 11 Pro
- Python: 3.12.10 (Global Env)
- Problema conhecido: Windows Long Path — ativar LongPathsEnabled no regedit
- Jupyter: extensão da Microsoft no VS Code (não via terminal)
- Kernel reinicia ao fechar VS Code — sempre rodar "Run All" ao abrir
