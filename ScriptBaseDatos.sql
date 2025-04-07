CREATE TABLE PROPIETARIO (
    CEDULA NUMBER(12) NOT NULL,
    EMAIL VARCHAR2 (50),
    TELEFONO NUMBER (10) NOT NULL,
    NOMBRE VARCHAR2 (50) NOT NULL,
    CONSTRAINT PROPIETARIO_PK PRIMARY KEY(CEDULA));
    
CREATE TABLE VETERINARIO(
    ID NUMBER(3) NOT NULL,
    NOMBRE VARCHAR2(50) NOT NULL,
    CONSTRAINT VETERINARIO_PK PRIMARY KEY(ID));

CREATE TABLE MEDICAMENTO(
    ID NUMBER(8) NOT NULL,
    NOMBRE VARCHAR2(30) NOT NULL,
    PRECIO NUMBER(6) NOT NULL,
    CONSTRAINT MEDICAMENTO_PK PRIMARY KEY(ID));
    
CREATE TABLE CONSULTA(
    ID_CONSULTA NUMBER(4) NOT NULL,
    FECHA DATE,
    PRECIO_TOTAL NUMBER(7) NOT NULL,
    DIAGNOSTICO VARCHAR2(200) NOT NULL,
    CONSTRAINT CONSULTA_PK PRIMARY KEY(ID_CONSULTA));
    
CREATE TABLE ESPECIE(
    ID NUMBER(3) NOT NULL,
    NOMBRE VARCHAR2(50) NOT NULL,
    CONSTRAINT ESPECIE_PK PRIMARY KEY(ID));
    
CREATE TABLE RAZA(
    ID NUMBER(3) NOT NULL,
    NOMBRE VARCHAR2(50) NOT NULL,
    CONSTRAINT RAZA_PK PRIMARY KEY(ID));
    
CREATE TABLE ESPECIALIDAD(
    ID NUMBER(3) NOT NULL,
    NOMBRE_ESPECIALIDAD VARCHAR2(50) NOT NULL,
    CONSTRAINT ESPECIALIDAD_PK PRIMARY KEY(ID));

CREATE TABLE MASCOTA (
    ID NUMBER(3) NOT NULL,
    NOMBRE VARCHAR2(20),
    ESPECIE_ID NUMBER(2) NOT NULL,
    RAZA_ID NUMBER(2) NOT NULL,
    EDAD NUMBER(2),
    PESO NUMBER(3) NOT NULL,
    ID_PROPIETARIO NUMBER(12) NOT NULL,
    CONSTRAINT MASCOTA_PK PRIMARY KEY(ID),
    CONSTRAINT MASCOTA_PROPIETARIO_FK FOREIGN KEY(ID_PROPIETARIO) REFERENCES PROPIETARIO(CEDULA),
    CONSTRAINT MASCOTA_ESPECIE_FK FOREIGN KEY(ESPECIE_ID) REFERENCES ESPECIE(ID),
    CONSTRAINT MASCOTA_RAZA_FK FOREIGN KEY(RAZA_ID) REFERENCES RAZA(ID));

CREATE TABLE CONSULTA_MASCOTA(
    ID_CONSULTA NUMBER(3) NOT NULL,
    ID_MASCOTA NUMBER(3) NOT NULL,
    CONSTRAINT CONSULTA_MASCOTA_CONSULTA_FK FOREIGN KEY(ID_CONSULTA) REFERENCES CONSULTA(ID_CONSULTA),
    CONSTRAINT CONSULTA_MASCOTA_MASCOTA_FK FOREIGN KEY(ID_MASCOTA) REFERENCES MASCOTA(ID),
    CONSTRAINT CONSULTA_MASCOTA_PK PRIMARY KEY(ID_CONSULTA));
    
    
CREATE TABLE CONSULTA_VETERINARIO(
    ID_CONSULTA NUMBER(3) NOT NULL,
    ID_VETERINARIO NUMBER(3) NOT NULL,
    CONSTRAINT CONSULTA_VETERINARIO_CONSULTA_FK FOREIGN KEY(ID_CONSULTA) REFERENCES CONSULTA(ID_CONSULTA),
    CONSTRAINT CONSULTA_VETERINARIO_VETERINARIO_FK FOREIGN KEY(ID_VETERINARIO) REFERENCES VETERINARIO(ID),
    CONSTRAINT CONSULTA_MEDICAMENTO_PK PRIMARY KEY(ID_CONSULTA));
    
