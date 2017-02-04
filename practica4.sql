SET serveroutput ON;
--Recapitulando lo que es un bloque plsql
DECLARE
  nombre VARCHAR2(20):='Azael';
BEGIN
  DBMS_OUTPUT.PUT_LINE('Buenas Noches '||nombre);
END;
/
DECLARE
  edad    INTEGER:=27;
  dias    INTEGER;
  estatus VARCHAR2(12);
BEGIN
  dias     :=edad*365;
  IF dias   >10000 THEN
    estatus:='viejo';
  ELSE
    estatus:='joven';
  END IF;
  DBMS_OUTPUT.PUT_LINE('Tu edad en dias es: '||dias||' Estatus: '||estatus );
END;
/
--veremos nuestro primer procedimiento almacenado
CREATE OR REPLACE
PROCEDURE saludar(
    mensaje IN VARCHAR2)
AS
  --aqui declaramos variables
BEGIN
  --aqui va la logica
  DBMS_OUTput.put_line('Hola Buenas Noches'||mensaje);
END;
/
--ejecutamos el procedimiento
EXEC saludar(' Dragoncito tierno \(OwO)/');
--generamos una secuencia
CREATE sequence sec_persona start with 1 increment BY 1 nomaxvalue;
  --generamos la tabla
  CREATE TABLE persona
    (
      id_persona INTEGER,
      nombre     VARCHAR2(20),
      edad       INTEGER,
      CONSTRAINT pk_id_persona PRIMARY KEY(id_persona)
    );
  --
CREATE OR REPLACE
PROCEDURE guardar_persona
  (
    my_id OUT INTEGER,
    my_nombre IN VARCHAR2,
    my_edad   IN INTEGER
  )
AS
BEGIN
  SELECT sec_persona.nextval INTO my_id FROM dual;
  INSERT INTO persona VALUES
    (my_id, my_nombre, my_edad
    );
END;
/
DECLARE
  valor INTEGER;
BEGIN
  guardar_persona(valor,'Azael', 27);
END;
/
SELECT * FROM persona;
--esto es de la clase del 4 FEB
CREATE TABLE trabajador1
  (
    seguro_social INTEGER,
    nombre        VARCHAR2(80),
    paterno       VARCHAR2(80),
    CONSTRAINT pk_trabajador1 PRIMARY KEY (seguro_social)
  );
--creamos la secueancia
CREATE sequence sec_nomina start with 1 increment BY 1 noMAXvalue;
  --creamos la segunda tabla
  CREATE TABLE nomina
    (
      id_nomina     INTEGER,
      seguro_social INTEGER,
      horas_lab     INTEGER,
      fecha_pago    DATE,
      saldo FLOAT,
      CONSTRAINT pk_id_nomina PRIMARY KEY(id_nomina),
      CONSTRAINT fk_seguro_social FOREIGN KEY(seguro_social) REFERENCES trabajador(seguro_social)
    );
  --creamos el procedimiento
CREATE OR REPLACE
PROCEDURE guardar_trabajador
  (
    my_id      IN INTEGER,
    my_nombre  IN VARCHAR2,
    my_paterno IN VARCHAR2
  )
AS
BEGIN
  INSERT INTO trabajador1 VALUES
    (my_id, my_nombre, my_paterno
    );
END;
/
--creamos nuestro segundo procedimiento
CREATE OR REPLACE
PROCEDURE guardar_nomina
  (
    my_id_nomina OUT INTEGER,
    my_seguro_social IN INTEGER
  )
AS
BEGIN
  SELECT sec_nomina.nextval INTO my_id_nomina FROM dual;
  INSERT
  INTO nomina
    (
      id_nomina,
      seguro_social
    )
    VALUES
    (
      my_id_nomina,
      my_seguro_social
    );
END;
/


EXEC guardar_trabajador(333,'Azael', 'Fann');
exec guardar_trabajador(777,'Suo', 'Harunosuke');

select * from trabajador1;
select * from nomina;

DECLARE
  valor INTEGER;
BEGIN
  guardar_trabajador(555,'Misael','Fann');
  guardar_nomina(valor,555);
  END;
/
