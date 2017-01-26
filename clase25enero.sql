

set serveroutput on;


--Recapitulando lo que es un bloque plsql

declare
nombre varchar2(20):='Azael';
begin
DBMS_OUTPUT.PUT_LINE('Buenas Noches '||nombre);
end;
/

declare
edad integer:=27;
dias integer;
begin
dias:=edad*365;
DBMS_OUTPUT.PUT_LINE('Tu edad en dias es: '||dias);
end;
/

