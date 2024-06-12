set search_path=oper_eal;

INSERT INTO Aluno (AlunoCPF, AlunoSenha, AlunoNome, AlunoEmail, AlunoCelular, DataNascimento, Logradouro, Municipio, Bairro, Estado, AlunoID, Sexo)
VALUES 
('12456109876', 'senha5556', 'Lucas Martins', 'lucas.martin@email.com', '33333333333', '1997-04-10', 'Rua FF, 5556', 'Campinas', 'Cambuí', 'SP', 36, 'F'),
('12456109899', 'senha5556', 'Lucas Martins', 'lucas.martin@emal.com', '33333333333', '1997-04-10', 'Rua FF, 5556', 'Campinas', 'Cambuí', 'SP', 37, 'M');


set search_path=oper_eal;

INSERT INTO AlunoPaga (TransacaoData, AlunoID, Quantidade, ServicoID)
VALUES
('2024-03-11 17:00:00', 17, 1, 7),
('2024-03-11 17:00:00', 17, 1, 6),
('2024-03-23 13:32:00', 14, 18, 3),
('2024-03-09 13:32:00', 25, 5, 3),
('2024-03-09 13:32:00', 9, 4, 2),
('2024-03-02 09:53:00', 11, 11, 2),
('2024-03-02 09:53:00', 19, 1, 7),
('2024-03-02 09:53:00', 19, 1, 6),
('2024-03-02 19:02:00', 22, 1, 4),
('2024-03-02 19:02:00', 26, 1, 7),
('2024-03-02 19:02:00', 26, 1, 6),
('2024-03-04 12:01:00', 30, 1, 2);