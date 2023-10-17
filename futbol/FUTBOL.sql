use futbol;

create table equipos (
id_equipo int primary key auto_increment,
nombre_equipo varchar(50)
);
create table jugadores (
id_jugador int primary key auto_increment,
id_equipo int,
nombre_jugador varchar(50),
foreign key (id_equipo) references equipos(id_equipo)
);
create table partidos (
id_partido int primary key auto_increment,
id_equipo_local int,
id_equipo_visitante int,
fecha datetime,
foreign key (id_equipo_local) references equipos(id_equipo),
foreign key (id_equipo_visitante) references equipos (id_equipo),
constraint check (id_equipo_local <> id_equipo_visitante)
);
create table jugadores_x_equipo_x_partido(
id_jugador int,
id_partido int,
puntos int,
rebotes int,
asistencias int,
minutos int,
faltas int,
constraint pk_jugador_partido primary key (id_jugador, id_partido),
constraint fk_id_jugador foreign key (id_jugador) references jugadores (id_jugador),
constraint fk_id_partido foreign key (id_partido) references partidos (id_partido)
);

INSERT INTO equipos(nombre_equipo) VALUES ('River'), ('Boca');
INSERT INTO equipos(nombre_equipo) VALUES ('Atletico Tucuman'), ('San Lorenzo'),
('Racing');
INSERT INTO equipos(nombre_equipo) VALUES ('Patronato');
INSERT INTO equipos(nombre_equipo) VALUES ('Atletica Patronato');

alter table jugadores add column apellido varchar(50);

SELECT * FROM equipos;

INSERT INTO jugadores (id_equipo, nombre_jugador, apellido_jugador) VALUES
(1, 'Pablo', 'Fino'), (1, 'Matias', 'Tassara'),
(1, 'Fausto', 'Moya'), (1, 'Lisandro', 'Canueto'),
(1, 'Mariela', 'Cagnoli'), (2, 'Veronica', 'Tomich'),
(2, 'Ana', 'Nibio'), (2, 'Karina', 'Felice'), (2, 'Antonela', 'Bertarini'),
(3, 'Demi','Lovato'), (3, 'Selena', 'Gomez'), (3, 'Taylor', 'Switz'),
(3, 'Megan', 'Merkle'), (3, 'Principe', 'Harry'),
(4, 'Principe', 'Francescoli'), (4, 'Juampy', 'Sorin'),
(4, 'Marcelo', 'Gallardo'), (4, 'Javier', 'Saviola'), (4, 'Pablo', 'Aimar'),
(4, 'Burrito', 'Ortega'), (6, 'TeFuiste', 'ALaB');
;

select *
from jugadores;

INSERT INTO partidos (id_equipo_local, id_equipo_visitante, fecha)
VALUES (1, 2, '2018-11-01'), (3, 4, '2018-11-02'),
       (1, 3, '2018-11-03'), (2, 4, '2018-11-04'),
       (1, 4, '2018-11-05'), (2, 3, '2018-11-06');
select *
from Partidos;

INSERT INTO jugadores_x_equipo_x_partido(id_jugador, id_partido, puntos, rebotes,
asistencias,
minutos, faltas) VALUES
(1,1,3,5,20,56,2), (2,1,6,7,12,90,4),(3,1,4,7,15,90,7),(4,3,8,4,3,45,1), (5,5,8,6,15,90,0),
(6,4,5,9,15,80,4), (7,6,6,7,8,25,2), (8,4,4,6,6,90,8), (9,6,7,8,9,41,6), (10,2,6,6,6,90,16),
(11,2,7,9,5,53,8), (12,2,5,6,2,82,6), (13,2,5,6,5,15,6), (14,2,8,5,6,40,13);
INSERT INTO jugadores_x_equipo_x_partido(id_jugador, id_partido, puntos, rebotes,
asistencias,
minutos, faltas) VALUES
(1,3,8,9,9,90,9), (2,3,8,7,15,46,9),(3,3,6,7,15,90,7),(4,1,2,9,9,90,8), (5,3,6,8,56,85,12),
(6,6,8,8,5,15,1), (7,4,8,17,4,90,5), (8,6,5,9,5,45,6), (9,4,5,6,9,90,3);
Select *
from jugadores_x_equipo_x_partido;
/*A PARTIR DE ACA SON RESOLUCIONES DEL EJERCICIO. */
/*EJERCICIO 1.*/
alter table jugadores change column apellido apellido_jugador varchar(50);

