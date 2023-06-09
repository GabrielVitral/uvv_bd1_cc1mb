-- aluno: Gabriel Vitral Monteiro
-- turma: CC1MB
--matrícula: 202305835

-- apagar database se existir um anteriormente
DROP DATABASE IF EXISTS uvv;
--remover usuário gabriel
DROP ROLE IF EXISTS gabriel;

DROP SCHEMA IF EXISTS lojas;

DROP USER IF EXISTS gabriel;




-- Nesse comando estou criando um usuário com senha
CREATE ROLE gabriel WITH LOGIN PASSWORD 'computacao@raiz';



--Comando que cria o banco de dados
CREATE DATABASE uvv
OWNER gabriel
       TEMPLATE template0
       ENCODING 'UTF8'
       LC_COLLATE 'pt_BR.UTF-8'
       LC_CTYPE 'pt_BR.UTF-8'
       ALLOW_CONNECTIONS true;

--conectando-se ao banco de dados uvv,utilizando o usuário gabriel

\c 'dbname=uvv user=gabriel password=computacao@raiz';

-- criando o schema
CREATE SCHEMA lojas AUTHORIZATION gabriel;

SET search_path TO lojas, '$user', public;

ALTER USER gabriel SET search_path TO lojas, '$user', public;

-- criando a tabela produtos
CREATE TABLE produtos (
                produtoid NUMERIC(38) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                preco_unitario NUMERIC(10,2),
                detalhes BYTEA,
                imagem BYTEA,
                imagem_mime_type VARCHAR(512),
                imagem_arquivo VARCHAR(512),
                imagem_charset VARCHAR(512),
                imagem_ultima_atualizacao DATE,
                CONSTRAINT produto_id PRIMARY KEY (produtoid)

-- adicionando comentários nas colunas das tabelas
);
COMMENT ON TABLE produtos IS 'Tabela com dados dos produtos';
COMMENT ON COLUMN produtos.produtoid IS 'número de identificação do pedido';
COMMENT ON COLUMN produtos.nome IS 'nome do produto';
COMMENT ON COLUMN produtos.preco_unitario IS 'preço unitário do produto';
COMMENT ON COLUMN produtos.detalhes IS 'especificações e detalhes do produto';
COMMENT ON COLUMN produtos.imagem IS 'imagem';
COMMENT ON COLUMN produtos.imagem_mime_type IS 'imagem mime type';
COMMENT ON COLUMN produtos.imagem_arquivo IS 'imagem do arquivo';
COMMENT ON COLUMN produtos.imagem_charset IS 'imagem charset';
COMMENT ON COLUMN produtos.imagem_ultima_atualizacao IS 'imagem da última atualização';

-- criando a tabela lojas
CREATE TABLE lojas (
                lojas_id NUMERIC(38) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                endereco_web VARCHAR(100),
                endereco_fisico VARCHAR(512),
                latitude NUMERIC,
                longitude NUMERIC,
                logo BYTEA,
                logo_mime_type VARCHAR(512),
                logo_arquivo VARCHAR(512),
                logo_charset VARCHAR(512),
                logo_ultima_atualizacao DATE,
                CONSTRAINT lojas_id PRIMARY KEY (lojas_id)

-- adicionando comentários nas colunas da tabela
);
COMMENT ON TABLE lojas IS 'Tabela com dados sobre as lojas';
COMMENT ON COLUMN lojas.lojas_id IS 'loja';
COMMENT ON COLUMN lojas.nome IS 'nome da loja';
COMMENT ON COLUMN lojas.endereco_web IS 'link do site';
COMMENT ON COLUMN lojas.endereco_fisico IS 'endereço da loja física';
COMMENT ON COLUMN lojas.latitude IS 'latidude - localização';
COMMENT ON COLUMN lojas.longitude IS 'longitude - localização';
COMMENT ON COLUMN lojas.logo IS 'logo';
COMMENT ON COLUMN lojas.logo_mime_type IS 'logo_mime_type';
COMMENT ON COLUMN lojas.logo_arquivo IS 'logo do arquivo';
COMMENT ON COLUMN lojas.logo_charset IS 'logo-charset';
COMMENT ON COLUMN lojas.logo_ultima_atualizacao IS 'logo_ultima_atualizacao';

-- criando a tabela estoques
CREATE TABLE estoques (
                estoque_id NUMERIC(38) NOT NULL,
                produto_id NUMERIC(38) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                quantidade NUMERIC(38) NOT NULL,
                CONSTRAINT estoque_id PRIMARY KEY (estoque_id)

-- adicionando comentários nas colunas da tabela
);
COMMENT ON TABLE estoques IS 'Tabela com dados sobre estoques';
COMMENT ON COLUMN estoques.estoque_id IS 'identificação do produto no estoque';
COMMENT ON COLUMN estoques.produto_id IS 'número de identificação do produto';
COMMENT ON COLUMN estoques.loja_id IS 'loja';
COMMENT ON COLUMN estoques.quantidade IS 'qualidade';

-- criando a tabela clientes
CREATE TABLE clientes (
                cliente_id NUMERIC(38) NOT NULL,
                email VARCHAR(255) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                telefone1 VARCHAR(20),
                telefone2 VARCHAR(20),
                telefone3 VARCHAR(20),
                CONSTRAINT cliente_id PRIMARY KEY (cliente_id)

-- adicionando comentários nas colunas da tabela
);
COMMENT ON TABLE clientes IS 'Tabela com dados dos clientes';
COMMENT ON COLUMN clientes.cliente_id IS 'Número de identificação do cliente';
COMMENT ON COLUMN clientes.email IS 'email do cliente';
COMMENT ON COLUMN clientes.nome IS 'nome do cliente';
COMMENT ON COLUMN clientes.telefone1 IS 'telefone de contato com cliente';
COMMENT ON COLUMN clientes.telefone2 IS 'telefone 2 de contato com o cliente';
COMMENT ON COLUMN clientes.telefone3 IS 'telefone 3 de contato com o cliente';


