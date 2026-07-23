CREATE DATABASE IF NOT EXISTS ecommerce;
USE ecommerce;

-- 1. TABELAS PRINCIPAIS DE CLIENTE
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

-- 2. PAGAMENTOS
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

-- 4. PEDIDO E ENTREGA
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

-- RELACIONAMENTOS (TABELAS DE JUNÇÃO)
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
