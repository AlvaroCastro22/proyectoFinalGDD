CREATE PROCEDURE ActualizarPesoPaciente
   
    @DNI VARCHAR(8),
    @peso DECIMAL(5,2)
AS
BEGIN
    UPDATE Paciente
    SET peso = @peso
    WHERE   DNI = @DNI;
END;

CREATE PROCEDURE ActualizarTelefono
    @DNI VARCHAR(8),
    @nuevo_telefono VARCHAR(15)
AS
BEGIN
    UPDATE datos_personales
    SET Telefono = @nuevo_telefono
    WHERE DNI = @DNI;
END;

EXEC ActualizarTelefono 
    @DNI = '12345678',           
    @nuevo_telefono = '987654321'; 



CREATE PROCEDURE ReprogramarActividadMedica
    @id_actividad_medica INT,
    @nueva_fecha DATE,
    @nueva_hora TIME
AS
BEGIN
    UPDATE Actividad_Medica
    SET fecha = @nueva_fecha,
        hora = @nueva_hora
    WHERE id_actividad_medica = @id_actividad_medica;
END;