-- criando a tabela envios 
CREATE TABLE envios (
                envio_id NUMERIC(38) NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                enderecoentrega VARCHAR(512) NOT NULL,
                status VARCHAR(15) NOT NULL,
                CONSTRAINT envio_id PRIMARY KEY (envio_id)

-- adicionando comentários nas colunas da tabela
);
COMMENT ON TABLE envios IS 'Tabela com dados dos envios';
COMMENT ON COLUMN envios.envio_id IS 'número do pedido enviado';
COMMENT ON COLUMN envios.cliente_id IS 'cliente que recebeu o pedido';
COMMENT ON COLUMN envios.loja_id IS 'loja';
COMMENT ON COLUMN envios.enderecoentrega IS 'endereço de entrega do pedido';
COMMENT ON COLUMN envios.status IS 'situação do pedido';

-- criando a tabela pedidos
CREATE TABLE pedidos (
                pedido_id NUMERIC(38) NOT NULL,
                status VARCHAR(15) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                data_hora TIMESTAMP NOT NULL,
                CONSTRAINT pedido_id PRIMARY KEY (pedido_id)

-- adicionando comentários nas colunas da tabela
);
COMMENT ON TABLE pedidos IS 'Tabela com dados dos pedidos';
COMMENT ON COLUMN pedidos.pedido_id IS 'número de identificação do pedido';
COMMENT ON COLUMN pedidos.status IS 'status do pedido';
COMMENT ON COLUMN pedidos.loja_id IS 'loja que possui os produtos';
COMMENT ON COLUMN pedidos.cliente_id IS 'referente ao cliente a quem o pedido foi endereçado';
COMMENT ON COLUMN pedidos.data_hora IS 'horário e data de entrega dos pedidos';

--criando a tabela pedidos_itens
CREATE TABLE pedidos_itens (
                produto_id NUMERIC(38) NOT NULL,
                pedido_id NUMERIC(38) NOT NULL,
                numero_da_linha NUMERIC(38) NOT NULL,
                preco_unitario NUMERIC(10,2) NOT NULL,
                quantidade NUMERIC(38) NOT NULL,
                envio_id NUMERIC(38),
                CONSTRAINT id_pedido PRIMARY KEY (produto_id, pedido_id)


-- adicionando comentários nas coluna da tabela
);
COMMENT ON TABLE pedidos_itens IS 'Tabela com dados dos itens contidos em um pedido';
COMMENT ON TABLE pedidos_itens IS 'itens dos pedidos';
COMMENT ON COLUMN pedidos_itens.produto_id IS 'id dos produtos';
COMMENT ON COLUMN pedidos_itens.pedido_id IS 'id dos pedidos';
COMMENT ON COLUMN pedidos_itens.numero_da_linha IS 'numero da linha dos items do pedido';
COMMENT ON COLUMN pedidos_itens.preco_unitario IS 'preco dos items';
COMMENT ON COLUMN pedidos_itens.envio_id IS 'id do envio';


-- Adicionar constraints obrigatórias


-- Adicionar a constraint na coluna status da tabela pedidos
ALTER TABLE pedidos
ADD CONSTRAINT status_do_pedido
CHECK (status IN ('CANCELADO', 'COMPLETO', 'ABERTO', 'PAGO', 'REEMBOLSADO', 'ENVIADO'));

-- Adicionar a constraint na tabela lojas
ALTER TABLE lojas
ADD CONSTRAINT endereco_loja
CHECK ((endereco_web IS NOT NULL AND endereco_fisico IS NULL) OR (endereco_web IS NULL AND endereco_fisico IS NOT NULL));

--Adicionar constraints na tabela produtos
ALTER TABLE produtos
ADD CONSTRAINT preco_unitario
CHECK (preco_unitario>0);

-- Adicionar a constraint na coluna status da tabela envios
ALTER TABLE envios
ADD CONSTRAINT status_do_envio
CHECK (status IN ('CRIADO', 'ENVIADO', 'TRANSITO', 'ENTREGUE'));


ALTER TABLE pedidos_itens ADD CONSTRAINT produtos_pedidos_itens_fk
FOREIGN KEY (produto_id)
REFERENCES produtos (produtoid)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE estoques ADD CONSTRAINT produtos_estoques_fk
FOREIGN KEY (produto_id)
REFERENCES produtos (produtoid)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE pedidos ADD CONSTRAINT lojas_pedidos_fk
FOREIGN KEY (loja_id)
REFERENCES lojas (lojas_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE estoques ADD CONSTRAINT lojas_estoques_fk
FOREIGN KEY (loja_id)
REFERENCES lojas (lojas_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE envios ADD CONSTRAINT lojas_envios_fk
FOREIGN KEY (loja_id)
REFERENCES lojas (lojas_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE pedidos ADD CONSTRAINT clientes_pedidos_fk
FOREIGN KEY (cliente_id)
REFERENCES clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE envios ADD CONSTRAINT clientes_envios_fk
FOREIGN KEY (cliente_id)
REFERENCES clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE pedidos_itens ADD CONSTRAINT envios_pedidos_itens_fk
FOREIGN KEY (envio_id)
REFERENCES envios (envio_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE pedidos_itens ADD CONSTRAINT pedidos_pedidos_itens_fk
FOREIGN KEY (pedido_id)
REFERENCES pedidos (pedido_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