CREATE TABLE VETERINARIO_ESPECIALIDAD(
    ID_ESPECIALIDAD NUMBER(3) NOT NULL,
    ID_VETERINARIO NUMBER(3) NOT NULL,
    CONSTRAINT VETERINARIO_ESPECIALIDAD_ESPECIALIDAD_FK FOREIGN KEY(ID_ESPECIALIDAD) REFERENCES ESPECIALIDAD(ID),
    CONSTRAINT VETERINARIO_ESPECIALIDAD_VETERINARIO_FK FOREIGN KEY(ID_VETERINARIO) REFERENCES VETERINARIO(ID));

CREATE TABLE CONSULTA_MEDICAMENTO(
    ID_CONSULTA NUMBER(3) NOT NULL,
    ID_MEDICAMENTO NUMBER(3) NOT NULL,
    CANTIDAD NUMBER(3) NOT NULL,
    CONSTRAINT CONSULTA_MEDICAMENTO_CONSULTA_FK FOREIGN KEY(ID_CONSULTA) REFERENCES CONSULTA(ID_CONSULTA),
    CONSTRAINT CONSULTA_MEDICAMENTO_MEDICAMENTO_FK FOREIGN KEY(ID_MEDICAMENTO) REFERENCES MEDICAMENTO(ID),
    CONSTRAINT CONSULTA_MEDICAMENTO_ID_PK PRIMARY KEY(ID_CONSULTA));

--Creacion de las secuencias--

CREATE SEQUENCE secuencia_veterinario
    INCREMENT BY 1
    START WITH 6
    MINVALUE 6
    MAXVALUE 1000
    CYCLE;

CREATE SEQUENCE secuencia_medicamento
    INCREMENT BY 1
    START WITH 6
    MINVALUE 6
    MAXVALUE 1000
    CYCLE;

CREATE SEQUENCE secuencia_consulta
    INCREMENT BY 1
    START WITH 4
    MINVALUE 4
    MAXVALUE 1000
    CYCLE;

CREATE SEQUENCE secuencia_especialidad
    INCREMENT BY 1
    START WITH 6
    MINVALUE 6
    MAXVALUE 1000
    CYCLE;

CREATE SEQUENCE secuencia_raza
    INCREMENT BY 1
    START WITH 33
    MINVALUE 33
    MAXVALUE 1000
    CYCLE;

CREATE SEQUENCE secuencia_especie
    INCREMENT BY 1
    START WITH 6
    MINVALUE 6
    MAXVALUE 1000
    CYCLE;

CREATE SEQUENCE secuencia_mascota
    INCREMENT BY 1
    START WITH 5
    MINVALUE 5
    MAXVALUE 1000
    CYCLE;

CREATE SEQUENCE CONTADOR_UPDATES
    INCREMENT BY 1
    START WITH 0
    MINVALUE 0
    MAXVALUE 1000
    CYCLE;

--------------------------Paquete de consultas----------------------------------


create or replace package consultas as
    Function ventaTotalAnio(anio IN NUMBER) return number;
    Function ventaTotalMes(MES IN NUMBER, anio in NUMBER) return number;
    Function ventaTotalDia(dia IN NUMBER,mes in NUMBER, anio in NUMBER) return number;
    procedure imprimirAnio(anio in NUMBER);
    procedure imprimirMes(mes in NUMBER, anio in NUMBER);
    procedure imprimirDia(dia in NUMBER,mes in NUMBER, anio in NUMBER);
    procedure ConsultasAnio(anio in NUMBER);
    procedure ConsultasMes(mes in NUMBER, anio in NUMBER);
    procedure ConsultasDia(dia in NUMBER,mes in NUMBER, anio in NUMBER);
    procedure ventasTotales;
end consultas;

