-- Inserir dados fictícios na tabela Aluno
INSERT INTO Aluno (AlunoCPF, AlunoSenha, AlunoNome, AlunoEmail, AlunoCelular, DataNascimento, Logradouro, Municipio, Bairro, Estado, AlunoID)
VALUES 
('12345678901', 'senha123', 'João Silva', 'joao.silva@email.com', '11111111111', '2000-01-01', 'Rua A, 123', 'São Paulo', 'Centro', 'SP', 1),
('23456789012', 'senha456', 'Maria Oliveira', 'maria.oliveira@email.com', '22222222222', '1995-05-10', 'Rua B, 456', 'Rio de Janeiro', 'Copacabana', 'RJ', 2),
('34567890123', 'senha789', 'Pedro Souza', 'pedro.souza@email.com', '33333333333', '1998-03-15', 'Rua C, 789', 'Belo Horizonte', 'Savassi', 'MG', 3),
('45678901234', 'senha321', 'Ana Lima', 'ana.lima@email.com', '44444444444', '2001-07-20', 'Rua D, 321', 'Curitiba', 'Batel', 'PR', 4),
('56789012345', 'senha654', 'Carlos Santos', 'carlos.santos@email.com', '55555555555', '1997-12-30', 'Rua E, 654', 'Porto Alegre', 'Centro', 'RS', 5);

-- Inserir dados fictícios na tabela Veiculo
INSERT INTO Veiculo (IDVeiculo, Modelo, VeiculoTipo)
VALUES 
(1, 'Fiat Uno', 'Carro'),
(2, 'Honda CG 150', 'Moto'),
(3, 'Toyota Corolla', 'Carro'),
(4, 'Yamaha YBR', 'Moto'),
(5, 'Volkswagen Gol', 'Carro'),
(6, 'Mercedes-Benz L-312', 'Ônibus'),
(7, 'Volvo FH', 'Caminhão'),
(8, 'Kombão', 'Motorhome');

-- Inserir dados fictícios na tabela Sala
INSERT INTO Sala (IDSala, CapacidadeMax)
VALUES 
(1, 30),
(2, 30),
(3, 30),
(4, 30),
(5, 30);

-- Inserir dados fictícios na tabela Tema
INSERT INTO Tema (QuantidadeAula, TemaNome, TemaID)
VALUES 
(16, 'Direção Defensiva', 1),
(18, 'Legislação de Trânsito', 2),
(4, 'Primeiros Socorros', 3),
(3, 'Mecânica Básica', 4),
(4, 'Meio Ambiente', 5);

-- Inserir dados fictícios na tabela Funcionario
INSERT INTO Funcionario (Salario, FuncCPF, FuncCelular, FuncEmail, FuncID, Cargo, FuncNome, FuncSenha)
VALUES 
(3000.00, '11111111111', '99999999999', 'func1@email.com', 1, 'Instrutor', 'Instrutor 1', 'senha1'),
(3200.00, '22222222222', '88888888888', 'func2@email.com', 2, 'Instrutor', 'Instrutor 2', 'senha2'),
(3400.00, '33333333333', '77777777777', 'func3@email.com', 3, 'Instrutor', 'Instrutor 3', 'senha3'),
(3600.00, '44444444444', '66666666666', 'func4@email.com', 4, 'Instrutor', 'Instrutor 4', 'senha4'),
(3800.00, '55555555555', '55555555555', 'func5@email.com', 5, 'Instrutor', 'Instrutor 5', 'senha5');

-- Inserir dados fictícios na tabela ServicoAutoEsc
INSERT INTO ServicoAutoEsc (ServicoTipo, ServicoValor, ServicoID, ServicoDescricao)
VALUES 
('Pacote Aulas', 1500.00, 1, 'Pacote contendo todas as aulas obrigatórias'),
('Aula Teórica', 50.00, 2, 'Aula teórica'),
('Aula Prática', 160.00, 3, 'Aula prática de direção'),
('Exames - Primeira Tentativa', 230.00, 4, 'Primeira marcação dos exames práticos e teóricos'),
('Exame Teórico - Repetição', 150.00, 5, 'Repetição do exame teórico, em caso de reprovação'),
('Exame Prático - Repetição', 250.00, 6, 'Repetição do exame prático de direção, em caso de reprovação'),
('Duda', 315.00, 7, 'Taxa de imposto paga ao governo para realização dos exames');

-- Inserir dados fictícios na tabela Pagamento
INSERT INTO Pagamento (PagtoID, PagtoValor, PagtoData, FuncID)
VALUES 
(1, 3000.00, '2024-02-05', 1),
(2, 3200.00, '2024-02-05', 2),
(3, 3400.00, '2024-02-05', 3),
(4, 3600.00, '2024-02-05', 4),
(5, 3800.00, '2024-02-05', 5);

