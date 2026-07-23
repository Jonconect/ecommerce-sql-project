USE ecommerce;

-- Inserindo Clientes
INSERT INTO Cliente (Nome, Email, Endereco) VALUES
('Ana Silva', 'ana.silva@email.com', 'Rua A, 123'),
('Juliana Lima', 'juliana@email.com', 'Rua B, 456'),
('Tech Solutions', 'contato@techsol.com', 'Av Central, 1000');

INSERT INTO ClientePF (idCliente, CPF) VALUES (1, '11122233344'), (2, '55566677788');
INSERT INTO ClientePJ (idCliente, CNPJ, RazaoSocial) VALUES (3, '12345678000199', 'Tech Solutions LTDA');

-- Inserindo Pagamentos
INSERT INTO FormasPagamento (idCliente, TipoPagamento, NumeroCartao) VALUES
(1, 'Cartão de Crédito', '1234-5678-9012-3456'),
(1, 'PIX', NULL),
(2, 'Boleto', NULL),
(3, 'Cartão de Débito', '9876-5432-1098-7654');

-- Inserindo Produtos, Fornecedores e Estoque
INSERT INTO Produto (NomeProduto, Categoria, Valor) VALUES
('Mouse Sem Fio', 'Eletrônicos', 50.00),
('Teclado Mecânico', 'Eletrônicos', 150.00),
('Camiseta Algodão', 'Vestuário', 40.00);

INSERT INTO Fornecedor (RazaoSocial, CNPJ) VALUES
('Tech Distribuidora', '99888777000111'),
('Vendas Gerais S.A.', '12345678000199');

INSERT INTO Vendedor (RazaoSocial, CNPJ) VALUES
('Vendas Gerais S.A.', '12345678000199');

INSERT INTO Estoque (Localizacao, Quantidade) VALUES ('Depósito SP', 500), ('Depósito RJ', 200);

-- Inserindo Pedidos e Entregas
INSERT INTO Pedido (idCliente, StatusPedido, Descricao, Frete) VALUES
(1, 'Enviado', 'Compra de eletrônicos', 15.00),
(1, 'Entregue', 'Compra de roupa', 10.00),
(3, 'Processando', 'Compra de teclado', 12.00);

INSERT INTO Entrega (idPedido, StatusEntrega, CodigoRastreio) VALUES
(1, 'Em Trânsito', 'BR123456789SP'),
(2, 'Entregue', 'BR987654321SP'),
(3, 'Em Processamento', 'BR555444333SP');

-- Relacionando Produtos com Pedidos, Estoque e Fornecedores
INSERT INTO ProdutoPedido (idProduto, idPedido, Quantidade) VALUES (1, 1, 2), (3, 2, 1), (2, 3, 1);
INSERT INTO ProdutoFornecedor (idProduto, idFornecedor) VALUES (1, 1), (2, 2);
INSERT INTO ProdutoEstoque (idProduto, idEstoque, Quantidade) VALUES (1, 1, 100), (2, 2, 50);