create or replace package body consultas as

    Function ventaTotalAnio(anio IN NUMBER) return number
    is
    TotalAnio NUMBER;
    begin
         select SUM((ME.PRECIO*CME.CANTIDAD) + C.PRECIO_TOTAL) INTO TotalAnio
        from consulta c
        INNER JOIN consulta_medicamento CME on c.ID_CONSULTA = CME.ID_CONSULTA
        INNER JOIN medicamento ME on me.ID = CME.ID_MEDICAMENTO
        where EXTRACT(YEAR FROM FECHA) = anio;
        return TotalAnio;
        EXCEPTION WHEN OTHERS THEN
            DBMS_OUTPUT.put_line (SQLERRM);
    end;

    Function ventaTotalMes(mes in NUMBER, anio in NUMBER) return number
    is
    TotalMes NUMBER;
    begin
    
        select SUM((ME.PRECIO*CME.CANTIDAD) + C.PRECIO_TOTAL) INTO TotalMes
        from consulta c
        INNER JOIN consulta_medicamento CME on c.ID_CONSULTA = CME.ID_CONSULTA
        INNER JOIN medicamento ME on me.ID = CME.ID_MEDICAMENTO
        where EXTRACT(MONTH FROM FECHA) = mes
        and EXTRACT(YEAR FROM FECHA) = anio;
        return TotalMes;
        EXCEPTION WHEN OTHERS THEN
            DBMS_OUTPUT.put_line (SQLERRM);
        
    end;
    
    
    Function ventaTotalDia(dia in NUMBER,mes in NUMBER, anio in NUMBER) return number
    is
    TotalDia NUMBER;
    begin
    
        select SUM((ME.PRECIO*CME.CANTIDAD) + C.PRECIO_TOTAL) INTO TotalDia
        from consulta c
        INNER JOIN consulta_medicamento CME on c.ID_CONSULTA = CME.ID_CONSULTA
        INNER JOIN medicamento ME on me.ID = CME.ID_MEDICAMENTO
        where EXTRACT(DAY FROM FECHA) = dia
        and EXTRACT(MONTH FROM FECHA) = mes
        and EXTRACT(YEAR FROM FECHA) = anio;
        return TotalDia;
        EXCEPTION WHEN OTHERS THEN
            DBMS_OUTPUT.put_line (SQLERRM);
    end;
  
    procedure imprimirMes(mes in NUMBER, anio in NUMBER)
    is
    begin
    
        IF  (mes>12) THEN
            DBMS_OUTPUT.put_line ('Mes no valido');
        ELSE
            dbms_output.put_line('las ventas del mes '|| mes ||' son: '|| ventaTotalMes(mes, anio));
        END IF;

        EXCEPTION WHEN OTHERS THEN
            DBMS_OUTPUT.put_line (SQLERRM);

    end;
    
    procedure imprimirAnio(anio in NUMBER)
    is
    begin
        dbms_output.put_line('las ventas del a o '|| anio ||' son: '|| ventaTotalAnio(anio));

        EXCEPTION WHEN OTHERS THEN
            DBMS_OUTPUT.put_line (SQLERRM);
    end;
    
    procedure imprimirDia(dia in NUMBER,mes in NUMBER, anio in NUMBER)
    is
    begin
    
        IF  (mes>12 OR dia>31) THEN
            DBMS_OUTPUT.put_line ('Mes no valido');
        ELSE
        dbms_output.put_line('las ventas del dia '|| dia ||' son: '|| ventaTotalDia(dia, mes, anio));
        END IF;
        
        EXCEPTION WHEN OTHERS THEN
            DBMS_OUTPUT.put_line (SQLERRM);
    end;
    
    procedure ventasTotales
    is
    TOTAL NUMBER;
    begin
        
        select sum((ME.PRECIO*CME.CANTIDAD) + C.PRECIO_TOTAL) INTO TOTAL
        from consulta c
        INNER JOIN consulta_medicamento CME on c.ID_CONSULTA = CME.ID_CONSULTA
        INNER JOIN medicamento ME on me.ID = CME.ID_MEDICAMENTO;
        
        dbms_output.put_line('Las ganancias totales fueron: ' || TOTAL );

        EXCEPTION WHEN OTHERS THEN
            DBMS_OUTPUT.put_line (SQLERRM);
    end;
    
    procedure ConsultasAnio(anio in number)
    is
    TOTAL NUMBER;
    begin
        
        select count(*) INTO TOTAL
        from consulta 
        where EXTRACT(YEAR FROM FECHA) = anio;
        
        dbms_output.put_line('La cantidad de consultas de el ano fueron: ' || TOTAL );

        EXCEPTION WHEN OTHERS THEN
            DBMS_OUTPUT.put_line (SQLERRM);
    end;
    
    procedure ConsultasMes(mes in NUMBER, anio in NUMBER)
    is
    TOTAL NUMBER;
    begin
    
        IF  (mes>12) THEN
            DBMS_OUTPUT.put_line ('Mes no valido');
        ELSE
            select count(*) INTO TOTAL
            from consulta 
            where EXTRACT(MONTH FROM FECHA) = mes
            and EXTRACT(YEAR FROM FECHA) = anio;
        
            dbms_output.put_line('Las ganancias totales del mes fueron: ' || TOTAL );
        end if;
        
        EXCEPTION WHEN OTHERS THEN
            DBMS_OUTPUT.put_line (SQLERRM);

    end;
    
    procedure ConsultasDia(dia in NUMBER,mes in NUMBER, anio in NUMBER)
    is
    TOTAL NUMBER;
    begin
        
        IF  (mes>12 OR dia>31) THEN
            DBMS_OUTPUT.put_line ('Mes o Dia no valido');
        ELSE
            select count(*) INTO TOTAL
            from consulta 
            where EXTRACT(Day FROM FECHA) = dia and
            EXTRACT(MONTH FROM FECHA) = mes
            and EXTRACT(YEAR FROM FECHA) = anio;
            
            dbms_output.put_line('Las ganancias totales del dia fueron: ' || TOTAL );
        END IF;


        EXCEPTION WHEN OTHERS THEN
            DBMS_OUTPUT.put_line (SQLERRM);
    end;
