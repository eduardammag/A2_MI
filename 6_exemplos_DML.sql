set search_path=dw_eal;
select * from receita;
--- mostrando as datas presentes na dim calendario
--select * from calendario;

set search_path=oper_eal;
insert into alunopaga values ('2025-02-05 13:42:00', 1, 1, 1);

set search_path=dw_eal;
select * from receita;
--- mostrando que a nova data adicionada ao calendario
--select * from calendario;


-- exemplo de 
set search_path=oper_eal;
insert into pagamento values (6, 3800.00, '2025-01-01', 1);