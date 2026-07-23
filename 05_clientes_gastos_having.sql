-- 4. Clientes que gastaram mais de R$ 50,00 no total (Usando HAVING e Atributo Derivado)
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