end consultas;

CREATE OR REPLACE PACKAGE actualizaciones AS
  PROCEDURE actualizar_propietario(email_in IN VARCHAR2, telefono_in IN VARCHAR2, nombre_in IN VARCHAR2, cedula_in IN NUMBER);
  PROCEDURE actualizar_especialidad(nombre_in IN VARCHAR2, id_especialidad_in IN NUMBER);
  PROCEDURE actualizar_especie(nombre_especie_in IN VARCHAR2, id_especie_in IN NUMBER);
  PROCEDURE actualizar_mascota(nombre_in IN VARCHAR2, especie_id_in IN NUMBER, raza_id_in IN NUMBER, edad_in IN NUMBER, peso_in IN NUMBER, id_propietario_in IN NUMBER, mascota_id_in IN NUMBER);
  PROCEDURE actualizar_medicamento(nombre_in IN VARCHAR2, precio_in IN NUMBER, id_medicamento_in IN NUMBER);
  PROCEDURE actualizar_raza(nombre_raza_in IN VARCHAR2, id_raza_in IN NUMBER);
  PROCEDURE actualizar_veterinario(nombre_veterinario_in IN VARCHAR2, id_veterinario_in IN NUMBER);
  PROCEDURE actualizar_veterinario_especialidad(id_especialidad_in IN NUMBER, id_veterinario_in IN NUMBER);
  FUNCTION contador_actualizaciones return number;
END actualizaciones;
/

