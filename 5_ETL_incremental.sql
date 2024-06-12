Drop schema if exists audit cascade;
create schema audit;
set search_path=audit;

CREATE TABLE audit.ins_Aluno AS SELECT * FROM oper_eal.Aluno WHERE 1=0;
CREATE TABLE audit.ins_AlunoPaga AS SELECT * FROM oper_eal.AlunoPaga WHERE 1=0;
CREATE TABLE audit.ins_Veiculo AS SELECT * FROM oper_eal.Veiculo WHERE 1=0;
CREATE TABLE audit.ins_Sala AS SELECT * FROM oper_eal.Sala WHERE 1=0;
CREATE TABLE audit.ins_Tema AS SELECT * FROM oper_eal.Tema WHERE 1=0;
CREATE TABLE audit.ins_Funcionario AS SELECT * FROM oper_eal.Funcionario WHERE 1=0;
CREATE TABLE audit.ins_ServicoAutoEsc AS SELECT * FROM oper_eal.ServicoAutoEsc WHERE 1=0;
CREATE TABLE audit.ins_Pagamento AS SELECT * FROM oper_eal.Pagamento WHERE 1=0;
CREATE TABLE audit.ins_Exame AS SELECT * FROM oper_eal.Exame WHERE 1=0;
CREATE TABLE audit.ins_ExamePratico AS SELECT * FROM oper_eal.ExamePratico WHERE 1=0;
CREATE TABLE audit.ins_ExameTeorica AS SELECT * FROM oper_eal.ExameTeorica WHERE 1=0;
CREATE TABLE audit.ins_Aula AS SELECT * FROM oper_eal.Aula WHERE 1=0;
CREATE TABLE audit.ins_AulaPratica AS SELECT * FROM oper_eal.AulaPratica WHERE 1=0;
CREATE TABLE audit.ins_AulaTeorica AS SELECT * FROM oper_eal.AulaTeorica WHERE 1=0;
CREATE TABLE audit.ins_AulaTSala AS SELECT * FROM oper_eal.AulaTSala WHERE 1=0;
CREATE TABLE audit.ins_VeiculoAula AS SELECT * FROM oper_eal.VeiculoAula WHERE 1=0;
CREATE TABLE audit.ins_AulaTAluno AS SELECT * FROM oper_eal.AulaTAluno WHERE 1=0;

CREATE TABLE audit.ins_CondutoresHabilitados AS SELECT * FROM oper_eal.CondutoresHabilitados WHERE 1=0;

CREATE OR REPLACE FUNCTION audit.ins_func_template()
RETURNS trigger AS $body$
DECLARE
    v_new_data TEXT;
BEGIN
    IF (TG_OP = 'INSERT') THEN
        v_new_data := ROW(NEW.*);
        EXECUTE format('INSERT INTO audit.ins_%I VALUES (%s)', TG_TABLE_NAME, string_agg('NEW.' || col, ',')) FROM (
            SELECT column_name AS col FROM information_schema.columns WHERE table_schema = 'oper_eal' AND table_name = TG_TABLE_NAME
        ) s;
        RETURN NEW;
    ELSE
        RAISE WARNING '[AUDIT.IF_MODIFIED_FUNC] - Other action occurred: %, at %', TG_OP, now();
        RETURN NULL;
    END IF;

EXCEPTION
    WHEN data_exception THEN
        RAISE WARNING '[AUDIT.IF_MODIFIED_FUNC] - UDF ERROR [DATA EXCEPTION] - SQLSTATE: %, SQLERRM: %', SQLSTATE, SQLERRM;
        RETURN NULL;
    WHEN unique_violation THEN
        RAISE WARNING '[AUDIT.IF_MODIFIED_FUNC] - UDF ERROR [UNIQUE] - SQLSTATE: %, SQLERRM: %', SQLSTATE, SQLERRM;
        RETURN NULL;
    WHEN others THEN
        RAISE WARNING '[AUDIT.IF_MODIFIED_FUNC] - UDF ERROR [OTHER] - SQLSTATE: %, SQLERRM: %', SQLSTATE, SQLERRM;
        RETURN NULL;
END;
$body$
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = pg_catalog, audit;


CREATE TRIGGER Aluno_insert_trg
AFTER INSERT ON oper_eal.Aluno
FOR EACH ROW EXECUTE PROCEDURE audit.ins_func_template();

CREATE TRIGGER Veiculo_insert_trg
AFTER INSERT ON oper_eal.Veiculo
FOR EACH ROW EXECUTE PROCEDURE audit.ins_func_template();

CREATE TRIGGER Sala_insert_trg
AFTER INSERT ON oper_eal.Sala
FOR EACH ROW EXECUTE PROCEDURE audit.ins_func_template();

CREATE TRIGGER Tema_insert_trg
AFTER INSERT ON oper_eal.Tema
FOR EACH ROW EXECUTE PROCEDURE audit.ins_func_template();

