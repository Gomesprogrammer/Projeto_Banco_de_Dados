CREATE OR REPLACE FUNCTION fn_podio_etapa(p_id_etapa INTEGER)
RETURNS TABLE (
    nivel VARCHAR,
    posicao BIGINT,
    equipe VARCHAR,
    escola VARCHAR,
    total_pontos NUMERIC,
    status VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT 
        vp.nivel,
        vp.posicao,
        vp.nome_equipe,
        es.nome,
        vp.total_pontos,
        vp.status
    FROM vw_placar vp
    JOIN equipes eq ON vp.id_equipe = eq.id_equipe
    JOIN escolas es ON eq.id_escola = es.id_escola
    WHERE vp.id_etapa = p_id_etapa
    ORDER BY vp.nivel, vp.posicao;
END;
$$;