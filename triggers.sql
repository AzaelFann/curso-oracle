CREATE TABLE usuario_xxx (
    id       INTEGER,
    nombre   VARCHAR2(40),
    edad     INTEGER,
    CONSTRAINT pk_id PRIMARY KEY ( id )
);

CREATE OR REPLACE TRIGGER dis_usuario_xxx BEFORE
    INSERT ON usuario_xxx
    FOR EACH ROW
BEGIN
    IF :new.edad < 18 THEN
        raise_application_error(-20001,'Eres menor de edad');
    END IF;
END;
/

SELECT
    *
FROM
    usuario_xxx;

INSERT INTO usuario_xxx VALUES ( 1,'Kucabara',21 );

INSERT INTO usuario_xxx VALUES ( 1,'Misael',13 );
--
--
--modificar el disparador anterior de tal manera que valide lo siguiente
--debera verificar que el nombre solo contenga mayusculas, si no es
--asi debera lanzar la excepcion
--