CREATE TRIGGER Funcionario_insert_trg
AFTER INSERT ON oper_eal.Funcionario
FOR EACH ROW EXECUTE PROCEDURE audit.ins_func_template();

CREATE TRIGGER ServicoAutoEsc_insert_trg
AFTER INSERT ON oper_eal.ServicoAutoEsc
FOR EACH ROW EXECUTE PROCEDURE audit.ins_func_template();

CREATE TRIGGER Exame_insert_trg
AFTER INSERT ON oper_eal.Exame
FOR EACH ROW EXECUTE PROCEDURE audit.ins_func_template();

CREATE TRIGGER ExamePratico_insert_trg
AFTER INSERT ON oper_eal.ExamePratico
FOR EACH ROW EXECUTE PROCEDURE audit.ins_func_template();

CREATE TRIGGER ExameTeorica_insert_trg
AFTER INSERT ON oper_eal.ExameTeorica
FOR EACH ROW EXECUTE PROCEDURE audit.ins_func_template();

CREATE TRIGGER Aula_insert_trg
AFTER INSERT ON oper_eal.Aula
FOR EACH ROW EXECUTE PROCEDURE audit.ins_func_template();

CREATE TRIGGER AulaPratica_insert_trg
AFTER INSERT ON oper_eal.AulaPratica
FOR EACH ROW EXECUTE PROCEDURE audit.ins_func_template();

CREATE TRIGGER AulaTeorica_insert_trg
AFTER INSERT ON oper_eal.AulaTeorica
FOR EACH ROW EXECUTE PROCEDURE audit.ins_func_template();

CREATE TRIGGER AulaTSala_insert_trg
AFTER INSERT ON oper_eal.AulaTSala
FOR EACH ROW EXECUTE PROCEDURE audit.ins_func_template();

CREATE TRIGGER VeiculoAula_insert_trg
AFTER INSERT ON oper_eal.VeiculoAula
FOR EACH ROW EXECUTE PROCEDURE audit.ins_func_template();

CREATE TRIGGER AulaTAluno_insert_trg
AFTER INSERT ON oper_eal.AulaTAluno
FOR EACH ROW EXECUTE PROCEDURE audit.ins_func_template();

CREATE TRIGGER CondutoresHabilitados_insert_trg
AFTER INSERT ON oper_eal.CondutoresHabilitados
FOR EACH ROW EXECUTE PROCEDURE audit.ins_func_template();



CREATE OR REPLACE FUNCTION dw_eal.ins_AlunoPaga_func()
RETURNS trigger AS $$
BEGIN
    INSERT INTO dw_eal.CALENDARIO (CalendarioKey, DataCompleta, DiaDaSemana, DiaDoMes, Mes, Trimestre, Ano)
    VALUES (
        EXTRACT(epoch FROM NEW.TransacaoData)::BIGINT,
        NEW.TransacaoData,
        TO_CHAR(NEW.TransacaoData, 'Day'),
        EXTRACT(DAY FROM NEW.TransacaoData),
        EXTRACT(MONTH FROM NEW.TransacaoData),
        CEILING(EXTRACT(MONTH FROM NEW.TransacaoData) / 3.0),
        EXTRACT(YEAR FROM NEW.TransacaoData)
    )
    ON CONFLICT (CalendarioKey) DO NOTHING;

    INSERT INTO dw_eal.SERVICO_TRANSACAO (TransacaoKey, ClienteID, ServicoID, TransacaoData, ServicoTipo, ServicoValor, Quantidade)
    SELECT
        gen_random_uuid(),
        NEW.AlunoID AS ClienteID,
        NEW.ServicoID,
        NEW.TransacaoData,
        s.ServicoTipo,
        s.ServicoValor,
        NEW.Quantidade
    FROM ServicoAutoEsc s
    WHERE NEW.ServicoID = s.ServicoID;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER ins_AlunoPaga_trigger
AFTER INSERT ON oper_eal.AlunoPaga
FOR EACH ROW EXECUTE FUNCTION dw_eal.ins_AlunoPaga_func();


CREATE OR REPLACE FUNCTION dw_eal.ins_Pagamento_func()
RETURNS trigger AS $$
BEGIN
    INSERT INTO dw_eal.CALENDARIO (CalendarioKey, DataCompleta, DiaDaSemana, DiaDoMes, Mes, Trimestre, Ano)
    VALUES (
        EXTRACT(epoch FROM NEW.PagtoData)::BIGINT,
        NEW.PagtoData,
        TO_CHAR(NEW.PagtoData, 'Day'),
        EXTRACT(DAY FROM NEW.PagtoData),
        EXTRACT(MONTH FROM NEW.PagtoData),
        CEILING(EXTRACT(MONTH FROM NEW.PagtoData) / 3.0),
        EXTRACT(YEAR FROM NEW.PagtoData)
    )
    ON CONFLICT (CalendarioKey) DO NOTHING;

    INSERT INTO dw_eal.PAGAMENTO (PagtoKey, PagtoID, PagtoValor, PagtoData, FuncID)
    VALUES (
        gen_random_uuid(),
        NEW.PagtoID,
        NEW.PagtoValor,     
        NEW.PagtoData,
        NEW.FuncID
    );

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER ins_Pagamento_trigger
AFTER INSERT ON oper_eal.Pagamento
FOR EACH ROW EXECUTE FUNCTION dw_eal.ins_Pagamento_func();


