create database EasyPark
go

use EasyPark
go

create table pessoas 
(
	ID int				not null primary key identity,
	NOME varchar(50)	,
	RG varchar (15)		,
	CIDADE varchar(100)	,	
	SENHA varchar (MAX)	,
)
go

create table funcionarios
(
	ID_FUNCIONARIO int	not null primary key identity,
	PESSOA_ID int		not null,	
	SETOR int			not null,
	FISCAL int			not null,
	STATUS_FUN int		not null,
	foreign key (PESSOA_ID) references pessoas (ID)
)
go

create table logins 
(
	PESSOA_ID int		not null primary key,
	EMAIL varchar (50)	,
	CONFIRMACAO	int		not null,
	SALDO decimal (9,2)	,
	foreign key (PESSOA_ID) references pessoas(ID)
)
go

create table veiculos
(
	ID_VEICULO int				not null primary key identity,
	LOGIN_ID int				not null,
	PLACA varchar (10)			not null,
	foreign key (LOGIN_ID) references logins (PESSOA_ID),
)
go

create table compras
(
	ID_COMPRA		int				not null primary key identity,
	LOGIN_ID		int				,
	VALOR			decimal (9,2)	not null,
	DATA_COMP		datetime		not null,
	HORA_COMP		datetime		not null,
	foreign key (LOGIN_ID) references logins (PESSOA_ID)
)
go

create table paradas
(
	ID_PARADA		int				not null primary key identity,
	VEICULO_ID		int				not null,
	DATA_PARA		datetime		not null,
	QTD_HORA		int				not null,
	foreign key (VEICULO_ID) references veiculos (ID_VEICULO) 
)
go

create table notificacoes
(
	ID_NOTICACAO	int primary key identity,
	PARADA_ID		int,
	FUNCIONARIO_ID  int,
	PESSOA_ID		int not null,
	DATA_NOT		datetime,
	DESCRICAO		int,
	CONFLEITURA		int,
	foreign key (PARADA_ID)			references paradas (ID_PARADA),
	foreign key (FUNCIONARIO_ID)	references funcionarios (ID_FUNCIONARIO),
	foreign key (PESSOA_ID)			references pessoas (ID)
)
go

create table pesquisas
(
	ID_PESQUISA		int primary key identity,
	VEICULO_ID		int not null,
	PARADA_ID		int,
	FUNCIONARIO_ID	int not null,
	STATUS_PES		int not null,
	foreign key (VEICULO_ID) references veiculos (ID_VEICULO),
	foreign key (PARADA_ID) references paradas (ID_PARADA),
	foreign key (FUNCIONARIO_ID) references funcionarios (ID_FUNCIONARIO)
)
go

drop database EasyPark

/*LEGENDA
LEGENDA PARA AS DESCRIÇOES DAS NOTIFICAÇOES 
1 - O USUARIO NÃO POSSUE CADASTRO
2 - O HORARIO DA PARADA JA TERMINOU
3 - O HORARIO DA PARADA ACABOU DE TERMINAR
4 - O VEICULO NAO REALIZOU A PARADA NO DIA DA PESQUISA
5 - O USUARIO NÃO REALIZOU A PARADA 

CONFLEITURA 
1 = true LIDO A MSG
0 = false NÂO LIDO A MSG
--
STATUS DA PESQUISA
0 = NÃO NOTIFICOU
1 = NOTIFICOU
2 = PARADA CORRETA
3 = ERRO SISTEMA

CONFIRMAÇAO DE EMAIL
0 = NÃO CONFIRMOU
1 = CONFIRMOU

STATUS FUNCIONARIO
0 = INATIVO
1 = ATIVO
*/

select * from funcionarios
select * from logins
select * from veiculos
select * from pessoas
select * from paradas
select * from notificacoes
select * from compras
select * from pesquisas

/*	CUIDADO !!!!!!!!!!*/
drop database EasyPark
delete from pessoas
delete from logins
delete from veiculos

delete veiculos where LOGIN_ID = 1036
delete logins where PESSOA_ID = 1036
delete pessoas where ID = 1036


/*	ADD PESSOAS */
insert into pessoas values	('Rauan',				'12.456.789-0',	'São Jose do Rio Preto', '1234'),
							('Carol',				'12.938.475-6',	'São Jose do Rio Preto', '123'),
							('Raissa',				'22.234.756-5',	'São Jose do Rio Preto', '123'),
							('Lucimar',				'10.234.676-4',	'São Jose do Rio Preto', '123'),
							('Adriano',				'10.334.700-3',	'São Jose do Rio Preto', '123'),
							('Carlos Jose',			'12.426.729-0',	'São Jose do Rio Preto', '1234'),
							('Jose',				'12.928.475-6',	'São Jose do Rio Preto', '123'),
							('Joaquina',			'42.234.716-5',	'São Jose do Rio Preto', '123'),
							('Jamil',				'22.434.676-4',	'São Jose do Rio Preto', '123'),
							('Tereza',				'32.232.700-3',	'São Jose do Rio Preto', '123'),
							('Jose Carlos',			'63.425.729-0',	'São Jose do Rio Preto', '1234'),
							('Jose romero',			'72.928.470-0',	'São Jose do Rio Preto', '123'),
							('Brito',				'82.234.711-1',	'São Jose do Rio Preto', '123'),
							('Carla',				'82.434.672-2',	'São Jose do Rio Preto', '123'),
							('Vera',				'92.232.703-3',	'São Jose do Rio Preto', '123'),
							('Jose Carlos Britto',	'23.425.750-0',	'São Jose do Rio Preto', '1234'),
							('Carlão',				'12.925.470-0',	'São Jose do Rio Preto', '123'),
							('Rena',				'52.235.711-1',	'São Jose do Rio Preto', '123'),
							('Renata',				'24.434.672-2',	'São Jose do Rio Preto', '123'),
							('Vera',				'33.532.703-3',	'São Jose do Rio Preto', '123'),
							('Marisa',				'33.552.703-4',	'São Jose do Rio Preto', '123'),
							('Marcela',				'33.552.703-5',	'São Jose do Rio Preto', '123'),
							('Matheus',				'33.552.703-6',	'São Jose do Rio Preto', '123')

/*	ADD LOGINS AOS USUARIOS*/
insert into logins values	(2, 'carol@gmail.com',		1, 15.0),
							(3, 'raissa@gmail.com',		1, 2.0),
							(4, 'lucimar@gmail.com',	1, 0.0),
							(5, 'adriano@gmail.com',	0, 10.0),
							(6, 'Carlosjose@gmail.com', 0, 100.0),
							(7, 'Jose@gmail.com',		0, 32.0),
							(8, 'Joaquina@gmail.com',	0, 22.5),
							(9, 'Jamil@gmail.com',		0, 14.5),
							(10, 'Tereza@gmail.com',	0, 8.5),
							(11, 'Josecar@gmail.com',	0, 10.0)

/*	ADD VEICULOS AOS USUARIOS*/
insert into veiculos values	(2,'ASD-1234'),
							(3,'QWE-1234'),
							(4,'TYU-1234'),
							(5,'DFG-1234'),
							(6,'HJK-1234'),
							(7,'ZXC-1234'),
							(8,'BNM-1234'),
							(9,'JKL-1234'),
							(10,'TGB-1234'),
							(11,'UJM-1234')

/*	ADD OS FUNCIONARIOS*/
insert into funcionarios values (12, 4321, 1234, 1),
								(13, 5678, 8765, 1),
								(14, 1234, 4321, 1),
								(15, 1212, 2121, 1),
								(16, 1313, 3131, 0),
								(17, 1414, 4141, 1),
								(18, 1515, 5151, 1),
								(19, 1616, 6161, 0),
								(20, 1717, 7171, 1),
								(21, 1818, 8181, 1),
								(22, 1919, 9191, 1),
								(23, 1888, 8881, 1)

/*	ADD COMPRAS DOS USUARIOS*/								
insert into compras values	(2, 5.0,	GETDATE(), GETDATE()),
							(2, 10.0,	GETDATE()-42, GETDATE()-42),
							(2, 20.0,	GETDATE()-42, GETDATE()-42),
							(2, 10.0,	GETDATE()-50, GETDATE()-50),
							(2, 5.0,	GETDATE()-55, GETDATE()-55)

/*	ADD PARADAS DOS USUARIOS*/	
insert into paradas values	(1, GETDATE(), 2),
							(1, GETDATE()-42, 1),
							(1, GETDATE()-43, 3),
							(1, GETDATE()-50, 3),
							(1, GETDATE()-56, 2)

/*	ADD NOTIFICAÇÕES DOS USUARIOS*/	
insert into notificacoes values (1, 2, 2, GETDATE()   , 2, 0),
								(3, 3, 2, GETDATE()-43, 2, 0),
								(5, 4, 2, GETDATE()-56, 2, 0)


/*TESTESS*/
/*TESTES


select SENHA, NOME from logins l, pessoas p where EMAIL = 'rauan_sanfelice@hotmail.com' and l.PESSOA_ID = p.ID

select ID_NOTICACAO, DATA_NOT, CONFLEITURA 
from 
	pessoas p, 
	veiculos v, 
	paradas pa, 
	notificacoes n 
where 
	p.ID = v.LOGIN_ID and 
	v.ID_VEICULO = pa.VEICULO_ID and 
	pa.ID_PARADA = n.PARADA_ID and
	p.ID = 2 
order by data_not desc


update logins set CONFIRMACAO = 1 where PESSOA_ID = 4
select * from logins where PESSOA_ID = 4

select * from pessoas p, logins l where p.ID = l.PESSOA_ID and l.EMAIL = 'rauan_sanfelice@hotmail.com' and p.SENHA = 123
select * from pessoas p, logins l where p.ID = l.PESSOA_ID

/*	TUDO SOBRE A PESQUISA QUE O FUNCIONARIO REALIZA*/
insert into pesquisas values (1, 1, 1)
update pesquisas set STATUS_PES = 5 WHERE ID_PESQUISA = 1 
select COUNT(ID_PESQUISA) PESQUISAS from pesquisas p , funcionarios f, pessoas pe where f.ID_FUNCIONARIO = p.FUNCIONARIO_ID and f.PESSOA_ID = pe.ID and pe.ID = 12
Select COUNT(STATUS_PES) TOTAL FROM pesquisas pe, funcionarios f, pessoas p where STATUS_PES = 2 and pe.FUNCIONARIO_ID = f.ID_FUNCIONARIO and p.ID = f.PESSOA_ID and p.ID = 12


/* PESQUISA DAS PARADAS POR DATA*/
select * from paradas where convert(varchar(10), DATA_PARA, 111) = '2016/01/28'
select * from paradas where convert(varchar(10), DATA_PARA, 103) = '28/01/2016'
select convert(varchar(10), DATA_PARA, 103) from paradas

/* SELECT DE FUNCIONARIOS TODOS FUNCIONANDO CORRETAMENTE */
select * from pessoas p, funcionarios f where p.id = f.PESSOA_ID and p.ID = 3
select * from funcionarios where PESSOA_ID = 3
select * from pessoas p, funcionarios f where f.PESSOA_ID = p.ID and p.SENHA = 123 and f.FISCAL = 4321
select * from pessoas p, funcionarios f where p.ID = f.PESSOA_ID
select * from pessoas p, funcionarios f where p.ID = f.PESSOA_ID and NOME like 'rai%'

/* SELECT DE LOGIN TODOS FUNCIONANDO CORRETAMENTE */ 
select * from pessoas p, logins l where p.ID = l.PESSOA_ID and l.PESSOA_ID = 2
select * from pessoas p, logins l where p.ID = l.PESSOA_ID and l.EMAIL = 'carol@gmail.com' and p.SENHA = 123
select * from pessoas p, logins l where p.ID = l.PESSOA_ID
select * from pessoas where NOME like 'raUan%'
select * from pessoas p, logins l where p.ID = l.PESSOA_ID and l.PESSOA_ID = 2
update logins set SALDO = 55 where PESSOA_ID = 2

/* SELECT DE PARADAS TODOS FUNCIONANDO CORRETAMENTE */ 
select * from paradas where ID_PARADA = 1
select TOP 1 ID_PARADA, ID_VEICULO, DATA_PARA,QTD_HORA 
from pessoas pe, veiculos v, paradas p 
where pe.ID = v.LOGIN_ID and v.ID_VEICULO = p.VEICULO_ID and pe.ID = 2 ORDER BY DATA_PARA desc
select * from pessoas p, veiculos v, paradas pa where v.LOGIN_ID = p.ID and pa.VEICULO_ID = v.ID_VEICULO and v.LOGIN_ID = 2 order by DATA_PARA desc
select * from paradas pa, notificacoes n where pa.ID_PARADA = n.PARADA_ID and pa.ID_PARADA = 8	

/* SELECT DE NOTIFICAO TODOS FUNCIONANDO CORRETAMENTE */ 
select ID_NOTICACAO, DATA_NOT, CONFLEITURA from pessoas p, veiculos v, paradas pa, notificacoes n 
where p.ID = v.LOGIN_ID and v.ID_VEICULO = pa.VEICULO_ID and pa.ID_PARADA = n.PARADA_ID and p.ID = 4 order by data_not desc
update notificacoes set CONFLEITURA = 0 where ID_NOTICACAO = 3
select TOP 1 * from pessoas pe, veiculos v, notificacoes n where pe.ID = v.LOGIN_ID and pe.ID = 4 ORDER BY DATA_NOT desc
select COUNT(ID_NOTICACAO) TOTALNOTIFICACAO from notificacoes n, funcionarios f, pessoas p where n.FUNCIONARIO_ID = f.ID_FUNCIONARIO and f.PESSOA_ID = p.ID and p.ID = 12

/*SELECT PARA O GRAFICO*/
Select (Select count(ID_PARADA) From paradas) as totalparadas, (Select count(ID_NOTICACAO) From notificacoes) as totalnotificacoes
select DATA_COMP from compras where (convert(varchar(2), DATA_COMP, 101) * 100) + 20 = 120 

