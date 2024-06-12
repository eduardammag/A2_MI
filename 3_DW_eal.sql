drop schema if exists dw_eal cascade;
create schema dw_eal;

set search_path=dw_eal;

CREATE TABLE CALENDARIO (
    CalendarioKey VARCHAR NOT NULL,
    DataCompleta TIMESTAMP NOT NULL,
    DiaDaSemana VARCHAR(10) NOT NULL,
    DiaDoMes INT NOT NULL,
    Mes INT NOT NULL,
    Trimestre INT NOT NULL,
    Ano INT NOT NULL,
    PRIMARY KEY (CalendarioKey)
);

CREATE TABLE CLIENTE (
    ClienteKey VARCHAR NOT NULL,
    ClienteID INT NOT NULL,
    ClienteNome VARCHAR(255) NOT NULL,
    DataNascimento DATE NOT NULL,
    ClienteSexo CHAR(1) NOT NULL,
    PRIMARY KEY (ClienteKey)
);

CREATE TABLE CLIENTE_ENDERECO (
    EnderecoKey VARCHAR NOT NULL,
    ClienteID INT NOT NULL,
    Logradouro VARCHAR(255) NOT NULL,
    Municipio VARCHAR(255) NOT NULL,
    Bairro VARCHAR(255) NOT NULL,
    Estado CHAR(2) NOT NULL,
    PRIMARY KEY (EnderecoKey)
);

CREATE TABLE SERVICO_TRANSACAO (
    TransacaoKey VARCHAR NOT NULL,
    ClienteID INT NOT NULL,
    ServicoID INT NOT NULL,
    TransacaoData TIMESTAMP NOT NULL,
    ServicoTipo VARCHAR(255) NOT NULL,
    ServicoValor MONEY NOT NULL,
    Quantidade INT NOT NULL,
    PRIMARY KEY (TransacaoKey)
);


CREATE TABLE FUNCIONARIO (
    FuncKey VARCHAR NOT NULL,
    FuncID INT NOT NULL,
    Cargo VARCHAR(255) NOT NULL,
    FuncNome VARCHAR(255) NOT NULL,
    PRIMARY KEY (FuncKey)
);

CREATE TABLE PAGAMENTO (
    PagtoKey VARCHAR NOT NULL,
    PagtoID INT NOT NULL,
    PagtoValor MONEY NOT NULL,
    PagtoData DATE NOT NULL,
    FuncID INT NOT NULL,
    PRIMARY KEY (PagtoKey)
);


-- Fact tables

CREATE TABLE DESPESAS (
    DespesaID INT NOT NULL,
    FuncKey VARCHAR NOT NULL,
    PagtoKey VARCHAR NOT NULL,
    CalendarioKey VARCHAR NOT NULL,
    ValorGasto MONEY NOT NULL,
    PRIMARY KEY (DespesaID),
    FOREIGN KEY (FuncKey) REFERENCES FUNCIONARIO(FuncKey),
    FOREIGN KEY (PagtoKey) REFERENCES PAGAMENTO(PagtoKey),
    FOREIGN KEY (CalendarioKey) REFERENCES CALENDARIO(CalendarioKey)
);

CREATE TABLE RECEITA (
    ClienteID INT NOT NULL,
    ServicoID INT NOT NULL,
    TransacaoData TIMESTAMP NOT NULL,
    CalendarioKey VARCHAR NOT NULL,
    ClienteKey VARCHAR NOT NULL,
    EnderecoKey VARCHAR NOT NULL,
    TransacaoKey VARCHAR NOT NULL,
    ValorRecebido MONEY NOT NULL,
    Hora TIME,
    PRIMARY KEY (ClienteID, ServicoID, TransacaoData),
    FOREIGN KEY (CalendarioKey) REFERENCES CALENDARIO(CalendarioKey),
    FOREIGN KEY (ClienteKey) REFERENCES CLIENTE(ClienteKey),
    FOREIGN KEY (EnderecoKey) REFERENCES CLIENTE_ENDERECO(EnderecoKey),
    FOREIGN KEY (TransacaoKey) REFERENCES SERVICO_TRANSACAO(TransacaoKey)
);

CREATE TABLE CONDUTORESHABILITADOS (
    UF CHAR(2) NOT NULL,
    Sexo CHAR(1) NOT NULL,
    FaixaEtaria VARCHAR(255) NOT NULL,
    CategoriaHabilitacao VARCHAR(255) NOT NULL,
    Quantidade INT NOT NULL,
);