CREATE OR REPLACE PACKAGE BODY actualizaciones AS

  PROCEDURE actualizar_propietario(email_in IN VARCHAR2, telefono_in IN VARCHAR2, nombre_in IN VARCHAR2, cedula_in IN NUMBER) AS
  CONT NUMBER;
  BEGIN
    UPDATE propietario SET EMAIL=email_in, TELEFONO=telefono_in, NOMBRE=nombre_in WHERE CEDULA=cedula_in;
    SELECT CONTADOR_UPDATES.NEXTVAL INTO CONT FROM DUAL;

    EXCEPTION WHEN OTHERS THEN
            DBMS_OUTPUT.put_line (SQLERRM);
  END;


  PROCEDURE actualizar_especialidad(nombre_in IN VARCHAR2, id_especialidad_in IN NUMBER) AS
  CONT NUMBER;
  BEGIN
    UPDATE especialidad SET NOMBRE_ESPECIALIDAD=nombre_in WHERE ID=id_especialidad_in;
    SELECT CONTADOR_UPDATES.NEXTVAL INTO CONT FROM DUAL;
    EXCEPTION WHEN OTHERS THEN
            DBMS_OUTPUT.put_line (SQLERRM);
  END;


  PROCEDURE actualizar_especie(nombre_especie_in IN VARCHAR2, id_especie_in IN NUMBER) AS
  CONT NUMBER;
  BEGIN
    UPDATE especie SET NOMBRE=nombre_especie_in WHERE ID=id_especie_in;
    SELECT CONTADOR_UPDATES.NEXTVAL INTO CONT FROM DUAL;
    EXCEPTION WHEN OTHERS THEN
            DBMS_OUTPUT.put_line (SQLERRM);
  END;


  PROCEDURE actualizar_mascota(nombre_in IN VARCHAR2, especie_id_in IN NUMBER, raza_id_in IN NUMBER, edad_in IN NUMBER, peso_in IN NUMBER, id_propietario_in IN NUMBER, mascota_id_in IN NUMBER) AS
  CONT NUMBER;
  BEGIN
    UPDATE mascota SET NOMBRE=nombre_in, ESPECIE_ID=especie_id_in, RAZA_ID=raza_id_in, EDAD=edad_in, PESO=peso_in, ID_PROPIETARIO=id_propietario_in WHERE ID=mascota_id_in;
    SELECT CONTADOR_UPDATES.NEXTVAL INTO CONT FROM DUAL;
    EXCEPTION WHEN OTHERS THEN
            DBMS_OUTPUT.put_line (SQLERRM);
  END;


  PROCEDURE actualizar_medicamento(nombre_in IN VARCHAR2, precio_in IN NUMBER, id_medicamento_in IN NUMBER) AS
  CONT NUMBER;
  BEGIN
    UPDATE medicamento SET NOMBRE=nombre_in, PRECIO=precio_in WHERE ID=id_medicamento_in;
    SELECT CONTADOR_UPDATES.NEXTVAL INTO CONT FROM DUAL;
    EXCEPTION WHEN OTHERS THEN
            DBMS_OUTPUT.put_line (SQLERRM);
  END;


  PROCEDURE actualizar_raza(nombre_raza_in IN VARCHAR2, id_raza_in IN NUMBER) AS
  CONT NUMBER;
  BEGIN
    UPDATE raza SET NOMBRE=nombre_raza_in WHERE ID=id_raza_in;
    SELECT CONTADOR_UPDATES.NEXTVAL INTO CONT FROM DUAL;
    EXCEPTION WHEN OTHERS THEN
            DBMS_OUTPUT.put_line (SQLERRM);
  END;


  PROCEDURE actualizar_veterinario(nombre_veterinario_in IN VARCHAR2, id_veterinario_in IN NUMBER) AS
  CONT NUMBER;
    BEGIN
        UPDATE veterinario SET NOMBRE=nombre_veterinario_in WHERE ID=id_veterinario_in;
        SELECT CONTADOR_UPDATES.NEXTVAL INTO CONT FROM DUAL;
        EXCEPTION WHEN OTHERS THEN
            DBMS_OUTPUT.put_line (SQLERRM);
    END;
    

    PROCEDURE actualizar_veterinario_especialidad(id_especialidad_in IN NUMBER, id_veterinario_in IN NUMBER) AS
    CONT NUMBER;
    BEGIN
        UPDATE veterinario_especialidad SET ID_ESPECIALIDAD=id_especialidad_in WHERE ID_VETERINARIO=id_veterinario_in;
        SELECT CONTADOR_UPDATES.NEXTVAL INTO CONT FROM DUAL;
        EXCEPTION WHEN OTHERS THEN
            DBMS_OUTPUT.put_line (SQLERRM);
    END;

    Function contador_actualizaciones return number
    is
    CONT NUMBER;
    begin
    SELECT CONTADOR_UPDATES.NEXTVAL INTO CONT FROM DUAL;
        RETURN CONT-1;
    end;

END actualizaciones;
/

CREATE TABLE Bitacora_medicamento (
  fecha DATE,
  hora TIMESTAMP,
  accion VARCHAR2(50),
  usuario VARCHAR2(50),
  id_medicamento NUMBER,
  valor_modificado VARCHAR2(255),
  valor_nuevo VARCHAR2(255)
);

CREATE OR REPLACE TRIGGER bitacora_medicamento_trigger
    AFTER INSERT OR UPDATE OR DELETE ON medicamento
    FOR EACH ROW
    DECLARE
      v_accion VARCHAR2(50);
    BEGIN
      IF INSERTING THEN
        v_accion := 'Medicamento Agregado';
        INSERT INTO bitacora_medicamento VALUES (SYSDATE, CURRENT_TIMESTAMP, v_accion, USER,:NEW.ID, NULL, NULL);
      ELSIF UPDATING THEN
        v_accion :='Medicamento Editado';
        IF UPDATING('NOMBRE') AND UPDATING('PRECIO') AND :OLD.NOMBRE != :NEW.NOMBRE AND :OLD.PRECIO != :NEW.PRECIO THEN
            INSERT INTO bitacora_medicamento VALUES (SYSDATE, CURRENT_TIMESTAMP, v_accion, USER,:OLD.ID, 'NOMBRE: '||:OLD.NOMBRE||' PRECIO: '||:OLD.PRECIO, 'NOMBRE: '||:NEW.NOMBRE||' PRECIO: '||:NEW.PRECIO);
        ELSIF UPDATING('NOMBRE') AND :OLD.NOMBRE != :NEW.NOMBRE THEN
            INSERT INTO bitacora_medicamento VALUES (SYSDATE, CURRENT_TIMESTAMP, v_accion, USER,:OLD.ID, :OLD.NOMBRE, :NEW.NOMBRE);
        ELSIF UPDATING('PRECIO') AND :OLD.PRECIO != :NEW.PRECIO THEN
            INSERT INTO bitacora_medicamento VALUES (SYSDATE, CURRENT_TIMESTAMP, v_accion, USER,:OLD.ID, :OLD.PRECIO, :NEW.PRECIO);
        END IF;
      ELSIF DELETING THEN
        v_accion := 'Medicamento Eliminado';
        INSERT INTO bitacora_medicamento VALUES (SYSDATE, CURRENT_TIMESTAMP, v_accion, USER,:OLD.ID, :OLD.NOMBRE, NULL);
      END IF;
            