select COUNT(DATA_PARA) AS DATA from paradas

select DATA_PARA from paradas order by DATA_PARA

select  COUNT(DATA_PARA) from paradas where			convert(varchar(4), DATA_PARA, 111) = '2016'
select  COUNT(DATA_NOT)  from notificacoes where	convert(varchar(4), DATA_NOT, 111) = '2016'
select  COUNT(DATA_COMP) from compras where			convert(varchar(4), DATA_COMP, 111) = '2016'
select  SUM(VALOR) as decimal from compras where	convert(varchar(4), DATA_COMP, 111) = '2016'

select  COUNT(DATA_PARA) as data from paradas where		convert(varchar(4), DATA_PARA, 111) = '2016'	and Datepart(MONTH, DATA_PARA ) = '1'
select COUNT(DATA_PARA) AS MES from paradas where		convert(varchar(4), DATA_PARA, 111) = '2016' and Datepart(MONTH, DATA_PARA)  = 2
select COUNT(DATA_PARA) AS MES from paradas where		convert(varchar(4), DATA_PARA, 111) = 2016 and Datepart(MONTH, DATA_PARA)  = 1
select SUM(VALOR) as SOMA from compras where			convert(varchar(4), DATA_COMP, 111) = '2016' and Datepart(MONTH, DATA_COMP)  = '2'
select COUNT(DATA_PARA) AS MES from paradas where convert(varchar(4), DATA_PARA, 111) = 2016 and Datepart(MONTH, DATA_PARA)  = 1


select  COUNT(DATA_NOT)  from notificacoes where	convert(varchar(4), DATA_NOT,  111) = '2016'	and convert(varchar(2), DATA_NOT,  101) = '02'
select  COUNT(DATA_COMP) from compras where			convert(varchar(4), DATA_COMP, 111) = '2016'	and convert(varchar(2), DATA_COMP, 101) = '02'
select  SUM(VALOR)		 from compras where			convert(varchar(4), DATA_COMP, 111) = '2016'	and convert(varchar(2), DATA_COMP, 101) = '1'

select COUNT(DATA_PARA) AS MES from paradas where convert(varchar(4), DATA_PARA, 111) = 2016 and convert(varchar(2), DATA_PARA, 101) = 01

select SUM(VALOR) as SOMA from compras where convert(varchar(4), DATA_COMP, 111) = 2016 and (convert(varchar(2), DATA_COMP, 101) * 100) + 20 = 120
select COUNT(DATA_PARA) AS MES from paradas where convert(varchar(4), DATA_PARA, 111) = '2016' and convert(varchar(2), DATA_PARA, 101)  = '01' 

select top 1 ID_NOTICACAO, DATA_NOT, DESCRICAO, CONFLEITURA, ID_PARADA, FUNCIONARIO_ID 
                                    from pessoas pe, veiculos v, notificacoes n, paradas pa 
                                    where v.LOGIN_ID = pe.ID and pa.VEICULO_ID = v.ID_VEICULO and pa.ID_PARADA = n.PARADA_ID and pe.ID = 2 order by DATA_NOT desc


IF ('teste') = ''
BEGIN
	insert into pessoas values (null, null, null, null)
	select @@IDENTITY from pessoas
END
ELSE
	insert into pessoas values ('Renan','12.222.789-0',	'São Jose do Rio Preto', '1234')
	select @@IDENTITY from pessoas
GO

update funcionarios set STATUS_FUN = 0 where PESSOA_ID = 23

select top 1 DATA_PARA, QTD_HORA from veiculos v, paradas p where v.ID_VEICULO = p.VEICULO_ID and PLACA = 'OOO-1234' order by DATA_PARA desc

drop database easypark

select * from paradas where convert(varchar(10), DATA_PARA, 103) =  '10/06/2016' and VEICULO_ID =  1

select * from compras where convert(varchar(10), DATA_COMP, 103) =  '10/06/2016' and LOGIN_ID = 2

select * from notificacoes where ID_NOTICACAO = 1

--LISTA NOTIFICAÇÃO
select ID_NOTICACAO, DATA_NOT, CONFLEITURA 
from 
	pessoas p, 
	notificacoes n 
where 
	p.ID = 2 and 
	n.PESSOA_ID = 2 and 
	p.ID = n.PESSOA_ID
order by data_not desc

select ID_PARADA,ID_VEICULO, DATA_PARA, QTD_HORA from 
pessoas p, veiculos v, paradas pa 
where v.LOGIN_ID = p.ID and pa.VEICULO_ID = v.ID_VEICULO and v.LOGIN_ID = 2 order by DATA_PARA desc


select * from pessoas where NOME = 'Rauan' and SENHA = '1234'

select * from paradas p, veiculos v where v.ID_VEICULO = '2'
insert into notificacoes values ('15', '2', GETDATE(),GETDATE())


select SENHA from logins l, pessoas p where EMAIL = 'carol@gmail.com' and l.PESSOA_ID = p.ID

select * from funcionarios where FISCAL = 1234

select * from pessoas pe, veiculos v, notificacoes n where pe.ID = v.LOGIN_ID and pe.ID = 4 ORDER BY DATA_NOT desc

select top 1 ID_NOTICACAO, DATA_NOT, DESCRICAO, CONFLEITURA, ID_PARADA, FUNCIONARIO_ID 
from pessoas pe, veiculos v, notificacoes n, paradas pa 
where v.LOGIN_ID = pe.ID and pa.VEICULO_ID = v.ID_VEICULO and pa.ID_PARADA = n.PARADA_ID and pe.ID = 4 order by DATA_NOT desc

update parada set 
			DATA = 0,
			HORA_INICIAL = 0,
			MIN_INICIAL = 0,
			TEMP_COMPRADO = 0,
			TEMP_ADICIONADO = 0
			where PARADA_ID = 2

delete from veiculos
where ID_VEICULO = 2

create view Cliente_Parada
as
	select p.*, pa.*, v.*
	from pessoas p, logins g, paradas pa, veiculos v
	where ID_VEICULO = ID_PESSOA;

select * from Cliente_Parada

select top 1 ID_NOTICACAO,PARADA_ID, FUNCIONARIO_ID, PESSOA_ID,DATA_NOT,DESCRICAO,CONFLEITURA 
from 
	notificacoes 
where 
	PESSOA_ID = 2 
order by DATA_NOT desc
*/



/*
insert into compras values	(2, 5.0,	'2015-01-19 08:12:00.000', '2015-01-19 08:12:00.000'),
							(2, 20.0,	'2015-02-20 12:12:00.000', '2015-02-20 12:12:00.000'),
							(2, 5.0,	'2015-03-02 10:10:00.000', '2015-03-02 10:10:00.000'),
							(2, 10.0,	'2015-04-01 11:12:00.000', '2015-04-01 11:12:00.000'),
							(2, 5.0,	'2015-05-05 11:12:00.000', '2015-05-05 11:12:00.000'),
							(2, 20.0,	'2015-06-06 08:12:00.000', '2015-06-06 08:12:00.000'),
							(2, 5.0,	'2015-07-19 12:12:00.000', '2015-07-19 12:12:00.000'),
							(2, 10.0,	'2015-08-19 17:12:00.000', '2015-08-19 17:12:00.000'),
							(2, 5.0,	'2015-09-19 19:12:00.000', '2015-09-19 19:12:00.000'),
							(2, 20.0,	'2015-10-19 18:12:00.000', '2015-10-19 18:12:00.000'),
							(2, 5.0,	'2015-11-19 19:12:00.000', '2015-11-19 19:12:00.000'),
							(2, 20.0,	'2015-12-19 18:12:00.000', '2015-12-19 18:12:00.000')
insert into compras values	(2, 5.0,	'2016-01-19 08:12:00.000', '2016-01-19 08:12:00.000'),
							(2, 20.0,	'2016-01-20 12:12:00.000', '2016-01-20 12:12:00.000'),
							(2, 5.0,	'2016-01-02 10:10:00.000', '2016-01-02 10:10:00.000'),
							(2, 10.0,	'2016-01-01 11:12:00.000', '2016-01-01 11:12:00.000'),
							(2, 5.0,	'2016-01-05 11:12:00.000', '2016-01-05 11:12:00.000'),
							(2, 20.0,	'2016-01-06 08:12:00.000', '2016-01-06 08:12:00.000'),
							(2, 5.0,	'2016-02-19 12:12:00.000', '2016-02-19 12:12:00.000'),
							(2, 10.0,	'2016-02-19 17:12:00.000', '2016-02-19 17:12:00.000'),
							(2, 5.0,	'2016-02-19 19:12:00.000', '2016-02-19 19:12:00.000'),
							(2, 20.0,	'2016-02-19 18:12:00.000', '2016-02-19 18:12:00.000'),
							(2, 5.0,	'2016-02-19 19:12:00.000', '2016-02-19 19:12:00.000'),
							(2, 20.0,	'2016-02-19 18:12:00.000', '2016-02-19 18:12:00.000')
update logins set SALDO = 270 where logins.PESSOA_ID = 2

/*2 - USUARIO - 10 COMPRAS POR ANO*/
insert into compras values	(3, 5.0,	'2014-01-19 08:12:00.000', '2014-01-19 08:12:00.000'),
							(3, 20.0,	'2014-02-20 12:12:00.000', '2014-02-20 12:12:00.000'),
							(3, 5.0,	'2014-03-02 10:10:00.000', '2014-03-02 10:10:00.000'),
							(3, 10.0,	'2014-04-01 11:12:00.000', '2014-04-01 11:12:00.000'),
							(3, 5.0,	'2014-05-05 11:12:00.000', '2014-05-05 11:12:00.000'),
							(3, 20.0,	'2014-06-06 08:12:00.000', '2014-06-06 08:12:00.000'),
							(3, 5.0,	'2014-07-19 12:12:00.000', '2014-07-19 12:12:00.000'),
							(3, 10.0,	'2014-08-19 17:12:00.000', '2014-08-19 17:12:00.000'),
							(3, 5.0,	'2014-09-19 19:12:00.000', '2014-09-19 19:12:00.000'),
							(3, 20.0,	'2014-10-19 18:12:00.000', '2014-10-19 18:12:00.000'),
							(3, 5.0,	'2014-11-19 19:12:00.000', '2014-11-19 19:12:00.000'),
							(3, 20.0,	'2014-12-19 18:12:00.000', '2014-12-19 18:12:00.000')
insert into compras values	(3, 5.0,	'2015-01-19 08:12:00.000', '2015-01-19 08:12:00.000'),
							(3, 20.0,	'2015-02-20 12:12:00.000', '2015-02-20 12:12:00.000'),
							(3, 5.0,	'2015-03-02 10:10:00.000', '2015-03-02 10:10:00.000'),
							(3, 10.0,	'2015-04-01 11:12:00.000', '2015-04-01 11:12:00.000'),
							(3, 5.0,	'2015-05-05 11:12:00.000', '2015-05-05 11:12:00.000'),
							(3, 20.0,	'2015-06-06 08:12:00.000', '2015-06-06 08:12:00.000'),
							(3, 5.0,	'2015-07-19 12:12:00.000', '2015-07-19 12:12:00.000'),
							(3, 10.0,	'2015-08-19 17:12:00.000', '2015-08-19 17:12:00.000'),
							(3, 5.0,	'2015-09-19 19:12:00.000', '2015-09-19 19:12:00.000'),
							(3, 20.0,	'2015-10-19 18:12:00.000', '2015-10-19 18:12:00.000'),
							(3, 5.0,	'2015-11-19 19:12:00.000', '2015-11-19 19:12:00.000'),
							(3, 20.0,	'2015-12-19 18:12:00.000', '2015-12-19 18:12:00.000')
insert into compras values	(3, 5.0,	'2016-01-19 08:12:00.000', '2016-01-19 08:12:00.000'),
							(3, 20.0,	'2016-01-20 12:12:00.000', '2016-01-20 12:12:00.000'),
							(3, 5.0,	'2016-01-02 10:10:00.000', '2016-01-02 10:10:00.000'),
							(3, 10.0,	'2016-01-01 11:12:00.000', '2016-01-01 11:12:00.000'),
							(3, 5.0,	'2016-01-05 11:12:00.000', '2016-01-05 11:12:00.000'),
							(3, 20.0,	'2016-01-06 08:12:00.000', '2016-01-06 08:12:00.000'),
							(3, 5.0,	'2016-02-19 12:12:00.000', '2016-02-19 12:12:00.000'),
							(3, 10.0,	'2016-02-19 17:12:00.000', '2016-02-19 17:12:00.000'),
							(3, 5.0,	'2016-02-19 19:12:00.000', '2016-02-19 19:12:00.000'),
							(3, 20.0,	'2016-02-19 18:12:00.000', '2016-02-19 18:12:00.000'),
							(3, 5.0,	'2016-02-19 19:12:00.000', '2016-02-19 19:12:00.000'),
							(3, 20.0,	'2016-02-19 18:12:00.000', '2016-02-19 18:12:00.000')
update logins set SALDO = 270 where logins.PESSOA_ID = 3

/*3 - USUARIO*/
insert into compras values	(4, 5.0,	'2014-01-19 08:12:00.000', '2014-01-19 08:12:00.000'),
							(4, 20.0,	'2014-02-20 12:12:00.000', '2014-02-20 12:12:00.000'),
							(4, 5.0,	'2014-03-02 10:10:00.000', '2014-03-02 10:10:00.000'),
							(4, 10.0,	'2014-04-01 11:12:00.000', '2014-04-01 11:12:00.000'),
							(4, 5.0,	'2014-05-05 11:12:00.000', '2014-05-05 11:12:00.000'),
							(4, 20.0,	'2014-06-06 08:12:00.000', '2014-06-06 08:12:00.000'),
							(4, 5.0,	'2014-07-19 12:12:00.000', '2014-07-19 12:12:00.000'),
							(4, 10.0,	'2014-08-19 17:12:00.000', '2014-08-19 17:12:00.000'),
							(4, 5.0,	'2014-09-19 19:12:00.000', '2014-09-19 19:12:00.000'),
							(4, 20.0,	'2014-10-19 18:12:00.000', '2014-10-19 18:12:00.000'),
							(4, 5.0,	'2014-11-19 19:12:00.000', '2014-11-19 19:12:00.000'),
							(4, 20.0,	'2014-12-19 18:12:00.000', '2014-12-19 18:12:00.000')
