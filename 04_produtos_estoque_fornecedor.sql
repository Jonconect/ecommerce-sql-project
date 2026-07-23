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