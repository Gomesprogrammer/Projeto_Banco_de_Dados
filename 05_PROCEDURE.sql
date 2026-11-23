CREATE OR REPLACE PROCEDURE encerrar_etapa(
    p_etapa INTEGER, 
    P_vagas INTEGER,
    p_proxima_etapa INTEGER DEFAULT NULL,
    p_proxima_data DATE DEFAULT CURRENT_DATE)
LANGUAGE plpgsql
AS $$

    BEGIN 
        IF p_proxima_etapa IS NOT NULL THEN 
            UPDATE inscricoes_etapas_equipes
            SET status = 'classificado'
            WHERE id_inscricao IN (SELECT id_inscricao FROM vw_placar WHERE id_etapa=p_etapa AND posicao<=p_vagas);

            UPDATE inscricoes_etapas_equipes
            SET status = 'desclassificado'
            WHERE id_inscricao IN (SELECT id_inscricao FROM vw_placar WHERE id_etapa=p_etapa AND posicao>p_vagas);

            INSERT INTO inscricoes_etapas_equipes (data_inscricao, status, id_equipe, id_etapa)
            SELECT p_proxima_data, 'inscrito', id_equipe, p_proxima_etapa
            FROM vw_placar
            WHERE id_etapa=p_etapa AND posicao<=p_vagas
            ORDER BY id_equipe;

        ELSE 
        
            UPDATE inscricoes_etapas_equipes
            SET status = 'classificado'
            WHERE id_inscricao IN (SELECT id_inscricao FROM vw_placar WHERE id_etapa=p_etapa AND posicao<=p_vagas);

            UPDATE inscricoes_etapas_equipes
            SET status = 'desclassificado'
            WHERE id_inscricao IN (SELECT id_inscricao FROM vw_placar WHERE id_etapa=p_etapa AND posicao>p_vagas);
        END IF;
    END;
$$;

CREATE OR REPLACE PROCEDURE desclassificar_equipe(
    p_id_inscricao INTEGER
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE inscricoes_etapas_equipes
    SET status = 'desclassificado'
    WHERE id_inscricao = p_id_inscricao;

    UPDATE avaliacao_rounds
    SET pontuacao = NULL
    WHERE id_inscricao = p_id_inscricao;
END;
$$;

