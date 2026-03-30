# 🛒 E-commerce Analytics — dbt + PostgreSQL

<p align="center">
  <img src="https://img.shields.io/badge/dbt-1.10-FF694B?style=for-the-badge&logo=dbt&logoColor=white" />
  <img src="https://img.shields.io/badge/PostgreSQL-Supabase-336791?style=for-the-badge&logo=postgresql&logoColor=white" />
  <img src="https://img.shields.io/badge/Arquitetura-Medallion-gold?style=for-the-badge" />
</p>

Projeto de **Data Engineering** desenvolvido durante a **Imersão de Dados** da [Jornada de Dados](https://suajornadadedados.com.br/) — ministrada por **Luciano Vasconcelos**.

O objetivo é construir uma camada analítica completa sobre um banco de dados de e-commerce usando **dbt (Data Build Tool)** com **PostgreSQL (Supabase)**, seguindo a **Arquitetura Medalhão (Medallion Architecture)**.

---

## 🏗️ Arquitetura

O projeto segue a **Arquitetura Medalhão** com 3 camadas de transformação:

```
📦 models/
├── 📄 _sources.yml              → Definição das 4 fontes de dados
├── 🥉 bronze/                   → 4 views  (cópia fiel dos dados brutos)
├── 🥈 silver/                   → 4 tables (tipagem + colunas calculadas)
└── 🥇 gold/                     → 4 tables (métricas e regras de negócio)
    ├── sales/                   → Análise temporal de vendas
    ├── customer_success/        → Segmentação de clientes
    └── pricing/                 → Competitividade de preços
```

| Camada | Objetivo | Materialização | Qtd |
|--------|----------|----------------|-----|
| **Bronze** | Cópia exata das tabelas raw, sem transformação | `view` | 4 |
| **Silver** | Tipagem, colunas calculadas, sem JOINs | `table` | 4 |
| **Gold** | JOINs, agregações, métricas e regras de negócio | `table` | 4 |

---

## 📊 Data Marts (Gold)

### 📈 Sales
- **`vendas_temporais`** — Análise de vendas por dia, hora e dia da semana
- **`vendas_ytd`** — Receita acumulada mês a mês (YTD) com crescimento MoM%

### 👥 Customer Success
- **`clientes_segmentacao`** — Segmentação de clientes em **VIP**, **TOP_TIER** e **REGULAR** com ranking por receita

### 💰 Pricing
- **`precos_competitividade`** — Comparação de preços com concorrentes, classificação (MAIS_CARO_QUE_TODOS → NA_MEDIA)

---

## 🗂️ Fontes de Dados

| Tabela | Descrição | Registros |
|--------|-----------|-----------|
| `vendas` | Transações de vendas | 3.020 |
| `produtos` | Catálogo de produtos | 215 |
| `clientes` | Cadastro de clientes | 50 |
| `preco_competidores` | Preços coletados de concorrentes | 728 |

---

## 🚀 Como Executar

### Pré-requisitos
- Python 3.8+
- dbt-core + dbt-postgres
- Acesso a um banco PostgreSQL (ex: Supabase)

### Instalação

```bash
# Clone o repositório
git clone https://github.com/ArturBiamonti/ecommerce_imersao.git
cd ecommerce_imersao/ecommerce

# Instale as dependências
pip install dbt-core dbt-postgres

# Configure o profiles.yml com suas credenciais do banco
# (~/.dbt/profiles.yml)

# Execute todos os modelos
dbt run
```

### Resultado esperado

```
Completed successfully
Done. PASS=12 WARN=0 ERROR=0 SKIP=0 NO-OP=0 TOTAL=12
```

---

## 🧰 Tecnologias

- **[dbt](https://www.getdbt.com/)** — Transformação de dados com SQL versionado
- **[PostgreSQL](https://www.postgresql.org/)** — Banco de dados relacional
- **[Supabase](https://supabase.com/)** — Plataforma de banco de dados na nuvem

---

## 📚 Sobre a Imersão

Este projeto foi desenvolvido como parte da **Imersão de Dados** da **[Jornada de Dados](https://suajornadadedados.com.br/)**, uma comunidade de Data Engineering criada por **Luciano Vasconcelos**. A imersão foca em ensinar as melhores práticas de engenharia de dados com projetos hands-on.

---

## 📝 Licença

Este projeto é de uso educacional, desenvolvido durante a Imersão de Dados da Jornada de Dados.
