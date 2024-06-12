set search_path=dw_eal;

TRUNCATE table despesas CASCADE;
TRUNCATE table receita CASCADE;

TRUNCATE table calendario CASCADE;
TRUNCATE table cliente CASCADE;
TRUNCATE table cliente_endereco CASCADE;
TRUNCATE table servico_transacao CASCADE;
TRUNCATE table funcionario CASCADE;
TRUNCATE table pagamento CASCADE;

TRUNCATE table condutoreshabilitados CASCADE;
TRUNCATE table ANALISECLIENTES CASCADE;

set search_path=oper_eal;

INSERT INTO dw_eal.CALENDARIO (CalendarioKey, DataCompleta, DiaDaSemana, DiaDoMes, Mes, Trimestre, Ano)
SELECT DISTINCT
    EXTRACT(epoch FROM TransacaoData)::BIGINT AS CalendarioKey,
    TransacaoData AS DataCompleta,
    TO_CHAR(TransacaoData, 'Day') AS DiaDaSemana,
    EXTRACT(DAY FROM TransacaoData) AS DiaDoMes,
    EXTRACT(MONTH FROM TransacaoData) AS Mes,
    CEILING(EXTRACT(MONTH FROM TransacaoData) / 3.0) AS Trimestre,
    EXTRACT(YEAR FROM TransacaoData) AS Ano
FROM AlunoPaga

UNION

SELECT DISTINCT
    EXTRACT(epoch FROM PagtoData)::BIGINT AS CalendarioKey,
    PagtoData AS DataCompleta,
    TO_CHAR(PagtoData, 'Day') AS DiaDaSemana,
    EXTRACT(DAY FROM PagtoData) AS DiaDoMes,
    EXTRACT(MONTH FROM PagtoData) AS Mes,
    CEILING(EXTRACT(MONTH FROM PagtoData) / 3.0) AS Trimestre,
    EXTRACT(YEAR FROM PagtoData) AS Ano
FROM Pagamento;


INSERT INTO dw_eal.CLIENTE (ClienteKey, ClienteID, ClienteNome, DataNascimento, ClienteSexo)
SELECT
    gen_random_uuid(),
    AlunoID AS ClienteID,
    AlunoNome AS ClienteNome,
    DataNascimento,
    Sexo AS ClienteSexo
FROM Aluno;


INSERT INTO dw_eal.CLIENTE_ENDERECO (EnderecoKey, ClienteID, Logradouro, Municipio, Bairro, Estado)
SELECT
    gen_random_uuid(),
    AlunoID AS ClienteID,
    Logradouro,
    Municipio,
    Bairro,
    Estado
FROM Aluno;


INSERT INTO dw_eal.FUNCIONARIO (FuncKey, FuncID, Cargo, FuncNome)
SELECT
    gen_random_uuid(),
    FuncID,
    Cargo,
    FuncNome
FROM Funcionario;


INSERT INTO dw_eal.PAGAMENTO (PagtoKey, PagtoID, PagtoValor, PagtoData, FuncID)
SELECT
    gen_random_uuid(),
    PagtoID,
    PagtoValor,
    PagtoData,
    FuncID
FROM Pagamento;


INSERT INTO dw_eal.SERVICO_TRANSACAO (TransacaoKey, ClienteID, ServicoID, TransacaoData, ServicoTipo, ServicoValor, Quantidade)
SELECT
    gen_random_uuid(),
    AlunoID AS ClienteID,
    AlunoPaga.ServicoID,
    TransacaoData,
    ServicoTipo,
    ServicoValor,
    Quantidade
FROM AlunoPaga
JOIN ServicoAutoEsc ON AlunoPaga.ServicoID = ServicoAutoEsc.ServicoID;


INSERT INTO dw_eal.DESPESAS (DespesaID, FuncKey, PagtoKey, CalendarioKey, ValorGasto)
SELECT
    p.PagtoID AS DespesaID,
    f.FuncKey,
    p.PagtoKey,
    EXTRACT(epoch FROM p.PagtoData)::BIGINT AS CalendarioKey,
    p.PagtoValor AS ValorGasto
FROM dw_eal.PAGAMENTO p
JOIN dw_eal.FUNCIONARIO f ON p.FuncID = f.FuncID;


INSERT INTO dw_eal.RECEITA (ClienteID, ServicoID, TransacaoData, CalendarioKey, ClienteKey, EnderecoKey, TransacaoKey, ValorRecebido, Hora)
SELECT
    st.ClienteID,
    st.ServicoID,
    st.TransacaoData,
    EXTRACT(epoch FROM st.TransacaoData)::BIGINT AS CalendarioKey,
    c.ClienteKey,
    ce.EnderecoKey,
    st.TransacaoKey,
    st.ServicoValor * st.Quantidade AS ValorRecebido,
    TO_CHAR(st.TransacaoData, 'HH24:MI:SS')::TIME AS Hora
FROM dw_eal.SERVICO_TRANSACAO st
JOIN dw_eal.CLIENTE c ON st.ClienteID = c.ClienteID
JOIN dw_eal.CLIENTE_ENDERECO ce ON st.ClienteID = ce.ClienteID;


INSERT INTO dw_eal.CONDUTORESHABILITADOS (CondKey, UF, Sexo, FaixaEtaria, CategoriaHabilitacao, Quantidade)
SELECT
    gen_random_uuid(),
    UF,
    Sexo,
    FaixaEtaria,
    CategoriaHabilitacao,
    Quantidade
FROM CONDUTORESHABILITADOS;

INSERT INTO dw_eal.ANALISECLIENTES (ClienteID, ClienteKey, CondKey, EnderecoKey, PropGeralMulheres, PropClientesMulheres)
SELECT
    c.ClienteID,
    c.ClienteKey,
    ch.CondKey,
    ce.EnderecoKey,
    COUNT(CASE WHEN ch.Sexo = 'F' THEN 1 END) / COUNT(*)::DECIMAL AS PropGeralMulheres,
    COUNT(CASE WHEN c.ClienteSexo = 'F' THEN 1 END) / COUNT(*)::DECIMAL AS PropClientesMulheres
FROM dw_eal.CLIENTE c
JOIN dw_eal.CLIENTE_ENDERECO ce ON c.ClienteID = ce.ClienteID
JOIN dw_eal.CONDUTORESHABILITADOS ch ON ce.Estado = ch.UF
GROUP BY c.ClienteKey, ch.CondKey, ce.EnderecoKey;