SELECT j.nombre_jugador, j.apellido_jugador, e.nombre_equipo
FROM jugadores AS j
INNER JOIN equipos AS e ON e.id_equipo = j.id_equipo;
/*EJERCICIO 2.*/
INSERT INTO jugadores (id_equipo, nombre_jugador, apellido_jugador) VALUES
(5,"Descendiste","PorBurro");
SELECT * 
FROM equipos AS e
WHERE e.nombre_equipo like 'p%';
/*EJERCICIO 3.*/
SELECT * 
FROM jugadores as j
INNER JOIN equipos as e ON
j.id_equipo = e.id_equipo
HAVING 
e.nombre_equipo like '%Atletico%' OR e.nombre_equipo like '%Atletica%';
/*EJERCICIO 4.*/
SELECT j.nombre_jugador, j.apellido_jugador,
e.nombre_equipo 
FROM jugadores AS j INNER JOIN 
equipos as e ON
j.id_equipo = e.id_equipo INNER JOIN
jugadores_x_equipo_x_partido as jep ON
jep.id_jugador = j.id_jugador INNER JOIN
partidos as p ON
p.id_partido = JEP.id_partido;
/*EJERCICIO 5. PREGUNTAR*/
SELECT p.fecha, e.nombre_equipo
FROM partidos as p INNER JOIN
equipos as E ON
p.id_equipo_local = e.id_equipo AND
p.id_equipo_visitante = e.id_equipo;
/*EJERCICIO 6.*/
SELECT e.nombre_equipo, COUNT(j.id_jugador)
FROM equipos as e INNER JOIN 
jugadores as j ON
e.id_equipo = j.id_equipo
GROUP BY e.nombre_equipo;
/*EJERCICIO 7.*/
SELECT j.nombre_jugador , count(jep.id_partido)
FROM jugadores as j INNER JOIN
jugadores_x_equipo_x_partido as jep ON
j.id_jugador = jep.id_jugador
GROUP BY j.nombre_jugador;
/*EJERCICIO 8.*/
SELECT  j.nombre_jugador, sum(jep.puntos) as puntosTotales
FROM jugadores as J INNER JOIN
jugadores_x_equipo_x_partido as jep ON
j.id_jugador = jep.id_jugador
GROUP BY j.nombre_jugador
ORDER BY puntosTotales DESC
LIMIT 6;
/*EJERCICIO 9.*/
SELECT j.nombre_jugador, avg(jep.puntos) as promedioPuntos
FROM jugadores as J INNER JOIN
jugadores_x_equipo_x_partido as jep ON
j.id_jugador = jep.id_jugador
GROUP BY j.nombre_jugador
ORDER BY promedioPuntos DESC
LIMIT 5;
/*EJERCICIO 10.*/
SELECT j.nombre_jugador, MAX(p.fecha) as fechaMax, MIN(p.fecha) as fechaMin
FROM jugadores as j INNER JOIN jugadores_x_equipo_x_partido as jep ON
j.id_jugador = jep.id_jugador INNER JOIN partidos as p ON
p.id_partido = jep.id_partido
GROUP BY j.nombre_jugador;
/*EJERCICIO 11.*/
SELECT e.nombre_equipo,e.id_equipo, count(j.id_jugador) as contadorJugadores
FROM equipos as e 
INNER JOIN jugadores as j ON
e.id_equipo = j.id_equipo
GROUP BY e.id_equipo
HAVING contadorJugadores > 10;
/*EJERCICIO 12. PREGUNTAR POR QUE SE AGARRA LA TABLA INTERMEDIA, NO ENTENDI BIEN*/
SELECT j.nombre_jugador, count(jep.id_partido) as contadorPartidos, avg(jep.puntos) as promedioPuntos
FROM jugadores as j INNER JOIN jugadores_x_equipo_x_partido as jep ON
j.id_jugador = jep.id_jugador
GROUP BY j.nombre_jugador
HAVING contadorPartidos > 0 AND promedioPuntos > 0;
/*EJERCICIO 13.*/
SELECT j.nombre_jugador, avg(jep.puntos) as promedioPuntos, avg(jep.asistencias) as promedioAsistencias, avg(jep.rebotes) as promedioRebotes
FROM jugadores as j INNER JOIN jugadores_x_equipo_x_partido as jep ON
j.id_jugador = jep.id_jugador INNER JOIN partidos as p ON
p.id_partido = jep.id_partido
GROUP BY j.nombre_jugador
HAVING promedioPuntos > 2 AND promedioAsistencias > 2 AND promedioRebotes > 2;
/*EJERCICIO 14.*/
SELECT jep.puntos, e.nombre_equipo 
FROM jugadores_x_equipo_x_partido as jep INNER JOIN partidos as p ON
jep.id_partido = p.id_partido INNER JOIN equipos as e ON
e.id_equipo = p.id_equipo_local;
/*EJERCICIO 15.*/
SELECT e.nombre_equipo, count(p.id_equipo_local) as partidosComoLocal
FROM equipos as e INNER JOIN partidos as p ON
e.id_equipo = p.id_equipo_local
GROUP BY e.nombre_equipo
HAVING partidosComoLocal > 1;