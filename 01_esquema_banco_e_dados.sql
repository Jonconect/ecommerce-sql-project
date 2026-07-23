-- ============================================================
-- PROJETO LÓGICO DE BANCO DE DADOS - E-COMMERCE (DIO)
-- ============================================================

CREATE DATABASE IF NOT EXISTS ecommerce;
USE ecommerce;

-- 1. TABELAS PRINCIPAIS DE CLIENTE (Refinamento PJ / PF)
CREATE TABLE Cliente (
    idCliente INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(50) NOT NULL,
    Email VARCHAR(50) NOT NULL UNIQUE,
    Endereco VARCHAR(255)
);

CREATE TABLE ClientePF (
    idClientePF INT AUTO_INCREMENT PRIMARY KEY,
    idCliente INT,
    CPF CHAR(11) NOT NULL UNIQUE,
    FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente) ON DELETE CASCADE
);

CREATE TABLE ClientePJ (
    idClientePJ INT AUTO_INCREMENT PRIMARY KEY,
    idCliente INT,
    CNPJ CHAR(14) NOT NULL UNIQUE,
    RazaoSocial VARCHAR(100) NOT NULL,
    FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente) ON DELETE CASCADE
);

-- 2. PAGAMENTOS (Refinamento: Múltiplas formas de pagamento)
CREATE TABLE FormasPagamento (
    idPagamento INT AUTO_INCREMENT PRIMARY KEY,
    idCliente INT,
    TipoPagamento ENUM('Cartão de Crédito', 'Cartão de Débito', 'PIX', 'Boleto') NOT NULL,
    NumeroCartao VARCHAR(20),
    FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente)
);

-- 3. PRODUTOS, FORNECEDORES E VENDEDORES
CREATE TABLE Produto (
    idProduto INT AUTO_INCREMENT PRIMARY KEY,
    NomeProduto VARCHAR(50) NOT NULL,
    Categoria VARCHAR(30),
    Valor FLOAT NOT NULL
);

CREATE TABLE Fornecedor (
    idFornecedor INT AUTO_INCREMENT PRIMARY KEY,
    RazaoSocial VARCHAR(100) NOT NULL,
    CNPJ CHAR(14) NOT NULL UNIQUE
);

CREATE TABLE Vendedor (
    idVendedor INT AUTO_INCREMENT PRIMARY KEY,
    RazaoSocial VARCHAR(100) NOT NULL,
    CNPJ CHAR(14) UNIQUE
);

CREATE TABLE Estoque (
    idEstoque INT AUTO_INCREMENT PRIMARY KEY,
    Localizacao VARCHAR(100),
    Quantidade INT DEFAULT 0
);

-- 4. PEDIDO E ENTREGA (Refinamento: Status e Código de Rastreio)
CREATE TABLE Pedido (
    idPedido INT AUTO_INCREMENT PRIMARY KEY,
    idCliente INT,
    StatusPedido ENUM('Em andamento', 'Processando', 'Enviado', 'Entregue') DEFAULT 'Em andamento',
    Descricao VARCHAR(255),
    Frete FLOAT DEFAULT 10.0,
    FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente)
);

CREATE TABLE Entrega (
    idEntrega INT AUTO_INCREMENT PRIMARY KEY,
    idPedido INT,
    StatusEntrega ENUM('Em Processamento', 'Em Trânsito', 'Em Rota de Entrega', 'Entregue', 'Cancelado') DEFAULT 'Em Processamento',
    CodigoRastreio VARCHAR(50) NOT NULL UNIQUE,
    FOREIGN KEY (idPedido) REFERENCES Pedido(idPedido)
);

-- RELACIONAMENTOS (TABELAS INTERMEDIÁRIAS / JUNÇÕES)
CREATE TABLE ProdutoPedido (
    idProduto INT,
    idPedido INT,
    Quantidade INT DEFAULT 1,
    PRIMARY KEY (idProduto, idPedido),
    FOREIGN KEY (idProduto) REFERENCES Produto(idProduto),
    FOREIGN KEY (idPedido) REFERENCES Pedido(idPedido)
);

CREATE TABLE ProdutoEstoque (
    idProduto INT,
    idEstoque INT,
    Quantidade INT DEFAULT 0,
    PRIMARY KEY (idProduto, idEstoque),
    FOREIGN KEY (idProduto) REFERENCES Produto(idProduto),
    FOREIGN KEY (idEstoque) REFERENCES Estoque(idEstoque)
);

CREATE TABLE ProdutoFornecedor (
    idProduto INT,
    idFornecedor INT,
    PRIMARY KEY (idProduto, idFornecedor),
    FOREIGN KEY (idProduto) REFERENCES Produto(idProduto),
    FOREIGN KEY (idFornecedor) REFERENCES Fornecedor(idFornecedor)
);

-- ============================================================
-- PERSISTÊNCIA DE DADOS PARA TESTES
-- ============================================================

INSERT INTO Cliente (Nome, Email, Endereco) VALUES
('Ana Silva', 'ana.silva@email.com', 'Rua A, 123'),
('Juliana Lima', 'juliana@email.com', 'Rua B, 456'),
('Tech Solutions', 'contato@techsol.com', 'Av Central, 1000'),
('Carlos Eduardo', 'carlos@email.com', 'Rua C, 789'),
('Tech Brasil LTDA', 'contato@techbrasil.com', 'Av Central, 2000');

INSERT INTO ClientePF (idCliente, CPF) VALUES (1, '11122233344'), (2, '55566677788'), (4, '99988877766');
INSERT INTO ClientePJ (idCliente, CNPJ, RazaoSocial) VALUES (3, '12345678000199', 'Tech Solutions LTDA'), (5, '98765432000188', 'Tech Brasil LTDA');

INSERT INTO FormasPagamento (idCliente, TipoPagamento, NumeroCartao) VALUES
(1, 'Cartão de Crédito', '1234-5678-9012-3456'),
(1, 'PIX', NULL),
(2, 'Boleto', NULL),
(3, 'Cartão de Débito', '9876-5432-1098-7654');

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

INSERT INTO Pedido (idCliente, StatusPedido, Descricao, Frete) VALUES
(1, 'Enviado', 'Compra de eletrônicos', 15.00),
(1, 'Entregue', 'Compra de roupa', 10.00),
(3, 'Processando', 'Compra de teclado', 12.00);

INSERT INTO Entrega (idPedido, StatusEntrega, CodigoRastreio) VALUES
(1, 'Em Trânsito', 'BR123456789SP'),
(2, 'Entregue', 'BR987654321SP'),
(3, 'Em Processamento', 'BR555444333SP');

INSERT INTO ProdutoPedido (idProduto, idPedido, Quantidade) VALUES (1, 1, 2), (3, 2, 1), (2, 3, 1);
INSERT INTO ProdutoFornecedor (idProduto, idFornecedor) VALUES (1, 1), (2, 2);
INSERT INTO ProdutoEstoque (idProduto, idEstoque, Quantidade) VALUES (1, 1, 100), (2, 2, 50);