END;

----------------------------DATOS DE PRUEBA------------------------------

INSERT INTO PROPIETARIO (CEDULA, EMAIL, TELEFONO, NOMBRE) VALUES 
(1234567890, 'ejemplo@ejemplo.com', 1234567890, 'Juan Perez');
INSERT INTO PROPIETARIO (CEDULA, EMAIL, TELEFONO, NOMBRE) VALUES 
(2345678901, 'ejemplo2@ejemplo.com', 2345678901, 'Maria Rodriguez');
INSERT INTO PROPIETARIO (CEDULA, EMAIL, TELEFONO, NOMBRE) VALUES 
(3456789012, 'ejemplo3@ejemplo.com', 3456789012, 'Pedro Gomez');
INSERT INTO PROPIETARIO (CEDULA, EMAIL, TELEFONO, NOMBRE) VALUES 
(4567890123, 'ejemplo4@ejemplo.com', 4567890123, 'Lucia Sanchez');
INSERT INTO PROPIETARIO (CEDULA, EMAIL, TELEFONO, NOMBRE) VALUES 
(5678901234, 'ejemplo5@ejemplo.com', 5678901234, 'Alejandro Torres');

INSERT INTO VETERINARIO (ID, NOMBRE) VALUES (001, 'Maria Gonzalez');
INSERT INTO VETERINARIO (ID, NOMBRE) VALUES (002, 'Pedro Ramirez');
INSERT INTO VETERINARIO (ID, NOMBRE) VALUES (003, 'Lucia Garcia');
INSERT INTO VETERINARIO (ID, NOMBRE) VALUES (004, 'Andres Sanchez');
INSERT INTO VETERINARIO (ID, NOMBRE) VALUES (005, 'Ana Torres');

INSERT INTO MEDICAMENTO (ID, NOMBRE, PRECIO) VALUES (1, 'Aspirina', 1000);
INSERT INTO MEDICAMENTO (ID, NOMBRE, PRECIO) VALUES (2, 'Ibuprofeno', 2000);
INSERT INTO MEDICAMENTO (ID, NOMBRE, PRECIO) VALUES (3, 'Paracetamol', 1500);
INSERT INTO MEDICAMENTO (ID, NOMBRE, PRECIO) VALUES (4, 'Diclofenaco', 3000);
INSERT INTO MEDICAMENTO (ID, NOMBRE, PRECIO) VALUES (5, 'Omeprazol', 2500);

INSERT INTO ESPECIE (ID, NOMBRE) VALUES (1, 'Perro');
INSERT INTO ESPECIE (ID, NOMBRE) VALUES (2, 'Gato');
INSERT INTO ESPECIE (ID, NOMBRE) VALUES (3, 'Conejo');
INSERT INTO ESPECIE (ID, NOMBRE) VALUES (4, 'Pez');
INSERT INTO ESPECIE (ID, NOMBRE) VALUES (5, 'Tortuga');

