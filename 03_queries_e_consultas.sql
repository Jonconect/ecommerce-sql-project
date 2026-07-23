USE ecommerce;

-- 1. Quantos pedidos foram feitos por cada cliente?
SELECT 
    c.Nome AS Nome_Cliente,
    COUNT(p.idPedido) AS Total_de_Pedidos
FROM 
    Cliente c
LEFT JOIN 
    Pedido p ON c.idCliente = p.idCliente
GROUP BY 
    c.idCliente, c.Nome;


-- 2. Algum vendedor também é fornecedor?
SELECT 
    v.RazaoSocial AS Vendedor,
    f.RazaoSocial AS Fornecedor,
    v.CNPJ
FROM 
    Vendedor v
INNER JOIN 
    Fornecedor f ON v.CNPJ = f.CNPJ;


-- 3. Relação de produtos, fornecedores e estoques (Ordenado pelo valor do produto)
SELECT 
    p.NomeProduto,
    p.Categoria,
    p.Valor,
    f.RazaoSocial AS Nome_Fornecedor,
    e.Localizacao AS Local_Estoque,
    pe.Quantidade AS Qtd_Estoque
FROM 
    Produto p
INNER JOIN 
    ProdutoFornecedor pf ON p.idProduto = pf.idProduto
INNER JOIN 
    Fornecedor f ON pf.idFornecedor = f.idFornecedor
INNER JOIN 
    ProdutoEstoque pe ON p.idProduto = pe.idProduto
INNER JOIN 
    Estoque e ON pe.idEstoque = e.idEstoque
ORDER BY 
    p.Valor DESC;


-- 4. Quais clientes gastaram mais de R$ 50,00 no total de seus pedidos?
SELECT 
    c.Nome AS Nome_Cliente,
    SUM(pr.Valor * pp.Quantidade) AS Valor_Total_Gasto
FROM 
    Cliente c
INNER JOIN 
    Pedido p ON c.idCliente = p.idCliente
INNER JOIN 
    ProdutoPedido pp ON p.idPedido = pp.idPedido
INNER JOIN 
    Produto pr ON pp.idProduto = pr.idProduto
GROUP BY 
    c.idCliente, c.Nome
HAVING 
    Valor_Total_Gasto > 50.00;
