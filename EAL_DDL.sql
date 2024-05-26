Drop schema if exists oper_eal cascade;
create schema oper_eal;

set search_path=oper_eal;


CREATE TABLE Aluno
(
    AlunoCPF CHAR(11) NOT NULL,
    AlunoSenha VARCHAR(255) NOT NULL,
    AlunoNome VARCHAR(255) NOT NULL,
    AlunoEmail VARCHAR(255) NOT NULL,
    AlunoCelular VARCHAR(15) NOT NULL,
    DataNascimento DATE NOT NULL,
    Logradouro VARCHAR(255) NOT NULL,
    Municipio VARCHAR(255) NOT NULL,
    Bairro VARCHAR(255) NOT NULL,
    Estado CHAR(2) NOT NULL,
    AlunoID INT NOT NULL,
    PRIMARY KEY (AlunoID),
    UNIQUE (AlunoCPF),
    UNIQUE (AlunoEmail)
);

CREATE TABLE Veiculo
(
    IDVeiculo INT NOT NULL,
    Modelo VARCHAR(255) NOT NULL,
    VeiculoTipo VARCHAR(255) NOT NULL,
    PRIMARY KEY (IDVeiculo)
);

CREATE TABLE Sala
(
    IDSala INT NOT NULL,
    CapacidadeMax INT NOT NULL,
    PRIMARY KEY (IDSala)
);

CREATE TABLE Tema
(
    QuantidadeAula INT NOT NULL,
    TemaNome VARCHAR(255) NOT NULL,
    TemaID INT NOT NULL,
    PRIMARY KEY (TemaID)
);

CREATE TABLE Funcionario
(
    Salario MONEY NOT NULL,
    FuncCPF CHAR(11) NOT NULL,
    FuncCelular VARCHAR(15) NOT NULL,
    FuncEmail VARCHAR(255) NOT NULL,
    FuncID INT NOT NULL,
    Cargo VARCHAR(255) NOT NULL,
    FuncNome VARCHAR(255) NOT NULL,
    FuncSenha VARCHAR(255) NOT NULL,
    PRIMARY KEY (FuncID),
    UNIQUE (FuncCPF),
    UNIQUE (FuncEmail)
);

CREATE TABLE ServicoAutoEsc
(
    ServicoTipo VARCHAR(255) NOT NULL,
    ServicoValor MONEY NOT NULL,
    ServicoID INT NOT NULL,
    ServicoDescricao VARCHAR(255),
    PRIMARY KEY (ServicoID)
);

CREATE TABLE Pagamento
(
    PagtoID INT NOT NULL,
    PagtoValor MONEY NOT NULL,
    PagtoData DATE NOT NULL,
    FuncID INT NOT NULL,
    PRIMARY KEY (PagtoID),
    FOREIGN KEY (FuncID) REFERENCES Funcionario(FuncID)
);

CREATE TABLE Exame
(
    Status VARCHAR(255),
    ExameID INT NOT NULL,
    DtHrIni TIMESTAMP NOT NULL,
    DtHrFim TIMESTAMP NOT NULL,
    AlunoID INT NOT NULL,
    FuncID INT NOT NULL,
    PRIMARY KEY (ExameID),
    FOREIGN KEY (AlunoID) REFERENCES Aluno(AlunoID),
    FOREIGN KEY (FuncID) REFERENCES Funcionario(FuncID)
);

CREATE TABLE ExamePratico
(
    ExameID INT NOT NULL,
    IDVeiculo INT NOT NULL,
    PRIMARY KEY (ExameID),
    FOREIGN KEY (ExameID) REFERENCES Exame(ExameID),
    FOREIGN KEY (IDVeiculo) REFERENCES Veiculo(IDVeiculo)
);

CREATE TABLE ExameTeorica
(
    ExameID INT NOT NULL,
    IDSala INT NOT NULL,
    PRIMARY KEY (ExameID),
    FOREIGN KEY (ExameID) REFERENCES Exame(ExameID),
    FOREIGN KEY (IDSala) REFERENCES Sala(IDSala)
);

CREATE TABLE AlunoPaga
(
    TransacaoData TIMESTAMP NOT NULL,
    Quantidade INT NOT NULL,
    AlunoID INT NOT NULL,
    ServicoID INT NOT NULL,
    PRIMARY KEY (AlunoID, ServicoID, TransacaoData),
    FOREIGN KEY (AlunoID) REFERENCES Aluno(AlunoID),
    FOREIGN KEY (ServicoID) REFERENCES ServicoAutoEsc(ServicoID)
);

CREATE TABLE Aula
(
    AulaData DATE NOT NULL,
    AulaID INT NOT NULL,
    FuncID INT NOT NULL,
    PRIMARY KEY (AulaID),
    FOREIGN KEY (FuncID) REFERENCES Funcionario(FuncID)
);

CREATE TABLE AulaPratica
(
    AulaID INT NOT NULL,
    AlunoID INT NOT NULL,
    PRIMARY KEY (AulaID),
    FOREIGN KEY (AulaID) REFERENCES Aula(AulaID),
    FOREIGN KEY (AlunoID) REFERENCES Aluno(AlunoID)
);

CREATE TABLE AulaTeorica
(
    AulaID INT NOT NULL,
    TemaID INT NOT NULL,
    PRIMARY KEY (AulaID),
    FOREIGN KEY (AulaID) REFERENCES Aula(AulaID),
    FOREIGN KEY (TemaID) REFERENCES Tema(TemaID)
);

CREATE TABLE AulaTSala
(
    DtHrInicio TIMESTAMP NOT NULL,
    DtHrFim TIMESTAMP NOT NULL,
    AulaID INT NOT NULL,
    IDSala INT NOT NULL,
    PRIMARY KEY (AulaID, IDSala),
    FOREIGN KEY (AulaID) REFERENCES AulaTeorica(AulaID),
    FOREIGN KEY (IDSala) REFERENCES Sala(IDSala)
);

CREATE TABLE VeiculoAula
(
    DtHrInicio TIMESTAMP NOT NULL,
    DtHrFim TIMESTAMP NOT NULL,
    AulaID INT NOT NULL,
    IDVeiculo INT NOT NULL,
    PRIMARY KEY (AulaID, IDVeiculo),
    FOREIGN KEY (AulaID) REFERENCES AulaPratica(AulaID),
    FOREIGN KEY (IDVeiculo) REFERENCES Veiculo(IDVeiculo)
);

CREATE TABLE AulaTAluno
(
    PresencaAluno INT NOT NULL,
    AulaID INT NOT NULL,
    AlunoID INT NOT NULL,
    PRIMARY KEY (AulaID, AlunoID),
    FOREIGN KEY (AulaID) REFERENCES AulaTeorica(AulaID),
    FOREIGN KEY (AlunoID) REFERENCES Aluno(AlunoID)
);