INSERT INTO RAZA (ID, NOMBRE) VALUES (1, 'Labrador Retriever');
INSERT INTO RAZA (ID, NOMBRE) VALUES (2, 'Bulldog');
INSERT INTO RAZA (ID, NOMBRE) VALUES (3, 'Pastor Aleman');
INSERT INTO RAZA (ID, NOMBRE) VALUES (4, 'Siames');
INSERT INTO RAZA (ID, NOMBRE) VALUES (5, 'Angora');
INSERT INTO RAZA (ID, NOMBRE) VALUES (6, 'Chihuahua');
INSERT INTO RAZA (ID, NOMBRE) VALUES (7, 'Schnauzer');
INSERT INTO RAZA (ID, NOMBRE) VALUES (8, 'Rotweiler');
INSERT INTO RAZA (ID, NOMBRE) VALUES (9, 'Golden Retriever');
INSERT INTO RAZA (ID, NOMBRE) VALUES (10, 'Dachshund');
INSERT INTO RAZA (ID, NOMBRE) VALUES (11, 'Sin raza');
INSERT INTO RAZA (ID, NOMBRE) VALUES (12, 'Siamese');
INSERT INTO RAZA (ID, NOMBRE) VALUES (13, 'Maine Coon');
INSERT INTO RAZA (ID, NOMBRE) VALUES (14, 'Persa');
INSERT INTO RAZA (ID, NOMBRE) VALUES (15, 'Bengali');
INSERT INTO RAZA (ID, NOMBRE) VALUES (16, 'somalí');
INSERT INTO RAZA (ID, NOMBRE) VALUES (17, 'Ragdoll');
INSERT INTO RAZA (ID, NOMBRE) VALUES (18, 'Tan');
INSERT INTO RAZA (ID, NOMBRE) VALUES (19, 'Rex');
INSERT INTO RAZA (ID, NOMBRE) VALUES (20, 'Blanco de Hotot');
INSERT INTO RAZA (ID, NOMBRE) VALUES (21, 'Belier');
INSERT INTO RAZA (ID, NOMBRE) VALUES (22, 'Cabeza de león');
INSERT INTO RAZA (ID, NOMBRE) VALUES (23, 'Periquitos');
INSERT INTO RAZA (ID, NOMBRE) VALUES (24, 'Canarios');
INSERT INTO RAZA (ID, NOMBRE) VALUES (25, 'Agapornis');
INSERT INTO RAZA (ID, NOMBRE) VALUES (26, 'Ninfas');
INSERT INTO RAZA (ID, NOMBRE) VALUES (27, 'Cotorras');
INSERT INTO RAZA (ID, NOMBRE) VALUES (28, 'Hámster');
INSERT INTO RAZA (ID, NOMBRE) VALUES (29, 'Cobaya');
INSERT INTO RAZA (ID, NOMBRE) VALUES (30, 'Raton');
INSERT INTO RAZA (ID, NOMBRE) VALUES (31, 'Ninfas');
INSERT INTO RAZA (ID, NOMBRE) VALUES (32, 'Chinchilla');

INSERT INTO MASCOTA (NOMBRE, ESPECIE_ID, RAZA_ID, ID, EDAD, PESO, ID_PROPIETARIO) VALUES ('Firulais', 1, 1, 1, 3, 8, 1234567890);
INSERT INTO MASCOTA (NOMBRE, ESPECIE_ID, RAZA_ID, ID, EDAD, PESO, ID_PROPIETARIO) VALUES ('Max', 2, 2, 2, 2, 12.3, 2345678901);
INSERT INTO MASCOTA (NOMBRE, ESPECIE_ID, RAZA_ID, ID, EDAD, PESO, ID_PROPIETARIO) VALUES ('Toby', 3, 3, 3, 1, 3.8, 3456789012);
INSERT INTO MASCOTA (NOMBRE, ESPECIE_ID, RAZA_ID, ID, EDAD, PESO, ID_PROPIETARIO) VALUES ('Luna', 4, 4, 4, 4, 5.6, 4567890123);

INSERT INTO CONSULTA (FECHA, PRECIO_TOTAL, ID_CONSULTA, DIAGNOSTICO) VALUES (TO_DATE('2023/03/18', 'yyyy/mm/dd'), 1000, 1, 'Gripe');
INSERT INTO CONSULTA (FECHA, PRECIO_TOTAL, ID_CONSULTA, DIAGNOSTICO) VALUES (TO_DATE('2023/03/19', 'yyyy/mm/dd'), 2000, 2, 'Herida infectada');
INSERT INTO CONSULTA (FECHA, PRECIO_TOTAL, ID_CONSULTA, DIAGNOSTICO) VALUES (TO_DATE('2023/03/20', 'yyyy/mm/dd'), 1500, 3, 'Diarrea');

INSERT INTO CONSULTA_MEDICAMENTO (ID_CONSULTA, ID_MEDICAMENTO, CANTIDAD) VALUES (1, 1, 2);
INSERT INTO CONSULTA_MEDICAMENTO (ID_CONSULTA, ID_MEDICAMENTO, CANTIDAD) VALUES (2, 2, 1);
INSERT INTO CONSULTA_MEDICAMENTO (ID_CONSULTA, ID_MEDICAMENTO, CANTIDAD) VALUES (3, 3, 3);

