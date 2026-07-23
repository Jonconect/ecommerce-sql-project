-- 2. Algum vendedor também é fornecedor?
SELECT 
    v.RazaoSocial AS Vendedor,
    f.RazaoSocial AS Fornecedor,
    v.CNPJ
FROM 
    Vendedor v
INNER JOIN 
    Fornecedor f ON v.CNPJ = f.CNPJ;
