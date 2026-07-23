# 🛒 Projeto Lógico de Banco de Dados - E-Commerce

Desafio de Projeto desenvolvido para o Bootcamp da **DIO (Digital Innovation One)**.

## 📌 Descrição do Projeto
O objetivo deste projeto é construir a modelagem lógica de um banco de dados para um cenário de E-commerce, contemplando regras de negócio reais e refinamentos propostos no módulo.

### 🛠️ Refinamentos Implementados:
1. **Cliente PJ e PF:** A conta pode ser Pessoa Jurídica (CNPJ) ou Pessoa Física (CPF), mas não ambas.
2. **Pagamentos:** O cliente pode cadastrar mais de uma forma de pagamento (Cartão de Crédito/Débito, PIX, Boleto).
3. **Entrega:** Possui status de rastreamento (Em Processamento, Em Trânsito, Em Rota de Entrega, Entregue, Cancelado) e código de rastreio único.

---

## 🗂️ Estrutura dos Arquivos SQL

- **`01_esquema_banco_de_dados.sql`**: Script de criação de todas as tabelas, chaves primárias (PK), chaves estrangeiras (FK) e restrições (constraints).
- **`02_insercao_dados_teste.sql`**: Script com a persistência de dados fictícios para realização dos testes no banco de dados.
- **`03_pedidos_por_cliente.sql`**: Query que responde *"Quantos pedidos foram feitos por cada cliente?"* (Uso de `JOIN`, `COUNT` e `GROUP BY`).
- **`04_vendedor_fornecedor.sql`**: Query que responde *"Algum vendedor também é fornecedor?"* (Uso de `INNER JOIN` cruzando CNPJ).
- **`05_produtos_estoque_fornecedor.sql`**: Query da *"Relação de produtos, fornecedores e estoques"* (Uso de múltiplos `JOIN`s e `ORDER BY`).
- **`06_clientes_gastos_having.sql`**: Query que filtra *"Quais clientes gastaram mais de R$ 50,00 no total de seus pedidos?"* (Atributo derivado `SUM()` e filtro `HAVING`).

---

## 🚀 Tecnologias Utilizadas
- **MySQL / MySQL Workbench**
- **Git & GitHub**
