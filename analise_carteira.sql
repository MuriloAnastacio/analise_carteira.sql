-- Criação da tabela
CREATE TABLE carteira (
    id INT,
    nome VARCHAR(50),
    valor DECIMAL(10,2),
    dias_atraso INT,
    status VARCHAR(20)
);

-- Inserindo dados
INSERT INTO carteira VALUES
(1, 'Cliente A', 1000.00, 5, 'Em atraso'),
(2, 'Cliente B', 2000.00, 0, 'Em dia'),
(3, 'Cliente C', 1500.00, 30, 'Em atraso'),
(4, 'Cliente D', 3000.00, 60, 'Em atraso'),
(5, 'Cliente E', 500.00, 0, 'Em dia');

-- Total da carteira
SELECT SUM(valor) AS total_carteira
FROM carteira;

-- Total em atraso
SELECT SUM(valor) AS total_atraso
FROM carteira
WHERE dias_atraso > 0;

-- Percentual atraso
SELECT 
    SUM(CASE WHEN dias_atraso > 0 THEN valor ELSE 0 END) /
    SUM(valor) * 100 AS percentual_atraso
FROM carteira;

-- Aging list
SELECT
    CASE
        WHEN dias_atraso = 0 THEN 'Em dia'
        WHEN dias_atraso <= 30 THEN '1-30'
        WHEN dias_atraso <= 60 THEN '31-60'
        ELSE '60+'
    END AS faixa,
    SUM(valor) AS total
FROM carteira
GROUP BY faixa;