insert into compras values	(4, 5.0,	'2015-01-19 08:12:00.000', '2015-01-19 08:12:00.000'),
							(4, 20.0,	'2015-02-20 12:12:00.000', '2015-02-20 12:12:00.000'),
							(4, 5.0,	'2015-03-02 10:10:00.000', '2015-03-02 10:10:00.000'),
							(4, 10.0,	'2015-04-01 11:12:00.000', '2015-04-01 11:12:00.000'),
							(4, 5.0,	'2015-05-05 11:12:00.000', '2015-05-05 11:12:00.000'),
							(4, 20.0,	'2015-06-06 08:12:00.000', '2015-06-06 08:12:00.000'),
							(4, 5.0,	'2015-07-19 12:12:00.000', '2015-07-19 12:12:00.000'),
							(4, 10.0,	'2015-08-19 17:12:00.000', '2015-08-19 17:12:00.000'),
							(4, 5.0,	'2015-09-19 19:12:00.000', '2015-09-19 19:12:00.000'),
							(4, 20.0,	'2015-10-19 18:12:00.000', '2015-10-19 18:12:00.000'),
							(4, 5.0,	'2015-11-19 19:12:00.000', '2015-11-19 19:12:00.000'),
							(4, 20.0,	'2015-12-19 18:12:00.000', '2015-12-19 18:12:00.000')
insert into compras values	(4, 5.0,	'2016-01-19 08:12:00.000', '2016-01-19 08:12:00.000'),
							(4, 20.0,	'2016-01-20 12:12:00.000', '2016-01-20 12:12:00.000'),
							(4, 5.0,	'2016-01-02 10:10:00.000', '2016-01-02 10:10:00.000'),
							(4, 10.0,	'2016-01-01 11:12:00.000', '2016-01-01 11:12:00.000'),
							(4, 5.0,	'2016-01-05 11:12:00.000', '2016-01-05 11:12:00.000'),
							(4, 20.0,	'2016-01-06 08:12:00.000', '2016-01-06 08:12:00.000'),
							(4, 5.0,	'2016-02-19 12:12:00.000', '2016-02-19 12:12:00.000'),
							(4, 10.0,	'2016-02-19 17:12:00.000', '2016-02-19 17:12:00.000'),
							(4, 5.0,	'2016-02-19 19:12:00.000', '2016-02-19 19:12:00.000'),
							(4, 20.0,	'2016-02-19 18:12:00.000', '2016-02-19 18:12:00.000'),
							(4, 5.0,	'2016-02-19 19:12:00.000', '2016-02-19 19:12:00.000'),
							(4, 20.0,	'2016-02-19 18:12:00.000', '2016-02-19 18:12:00.000')
update logins set SALDO = 270 where logins.PESSOA_ID = 4

/*4 - USUARIO*/
insert into compras values	(5, 5.0,	'2014-01-19 08:12:00.000', '2014-01-19 08:12:00.000'),
							(5, 20.0,	'2014-02-20 12:12:00.000', '2014-02-20 12:12:00.000'),
							(5, 5.0,	'2014-03-02 10:10:00.000', '2014-03-02 10:10:00.000'),
							(5, 10.0,	'2014-04-01 11:12:00.000', '2014-04-01 11:12:00.000'),
							(5, 5.0,	'2014-05-05 11:12:00.000', '2014-05-05 11:12:00.000'),
							(5, 20.0,	'2014-06-06 08:12:00.000', '2014-06-06 08:12:00.000'),
							(5, 5.0,	'2014-07-19 12:12:00.000', '2014-07-19 12:12:00.000'),
							(5, 10.0,	'2014-08-19 17:12:00.000', '2014-08-19 17:12:00.000'),
							(5, 5.0,	'2014-09-19 19:12:00.000', '2014-09-19 19:12:00.000'),
							(5, 20.0,	'2014-10-19 18:12:00.000', '2014-10-19 18:12:00.000'),
							(5, 5.0,	'2014-11-19 19:12:00.000', '2014-11-19 19:12:00.000'),
							(5, 20.0,	'2014-12-19 18:12:00.000', '2014-12-19 18:12:00.000')
insert into compras values	(5, 5.0,	'2015-01-19 08:12:00.000', '2015-01-19 08:12:00.000'),
							(5, 20.0,	'2015-02-20 12:12:00.000', '2015-02-20 12:12:00.000'),
							(5, 5.0,	'2015-03-02 10:10:00.000', '2015-03-02 10:10:00.000'),
							(5, 10.0,	'2015-04-01 11:12:00.000', '2015-04-01 11:12:00.000'),
							(5, 5.0,	'2015-05-05 11:12:00.000', '2015-05-05 11:12:00.000'),
							(5, 20.0,	'2015-06-06 08:12:00.000', '2015-06-06 08:12:00.000'),
							(5, 5.0,	'2015-07-19 12:12:00.000', '2015-07-19 12:12:00.000'),
							(5, 10.0,	'2015-08-19 17:12:00.000', '2015-08-19 17:12:00.000'),
							(5, 5.0,	'2015-09-19 19:12:00.000', '2015-09-19 19:12:00.000'),
							(5, 20.0,	'2015-10-19 18:12:00.000', '2015-10-19 18:12:00.000'),
							(5, 5.0,	'2015-11-19 19:12:00.000', '2015-11-19 19:12:00.000'),
							(5, 20.0,	'2015-12-19 18:12:00.000', '2015-12-19 18:12:00.000')
insert into compras values	(5, 5.0,	'2016-01-19 08:12:00.000', '2016-01-19 08:12:00.000'),
							(5, 20.0,	'2016-01-20 12:12:00.000', '2016-01-20 12:12:00.000'),
							(5, 5.0,	'2016-01-02 10:10:00.000', '2016-01-02 10:10:00.000'),
							(5, 10.0,	'2016-01-01 11:12:00.000', '2016-01-01 11:12:00.000'),
							(5, 5.0,	'2016-01-05 11:12:00.000', '2016-01-05 11:12:00.000'),
							(5, 20.0,	'2016-01-06 08:12:00.000', '2016-01-06 08:12:00.000'),
							(5, 5.0,	'2016-02-19 12:12:00.000', '2016-02-19 12:12:00.000'),
							(5, 10.0,	'2016-02-19 17:12:00.000', '2016-02-19 17:12:00.000'),
							(5, 5.0,	'2016-02-19 19:12:00.000', '2016-02-19 19:12:00.000'),
							(5, 20.0,	'2016-02-19 18:12:00.000', '2016-02-19 18:12:00.000'),
							(5, 5.0,	'2016-02-19 19:12:00.000', '2016-02-19 19:12:00.000'),
							(5, 20.0,	'2016-02-19 18:12:00.000', '2016-02-19 18:12:00.000')
update logins set SALDO = 270 where logins.PESSOA_ID = 5

/*5 - USUARIO*/
insert into compras values	(6, 5.0,	'2014-01-19 08:12:00.000', '2014-01-19 08:12:00.000'),
							(6, 20.0,	'2014-02-20 12:12:00.000', '2014-02-20 12:12:00.000'),
							(6, 5.0,	'2014-03-02 10:10:00.000', '2014-03-02 10:10:00.000'),
							(6, 10.0,	'2014-04-01 11:12:00.000', '2014-04-01 11:12:00.000'),
							(6, 5.0,	'2014-05-05 11:12:00.000', '2014-05-05 11:12:00.000'),
							(6, 20.0,	'2014-06-06 08:12:00.000', '2014-06-06 08:12:00.000'),
							(6, 5.0,	'2014-07-19 12:12:00.000', '2014-07-19 12:12:00.000'),
							(6, 10.0,	'2014-08-19 17:12:00.000', '2014-08-19 17:12:00.000'),
							(6, 5.0,	'2014-09-19 19:12:00.000', '2014-09-19 19:12:00.000'),
							(6, 20.0,	'2014-10-19 18:12:00.000', '2014-10-19 18:12:00.000'),
							(6, 5.0,	'2014-11-19 19:12:00.000', '2014-11-19 19:12:00.000'),
							(6, 20.0,	'2014-12-19 18:12:00.000', '2014-12-19 18:12:00.000')
insert into compras values	(6, 5.0,	'2015-01-19 08:12:00.000', '2015-01-19 08:12:00.000'),
							(6, 20.0,	'2015-02-20 12:12:00.000', '2015-02-20 12:12:00.000'),
							(6, 5.0,	'2015-03-02 10:10:00.000', '2015-03-02 10:10:00.000'),
							(6, 10.0,	'2015-04-01 11:12:00.000', '2015-04-01 11:12:00.000'),
							(6, 5.0,	'2015-05-05 11:12:00.000', '2015-05-05 11:12:00.000'),
							(6, 20.0,	'2015-06-06 08:12:00.000', '2015-06-06 08:12:00.000'),
							(6, 5.0,	'2015-07-19 12:12:00.000', '2015-07-19 12:12:00.000'),
							(6, 10.0,	'2015-08-19 17:12:00.000', '2015-08-19 17:12:00.000'),
							(6, 5.0,	'2015-09-19 19:12:00.000', '2015-09-19 19:12:00.000'),
							(6, 20.0,	'2015-10-19 18:12:00.000', '2015-10-19 18:12:00.000'),
							(6, 5.0,	'2015-11-19 19:12:00.000', '2015-11-19 19:12:00.000'),
							(6, 20.0,	'2015-12-19 18:12:00.000', '2015-12-19 18:12:00.000')
insert into compras values	(6, 5.0,	'2016-01-19 08:12:00.000', '2016-01-19 08:12:00.000'),
							(6, 20.0,	'2016-01-20 12:12:00.000', '2016-01-20 12:12:00.000'),
							(6, 5.0,	'2016-01-02 10:10:00.000', '2016-01-02 10:10:00.000'),
							(6, 10.0,	'2016-01-01 11:12:00.000', '2016-01-01 11:12:00.000'),
							(6, 5.0,	'2016-01-05 11:12:00.000', '2016-01-05 11:12:00.000'),
							(6, 20.0,	'2016-01-06 08:12:00.000', '2016-01-06 08:12:00.000'),
							(6, 5.0,	'2016-02-19 12:12:00.000', '2016-02-19 12:12:00.000'),
							(6, 10.0,	'2016-02-19 17:12:00.000', '2016-02-19 17:12:00.000'),
							(6, 5.0,	'2016-02-19 19:12:00.000', '2016-02-19 19:12:00.000'),
							(6, 20.0,	'2016-02-19 18:12:00.000', '2016-02-19 18:12:00.000'),
							(6, 5.0,	'2016-02-19 19:12:00.000', '2016-02-19 19:12:00.000'),
							(6, 20.0,	'2016-02-19 18:12:00.000', '2016-02-19 18:12:00.000')
update logins set SALDO = 270 where logins.PESSOA_ID = 6

/*6 - USUARIO*/
insert into compras values	(7, 5.0,	'2014-01-19 08:12:00.000', '2014-01-19 08:12:00.000'),
							(7, 20.0,	'2014-02-20 12:12:00.000', '2014-02-20 12:12:00.000'),
							(7, 5.0,	'2014-03-02 10:10:00.000', '2014-03-02 10:10:00.000'),
							(7, 10.0,	'2014-04-01 11:12:00.000', '2014-04-01 11:12:00.000'),
							(7, 5.0,	'2014-05-05 11:12:00.000', '2014-05-05 11:12:00.000'),
							(7, 20.0,	'2014-06-06 08:12:00.000', '2014-06-06 08:12:00.000'),
							(7, 5.0,	'2014-07-19 12:12:00.000', '2014-07-19 12:12:00.000'),
							(7, 10.0,	'2014-08-19 17:12:00.000', '2014-08-19 17:12:00.000'),
							(7, 5.0,	'2014-09-19 19:12:00.000', '2014-09-19 19:12:00.000'),
							(7, 20.0,	'2014-10-19 18:12:00.000', '2014-10-19 18:12:00.000'),
							(7, 5.0,	'2014-11-19 19:12:00.000', '2014-11-19 19:12:00.000'),
							(7, 20.0,	'2014-12-19 18:12:00.000', '2014-12-19 18:12:00.000')
insert into compras values	(7, 5.0,	'2015-01-19 08:12:00.000', '2015-01-19 08:12:00.000'),
							(7, 20.0,	'2015-02-20 12:12:00.000', '2015-02-20 12:12:00.000'),
							(7, 5.0,	'2015-03-02 10:10:00.000', '2015-03-02 10:10:00.000'),
							(7, 10.0,	'2015-04-01 11:12:00.000', '2015-04-01 11:12:00.000'),
							(7, 5.0,	'2015-05-05 11:12:00.000', '2015-05-05 11:12:00.000'),
							(7, 20.0,	'2015-06-06 08:12:00.000', '2015-06-06 08:12:00.000'),
							(7, 5.0,	'2015-07-19 12:12:00.000', '2015-07-19 12:12:00.000'),
							(7, 10.0,	'2015-08-19 17:12:00.000', '2015-08-19 17:12:00.000'),
							(7, 5.0,	'2015-09-19 19:12:00.000', '2015-09-19 19:12:00.000'),
							(7, 20.0,	'2015-10-19 18:12:00.000', '2015-10-19 18:12:00.000'),
							(7, 5.0,	'2015-11-19 19:12:00.000', '2015-11-19 19:12:00.000'),
							(7, 20.0,	'2015-12-19 18:12:00.000', '2015-12-19 18:12:00.000')
