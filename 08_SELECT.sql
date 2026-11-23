SELECT 
    vp.nivel AS NIVEL,
    eq.nome_equipe AS EQUIPE,
    es.nome AS ESCOLA,
    ie.status AS STATUS
FROM vw_placar vp
JOIN equipes eq ON vp.id_equipe = eq.id_equipe
JOIN escolas es ON es.id_escola=eq.id_escola
JOIN inscricoes_etapas_equipes ie ON ie.id_inscricao=vp.id_inscricao
WHERE vp.id_etapa = 1
ORDER BY vp.nivel, vp.posicao;

--FUNÇÃO PODIO POR ETAPA
SELECT * FROM fn_podio_etapa(1);
SELECT * FROM fn_podio_etapa(2); 
SELECT * FROM fn_podio_etapa(3); 