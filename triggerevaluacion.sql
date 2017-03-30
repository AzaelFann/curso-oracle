--a)generar el diagrama E-R
CREATE TABLE alumno
  (
    num_cuenta INTEGER,
    nombre     VARCHAR2(25),
    paterno    VARCHAR(25),
    CONSTRAINT pk_num_cuenta PRIMARY KEY (num_cuenta)
  );
--
CREATE TABLE materia
  (
    id_materia INTEGER,
    nombre     VARCHAR2(120),
    CONSTRAINT pk_id_materia PRIMARY KEY (id_materia)
  );
--
CREATE sequence sec_mat start with 1 increment BY 1 nomaxvalue;
  --
CREATE OR REPLACE
PROCEDURE guardar_mat
  (
    my_id_materia OUT INTEGER,
    my_nombre IN VARCHAR2
  )
AS
BEGIN
  SELECT sec_mat.nextval INTO my_id_materia FROM dual;
  INSERT INTO materia VALUES
    (my_id_materia, my_nombre
    );
END;
/
--
CREATE TABLE evaluacion
  (
    num_cuenta INTEGER,
    id_materia INTEGER,
    calificacion FLOAT,
    estatus CHAR,
    CONSTRAINT fk_num_cuenta FOREIGN KEY(num_cuenta) REFERENCES alumno(num_cuenta),
    CONSTRAINT fk_id_materia FOREIGN KEY(id_materia) REFERENCES materia(id_materia)
  );
--
--b)guardar los siguientes registros
--
INSERT
INTO alumno VALUES
  (
    123,
    'Juan',
    'Torres'
  );
INSERT INTO alumno VALUES
  (456,'Daniela','Meza'
  );
INSERT INTO alumno VALUES
  (789,'Armando','Cardenas'
  );
--
--
DECLARE
  valor INTEGER;
BEGIN
  guardar_mat(valor, 'Metodologia Estructurada');
END;
/
--
guardar_mat(valor, 'Base de Datos II');
guardar_mat(valor, 'Negocios Electronicos');
--
SELECT * FROM alumno;
SELECT * FROM materia;
--
--
--c)generar un disparador que valide lo siguiente
--  solo esta permitido ingresar estatus A para aprobado y
--  R para reprobado, si se ingresa otro valor debe marcar error
--estatus='A'
--  si el estatus es A y se asigna una calificacion menor a 6 debe marcar error
--  si el estatus es R y se asigna una calificaion mayor a 5.99 debe marcar error
--probar el disparador del inciso c) ingresando los sig valores
--
--evaluacion
--cuenta    id_materia    calificacion    estatus
--123       1             7.9             A
--456       2             5               A       marca error
--789       1             4.2             R
--123       3             8.5             R       marca error
--
--Nota importante los tres primeros tienen +1/+0 hasta el fin del examen
--
CREATE OR REPLACE TRIGGER disp_evaluacion before
  INSERT ON evaluacion FOR EACH row 
  BEGIN 
  IF :new.calificacion>5.99 AND :new.estatus='A' THEN
  INSERT
  INTO evaluacion VALUES
    (
      :new.num_cuenta,
      :new.id_materia,
      :new.calificacion,
      :new.estatus
    );
  IF :new.calificacion<6 AND :new.estatus='B' THEN
    INSERT
    INTO evaluacion VALUES
      (
        :new.num_cuenta,
        :new.id_materia,
        :new.calificacion,
        :new.estatus
      );
  ELSE
    dbms_output.put_line('3rr0r');
  END IF;
END IF;
END;
/

insert into evaluacion values(123, 1, 7.5,'A');