insert into compras values	(7, 5.0,	'2016-01-19 08:12:00.000', '2016-01-19 08:12:00.000'),
							(7, 20.0,	'2016-01-20 12:12:00.000', '2016-01-20 12:12:00.000'),
							(7, 5.0,	'2016-01-02 10:10:00.000', '2016-01-02 10:10:00.000'),
							(7, 10.0,	'2016-01-01 11:12:00.000', '2016-01-01 11:12:00.000'),
							(7, 5.0,	'2016-01-05 11:12:00.000', '2016-01-05 11:12:00.000'),
							(7, 20.0,	'2016-01-06 08:12:00.000', '2016-01-06 08:12:00.000'),
							(7, 5.0,	'2016-02-19 12:12:00.000', '2016-02-19 12:12:00.000'),
							(7, 10.0,	'2016-02-19 17:12:00.000', '2016-02-19 17:12:00.000'),
							(7, 5.0,	'2016-02-19 19:12:00.000', '2016-02-19 19:12:00.000'),
							(7, 20.0,	'2016-02-19 18:12:00.000', '2016-02-19 18:12:00.000'),
							(7, 5.0,	'2016-02-19 19:12:00.000', '2016-02-19 19:12:00.000'),
							(7, 20.0,	'2016-02-19 18:12:00.000', '2016-02-19 18:12:00.000')
update logins set SALDO = 270 where logins.PESSOA_ID = 7

/*7 - USUARIO*/
insert into compras values	(8, 5.0,	'2014-01-19 08:12:00.000', '2014-01-19 08:12:00.000'),
							(8, 20.0,	'2014-02-20 12:12:00.000', '2014-02-20 12:12:00.000'),
							(8, 5.0,	'2014-03-02 10:10:00.000', '2014-03-02 10:10:00.000'),
							(8, 10.0,	'2014-04-01 11:12:00.000', '2014-04-01 11:12:00.000'),
							(8, 5.0,	'2014-05-05 11:12:00.000', '2014-05-05 11:12:00.000'),
							(8, 20.0,	'2014-06-06 08:12:00.000', '2014-06-06 08:12:00.000'),
							(8, 5.0,	'2014-07-19 12:12:00.000', '2014-07-19 12:12:00.000'),
							(8, 10.0,	'2014-08-19 17:12:00.000', '2014-08-19 17:12:00.000'),
							(8, 5.0,	'2014-09-19 19:12:00.000', '2014-09-19 19:12:00.000'),
							(8, 20.0,	'2014-10-19 18:12:00.000', '2014-10-19 18:12:00.000'),
							(8, 5.0,	'2014-11-19 19:12:00.000', '2014-11-19 19:12:00.000'),
							(8, 20.0,	'2014-12-19 18:12:00.000', '2014-12-19 18:12:00.000')
insert into compras values	(8, 5.0,	'2015-01-19 08:12:00.000', '2015-01-19 08:12:00.000'),
							(8, 20.0,	'2015-02-20 12:12:00.000', '2015-02-20 12:12:00.000'),
							(8, 5.0,	'2015-03-02 10:10:00.000', '2015-03-02 10:10:00.000'),
							(8, 10.0,	'2015-04-01 11:12:00.000', '2015-04-01 11:12:00.000'),
							(8, 5.0,	'2015-05-05 11:12:00.000', '2015-05-05 11:12:00.000'),
							(8, 20.0,	'2015-06-06 08:12:00.000', '2015-06-06 08:12:00.000'),
							(8, 5.0,	'2015-07-19 12:12:00.000', '2015-07-19 12:12:00.000'),
							(8, 10.0,	'2015-08-19 17:12:00.000', '2015-08-19 17:12:00.000'),
							(8, 5.0,	'2015-09-19 19:12:00.000', '2015-09-19 19:12:00.000'),
							(8, 20.0,	'2015-10-19 18:12:00.000', '2015-10-19 18:12:00.000'),
							(8, 5.0,	'2015-11-19 19:12:00.000', '2015-11-19 19:12:00.000'),
							(8, 20.0,	'2015-12-19 18:12:00.000', '2015-12-19 18:12:00.000')
insert into compras values	(8, 5.0,	'2016-01-19 08:12:00.000', '2016-01-19 08:12:00.000'),
							(8, 20.0,	'2016-01-20 12:12:00.000', '2016-01-20 12:12:00.000'),
							(8, 5.0,	'2016-01-02 10:10:00.000', '2016-01-02 10:10:00.000'),
							(8, 10.0,	'2016-01-01 11:12:00.000', '2016-01-01 11:12:00.000'),
							(8, 5.0,	'2016-01-05 11:12:00.000', '2016-01-05 11:12:00.000'),
							(8, 20.0,	'2016-01-06 08:12:00.000', '2016-01-06 08:12:00.000'),
							(8, 5.0,	'2016-02-19 12:12:00.000', '2016-02-19 12:12:00.000'),
							(8, 10.0,	'2016-02-19 17:12:00.000', '2016-02-19 17:12:00.000'),
							(8, 5.0,	'2016-02-19 19:12:00.000', '2016-02-19 19:12:00.000'),
							(8, 20.0,	'2016-02-19 18:12:00.000', '2016-02-19 18:12:00.000'),
							(8, 5.0,	'2016-02-19 19:12:00.000', '2016-02-19 19:12:00.000'),
							(8, 20.0,	'2016-02-19 18:12:00.000', '2016-02-19 18:12:00.000')
update logins set SALDO = 270 where logins.PESSOA_ID = 8

/*8 - USUARIO*/
insert into compras values	(9, 5.0,	'2014-01-19 08:12:00.000', '2014-01-19 08:12:00.000'),
							(9, 20.0,	'2014-02-20 12:12:00.000', '2014-02-20 12:12:00.000'),
							(9, 5.0,	'2014-03-02 10:10:00.000', '2014-03-02 10:10:00.000'),
							(9, 10.0,	'2014-04-01 11:12:00.000', '2014-04-01 11:12:00.000'),
							(9, 5.0,	'2014-05-05 11:12:00.000', '2014-05-05 11:12:00.000'),
							(9, 20.0,	'2014-06-06 08:12:00.000', '2014-06-06 08:12:00.000'),
							(9, 5.0,	'2014-07-19 12:12:00.000', '2014-07-19 12:12:00.000'),
							(9, 10.0,	'2014-08-19 17:12:00.000', '2014-08-19 17:12:00.000'),
							(9, 5.0,	'2014-09-19 19:12:00.000', '2014-09-19 19:12:00.000'),
							(9, 20.0,	'2014-10-19 18:12:00.000', '2014-10-19 18:12:00.000'),
							(9, 5.0,	'2014-11-19 19:12:00.000', '2014-11-19 19:12:00.000'),
							(9, 20.0,	'2014-12-19 18:12:00.000', '2014-12-19 18:12:00.000')
insert into compras values	(9, 5.0,	'2015-01-19 08:12:00.000', '2015-01-19 08:12:00.000'),
							(9, 20.0,	'2015-02-20 12:12:00.000', '2015-02-20 12:12:00.000'),
							(9, 5.0,	'2015-03-02 10:10:00.000', '2015-03-02 10:10:00.000'),
							(9, 10.0,	'2015-04-01 11:12:00.000', '2015-04-01 11:12:00.000'),
							(9, 5.0,	'2015-05-05 11:12:00.000', '2015-05-05 11:12:00.000'),
							(9, 20.0,	'2015-06-06 08:12:00.000', '2015-06-06 08:12:00.000'),
							(9, 5.0,	'2015-07-19 12:12:00.000', '2015-07-19 12:12:00.000'),
							(9, 10.0,	'2015-08-19 17:12:00.000', '2015-08-19 17:12:00.000'),
							(9, 5.0,	'2015-09-19 19:12:00.000', '2015-09-19 19:12:00.000'),
							(9, 20.0,	'2015-10-19 18:12:00.000', '2015-10-19 18:12:00.000'),
							(9, 5.0,	'2015-11-19 19:12:00.000', '2015-11-19 19:12:00.000'),
							(9, 20.0,	'2015-12-19 18:12:00.000', '2015-12-19 18:12:00.000')
insert into compras values	(9, 5.0,	'2016-01-19 08:12:00.000', '2016-01-19 08:12:00.000'),
							(9, 20.0,	'2016-01-20 12:12:00.000', '2016-01-20 12:12:00.000'),
							(9, 5.0,	'2016-01-02 10:10:00.000', '2016-01-02 10:10:00.000'),
							(9, 10.0,	'2016-01-01 11:12:00.000', '2016-01-01 11:12:00.000'),
							(9, 5.0,	'2016-01-05 11:12:00.000', '2016-01-05 11:12:00.000'),
							(9, 20.0,	'2016-01-06 08:12:00.000', '2016-01-06 08:12:00.000'),
							(9, 5.0,	'2016-02-19 12:12:00.000', '2016-02-19 12:12:00.000'),
							(9, 10.0,	'2016-02-19 17:12:00.000', '2016-02-19 17:12:00.000'),
							(9, 5.0,	'2016-02-19 19:12:00.000', '2016-02-19 19:12:00.000'),
							(9, 20.0,	'2016-02-19 18:12:00.000', '2016-02-19 18:12:00.000'),
							(9, 5.0,	'2016-02-19 19:12:00.000', '2016-02-19 19:12:00.000'),
							(9, 20.0,	'2016-02-19 18:12:00.000', '2016-02-19 18:12:00.000')
update logins set SALDO = 270 where logins.PESSOA_ID = 9

/*9 - USUARIO*/
insert into compras values	(10, 5.0,	'2014-01-19 08:12:00.000', '2014-01-19 08:12:00.000'),
							(10, 20.0,	'2014-02-20 12:12:00.000', '2014-02-20 12:12:00.000'),
							(10, 5.0,	'2014-03-02 10:10:00.000', '2014-03-02 10:10:00.000'),
							(10, 10.0,	'2014-04-01 11:12:00.000', '2014-04-01 11:12:00.000'),
							(10, 5.0,	'2014-05-05 11:12:00.000', '2014-05-05 11:12:00.000'),
							(10, 20.0,	'2014-06-06 08:12:00.000', '2014-06-06 08:12:00.000'),
							(10, 5.0,	'2014-07-19 12:12:00.000', '2014-07-19 12:12:00.000'),
							(10, 10.0,	'2014-08-19 17:12:00.000', '2014-08-19 17:12:00.000'),
							(10, 5.0,	'2014-09-19 19:12:00.000', '2014-09-19 19:12:00.000'),
							(10, 20.0,	'2014-10-19 18:12:00.000', '2014-10-19 18:12:00.000'),
							(10, 5.0,	'2014-11-19 19:12:00.000', '2014-11-19 19:12:00.000'),
							(10, 20.0,	'2014-12-19 18:12:00.000', '2014-12-19 18:12:00.000')
insert into compras values	(10, 5.0,	'2015-01-19 08:12:00.000', '2015-01-19 08:12:00.000'),
							(10, 20.0,	'2015-02-20 12:12:00.000', '2015-02-20 12:12:00.000'),
							(10, 5.0,	'2015-03-02 10:10:00.000', '2015-03-02 10:10:00.000'),
							(10, 10.0,	'2015-04-01 11:12:00.000', '2015-04-01 11:12:00.000'),
							(10, 5.0,	'2015-05-05 11:12:00.000', '2015-05-05 11:12:00.000'),
							(10, 20.0,	'2015-06-06 08:12:00.000', '2015-06-06 08:12:00.000'),
							(10, 5.0,	'2015-07-19 12:12:00.000', '2015-07-19 12:12:00.000'),
							(10, 10.0,	'2015-08-19 17:12:00.000', '2015-08-19 17:12:00.000'),
							(10, 5.0,	'2015-09-19 19:12:00.000', '2015-09-19 19:12:00.000'),
							(10, 20.0,	'2015-10-19 18:12:00.000', '2015-10-19 18:12:00.000'),
							(10, 5.0,	'2015-11-19 19:12:00.000', '2015-11-19 19:12:00.000'),
							(10, 20.0,	'2015-12-19 18:12:00.000', '2015-12-19 18:12:00.000')
insert into compras values	(10, 5.0,	'2016-01-19 08:12:00.000', '2016-01-19 08:12:00.000'),
							(10, 20.0,	'2016-01-20 12:12:00.000', '2016-01-20 12:12:00.000'),
							(10, 5.0,	'2016-01-02 10:10:00.000', '2016-01-02 10:10:00.000'),
							(10, 10.0,	'2016-01-01 11:12:00.000', '2016-01-01 11:12:00.000'),
							(10, 5.0,	'2016-01-05 11:12:00.000', '2016-01-05 11:12:00.000'),
							(10, 20.0,	'2016-01-06 08:12:00.000', '2016-01-06 08:12:00.000'),
							(10, 5.0,	'2016-02-19 12:12:00.000', '2016-02-19 12:12:00.000'),
							(10, 10.0,	'2016-02-19 17:12:00.000', '2016-02-19 17:12:00.000'),
							(10, 5.0,	'2016-02-19 19:12:00.000', '2016-02-19 19:12:00.000'),
							(10, 20.0,	'2016-02-19 18:12:00.000', '2016-02-19 18:12:00.000'),
							(10, 5.0,	'2016-02-19 19:12:00.000', '2016-02-19 19:12:00.000'),
							(10, 20.0,	'2016-02-19 18:12:00.000', '2016-02-19 18:12:00.000')
update logins set SALDO = 270 where logins.PESSOA_ID = 10