-- Inserir dados fictícios na tabela Exame
INSERT INTO Exame (Status, ExameID, DtHrIni, DtHrFim, AlunoID, FuncID)
VALUES 
('Aprovado', 1, '2024-01-21 09:00:00', '2024-01-21 12:00:00', 1, 1),
('Reprovado', 2, '2024-01-21 09:00:00', '2024-01-21 12:00:00', 2, 2),
('Aprovado', 3, '2024-01-21 09:00:00', '2024-01-21 12:00:00', 3, 1),
('Reprovado', 4, '2024-01-21 09:00:00', '2024-01-21 12:00:00', 4, 2),
('Aprovado', 5, '2024-01-21 09:00:00', '2024-01-21 12:00:00', 5, 1),
('Reprovado', 6, '2024-01-28 09:00:00', '2024-01-28 12:00:00', 2, 2),
('Aprovado', 7, '2024-02-07 09:00:00', '2024-02-07 13:00:00', 1, 3),
('Reprovado', 8, '2024-02-07 09:00:00', '2024-02-07 13:00:00', 3, 4),
('Reprovado', 9, '2024-02-07 09:00:00', '2024-02-07 13:00:00', 5, 3),
('Aprovado', 10, '2024-02-14 09:00:00', '2024-02-14 13:00:00', 5, 3);

-- Inserir dados fictícios na tabela ExamePratico
INSERT INTO ExamePratico (ExameID, IDVeiculo)
VALUES 
(7, 4),
(8, 6),
(9, 1),
(10, 1);

-- Inserir dados fictícios na tabela ExameTeorica
INSERT INTO ExameTeorica (ExameID, IDSala)
VALUES 
(1, 1),
(2, 2),
(3, 1),
(4, 2),
(5, 1),
(6, 5);

-- Inserir dados fictícios na tabela AlunoPaga
INSERT INTO AlunoPaga (TransacaoData, AlunoID, Quantidade, ServicoID)
VALUES 
('2024-01-02 09:53:00', 1, 1, 1),
('2024-01-02 09:53:00', 1, 1, 7),
('2024-01-02 09:53:00', 1, 1, 4),
('2024-01-02 19:02:00', 2, 1, 1),
('2024-01-02 19:02:00', 2, 1, 7),
('2024-01-02 19:02:00', 2, 1, 4),
('2024-01-04 12:01:00', 3, 1, 1),
('2024-01-04 12:01:00', 3, 1, 7),
('2024-01-04 12:01:00', 3, 1, 4),
('2024-01-07 09:00:00', 4, 1, 1),
('2024-01-07 09:00:00', 4, 1, 7),
('2024-01-07 09:00:00', 4, 1, 4),
('2024-01-11 17:00:00', 5, 1, 1),
('2024-01-11 17:00:00', 5, 1, 7),
('2024-01-11 17:00:00', 5, 1, 4),
('2024-01-23 13:32:00', 2, 1, 5),
('2024-02-09 13:32:00', 5, 5, 3),
('2024-02-09 13:32:00', 5, 1, 6);

-- Inserir dados fictícios na tabela Aula
INSERT INTO Aula (AulaData, AulaID, FuncID)
VALUES 
('2024-01-11', 1, 1),
('2024-01-20', 2, 2),
('2024-01-11', 3, 1),
('2024-01-31', 4, 3),
('2024-02-10', 5, 3);

-- Inserir dados fictícios na tabela AulaPratica
INSERT INTO AulaPratica (AulaID, AlunoID)
VALUES 
(4, 1),
(5, 5);

-- Inserir dados fictícios na tabela AulaTeorica
INSERT INTO AulaTeorica (AulaID, TemaID)
VALUES 
(1, 1),
(2, 4),
(3, 1);

-- Inserir dados fictícios na tabela AulaTSala
INSERT INTO AulaTSala (DtHrInicio, DtHrFim, AulaID, IDSala)
VALUES 
('2024-01-11 13:00:00', '2024-01-11 14:00:00', 1, 1),
('2024-01-20 11:00:00', '2024-01-20 12:00:00', 2, 2),
('2024-01-11 13:00:00', '2024-01-11 14:00:00', 3, 1);

-- Inserir dados fictícios na tabela VeiculoAula
INSERT INTO VeiculoAula (DtHrInicio, DtHrFim, AulaID, IDVeiculo)
VALUES 
('2024-01-31 15:00:00', '2024-01-31 16:00:00', 4, 2),
('2024-02-10 17:00:00', '2024-02-10 18:00:00', 5, 1);

-- Inserir dados fictícios na tabela AulaTAluno
INSERT INTO AulaTAluno (PresencaAluno, AulaID, AlunoID)
VALUES 
(1, 1, 1),
(1, 2, 2),
(1, 3, 3),
(1, 4, 1),
(1, 5, 5);
