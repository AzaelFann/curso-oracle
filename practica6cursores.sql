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
    
    insert into trabajador (seguro_social, nombre, edad) values(1,'Ana',28);
    insert into trabajador (seguro_social, nombre, edad) values(2,'Pedro',40);
    insert into trabajador (seguro_social, nombre, edad) values(3,'Juan',35);
    insert into trabajador (seguro_social, nombre, edad) values(4,'Karla',41);
    
    insert into nomina (seguro_social, sueldo_base, horas_lab) values();