/*10 - USUARIO*/
insert into compras values	(11, 5.0,	'2014-01-19 08:12:00.000', '2014-01-19 08:12:00.000'),
							(11, 20.0,	'2014-02-20 12:12:00.000', '2014-02-20 12:12:00.000'),
							(11, 5.0,	'2014-03-02 10:10:00.000', '2014-03-02 10:10:00.000'),
							(11, 10.0,	'2014-04-01 11:12:00.000', '2014-04-01 11:12:00.000'),
							(11, 5.0,	'2014-05-05 11:12:00.000', '2014-05-05 11:12:00.000'),
							(11, 20.0,	'2014-06-06 08:12:00.000', '2014-06-06 08:12:00.000'),
							(11, 5.0,	'2014-07-19 12:12:00.000', '2014-07-19 12:12:00.000'),
							(11, 10.0,	'2014-08-19 17:12:00.000', '2014-08-19 17:12:00.000'),
							(11, 5.0,	'2014-09-19 19:12:00.000', '2014-09-19 19:12:00.000'),
							(11, 20.0,	'2014-10-19 18:12:00.000', '2014-10-19 18:12:00.000'),
							(11, 5.0,	'2014-11-19 19:12:00.000', '2014-11-19 19:12:00.000'),
							(11, 20.0,	'2014-12-19 18:12:00.000', '2014-12-19 18:12:00.000')
insert into compras values	(11, 5.0,	'2015-01-19 08:12:00.000', '2015-01-19 08:12:00.000'),
							(11, 20.0,	'2015-02-20 12:12:00.000', '2015-02-20 12:12:00.000'),
							(11, 5.0,	'2015-03-02 10:10:00.000', '2015-03-02 10:10:00.000'),
							(11, 10.0,	'2015-04-01 11:12:00.000', '2015-04-01 11:12:00.000'),
							(11, 5.0,	'2015-05-05 11:12:00.000', '2015-05-05 11:12:00.000'),
							(11, 20.0,	'2015-06-06 08:12:00.000', '2015-06-06 08:12:00.000'),
							(11, 5.0,	'2015-07-19 12:12:00.000', '2015-07-19 12:12:00.000'),
							(11, 10.0,	'2015-08-19 17:12:00.000', '2015-08-19 17:12:00.000'),
							(11, 5.0,	'2015-09-19 19:12:00.000', '2015-09-19 19:12:00.000'),
							(11, 20.0,	'2015-10-19 18:12:00.000', '2015-10-19 18:12:00.000'),
							(11, 5.0,	'2015-11-19 19:12:00.000', '2015-11-19 19:12:00.000'),
							(11, 20.0,	'2015-12-19 18:12:00.000', '2015-12-19 18:12:00.000')
insert into compras values	(11, 5.0,	'2016-01-19 08:12:00.000', '2016-01-19 08:12:00.000'),
							(11, 20.0,	'2016-01-20 12:12:00.000', '2016-01-20 12:12:00.000'),
							(11, 5.0,	'2016-01-02 10:10:00.000', '2016-01-02 10:10:00.000'),
							(11, 10.0,	'2016-01-01 11:12:00.000', '2016-01-01 11:12:00.000'),
							(11, 5.0,	'2016-01-05 11:12:00.000', '2016-01-05 11:12:00.000'),
							(11, 20.0,	'2016-01-06 08:12:00.000', '2016-01-06 08:12:00.000'),
							(11, 5.0,	'2016-02-19 12:12:00.000', '2016-02-19 12:12:00.000'),
							(11, 10.0,	'2016-02-19 17:12:00.000', '2016-02-19 17:12:00.000'),
							(11, 5.0,	'2016-02-19 19:12:00.000', '2016-02-19 19:12:00.000'),
							(11, 20.0,	'2016-02-19 18:12:00.000', '2016-02-19 18:12:00.000'),
							(11, 5.0,	'2016-02-19 19:12:00.000', '2016-02-19 19:12:00.000'),
							(11, 20.0,	'2016-02-19 18:12:00.000', '2016-02-19 18:12:00.000')
update logins set SALDO = 270 where logins.PESSOA_ID = 11


/*	ADD PARADAS AOS USUARIOS - 20 PARADAS POR CADA ANO*/
/*1 - USUARIO*/
select * from paradas
insert into paradas values	(1, GETDATE()-150, 2),
							(1, '2014-02-02 09:02:00.000', 3),
							(1, '2014-03-03 10:03:00.000', 1),
							(1, '2014-04-03 11:04:00.000', 2),
							(1, '2014-05-04 12:05:00.000', 2),
							(1, '2014-06-05 13:06:00.000', 3),
							(1, '2014-07-06 14:07:00.000', 3),
							(1, '2014-08-07 15:08:00.000', 1),
							(1, '2014-09-08 16:09:00.000', 2),
							(1, '2014-10-09 08:10:12.122', 2),
							(1, '2014-11-10 09:11:12.122', 3),
							(1, '2014-12-11 10:12:12.122', 3),
							(1, '2014-01-01 08:13:00.000', 2),
							(1, '2014-02-02 09:14:00.000', 3),
							(1, '2014-03-03 10:15:00.000', 1),
							(1, '2014-04-03 11:16:00.000', 2),
							(1, '2014-05-04 12:17:00.000', 2),
							(1, '2014-06-05 13:18:00.000', 3),
							(1, '2014-07-06 14:19:00.000', 3),
							(1, '2014-08-07 15:20:00.000', 1),
							(1, '2014-09-08 16:21:00.000', 2),
							(1, '2014-10-09 06:22:12.122', 2),
							(1, '2014-11-10 06:23:12.122', 3),
							(1, '2014-12-10 05:24:12.122', 3)
insert into paradas values	(1, '2015-01-01 08:01:00.000', 2),
							(1, '2015-02-02 09:02:00.000', 3),
							(1, '2015-03-03 10:03:00.000', 1),
							(1, '2015-04-03 11:04:00.000', 2),
							(1, '2015-05-04 12:05:00.000', 2),
							(1, '2015-06-05 13:06:00.000', 3),
							(1, '2015-07-06 14:07:00.000', 3),
							(1, '2015-08-07 15:08:00.000', 1),
							(1, '2015-09-08 16:09:00.000', 2),
							(1, '2015-10-09 08:10:12.122', 2),
							(1, '2015-11-10 09:11:12.122', 3),
							(1, '2015-12-11 10:12:12.122', 3),
							(1, '2015-01-01 08:13:00.000', 2),
							(1, '2015-02-02 09:14:00.000', 3),
							(1, '2015-03-03 10:15:00.000', 1),
							(1, '2015-04-03 11:16:00.000', 2),
							(1, '2015-05-04 12:17:00.000', 2),
							(1, '2015-06-05 13:18:00.000', 3),
							(1, '2015-07-06 14:19:00.000', 3),
							(1, '2015-08-07 15:20:00.000', 1),
							(1, '2015-09-08 16:21:00.000', 2),
							(1, '2015-10-09 06:22:12.122', 2),
							(1, '2015-11-10 06:23:12.122', 3),
							(1, '2015-12-10 05:24:12.122', 3)
insert into paradas values	(1, '2016-01-01 08:01:00.000', 2),
							(1, '2016-01-02 09:02:00.000', 3),
							(1, '2016-01-03 10:03:00.000', 1),
							(1, '2016-01-03 11:04:00.000', 2),
							(1, '2016-01-04 12:05:00.000', 2),
							(1, '2016-01-05 13:06:00.000', 3),
							(1, '2016-01-06 14:07:00.000', 3),
							(1, '2016-01-07 15:08:00.000', 1),
							(1, '2016-01-08 16:09:00.000', 2),
							(1, '2016-01-09 08:10:12.122', 2),
							(1, '2016-01-10 09:11:12.122', 3),
							(1, '2016-01-11 10:12:12.122', 3),
							(1, '2016-02-01 08:13:00.000', 2),
							(1, '2016-02-02 09:14:00.000', 3),
							(1, '2016-02-03 10:15:00.000', 1),
							(1, '2016-02-03 11:16:00.000', 2),
							(1, '2016-02-04 12:17:00.000', 2),
							(1, '2016-02-05 13:18:00.000', 3),
							(1, '2016-02-06 14:19:00.000', 3),
							(1, '2016-02-07 15:20:00.000', 1),
							(1, '2016-02-08 16:21:00.000', 2),
							(1, '2016-02-09 06:22:12.122', 2),
							(1, '2016-02-10 06:23:12.122', 3),
							(1, '2016-02-10 05:24:12.122', 3)

/*2 - USUARIO*/
insert into paradas values	(2, '2014-01-01 08:01:00.000', 2),
							(2, '2014-02-02 09:02:00.000', 3),
							(2, '2014-03-03 10:03:00.000', 1),
							(2, '2014-04-03 11:04:00.000', 2),
							(2, '2014-05-04 12:05:00.000', 2),
							(2, '2014-06-05 13:06:00.000', 3),
							(2, '2014-07-06 14:07:00.000', 3),
							(2, '2014-08-07 15:08:00.000', 1),
							(2, '2014-09-08 16:09:00.000', 2),
							(2, '2014-10-09 08:10:12.122', 2),
							(2, '2014-11-10 09:11:12.122', 3),
							(2, '2014-12-11 10:12:12.122', 3),
							(2, '2014-01-01 08:13:00.000', 2),
							(2, '2014-02-02 09:14:00.000', 3),
							(2, '2014-03-03 10:15:00.000', 1),
							(2, '2014-04-03 11:16:00.000', 2),
							(2, '2014-05-04 12:17:00.000', 2),
							(2, '2014-06-05 13:18:00.000', 3),
							(2, '2014-07-06 14:19:00.000', 3),
							(2, '2014-08-07 15:20:00.000', 1),
							(2, '2014-09-08 16:21:00.000', 2),
							(2, '2014-10-09 06:22:12.122', 2),
							(2, '2014-11-10 06:23:12.122', 3),
							(2, '2014-12-10 05:24:12.122', 3)
insert into paradas values	(2, '2015-01-01 08:01:00.000', 2),
							(2, '2015-02-02 09:02:00.000', 3),
							(2, '2015-03-03 10:03:00.000', 1),
							(2, '2015-04-03 11:04:00.000', 2),
							(2, '2015-05-04 12:05:00.000', 2),
							(2, '2015-06-05 13:06:00.000', 3),
							(2, '2015-07-06 14:07:00.000', 3),
							(2, '2015-08-07 15:08:00.000', 1),
							(2, '2015-09-08 16:09:00.000', 2),
							(2, '2015-10-09 08:10:12.122', 2),
							(2, '2015-11-10 09:11:12.122', 3),
							(2, '2015-12-11 10:12:12.122', 3),
							(2, '2015-01-01 08:13:00.000', 2),
							(2, '2015-02-02 09:14:00.000', 3),
							(2, '2015-03-03 10:15:00.000', 1),
							(2, '2015-04-03 11:16:00.000', 2),
							(2, '2015-05-04 12:17:00.000', 2),
							(2, '2015-06-05 13:18:00.000', 3),
							(2, '2015-07-06 14:19:00.000', 3),
							(2, '2015-08-07 15:20:00.000', 1),
							(2, '2015-09-08 16:21:00.000', 2),
							(2, '2015-10-09 06:22:12.122', 2),
							(2, '2015-11-10 06:23:12.122', 3),
							(2, '2015-12-10 05:24:12.122', 3)
insert into paradas values	(2, '2016-01-01 08:01:00.000', 2),
							(2, '2016-01-02 09:02:00.000', 3),
							(2, '2016-01-03 10:03:00.000', 1),
							(2, '2016-01-03 11:04:00.000', 2),
							(2, '2016-01-04 12:05:00.000', 2),
							(2, '2016-01-05 13:06:00.000', 3),
							(2, '2016-01-06 14:07:00.000', 3),
							(2, '2016-01-07 15:08:00.000', 1),
							(2, '2016-01-08 16:09:00.000', 2),
							(2, '2016-01-09 08:10:12.122', 2),
							(2, '2016-01-10 09:11:12.122', 3),
							(2, '2016-01-11 10:12:12.122', 3),
							(2, '2016-02-01 08:13:00.000', 2),
							(2, '2016-02-02 09:14:00.000', 3),
							(2, '2016-02-03 10:15:00.000', 1),
							(2, '2016-02-03 11:16:00.000', 2),
							(2, '2016-02-04 12:17:00.000', 2),
							(2, '2016-02-05 13:18:00.000', 3),
							(2, '2016-02-06 14:19:00.000', 3),
							(2, '2016-02-07 15:20:00.000', 1),
							(2, '2016-02-08 16:21:00.000', 2),
							(2, '2016-02-09 06:22:12.122', 2),
							(2, '2016-02-10 06:23:12.122', 3),
							(2, '2016-02-10 05:24:12.122', 3)

/*3 - USUARIO*/
insert into paradas values	(3, '2014-01-01 08:01:00.000', 2),
							(3, '2014-02-02 09:02:00.000', 3),
							(3, '2014-03-03 10:03:00.000', 1),
							(3, '2014-04-03 11:04:00.000', 2),
							(3, '2014-05-04 12:05:00.000', 2),
							(3, '2014-06-05 13:06:00.000', 3),
							(3, '2014-07-06 14:07:00.000', 3),
							(3, '2014-08-07 15:08:00.000', 1),
							(3, '2014-09-08 16:09:00.000', 2),
							(3, '2014-10-09 08:10:12.122', 2),
							(3, '2014-11-10 09:11:12.122', 3),
							(3, '2014-12-11 10:12:12.122', 3),
							(3, '2014-01-01 08:13:00.000', 2),
							(3, '2014-02-02 09:14:00.000', 3),
							(3, '2014-03-03 10:15:00.000', 1),
							(3, '2014-04-03 11:16:00.000', 2),
							(3, '2014-05-04 12:17:00.000', 2),
							(3, '2014-06-05 13:18:00.000', 3),
							(3, '2014-07-06 14:19:00.000', 3),
							(3, '2014-08-07 15:20:00.000', 1),
							(3, '2014-09-08 16:21:00.000', 2),
							(3, '2014-10-09 06:22:12.122', 2),
							(3, '2014-11-10 06:23:12.122', 3),
							(3, '2014-12-10 05:24:12.122', 3)
