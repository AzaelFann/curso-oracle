SET serveroutput ON;
--tabla pelicula
CREATE TABLE pelicula
  (
    id_pelicula INTEGER,
    titulo      VARCHAR2(20),
    sinopsis    VARCHAR2(500),
    CONSTRAINT pk_id_pelicula PRIMARY KEY(id_pelicula)
  );
--- secuencia
CREATE sequence sec_pelicula start with 1 increment BY 1 nomaxvalue;
  ---tabla sala
  CREATE TABLE sala
    (
      num_sala    INTEGER,
      id_pelicula INTEGER,
      CONSTRAINT pk_num_sala PRIMARY KEY(num_sala),
      CONSTRAINT fk1_id_pelicula FOREIGN KEY (id_pelicula) REFERENCES pelicula(id_pelicula)
    );
  ---tabla de horario
  CREATE TABLE horario
    (
      id_horario  INTEGER,
      id_pelicula INTEGER,
      fecha       DATE,
      CONSTRAINT pk_id_horario PRIMARY KEY(id_horario),
      CONSTRAINT fk2_id_pelicula FOREIGN KEY(id_pelicula) REFERENCES pelicula(id_pelicula)
    );
  ---secuencia para horario
CREATE sequence sec_horario start with 1 increment BY 1 nomaxvalue;
  ---los procedimientos de peliculas
CREATE OR REPLACE
PROCEDURE guardar_pelicula
  (
    my_id_pelicula OUT INTEGER,
    my_titulo   IN VARCHAR2,
    my_sinopsis IN VARCHAR
  )
AS
BEGIN
  SELECT sec_pelicula.nextval INTO my_id_pelicula FROM dual;
  insert INTO pelicula VALUES(my_id_pelicula, my_titulo, my_sinopsis);
END;
/
---procedimiento para la sala
CREATE OR REPLACE
PROCEDURE guardar_sala(
    my_num_sala    IN INTEGER,
    my_id_pelicula IN INTEGER)
AS
BEGIN
  INSERT INTO sala VALUES (my_num_sala, my_id_pelicula);
END;
/
---procedimiento para horario
CREATE OR REPLACE
PROCEDURE guardar_horario
  (
    my_id_horario OUT INTEGER,
    my_id_pelicula IN INTEGER,
    my_fecha       IN DATE
  )
AS
BEGIN
  SELECT sec_horario.nextval INTO my_id_horario FROM dual;
  INSERT INTO horario VALUES (my_id_horario, my_id_pelicula, my_fecha);
END;
/
----guardamos datos en las tablas