INSERT INTO ESPECIALIDAD (ID, NOMBRE_ESPECIALIDAD) VALUES (1, 'Cirugia');
INSERT INTO ESPECIALIDAD (ID, NOMBRE_ESPECIALIDAD) VALUES (2, 'Dermatologia');
INSERT INTO ESPECIALIDAD (ID, NOMBRE_ESPECIALIDAD) VALUES (3, 'Oftalmologia');
INSERT INTO ESPECIALIDAD (ID, NOMBRE_ESPECIALIDAD) VALUES (4, 'Oncologia');
INSERT INTO ESPECIALIDAD (ID, NOMBRE_ESPECIALIDAD) VALUES (5, 'Cardiologia');

INSERT INTO CONSULTA_MASCOTA (ID_MASCOTA, ID_CONSULTA) VALUES (1, 1);
INSERT INTO CONSULTA_MASCOTA (ID_MASCOTA, ID_CONSULTA) VALUES (2, 2);
INSERT INTO CONSULTA_MASCOTA (ID_MASCOTA, ID_CONSULTA) VALUES (3, 3);

INSERT INTO CONSULTA_VETERINARIO (ID_CONSULTA, ID_VETERINARIO)  VALUES (1, 2);
INSERT INTO CONSULTA_VETERINARIO (ID_CONSULTA, ID_VETERINARIO)  VALUES (2, 1);
INSERT INTO CONSULTA_VETERINARIO (ID_CONSULTA, ID_VETERINARIO)  VALUES (3, 3);

INSERT INTO VETERINARIO_ESPECIALIDAD (ID_ESPECIALIDAD, ID_VETERINARIO)  VALUES (1, 1);
INSERT INTO VETERINARIO_ESPECIALIDAD (ID_ESPECIALIDAD, ID_VETERINARIO)  VALUES (2, 2);
INSERT INTO VETERINARIO_ESPECIALIDAD (ID_ESPECIALIDAD, ID_VETERINARIO)  VALUES (3, 3);
INSERT INTO VETERINARIO_ESPECIALIDAD (ID_ESPECIALIDAD, ID_VETERINARIO)  VALUES (4, 4);
INSERT INTO VETERINARIO_ESPECIALIDAD (ID_ESPECIALIDAD, ID_VETERINARIO)  VALUES (5, 5);

--------------------------------------------------------------------------------

--------Asi es como se despliega la tabla de las mascotas--------------------
Select M.ID, M.NOMBRE, M.EDAD, M.PESO, E.NOMBRE AS ESPECIE, R.NOMBRE AS RAZA, M.ID_PROPIETARIO
    FROM MASCOTA M INNER JOIN RAZA R ON M.RAZA_ID = R.ID 
    INNER JOIN ESPECIE E ON M.ESPECIE_ID = E.ID;
    
--------Asi es como se despliega la tabla de los veterinarios----------------
Select V.ID, V.NOMBRE, E.NOMBRE_ESPECIALIDAD
    FROM VETERINARIO V INNER JOIN VETERINARIO_ESPECIALIDAD VE ON V.ID = VE.ID_VETERINARIO 
    INNER JOIN ESPECIALIDAD E ON VE.ID_ESPECIALIDAD = E.ID;
    
--------Asi es como se despliega la tabla de las consultas---------------
select c.ID_CONSULTA, c.fecha,v.nombre AS VETERINARIO , M.nombre AS MASCOTA ,M.ID,M.ID_PROPIETARIO, c.diagnostico, ME.NOMBRE AS MEDICAMENTO, CME.CANTIDAD, ((ME.PRECIO*CME.CANTIDAD) + C.PRECIO_TOTAL) AS TOTAL  from consulta c 
    INNER JOIN consulta_veterinario cv on c.ID_CONSULTA = cv.ID_CONSULTA
    INNER JOIN consulta_mascota cm ON c.ID_CONSULTA = cm.ID_CONSULTA
    INNER JOIN consulta_medicamento CME on c.ID_CONSULTA = CME.ID_CONSULTA
    INNER JOIN mascota M on M.ID = cm.ID_MASCOTA
    INNER JOIN veterinario v on v.id = cv.ID_VETERINARIO
    INNER JOIN medicamento ME on me.ID = CME.ID_MEDICAMENTO;

--Drop sequence secuencia_veterinario;
--Drop sequence secuencia_medicamento;
--Drop sequence secuencia_consulta;
--Drop sequence secuencia_mascota;
--Drop sequence secuencia_raza;
--Drop sequence secuencia_especie;
--Drop sequence secuencia_especialidad;