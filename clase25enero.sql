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