insert into paradas values	(3, '2015-01-01 08:01:00.000', 2),
							(3, '2015-02-02 09:02:00.000', 3),
							(3, '2015-03-03 10:03:00.000', 1),
							(3, '2015-04-03 11:04:00.000', 2),
							(3, '2015-05-04 12:05:00.000', 2),
							(3, '2015-06-05 13:06:00.000', 3),
							(3, '2015-07-06 14:07:00.000', 3),
							(3, '2015-08-07 15:08:00.000', 1),
							(3, '2015-09-08 16:09:00.000', 2),
							(3, '2015-10-09 08:10:12.122', 2),
							(3, '2015-11-10 09:11:12.122', 3),
							(3, '2015-12-11 10:12:12.122', 3),
							(3, '2015-01-01 08:13:00.000', 2),
							(3, '2015-02-02 09:14:00.000', 3),
							(3, '2015-03-03 10:15:00.000', 1),
							(3, '2015-04-03 11:16:00.000', 2),
							(3, '2015-05-04 12:17:00.000', 2),
							(3, '2015-06-05 13:18:00.000', 3),
							(3, '2015-07-06 14:19:00.000', 3),
							(3, '2015-08-07 15:20:00.000', 1),
							(3, '2015-09-08 16:21:00.000', 2),
							(3, '2015-10-09 06:22:12.122', 2),
							(3, '2015-11-10 06:23:12.122', 3),
							(3, '2015-12-10 05:24:12.122', 3)
insert into paradas values	(3, '2016-01-01 08:01:00.000', 2),
							(3, '2016-01-02 09:02:00.000', 3),
							(3, '2016-01-03 10:03:00.000', 1),
							(3, '2016-01-03 11:04:00.000', 2),
							(3, '2016-01-04 12:05:00.000', 2),
							(3, '2016-01-05 13:06:00.000', 3),
							(3, '2016-01-06 14:07:00.000', 3),
							(3, '2016-01-07 15:08:00.000', 1),
							(3, '2016-01-08 16:09:00.000', 2),
							(3, '2016-01-09 08:10:12.122', 2),
							(3, '2016-01-10 09:11:12.122', 3),
							(3, '2016-01-11 10:12:12.122', 3),
							(3, '2016-02-01 08:13:00.000', 2),
							(3, '2016-02-02 09:14:00.000', 3),
							(3, '2016-02-03 10:15:00.000', 1),
							(3, '2016-02-03 11:16:00.000', 2),
							(3, '2016-02-04 12:17:00.000', 2),
							(3, '2016-02-05 13:18:00.000', 3),
							(3, '2016-02-06 14:19:00.000', 3),
							(3, '2016-02-07 15:20:00.000', 1),
							(3, '2016-02-08 16:21:00.000', 2),
							(3, '2016-02-09 06:22:12.122', 2),
							(3, '2016-02-10 06:23:12.122', 3),
							(3, '2016-02-10 05:24:12.122', 3)

/*4 - USUARIO*/
insert into paradas values	(4, '2014-01-01 08:01:00.000', 2),
							(4, '2014-02-02 09:02:00.000', 3),
							(4, '2014-03-03 10:03:00.000', 1),
							(4, '2014-04-03 11:04:00.000', 2),
							(4, '2014-05-04 12:05:00.000', 2),
							(4, '2014-06-05 13:06:00.000', 3),
							(4, '2014-07-06 14:07:00.000', 3),
							(4, '2014-08-07 15:08:00.000', 1),
							(4, '2014-09-08 16:09:00.000', 2),
							(4, '2014-10-09 08:10:12.122', 2),
							(4, '2014-11-10 09:11:12.122', 3),
							(4, '2014-12-11 10:12:12.122', 3),
							(4, '2014-01-01 08:13:00.000', 2),
							(4, '2014-02-02 09:14:00.000', 3),
							(4, '2014-03-03 10:15:00.000', 1),
							(4, '2014-04-03 11:16:00.000', 2),
							(4, '2014-05-04 12:17:00.000', 2),
							(4, '2014-06-05 13:18:00.000', 3),
							(4, '2014-07-06 14:19:00.000', 3),
							(4, '2014-08-07 15:20:00.000', 1),
							(4, '2014-09-08 16:21:00.000', 2),
							(4, '2014-10-09 06:22:12.122', 2),
							(4, '2014-11-10 06:23:12.122', 3),
							(4, '2014-12-10 05:24:12.122', 3)
insert into paradas values	(4, '2015-01-01 08:01:00.000', 2),
							(4, '2015-02-02 09:02:00.000', 3),
							(4, '2015-03-03 10:03:00.000', 1),
							(4, '2015-04-03 11:04:00.000', 2),
							(4, '2015-05-04 12:05:00.000', 2),
							(4, '2015-06-05 13:06:00.000', 3),
							(4, '2015-07-06 14:07:00.000', 3),
							(4, '2015-08-07 15:08:00.000', 1),
							(4, '2015-09-08 16:09:00.000', 2),
							(4, '2015-10-09 08:10:12.122', 2),
							(4, '2015-11-10 09:11:12.122', 3),
							(4, '2015-12-11 10:12:12.122', 3),
							(4, '2015-01-01 08:13:00.000', 2),
							(4, '2015-02-02 09:14:00.000', 3),
							(4, '2015-03-03 10:15:00.000', 1),
							(4, '2015-04-03 11:16:00.000', 2),
							(4, '2015-05-04 12:17:00.000', 2),
							(4, '2015-06-05 13:18:00.000', 3),
							(4, '2015-07-06 14:19:00.000', 3),
							(4, '2015-08-07 15:20:00.000', 1),
							(4, '2015-09-08 16:21:00.000', 2),
							(4, '2015-10-09 06:22:12.122', 2),
							(4, '2015-11-10 06:23:12.122', 3),
							(4, '2015-12-10 05:24:12.122', 3)
insert into paradas values	(4, '2016-01-01 08:01:00.000', 2),
							(4, '2016-01-02 09:02:00.000', 3),
							(4, '2016-01-03 10:03:00.000', 1),
							(4, '2016-01-03 11:04:00.000', 2),
							(4, '2016-01-04 12:05:00.000', 2),
							(4, '2016-01-05 13:06:00.000', 3),
							(4, '2016-01-06 14:07:00.000', 3),
							(4, '2016-01-07 15:08:00.000', 1),
							(4, '2016-01-08 16:09:00.000', 2),
							(4, '2016-01-09 08:10:12.122', 2),
							(4, '2016-01-10 09:11:12.122', 3),
							(4, '2016-01-11 10:12:12.122', 3),
							(4, '2016-02-01 08:13:00.000', 2),
							(4, '2016-02-02 09:14:00.000', 3),
							(4, '2016-02-03 10:15:00.000', 1),
							(4, '2016-02-03 11:16:00.000', 2),
							(4, '2016-02-04 12:17:00.000', 2),
							(4, '2016-02-05 13:18:00.000', 3),
							(4, '2016-02-06 14:19:00.000', 3),
							(4, '2016-02-07 15:20:00.000', 1),
							(4, '2016-02-08 16:21:00.000', 2),
							(4, '2016-02-09 06:22:12.122', 2),
							(4, '2016-02-10 06:23:12.122', 3),
							(4, '2016-02-10 05:24:12.122', 3)

/*5 - USUARIO*/
insert into paradas values	(5, '2014-01-01 08:01:00.000', 2),
							(5, '2014-02-02 09:02:00.000', 3),
							(5, '2014-03-03 10:03:00.000', 1),
							(5, '2014-04-03 11:04:00.000', 2),
							(5, '2014-05-04 12:05:00.000', 2),
							(5, '2014-06-05 13:06:00.000', 3),
							(5, '2014-07-06 14:07:00.000', 3),
							(5, '2014-08-07 15:08:00.000', 1),
							(5, '2014-09-08 16:09:00.000', 2),
							(5, '2014-10-09 08:10:12.122', 2),
							(5, '2014-11-10 09:11:12.122', 3),
							(5, '2014-12-11 10:12:12.122', 3),
							(5, '2014-01-01 08:13:00.000', 2),
							(5, '2014-02-02 09:14:00.000', 3),
							(5, '2014-03-03 10:15:00.000', 1),
							(5, '2014-04-03 11:16:00.000', 2),
							(5, '2014-05-04 12:17:00.000', 2),
							(5, '2014-06-05 13:18:00.000', 3),
							(5, '2014-07-06 14:19:00.000', 3),
							(5, '2014-08-07 15:20:00.000', 1),
							(5, '2014-09-08 16:21:00.000', 2),
							(5, '2014-10-09 06:22:12.122', 2),
							(5, '2014-11-10 06:23:12.122', 3),
							(5, '2014-12-10 05:24:12.122', 3)
insert into paradas values	(5, '2015-01-01 08:01:00.000', 2),
							(5, '2015-02-02 09:02:00.000', 3),
							(5, '2015-03-03 10:03:00.000', 1),
							(5, '2015-04-03 11:04:00.000', 2),
							(5, '2015-05-04 12:05:00.000', 2),
							(5, '2015-06-05 13:06:00.000', 3),
							(5, '2015-07-06 14:07:00.000', 3),
							(5, '2015-08-07 15:08:00.000', 1),
							(5, '2015-09-08 16:09:00.000', 2),
							(5, '2015-10-09 08:10:12.122', 2),
							(5, '2015-11-10 09:11:12.122', 3),
							(5, '2015-12-11 10:12:12.122', 3),
							(5, '2015-01-01 08:13:00.000', 2),
							(5, '2015-02-02 09:14:00.000', 3),
							(5, '2015-03-03 10:15:00.000', 1),
							(5, '2015-04-03 11:16:00.000', 2),
							(5, '2015-05-04 12:17:00.000', 2),
							(5, '2015-06-05 13:18:00.000', 3),
							(5, '2015-07-06 14:19:00.000', 3),
							(5, '2015-08-07 15:20:00.000', 1),
							(5, '2015-09-08 16:21:00.000', 2),
							(5, '2015-10-09 06:22:12.122', 2),
							(5, '2015-11-10 06:23:12.122', 3),
							(5, '2015-12-10 05:24:12.122', 3)
insert into paradas values	(5, '2016-01-01 08:01:00.000', 2),
							(5, '2016-01-02 09:02:00.000', 3),
							(5, '2016-01-03 10:03:00.000', 1),
							(5, '2016-01-03 11:04:00.000', 2),
							(5, '2016-01-04 12:05:00.000', 2),
							(5, '2016-01-05 13:06:00.000', 3),
							(5, '2016-01-06 14:07:00.000', 3),
							(5, '2016-01-07 15:08:00.000', 1),
							(5, '2016-01-08 16:09:00.000', 2),
							(5, '2016-01-09 08:10:12.122', 2),
							(5, '2016-01-10 09:11:12.122', 3),
							(5, '2016-01-11 10:12:12.122', 3),
							(5, '2016-02-01 08:13:00.000', 2),
							(5, '2016-02-02 09:14:00.000', 3),
							(5, '2016-02-03 10:15:00.000', 1),
							(5, '2016-02-03 11:16:00.000', 2),
							(5, '2016-02-04 12:17:00.000', 2),
							(5, '2016-02-05 13:18:00.000', 3),
							(5, '2016-02-06 14:19:00.000', 3),
							(5, '2016-02-07 15:20:00.000', 1),
							(5, '2016-02-08 16:21:00.000', 2),
							(5, '2016-02-09 06:22:12.122', 2),
							(5, '2016-02-10 06:23:12.122', 3),
							(5, '2016-02-10 05:24:12.122', 3)

/*6 - USUARIO*/
insert into paradas values	(6, '2014-01-01 08:01:00.000', 2),
							(6, '2014-02-02 09:02:00.000', 3),
							(6, '2014-03-03 10:03:00.000', 1),
							(6, '2014-04-03 11:04:00.000', 2),
							(6, '2014-05-04 12:05:00.000', 2),
							(6, '2014-06-05 13:06:00.000', 3),
							(6, '2014-07-06 14:07:00.000', 3),
							(6, '2014-08-07 15:08:00.000', 1),
							(6, '2014-09-08 16:09:00.000', 2),
							(6, '2014-10-09 08:10:12.122', 2),
							(6, '2014-11-10 09:11:12.122', 3),
							(6, '2014-12-11 10:12:12.122', 3),
							(6, '2014-01-01 08:13:00.000', 2),
							(6, '2014-02-02 09:14:00.000', 3),
							(6, '2014-03-03 10:15:00.000', 1),
							(6, '2014-04-03 11:16:00.000', 2),
							(6, '2014-05-04 12:17:00.000', 2),
							(6, '2014-06-05 13:18:00.000', 3),
							(6, '2014-07-06 14:19:00.000', 3),
							(6, '2014-08-07 15:20:00.000', 1),
							(6, '2014-09-08 16:21:00.000', 2),
							(6, '2014-10-09 06:22:12.122', 2),
							(6, '2014-11-10 06:23:12.122', 3),
							(6, '2014-12-10 05:24:12.122', 3)