CREATE OR REPLACE FUNCTION dw_eal.ins_Aluno_func()
RETURNS trigger AS $$
BEGIN
    INSERT INTO dw_eal.CLIENTE (ClienteKey, ClienteID, ClienteNome, DataNascimento, ClienteSexo)
    VALUES (
        gen_random_uuid(),
        NEW.AlunoID,
        NEW.AlunoNome,
        NEW.DataNascimento,
        NEW.AlunoSexo
    );

    INSERT INTO dw_eal.CLIENTE_ENDERECO (EnderecoKey, ClienteID, Logradouro, Municipio, Bairro, Estado)
    VALUES (
        gen_random_uuid(),
        NEW.AlunoID,
        NEW.Logradouro,
        NEW.Municipio,
        NEW.Bairro,
        NEW.Estado
    );

    INSERT INTo dw_eal.ANALISECLIENTES (ClienteID, ClienteKey, CondKey, EnderecoKey, PropGeralMulheres, PropClientesMulheres)
    SELECT
        NEW.AlunoID,
        c.ClienteKey,
        ce.EnderecoKey,
        ch.CondKey,
        COUNT(CASE WHEN c.ClienteSexo = 'F' THEN 1 END) / COUNT(*) AS PropGeralMulheres,
        COUNT(CASE WHEN c.ClienteSexo = 'F' THEN 1 END) / COUNT(*) AS PropClientesMulheres
    FROM dw_eal.CLIENTE c
    JOIN dw_eal.CLIENTE_ENDERECO ce ON NEW.AlunoID = ce.ClienteID
    Join oper_eal.CondutoresHabilitados ch ON NEW.Estado = ch.UF
    WHERE NEW.AlunoID = c.ClienteID;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER ins_Aluno_trigger
AFTER INSERT ON oper_eal.Aluno
FOR EACH ROW EXECUTE FUNCTION dw_eal.ins_Aluno_func();


CREATE OR REPLACE FUNCTION dw_eal.ins_Funcionario_func()
RETURNS trigger AS $$
BEGIN
    INSERT INTO dw_eal.FUNCIONARIO (FuncKey, FuncID, Cargo, FuncNome)
    VALUES (
        gen_random_uuid(),
        NEW.FuncID,
        NEW.Cargo,
        NEW.FuncNome
    );

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER ins_Funcionario_trigger
AFTER INSERT ON oper_eal.Funcionario
FOR EACH ROW EXECUTE FUNCTION dw_eal.ins_Funcionario_func();



CREATE OR REPLACE FUNCTION dw_eal.ins_Despesas_func()
RETURNS trigger AS $$
BEGIN
    INSERT INTO dw_eal.DESPESAS (DespesaID, FuncKey, PagtoKey, CalendarioKey, ValorGasto)
    SELECT
        NEW.PagtoID AS DespesaID,
        f.FuncKey,
        NEW.PagtoKey,
        EXTRACT(epoch FROM NEW.PagtoData)::BIGINT AS CalendarioKey,
        NEW.PagtoValor AS ValorGasto
    FROM dw_eal.FUNCIONARIO f
    WHERE NEW.FuncID = f.FuncID;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER ins_Despesas_trigger
AFTER INSERT ON dw_eal.PAGAMENTO
FOR EACH ROW EXECUTE FUNCTION dw_eal.ins_Despesas_func();



CREATE OR REPLACE FUNCTION dw_eal.ins_Receita_func()
RETURNS trigger AS $$
BEGIN
    INSERT INTO dw_eal.RECEITA (ClienteID, ServicoID, TransacaoData, CalendarioKey, ClienteKey, EnderecoKey, TransacaoKey, ValorRecebido, Hora)
    SELECT
        NEW.ClienteID,
        NEW.ServicoID,
        NEW.TransacaoData,
        EXTRACT(epoch FROM NEW.TransacaoData)::BIGINT AS CalendarioKey,
        c.ClienteKey,
        ce.EnderecoKey,
        NEW.TransacaoKey,
        NEW.ServicoValor * NEW.Quantidade AS ValorRecebido,
        TO_CHAR(NEW.TransacaoData, 'HH24:MI:SS')::TIME AS Hora
    FROM dw_eal.CLIENTE c
    JOIN dw_eal.CLIENTE_ENDERECO ce ON NEW.ClienteID = ce.ClienteID
    WHERE NEW.ClienteID = c.ClienteID;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER ins_Receita_trigger
AFTER INSERT ON dw_eal.SERVICO_TRANSACAO
FOR EACH ROW EXECUTE FUNCTION dw_eal.ins_Receita_func();
