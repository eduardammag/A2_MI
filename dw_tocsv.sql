set search_path=dw_eal;

COPY (SELECT * FROM dw_eal.calendario) TO '~/dw_eal/calendario.csv' WITH CSV HEADER;
COPY (SELECT * FROM dw_eal.cliente) TO '~/dw_eal/cliente.csv' WITH CSV HEADER;
COPY (SELECT * FROM dw_eal.cliente_endereco) TO '~/dw_eal/cliente_endereco.csv' WITH CSV HEADER;
COPY (SELECT * FROM dw_eal.despesas) TO '~/dw_eal/despesas.csv' WITH CSV HEADER;
COPY (SELECT * FROM dw_eal.funcionario) TO '~/dw_eal/funcionario.csv' WITH CSV HEADER;
COPY (SELECT * FROM dw_eal.pagamento) TO '~/dw_eal/pagamento.csv' WITH CSV HEADER;
COPY (SELECT * FROM dw_eal.receita) TO '~/dw_eal/receita.csv' WITH CSV HEADER;
COPY (SELECT * FROM dw_eal.servico_transacao) TO '~/dw_eal/servico_transacao.csv' WITH CSV HEADER;