insert into paradas values	(6, '2015-01-01 08:01:00.000', 2),
							(6, '2015-02-02 09:02:00.000', 3),
							(6, '2015-03-03 10:03:00.000', 1),
							(6, '2015-04-03 11:04:00.000', 2),
							(6, '2015-05-04 12:05:00.000', 2),
							(6, '2015-06-05 13:06:00.000', 3),
							(6, '2015-07-06 14:07:00.000', 3),
							(6, '2015-08-07 15:08:00.000', 1),
							(6, '2015-09-08 16:09:00.000', 2),
							(6, '2015-10-09 08:10:12.122', 2),
							(6, '2015-11-10 09:11:12.122', 3),
							(6, '2015-12-11 10:12:12.122', 3),
							(6, '2015-01-01 08:13:00.000', 2),
							(6, '2015-02-02 09:14:00.000', 3),
							(6, '2015-03-03 10:15:00.000', 1),
							(6, '2015-04-03 11:16:00.000', 2),
							(6, '2015-05-04 12:17:00.000', 2),
							(6, '2015-06-05 13:18:00.000', 3),
							(6, '2015-07-06 14:19:00.000', 3),
							(6, '2015-08-07 15:20:00.000', 1),
							(6, '2015-09-08 16:21:00.000', 2),
							(6, '2015-10-09 06:22:12.122', 2),
							(6, '2015-11-10 06:23:12.122', 3),
							(6, '2015-12-10 05:24:12.122', 3)
insert into paradas values	(6, '2016-01-01 08:01:00.000', 2),
							(6, '2016-01-02 09:02:00.000', 3),
							(6, '2016-01-03 10:03:00.000', 1),
							(6, '2016-01-03 11:04:00.000', 2),
							(6, '2016-01-04 12:05:00.000', 2),
							(6, '2016-01-05 13:06:00.000', 3),
							(6, '2016-01-06 14:07:00.000', 3),
							(6, '2016-01-07 15:08:00.000', 1),
							(6, '2016-01-08 16:09:00.000', 2),
							(6, '2016-01-09 08:10:12.122', 2),
							(6, '2016-01-10 09:11:12.122', 3),
							(6, '2016-01-11 10:12:12.122', 3),
							(6, '2016-02-01 08:13:00.000', 2),
							(6, '2016-02-02 09:14:00.000', 3),
							(6, '2016-02-03 10:15:00.000', 1),
							(6, '2016-02-03 11:16:00.000', 2),
							(6, '2016-02-04 12:17:00.000', 2),
							(6, '2016-02-05 13:18:00.000', 3),
							(6, '2016-02-06 14:19:00.000', 3),
							(6, '2016-02-07 15:20:00.000', 1),
							(6, '2016-02-08 16:21:00.000', 2),
							(6, '2016-02-09 06:22:12.122', 2),
							(6, '2016-02-10 06:23:12.122', 3),
							(6, '2016-02-10 05:24:12.122', 3)

/*7 - USUARIO*/
insert into paradas values	(7, '2014-01-01 08:01:00.000', 2),
							(7, '2014-02-02 09:02:00.000', 3),
							(7, '2014-03-03 10:03:00.000', 1),
							(7, '2014-04-03 11:04:00.000', 2),
							(7, '2014-05-04 12:05:00.000', 2),
							(7, '2014-06-05 13:06:00.000', 3),
							(7, '2014-07-06 14:07:00.000', 3),
							(7, '2014-08-07 15:08:00.000', 1),
							(7, '2014-09-08 16:09:00.000', 2),
							(7, '2014-10-09 08:10:12.122', 2),
							(7, '2014-11-10 09:11:12.122', 3),
							(7, '2014-12-11 10:12:12.122', 3),
							(7, '2014-01-01 08:13:00.000', 2),
							(7, '2014-02-02 09:14:00.000', 3),
							(7, '2014-03-03 10:15:00.000', 1),
							(7, '2014-04-03 11:16:00.000', 2),
							(7, '2014-05-04 12:17:00.000', 2),
							(7, '2014-06-05 13:18:00.000', 3),
							(7, '2014-07-06 14:19:00.000', 3),
							(7, '2014-08-07 15:20:00.000', 1),
							(7, '2014-09-08 16:21:00.000', 2),
							(7, '2014-10-09 06:22:12.122', 2),
							(7, '2014-11-10 06:23:12.122', 3),
							(7, '2014-12-10 05:24:12.122', 3)
insert into paradas values	(7, '2015-01-01 08:01:00.000', 2),
							(7, '2015-02-02 09:02:00.000', 3),
							(7, '2015-03-03 10:03:00.000', 1),
							(7, '2015-04-03 11:04:00.000', 2),
							(7, '2015-05-04 12:05:00.000', 2),
							(7, '2015-06-05 13:06:00.000', 3),
							(7, '2015-07-06 14:07:00.000', 3),
							(7, '2015-08-07 15:08:00.000', 1),
							(7, '2015-09-08 16:09:00.000', 2),
							(7, '2015-10-09 08:10:12.122', 2),
							(7, '2015-11-10 09:11:12.122', 3),
							(7, '2015-12-11 10:12:12.122', 3),
							(7, '2015-01-01 08:13:00.000', 2),
							(7, '2015-02-02 09:14:00.000', 3),
							(7, '2015-03-03 10:15:00.000', 1),
							(7, '2015-04-03 11:16:00.000', 2),
							(7, '2015-05-04 12:17:00.000', 2),
							(7, '2015-06-05 13:18:00.000', 3),
							(7, '2015-07-06 14:19:00.000', 3),
							(7, '2015-08-07 15:20:00.000', 1),
							(7, '2015-09-08 16:21:00.000', 2),
							(7, '2015-10-09 06:22:12.122', 2),
							(7, '2015-11-10 06:23:12.122', 3),
							(7, '2015-12-10 05:24:12.122', 3)
insert into paradas values	(7, '2016-01-01 08:01:00.000', 2),
							(7, '2016-01-02 09:02:00.000', 3),
							(7, '2016-01-03 10:03:00.000', 1),
							(7, '2016-01-03 11:04:00.000', 2),
							(7, '2016-01-04 12:05:00.000', 2),
							(7, '2016-01-05 13:06:00.000', 3),
							(7, '2016-01-06 14:07:00.000', 3),
							(7, '2016-01-07 15:08:00.000', 1),
							(7, '2016-01-08 16:09:00.000', 2),
							(7, '2016-01-09 08:10:12.122', 2),
							(7, '2016-01-10 09:11:12.122', 3),
							(7, '2016-01-11 10:12:12.122', 3),
							(7, '2016-02-01 08:13:00.000', 2),
							(7, '2016-02-02 09:14:00.000', 3),
							(7, '2016-02-03 10:15:00.000', 1),
							(7, '2016-02-03 11:16:00.000', 2),
							(7, '2016-02-04 12:17:00.000', 2),
							(7, '2016-02-05 13:18:00.000', 3),
							(7, '2016-02-06 14:19:00.000', 3),
							(7, '2016-02-07 15:20:00.000', 1),
							(7, '2016-02-08 16:21:00.000', 2),
							(7, '2016-02-09 06:22:12.122', 2),
							(7, '2016-02-10 06:23:12.122', 3),
							(7, '2016-02-10 05:24:12.122', 3)

/*8 - USUARIO*/
insert into paradas values	(8, '2014-01-01 08:01:00.000', 2),
							(8, '2014-02-02 09:02:00.000', 3),
							(8, '2014-03-03 10:03:00.000', 1),
							(8, '2014-04-03 11:04:00.000', 2),
							(8, '2014-05-04 12:05:00.000', 2),
							(8, '2014-06-05 13:06:00.000', 3),
							(8, '2014-07-06 14:07:00.000', 3),
							(8, '2014-08-07 15:08:00.000', 1),
							(8, '2014-09-08 16:09:00.000', 2),
							(8, '2014-10-09 08:10:12.122', 2),
							(8, '2014-11-10 09:11:12.122', 3),
							(8, '2014-12-11 10:12:12.122', 3),
							(8, '2014-01-01 08:13:00.000', 2),
							(8, '2014-02-02 09:14:00.000', 3),
							(8, '2014-03-03 10:15:00.000', 1),
							(8, '2014-04-03 11:16:00.000', 2),
							(8, '2014-05-04 12:17:00.000', 2),
							(8, '2014-06-05 13:18:00.000', 3),
							(8, '2014-07-06 14:19:00.000', 3),
							(8, '2014-08-07 15:20:00.000', 1),
							(8, '2014-09-08 16:21:00.000', 2),
							(8, '2014-10-09 06:22:12.122', 2),
							(8, '2014-11-10 06:23:12.122', 3),
							(8, '2014-12-10 05:24:12.122', 3)
insert into paradas values	(8, '2015-01-01 08:01:00.000', 2),
							(8, '2015-02-02 09:02:00.000', 3),
							(8, '2015-03-03 10:03:00.000', 1),
							(8, '2015-04-03 11:04:00.000', 2),
							(8, '2015-05-04 12:05:00.000', 2),
							(8, '2015-06-05 13:06:00.000', 3),
							(8, '2015-07-06 14:07:00.000', 3),
							(8, '2015-08-07 15:08:00.000', 1),
							(8, '2015-09-08 16:09:00.000', 2),
							(8, '2015-10-09 08:10:12.122', 2),
							(8, '2015-11-10 09:11:12.122', 3),
							(8, '2015-12-11 10:12:12.122', 3),
							(8, '2015-01-01 08:13:00.000', 2),
							(8, '2015-02-02 09:14:00.000', 3),
							(8, '2015-03-03 10:15:00.000', 1),
							(8, '2015-04-03 11:16:00.000', 2),
							(8, '2015-05-04 12:17:00.000', 2),
							(8, '2015-06-05 13:18:00.000', 3),
							(8, '2015-07-06 14:19:00.000', 3),
							(8, '2015-08-07 15:20:00.000', 1),
							(8, '2015-09-08 16:21:00.000', 2),
							(8, '2015-10-09 06:22:12.122', 2),
							(8, '2015-11-10 06:23:12.122', 3),
							(8, '2015-12-10 05:24:12.122', 3)
insert into paradas values	(8, '2016-01-01 08:01:00.000', 2),
							(8, '2016-01-02 09:02:00.000', 3),
							(8, '2016-01-03 10:03:00.000', 1),
							(8, '2016-01-03 11:04:00.000', 2),
							(8, '2016-01-04 12:05:00.000', 2),
							(8, '2016-01-05 13:06:00.000', 3),
							(8, '2016-01-06 14:07:00.000', 3),
							(8, '2016-01-07 15:08:00.000', 1),
							(8, '2016-01-08 16:09:00.000', 2),
							(8, '2016-01-09 08:10:12.122', 2),
							(8, '2016-01-10 09:11:12.122', 3),
							(8, '2016-01-11 10:12:12.122', 3),
							(8, '2016-02-01 08:13:00.000', 2),
							(8, '2016-02-02 09:14:00.000', 3),
							(8, '2016-02-03 10:15:00.000', 1),
							(8, '2016-02-03 11:16:00.000', 2),
							(8, '2016-02-04 12:17:00.000', 2),
							(8, '2016-02-05 13:18:00.000', 3),
							(8, '2016-02-06 14:19:00.000', 3),
							(8, '2016-02-07 15:20:00.000', 1),
							(8, '2016-02-08 16:21:00.000', 2),
							(8, '2016-02-09 06:22:12.122', 2),
							(8, '2016-02-10 06:23:12.122', 3),
							(8, '2016-02-10 05:24:12.122', 3)

/*9 - USUARIO*/
insert into paradas values	(9, '2014-01-01 08:01:00.000', 2),
							(9, '2014-02-02 09:02:00.000', 3),
							(9, '2014-03-03 10:03:00.000', 1),
							(9, '2014-04-03 11:04:00.000', 2),
							(9, '2014-05-04 12:05:00.000', 2),
							(9, '2014-06-05 13:06:00.000', 3),
							(9, '2014-07-06 14:07:00.000', 3),
							(9, '2014-08-07 15:08:00.000', 1),
							(9, '2014-09-08 16:09:00.000', 2),
							(9, '2014-10-09 08:10:12.122', 2),
							(9, '2014-11-10 09:11:12.122', 3),
							(9, '2014-12-11 10:12:12.122', 3),
							(9, '2014-01-01 08:13:00.000', 2),
							(9, '2014-02-02 09:14:00.000', 3),
							(9, '2014-03-03 10:15:00.000', 1),
							(9, '2014-04-03 11:16:00.000', 2),
							(9, '2014-05-04 12:17:00.000', 2),
							(9, '2014-06-05 13:18:00.000', 3),
							(9, '2014-07-06 14:19:00.000', 3),
							(9, '2014-08-07 15:20:00.000', 1),
							(9, '2014-09-08 16:21:00.000', 2),
							(9, '2014-10-09 06:22:12.122', 2),
							(9, '2014-11-10 06:23:12.122', 3),
							(9, '2014-12-10 05:24:12.122', 3)
insert into paradas values	(9, '2015-01-01 08:01:00.000', 2),
							(9, '2015-02-02 09:02:00.000', 3),
							(9, '2015-03-03 10:03:00.000', 1),
							(9, '2015-04-03 11:04:00.000', 2),
							(9, '2015-05-04 12:05:00.000', 2),
							(9, '2015-06-05 13:06:00.000', 3),
							(9, '2015-07-06 14:07:00.000', 3),
							(9, '2015-08-07 15:08:00.000', 1),
							(9, '2015-09-08 16:09:00.000', 2),
							(9, '2015-10-09 08:10:12.122', 2),
							(9, '2015-11-10 09:11:12.122', 3),
							(9, '2015-12-11 10:12:12.122', 3),
							(9, '2015-01-01 08:13:00.000', 2),
							(9, '2015-02-02 09:14:00.000', 3),
							(9, '2015-03-03 10:15:00.000', 1),
							(9, '2015-04-03 11:16:00.000', 2),
							(9, '2015-05-04 12:17:00.000', 2),
							(9, '2015-06-05 13:18:00.000', 3),
							(9, '2015-07-06 14:19:00.000', 3),
							(9, '2015-08-07 15:20:00.000', 1),
							(9, '2015-09-08 16:21:00.000', 2),
							(9, '2015-10-09 06:22:12.122', 2),
							(9, '2015-11-10 06:23:12.122', 3),
							(9, '2015-12-10 05:24:12.122', 3)
