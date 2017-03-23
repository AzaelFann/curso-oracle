CREATE TABLE trabajador
  (
    id     INTEGER,
    nombre VARCHAR2(20),
    sueldo_base FLOAT,
    CONSTRAINT pk_id1 PRIMARY KEY (id)
  );
--
CREATE TABLE respaldo_trabajador
  (
    id     INTEGER,
    nombre VARCHAR2(20),
    sueldo_base FLOAT,
    CONSTRAINT pk_id2 PRIMARY KEY (id)
  );
--
CREATE OR REPLACE PROCEDURE contar(numero OUT INTEGER)
AS
BEGIN
  SELECT COUNT(*) INTO numero FROM trabajador;
  dbms_output.put_line('Encontrados: ' ||numero);
END;
/
--
CREATE OR REPLACE PROCEDURE copiar
AS
  CURSOR cur_trabajador
  IS
    SELECT * FROM trabajador;
BEGIN
  FOR rec IN cur_trabajador
  LOOP
    INSERT INTO respaldo_trabajador VALUES(rec.id, rec.nombre, rec.sueldo_base);
  END LOOP;
END;
/
--
CREATE OR REPLACE TRIGGER disp_trabajador before
  INSERT ON trabajador FOR EACH row DECLARE valor INTEGER;
  BEGIN
    contar(valor);
    IF valor = 3 THEN
      copiar();
      DELETE FROM trabajador;
    END IF;
  END;
  /
--
--
insert into trabajador values (1,'Azael',2500);
insert into trabajador values (2,'Suo',2400);
insert into trabajador values (3,'Misael',3000);
select * from trabajador;
insert into trabajador values (4,'Hinowa',2700);
insert into trabajador values (5,'Aoi',1200);
insert into trabajador values (6,'Kurogane',1300);
select * from respaldo_trabajador;
insert into trabajador values (7,'Kurenai',1100);
