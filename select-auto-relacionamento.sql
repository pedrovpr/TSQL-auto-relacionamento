

declare @Tabela_Hierarquia_AutoRelacionamento as table
(
	Id int,
	Nome varchar(50),
	IdPai int
)


insert into @Tabela_Hierarquia_AutoRelacionamento values
(1, 'Pedro', null),
(2, 'José', 1),
(3, 'Priscila', 1),
(4, 'João', 2),
(5, 'Helena', 3),
(6, 'Claudio', 5),
(7, 'Maria', 4),
(8, 'Fabio', 4),
(9, 'Bernardo', 8);


WITH TabelaFinal AS
(
SELECT
    hierarquia.Id,
	hierarquia.Nome,
	hierarquia.IdPai,
    1 AS Nivel,
    CAST (hierarquia.Nome AS VARCHAR(400)) AS Hierarquia
FROM @Tabela_Hierarquia_AutoRelacionamento AS hierarquia
WHERE hierarquia.IdPai is null

UNION ALL

SELECT
    hierarquia.Id,
	hierarquia.Nome,
	hierarquia.IdPai,
    TabelaFinal.Nivel + 1,
    CAST (TabelaFinal.Hierarquia + ' > ' + RTRIM(hierarquia.Nome) AS VARCHAR(400))
FROM TabelaFinal
INNER JOIN @Tabela_Hierarquia_AutoRelacionamento AS hierarquia
ON TabelaFinal.Id = hierarquia.IdPai
)
      
select * from TabelaFinal


