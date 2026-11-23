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

CREATE OR REPLACE VIEW vw_placar AS
SELECT
    ie.id_inscricao,
    eq.id_equipe,
    eq.nome_equipe,
    nm.nivel,
    ie.id_etapa,
    et.nome_etapa,
    ie.status,
    SUM(ar.pontuacao) AS total_pontos,
    RANK() OVER (PARTITION BY ie.id_etapa, eq.id_nivel ORDER BY SUM(ar.pontuacao) DESC) AS posicao
    FROM inscricoes_etapas_equipes ie
    JOIN equipes eq ON ie.id_equipe = eq.id_equipe 
    JOIN nivel_modalidade nm ON eq.id_nivel = nm.id_nivel
    JOIN avaliacao_rounds ar ON ar.id_inscricao = ie.id_inscricao
    JOIN etapas et ON ie.id_etapa = et.id_etapa
    GROUP BY ie.id_inscricao, eq.id_equipe, eq.nome_equipe, nm.nivel, ie.id_etapa, et.nome_etapa,ie.status;