insert into paradas values	(9, '2016-01-01 08:01:00.000', 2),
							(9, '2016-01-02 09:02:00.000', 3),
							(9, '2016-01-03 10:03:00.000', 1),
							(9, '2016-01-03 11:04:00.000', 2),
							(9, '2016-01-04 12:05:00.000', 2),
							(9, '2016-01-05 13:06:00.000', 3),
							(9, '2016-01-06 14:07:00.000', 3),
							(9, '2016-01-07 15:08:00.000', 1),
							(9, '2016-01-08 16:09:00.000', 2),
							(9, '2016-01-09 08:10:12.122', 2),
							(9, '2016-01-10 09:11:12.122', 3),
							(9, '2016-01-11 10:12:12.122', 3),
							(9, '2016-02-01 08:13:00.000', 2),
							(9, '2016-02-02 09:14:00.000', 3),
							(9, '2016-02-03 10:15:00.000', 1),
							(9, '2016-02-03 11:16:00.000', 2),
							(9, '2016-02-04 12:17:00.000', 2),
							(9, '2016-02-05 13:18:00.000', 3),
							(9, '2016-02-06 14:19:00.000', 3),
							(9, '2016-02-07 15:20:00.000', 1),
							(9, '2016-02-08 16:21:00.000', 2),
							(9, '2016-02-09 06:22:12.122', 2),
							(9, '2016-02-10 06:23:12.122', 3),
							(9, '2016-02-10 05:24:12.122', 3)

/*10 - USUARIO*/
insert into paradas values	(10, '2014-01-01 08:01:00.000', 2),
							(10, '2014-02-02 09:02:00.000', 3),
							(10, '2014-03-03 10:03:00.000', 1),
							(10, '2014-04-03 11:04:00.000', 2),
							(10, '2014-05-04 12:05:00.000', 2),
							(10, '2014-06-05 13:06:00.000', 3),
							(10, '2014-07-06 14:07:00.000', 3),
							(10, '2014-08-07 15:08:00.000', 1),
							(10, '2014-09-08 16:09:00.000', 2),
							(10, '2014-10-09 08:10:12.122', 2),
							(10, '2014-11-10 09:11:12.122', 3),
							(10, '2014-12-11 10:12:12.122', 3),
							(10, '2014-01-01 08:13:00.000', 2),
							(10, '2014-02-02 09:14:00.000', 3),
							(10, '2014-03-03 10:15:00.000', 1),
							(10, '2014-04-03 11:16:00.000', 2),
							(10, '2014-05-04 12:17:00.000', 2),
							(10, '2014-06-05 13:18:00.000', 3),
							(10, '2014-07-06 14:19:00.000', 3),
							(10, '2014-08-07 15:20:00.000', 1),
							(10, '2014-09-08 16:21:00.000', 2),
							(10, '2014-10-09 06:22:12.122', 2),
							(10, '2014-11-10 06:23:12.122', 3),
							(10, '2014-12-10 05:24:12.122', 3)
insert into paradas values	(10, '2015-01-01 08:01:00.000', 2),
							(10, '2015-02-02 09:02:00.000', 3),
							(10, '2015-03-03 10:03:00.000', 1),
							(10, '2015-04-03 11:04:00.000', 2),
							(10, '2015-05-04 12:05:00.000', 2),
							(10, '2015-06-05 13:06:00.000', 3),
							(10, '2015-07-06 14:07:00.000', 3),
							(10, '2015-08-07 15:08:00.000', 1),
							(10, '2015-09-08 16:09:00.000', 2),
							(10, '2015-10-09 08:10:12.122', 2),
							(10, '2015-11-10 09:11:12.122', 3),
							(10, '2015-12-11 10:12:12.122', 3),
							(10, '2015-01-01 08:13:00.000', 2),
							(10, '2015-02-02 09:14:00.000', 3),
							(10, '2015-03-03 10:15:00.000', 1),
							(10, '2015-04-03 11:16:00.000', 2),
							(10, '2015-05-04 12:17:00.000', 2),
							(10, '2015-06-05 13:18:00.000', 3),
							(10, '2015-07-06 14:19:00.000', 3),
							(10, '2015-08-07 15:20:00.000', 1),
							(10, '2015-09-08 16:21:00.000', 2),
							(10, '2015-10-09 06:22:12.122', 2),
							(10, '2015-11-10 06:23:12.122', 3),
							(10, '2015-12-10 05:24:12.122', 3)
insert into paradas values	(10, '2016-01-01 08:01:00.000', 2),
							(10, '2016-01-02 09:02:00.000', 3),
							(10, '2016-01-03 10:03:00.000', 1),
							(10, '2016-01-03 11:04:00.000', 2),
							(10, '2016-01-04 12:05:00.000', 2),
							(10, '2016-01-05 13:06:00.000', 3),
							(10, '2016-01-06 14:07:00.000', 3),
							(10, '2016-01-07 15:08:00.000', 1),
							(10, '2016-01-08 16:09:00.000', 2),
							(10, '2016-01-09 08:10:12.122', 2),
							(10, '2016-01-10 09:11:12.122', 3),
							(10, '2016-01-11 10:12:12.122', 3),
							(10, '2016-02-01 08:13:00.000', 2),
							(10, '2016-02-02 09:14:00.000', 3),
							(10, '2016-02-03 10:15:00.000', 1),
							(10, '2016-02-03 11:16:00.000', 2),
							(10, '2016-02-04 12:17:00.000', 2),
							(10, '2016-02-05 13:18:00.000', 3),
							(10, '2016-02-06 14:19:00.000', 3),
							(10, '2016-02-07 15:20:00.000', 1),
							(10, '2016-02-08 16:21:00.000', 2),
							(10, '2016-02-09 06:22:12.122', 2),
							(10, '2016-02-10 06:23:12.122', 3),
							(10, '2016-02-10 05:24:12.122', 3)


/*			LEGENDA PARA AS DESCRIÇOES DAS NOTIFICAÇOES 
            1 - O USUARIO NÃO POSSUE CADASTRO
            2 - O HORARIO DA PARADA JA TERMINOU
            3 - O HORARIO DA PARADA ACABOU DE TERMINAR
            4 - O VEICULO NAO REALIZOU A PARADA NO DIA DA PESQUISA
            5 - O USUARIO NÃO REALIZOU A PARADA */

/*	ADD NOTIFICAÇÕES AOS USUARIOS - 10 POR USUARIO*/
/*1 - USUARIO*/
select * from notificacoes
insert into notificacoes values (2,	    1,  2,          GETDATE()-151, 2, 0)


/*2 - USUARIO*/
insert into notificacoes values (101,	1,	'2016-01-01 08:01:00.000', 2, 0),
								(102,	1,	'2016-02-02 09:02:00.000', 2, 0),
								(103,	1,	'2016-02-03 10:03:00.000', 2, 0),
								(88,	1,	'2015-08-07 15:38:00.000', 3, 0),
								(89,	1,	'2015-09-08 16:39:00.000', 3, 1),
								(90,	2,	'2015-10-09 08:40:12.122', 4, 1),
								(98,	2,	'2015-11-10 09:41:12.122', 4, 1),
								(61,	2,	'2014-01-01 08:31:00.000', 4, 1),
								(62,	2,	'2014-02-02 09:32:00.000', 5, 1),
								(63,	2,	'2014-03-03 10:33:00.000', 5, 1)

/*3 - USUARIO*/
insert into notificacoes values (161,	1,	'2016-01-01 08:01:00.000', 2, 0),
								(162,	1,	'2016-02-02 09:02:00.000', 2, 0),
								(163,	1,	'2016-02-03 10:03:00.000', 2, 0),
								(148,	1,	'2015-08-07 15:38:00.000', 3, 0),
								(149,	1,	'2015-09-08 16:39:00.000', 3, 1),
								(150,	2,	'2015-10-09 08:40:12.122', 4, 1),
								(158,	2,	'2015-11-10 09:41:12.122', 4, 1),
								(121,		2,	'2014-01-01 08:31:00.000', 4, 1),
								(122,		2,	'2014-02-02 09:32:00.000', 5, 1),
								(123,		2,	'2014-03-03 10:33:00.000', 5, 1)

/*4 - USUARIO*/
insert into notificacoes values (221,	1,	'2016-01-01 08:01:00.000', 2, 0),
								(222,	1,	'2016-02-02 09:02:00.000', 2, 0),
								(223,	1,	'2016-02-03 10:03:00.000', 2, 0),
								(208,	1,	'2015-08-07 15:38:00.000', 3, 0),
								(209,	1,	'2015-09-08 16:39:00.000', 3, 1),
								(210,	2,	'2015-10-09 08:40:12.122', 4, 1),
								(218,	2,	'2015-11-10 09:41:12.122', 4, 1),
								(181,	2,	'2014-01-01 08:31:00.000', 4, 1),
								(182,	2,	'2014-02-02 09:32:00.000', 5, 1),
								(183,	2,	'2014-03-03 10:33:00.000', 5, 1)

/*5 - USUARIO*/
insert into notificacoes values (281,	1,	'2016-01-01 08:01:00.000', 2, 0),
								(282,	1,	'2016-02-02 09:02:00.000', 2, 0),
								(283,	1,	'2016-02-03 10:03:00.000', 2, 0),
								(268,	1,	'2015-08-07 15:38:00.000', 3, 0),
								(269,	1,	'2015-09-08 16:39:00.000', 3, 1),
								(270,	2,	'2015-10-09 08:40:12.122', 4, 1),
								(278,	2,	'2015-11-10 09:41:12.122', 4, 1),
								(241,	2,	'2014-01-01 08:31:00.000', 4, 1),
								(242,	2,	'2014-02-02 09:32:00.000', 5, 1),
								(243,	2,	'2014-03-03 10:33:00.000', 5, 1)

/*6 - USUARIO*/
insert into notificacoes values (341,	1,	'2016-01-01 08:01:00.000', 2, 0),
								(342,	1,	'2016-02-02 09:02:00.000', 2, 0),
								(343,	1,	'2016-02-03 10:03:00.000', 2, 0),
								(328,	1,	'2015-08-07 15:38:00.000', 3, 0),
								(329,	1,	'2015-09-08 16:39:00.000', 3, 1),
								(330,	2,	'2015-10-09 08:40:12.122', 4, 1),
								(338,	2,	'2015-11-10 09:41:12.122', 4, 1),
								(301,	2,	'2014-01-01 08:31:00.000', 4, 1),
								(302,	2,	'2014-02-02 09:32:00.000', 5, 1),
								(303,	2,	'2014-03-03 10:33:00.000', 5, 1)

/*7 - USUARIO*/
insert into notificacoes values (401,	1,	'2016-01-01 08:01:00.000', 2, 0),
								(402,	1,	'2016-02-02 09:02:00.000', 2, 0),
								(403,	1,	'2016-02-03 10:03:00.000', 2, 0),
								(388,	1,	'2015-08-07 15:38:00.000', 3, 0),
								(389,	1,	'2015-09-08 16:39:00.000', 3, 1),
								(390,	2,	'2015-10-09 08:40:12.122', 4, 1),
								(398,	2,	'2015-11-10 09:41:12.122', 4, 1),
								(361,	2,	'2014-01-01 08:31:00.000', 4, 1),
								(362,	2,	'2014-02-02 09:32:00.000', 5, 1),
								(363,	2,	'2014-03-03 10:33:00.000', 5, 1)

/*8 - USUARIO*/
insert into notificacoes values (461,	1,	'2016-01-01 08:01:00.000', 2, 0),
								(462,	1,	'2016-02-02 09:02:00.000', 2, 0),
								(463,	1,	'2016-02-03 10:03:00.000', 2, 0),
								(448,	1,	'2015-08-07 15:38:00.000', 3, 0),
								(449,	1,	'2015-09-08 16:39:00.000', 3, 1),
								(450,	2,	'2015-10-09 08:40:12.122', 4, 1),
								(458,	2,	'2015-11-10 09:41:12.122', 4, 1),
								(421,	2,	'2014-01-01 08:31:00.000', 4, 1),
								(422,	2,	'2014-02-02 09:32:00.000', 5, 1),
								(423,	2,	'2014-03-03 10:33:00.000', 5, 1)

/*9 - USUARIO*/
insert into notificacoes values (581,	1,	'2016-01-01 08:01:00.000', 2, 0),
								(582,	1,	'2016-02-02 09:02:00.000', 2, 0),
								(583,	1,	'2016-02-03 10:03:00.000', 2, 0),
								(568,	1,	'2015-08-07 15:38:00.000', 3, 0),
								(569,	1,	'2015-09-08 16:39:00.000', 3, 1),
								(570,	2,	'2015-10-09 08:40:12.122', 4, 1),
								(578,	2,	'2015-11-10 09:41:12.122', 4, 1),
								(521,	2,	'2014-01-01 08:31:00.000', 4, 1),
								(522,	2,	'2014-02-02 09:32:00.000', 5, 1),
								(523,	2,	'2014-03-03 10:33:00.000', 5, 1)

/*10 - USUARIO*/
insert into notificacoes values (521,	1,	'2016-01-01 08:01:00.000', 2, 0),
								(522,	1,	'2016-02-02 09:02:00.000', 2, 0),
								(523,	1,	'2016-02-03 10:03:00.000', 2, 0),
								(508,	1,	'2015-08-07 15:38:00.000', 3, 0),
								(509,	1,	'2015-09-08 16:39:00.000', 3, 1),
								(510,	2,	'2015-10-09 08:40:12.122', 4, 1),
								(518,	2,	'2015-11-10 09:41:12.122', 4, 1),
								(481,	2,	'2014-01-01 08:31:00.000', 4, 1),
								(482,	2,	'2014-02-02 09:32:00.000', 5, 1),
								(483,	2,	'2014-03-03 10:33:00.000', 5, 1)
commit*/