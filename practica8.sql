SET serveroutput ON;
--
---
----
----
----
----
-----creamos la tabla dance
CREATE TABLE dance
  (
    id_dance INTEGER,
    nombre   VARCHAR2(20),
    edad     INTEGER,
    CONSTRAINT pk_id_dance PRIMARY KEY(id_dance)
  );
---
---
---
--generarlos siguientes registros
INSERT
INTO dance VALUES
  (
    1,
    'Azael',
    27
  );
INSERT INTO dance VALUES
  (2,'Suo',25
  );
INSERT INTO dance VALUES
  (3,'Misael',20
  );
INSERT INTO dance VALUES
  (4,'Hinowa',16
  );
--
SELECT * FROM dance;
--
--
--imprimir el nombre y la edad del cliente, si es menor de 18 años debe aparecer en una nueva columna "precoz" y si es mayor "viejo"
SELECT nombre,
  edad,
  edad AS "status"
FROM dance
WHERE edad <18;
--
--solucion con cursor
DECLARE
  estatus VARCHAR(20);
  CURSOR cur1
  IS
    SELECT * FROM dance;--declaracion del cursor
BEGIN
  FOR rec IN cur1
  LOOP
    IF rec.edad < 18 THEN
      estatus  :='precoz';
      dbms_output.put_line('nombre: '||rec.nombre||' edad: '||rec.edad||' estatus: '||estatus);
    ELSE
      estatus:='viejo';
      dbms_output.put_line('nombre: '||rec.nombre||' edad: '||rec.edad||' estatus: '||estatus);
    END IF;
  END LOOP;
END;
/
--
--
--
--ejercicio numero dos de cursores
--implementar el siguiente esquema
CREATE TABLE trabajador
  (
    seguro_social INTEGER,
    nombre        VARCHAR2(80),
    edad          INTEGER,
    CONSTRAINT pk_trabajador1 PRIMARY KEY (seguro_social)
  );
--creamos la secuencia
CREATE sequence sec_nomina start with 1 increment BY 1 noMAXvalue;
  --creamos la segunda tabla
  CREATE TABLE nomina
    (
      id_nomina     INTEGER,
      seguro_social INTEGER,
      sueldo_base FLOAT,
      horas_lab  INTEGER,
      fecha_pago DATE,
      CONSTRAINT pk_id_nomina PRIMARY KEY(id_nomina),
      CONSTRAINT fk_seguro_social FOREIGN KEY(seguro_social) REFERENCES trabajador(seguro_social)
    );
  --
  ---
  ----
  ---
  ----procedimientos asociados
  --existen en el paradigma relacional las siguientes relaciones
  --ONE TO ONE
  --ONE TO MANY
  --MANY TO ONE
  --MANY TO MANY
  ---
  ---todas ellas tienen las siguientes propiedades
  --direccionalidad: es el sentido de la relacion
  --cardinalidad: la cantidad que se asignan
  --ordinalidad: el orden de creacion de cada una
  --
  --la solucion es primero crear el procedimiento que guerda la nomina
  --
CREATE OR REPLACE
PROCEDURE guardar_nomina
  (
    my_id_nomina OUT INTEGER,
    my_seguro_social IN INTEGER,
    my_sueldo_base   IN FLOAT
  )
AS
BEGIN
  SELECT sec_nomina.nextval INTO my_id_nomina FROM dual;
  INSERT
  INTO nomina
    (
      id_nomina,
      seguro_social,
      sueldo_base
    )
    VALUES
    (
      my_id_nomina,
      my_seguro_social,
      my_sueldo_base
    );
END;
/
--
--
--
CREATE OR REPLACE
PROCEDURE generar_trabajador
  (
    my_seguro_social IN INTEGER,
    my_nombre        IN VARCHAR2,
    my_edad          IN INTEGER,
    my_id_nomina OUT INTEGER,
    my_sueldo_base IN FLOAT
  )
AS
BEGIN
  INSERT INTO trabajador VALUES
    (my_seguro_social, my_nombre, my_edad
    );
  guardar_nomina(my_id_nomina, my_seguro_social, my_sueldo_base);
END;
/
--
--
--
--
---
--
---
DECLARE
  valor INTEGER;
BEGIN
  generar_trabajador(1, 'Ana', 28, valor, 6000);
  generar_trabajador(2, 'Pedro', 40, valor, 8000);
  generar_trabajador(3, 'Juan', 35, valor, 7000);
  generar_trabajador(4, 'Karla', 41, valor, 10000);
END;
/
SELECT * FROM trabajador;
SELECT * FROM nomina;
--
---
--
--
--generar un procedimiento almacenado que permita ingresar las horas que trabajo x trabajador
--que estructura debe tener el procedimiento?
--ayuda usar usar dentro de l procedimiento update
--
--
--
--
--
---
---hacer la busqueda con cursores
--hacer la siguiente busqueda; buscar todos los registros y mostrar el nombre, la edad
--y el sueldo base de todos losdatos
--estrucura de un cursor basico
DECLARE
  CURSOR cur1
  IS
    SELECT * FROM trabajador;
  CURSOR cur2
  IS
    SELECT * FROM nomina;
BEGIN
  FOR rec IN cur1
  LOOP
    FOR rec1 IN cur2
    LOOP
      IF rec.seguro_social=rec1.seguro_social THEN
        DBMS_OUTPUT.PUT_LINE('Nombre: '||rec.nombre||' Edad: '||rec.edad||' Sueldo Base: '||rec1.sueldo_base);
      END IF;
    END LOOP;
  END LOOP;
END;
/
--
--gnerar un procedimiento almacenado que efectue un update masivo
--que haga lo siguiente
--debera actualizar las horas laboradas a 40 para todas las horas trabajadores
--y debe imprimir lo siguiente al efectuar la invocacion del procedimiento
--nombre: Suo suelod 6000 horas 40 Pago (la cantodad de horas multiplicada por el sueldo)
--
--
--
describe nomina;
--cursores con update!!!!!!!!!!!!!!!!!
DECLARE
  CURSOR cur3
  IS
    SELECT * FROM nomina FOR UPDATE;
BEGIN
  FOR rec IN cur3
  LOOP
    UPDATE nomina SET horas_lab=40 WHERE CURRENT OF cur3;
  END LOOP;
END;
/
SELECT * FROM nomina;
--
--
---
--
CREATE OR REPLACE
PROCEDURE actualizar_nomina(
    my_nombre IN VARCHAR2,
    my_sueldo IN FLOAT )
AS
BEGIN
END;
/
