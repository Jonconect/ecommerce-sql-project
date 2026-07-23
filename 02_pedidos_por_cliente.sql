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
