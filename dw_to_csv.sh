psql --csv -c 'SELECT * FROM dw_eal.calendario' > dw_eal/calendario.csv
psql --csv -c 'SELECT * FROM dw_eal.cliente' > dw_eal/cliente.csv
psql --csv -c 'SELECT * FROM dw_eal.cliente_endereco' > dw_eal/cliente_endereco.csv
psql --csv -c 'SELECT * FROM dw_eal.despesas' > dw_eal/despesas.csv
psql --csv -c 'SELECT * FROM dw_eal.funcionario' > dw_eal/funcionario.csv
psql --csv -c 'SELECT * FROM dw_eal.pagamento' > dw_eal/pagamento.csv
psql --csv -c 'SELECT * FROM dw_eal.receita' > dw_eal/receita.csv
psql --csv -c 'SELECT * FROM dw_eal.servico_transacao' > dw_eal/servico_transacao.csv