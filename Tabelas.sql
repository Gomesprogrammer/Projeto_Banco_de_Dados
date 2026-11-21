CREATE TABLE escolas (
    id_escola   INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nome        VARCHAR(200) NOT NULL,
    uf          CHAR(2)      NOT NULL,
    municipio   VARCHAR(100) NOT NULL,
    rede        VARCHAR(50)
);

CREATE TABLE nivel_modalidade (
    id_nivel         INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    modalidade       VARCHAR(100) NOT NULL,
    nivel            VARCHAR(50)  NOT NULL,
    faixa            VARCHAR(80)  NOT NULL,
    tempo_max_round  INTEGER      NOT NULL,
    CONSTRAINT uq_nivel_modalidade UNIQUE (modalidade, nivel, faixa)
);

CREATE TABLE etapas (
    id_etapa     INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nome_etapa   VARCHAR(100) NOT NULL,
    tipo         VARCHAR(20)  NOT NULL DEFAULT 'Nacional',
    edicao       INTEGER      NOT NULL,
    data_inicio  DATE         NOT NULL,
    data_fim     DATE         NOT NULL,
    local        VARCHAR(120) NOT NULL
);

CREATE TABLE equipes (
    id_equipe    INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nome_equipe  VARCHAR(120) NOT NULL,
    id_escola    INTEGER      NOT NULL REFERENCES escolas (id_escola),
    id_nivel     INTEGER      NOT NULL REFERENCES nivel_modalidade (id_nivel),
    CONSTRAINT uq_equipe_escola UNIQUE (nome_equipe, id_escola)
);

CREATE TABLE competidores (
    id_competidor    INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nome             VARCHAR(150) NOT NULL,
    data_nascimento  DATE,
    funcao           VARCHAR(100) NOT NULL,
    cpf              CHAR(11) UNIQUE,
    id_equipe        INTEGER NOT NULL REFERENCES equipes (id_equipe)
);

CREATE TABLE arenas (
    id_arena   INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    arena      VARCHAR(100) NOT NULL,
    id_etapa   INTEGER NOT NULL REFERENCES etapas (id_etapa),
    id_nivel   INTEGER NOT NULL REFERENCES nivel_modalidade (id_nivel),
    CONSTRAINT uq_arena_etapa UNIQUE (arena, id_etapa),
    CONSTRAINT uq_arena_id_etapa UNIQUE (id_arena, id_etapa)
);

CREATE TABLE inscricoes_etapas_equipes (
    id_inscricao    INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    data_inscricao  DATE         NOT NULL DEFAULT CURRENT_DATE,
    status          VARCHAR(100) NOT NULL DEFAULT 'inscrito',
    id_equipe       INTEGER NOT NULL REFERENCES equipes (id_equipe),
    id_etapa        INTEGER NOT NULL REFERENCES etapas (id_etapa),
    CONSTRAINT uq_inscricao_equipe_etapa UNIQUE (id_equipe, id_etapa),
    CONSTRAINT uq_inscricao_id_etapa UNIQUE (id_inscricao, id_etapa)
);

CREATE TABLE juizes (
    id_juiz                  INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nome                     VARCHAR(100) NOT NULL,
    cpf                      CHAR(11) NOT NULL UNIQUE,
    instituicao_federacao    VARCHAR(100) NOT NULL,
    funcao                   VARCHAR(50)  NOT NULL
);

CREATE TABLE juizes_niveis (
    id_nivel  INTEGER NOT NULL REFERENCES nivel_modalidade (id_nivel),
    id_juiz   INTEGER NOT NULL REFERENCES juizes (id_juiz),
    PRIMARY KEY (id_nivel, id_juiz)
);

