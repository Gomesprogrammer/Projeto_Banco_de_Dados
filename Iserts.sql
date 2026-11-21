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