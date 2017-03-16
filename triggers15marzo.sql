--hoy veremos  un ejercicio de disparador (trigger) de tipo automatizacion
--
--
--
--generar las tres tablas
--
CREATE TABLE papa
  (
    id     INTEGER,
    nombre VARCHAR2(40),
    edad   INTEGER,
    CONSTRAINT pk_id PRIMARY KEY (id)
  );
CREATE TABLE hijomayor
  (
    id     INTEGER,
    nombre VARCHAR2(40),
    edad   INTEGER,
    CONSTRAINT pk_id2 PRIMARY KEY (id)
  );
CREATE TABLE hijomenor
  (
    id     INTEGER,
    nombre VARCHAR2(40),
    edad   INTEGER,
    CONSTRAINT pk_id3 PRIMARY KEY (id)
  );
--
--
--
--
--generar un trigger que haga lo siguiente
--al guardar un registro en la tabla PAPA verificar si la edad
--es mayor a 18, si es asi guardar ademas el registro en la tabla
--HIJOMAYOR. Si la edad es menor de 18, guardar el registro en la
--tabla HIJOMENOR
--
--
CREATE OR REPLACE TRIGGER disp_papa AFTER
  INSERT ON papa FOR EACH row 
  BEGIN 
  IF :new.edad>18 THEN
  INSERT INTO hijomayor VALUES
    (:new.id, :new.nombre, :new.edad);
ELSE
  INSERT INTO hijomenor VALUES
    (:new.id, :new.nombre, :new.edad);
END IF;
END;
/

--
--
--
--probar que el disparador funcione correctamente insertando registros con edades
--mayor a 18 y menores a 18, unicamente en la tabla papa
--efectuar selects para comprobar funcionalidad
--
--
insert into papa values(1,'Azael',27);
insert into papa values(2,'Misael',16);
--
select * from papa;
select * from hijomayor;
select * from hijomenor;