CREATE TABLE avaliacao_rounds (
    id_round       INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    numero_round   INTEGER      NOT NULL,
    pontuacao      NUMERIC(6,2),
    id_juiz        INTEGER NOT NULL REFERENCES juizes (id_juiz),
    id_inscricao   INTEGER NOT NULL,
    id_arena       INTEGER NOT NULL,
    id_etapa       INTEGER NOT NULL,
    CONSTRAINT uq_round UNIQUE (id_inscricao, id_arena, numero_round),
    CONSTRAINT fk_round_inscricao FOREIGN KEY (id_inscricao, id_etapa)
        REFERENCES inscricoes_etapas_equipes (id_inscricao, id_etapa),
    CONSTRAINT fk_round_arena FOREIGN KEY (id_arena, id_etapa)
        REFERENCES arenas (id_arena, id_etapa)
);
INSERT INTO escolas (nome, uf, municipio, rede) VALUES
('Escola Estadual Coronel', 'SP', 'São Paulo', 'Publica'),
('Colegio Particular Modelo', 'RJ', 'Rio de Janeiro', 'Particular'),
('Escola Joao Serroso', 'MG', 'Belo Horizonte', 'Publica'), 
('Escola Senador Carlos', 'RS', 'Porto Alegre', 'Publica'),
('Colegio Maria Rosa', 'BA', 'Salvador', 'Particular'),
('Escola Joao Liberato', 'PR', 'Curitiba', 'Publica'),
('Colegio Isaac Newton', 'PE', 'Recife', 'Particular'),
('Escola de Educação Infantil Criativa', 'CE', 'Fortaleza', 'Publica'),
('Colegio Excelência', 'DF', 'Brasília', 'Particular'),
('Colegio de Artes e Cultura Local', 'SC', 'Florianópolis', 'Particular'), 
('Colegio Ciências e Tecnologia Avançada', 'SP', 'Campinas', 'Particular'),
('Escola de Línguas e Comunicação Internacional', 'RJ', 'Niterói', 'Publica'),
('Escola de Educação Especial Inclusiva', 'MG', 'Uberlândia', 'Publica'),
('Colegio de Educação Profissionalizante Técnica', 'RS', 'Caxias do Sul', 'Particular'),
('Escola de Ensino Fundamental e Médio Integrado', 'BA', 'Feira de Santana', 'Publica'),
('Colegio de Educação Infantil e Ensino Fundamental Criativa', 'PR', 'Londrina', 'Particular');

INSERT INTO nivel_modalidade (modalidade, nivel, faixa, tempo_max_round) VALUES
('Resgate', 'Nivel 0', 'Fundamental I', 300),
('Resgate', 'Nivel 1', 'Fundamental II', 300),
('Resgate', 'Nivel 2' ,'Fundamental III e Ensino Médio', 300);

INSERT INTO etapas (nome_etapa, tipo, edicao, data_inicio, data_fim, local) VALUES
('OBR - Etapa Nacional 2026', 'Nacional', 2026, '2026-11-01', '2026-11-02', 'Rio de Janeiro'),
('OBR - Etapa Estadual 2026', 'Estadual', 2026, '2026-10-15', '2026-10-15', 'Sao Paulo'),
('OBR - Etapa Regional 2026', 'Regional', 2026, '2026-09-10', '2026-09-10', 'Minas Gerais');

INSERT INTO equipes (nome_equipe, id_escola, id_nivel) VALUES
('Equipe Alpha', 1, 1),
('Equipe Beta', 2, 2),
('Equipe Gama', 3, 3),
('Equipe Delta', 4, 1),
('Equipe Epsilon', 5, 2),
('Equipe Zeta', 6, 3),
('Equipe Eta', 7, 1),
('Equipe Theta', 8, 2),
('Equipe Iota', 9, 3),
('Equipe Kappa', 10, 1), 
('Equipe Lambda', 11, 2),
('Equipe Mu', 12, 3),
('Equipe Nu', 13, 1),
('Equipe Xi', 14, 2),
('Equipe Omicron', 15, 3),
('Equipe Pi', 16, 1);

