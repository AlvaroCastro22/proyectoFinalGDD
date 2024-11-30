CREATE PROCEDURE ActualizarPesoPaciente
   
    @DNI VARCHAR(8),
    @peso DECIMAL(5,2)
AS
BEGIN
    UPDATE Paciente
    SET peso = @peso
    WHERE   DNI = @DNI;
END;

select * from datos_personales;

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

CREATE FUNCTION CalcularIMC(@peso DECIMAL(5,2), @altura DECIMAL(3,2))
RETURNS DECIMAL(10,2)
AS
BEGIN
    RETURN @peso / (@altura * @altura)
END;
select dbo.CalcularIMC(peso,altura) AS IMC from Paciente;

CREATE FUNCTION ObtenerEdadPaciente(@fecha_nacimiento DATE)
RETURNS INT
AS
BEGIN
    RETURN DATEDIFF(YEAR, @fecha_nacimiento, GETDATE()) 
           - CASE 
               WHEN MONTH(GETDATE()) < MONTH(@fecha_nacimiento)
                 OR (MONTH(GETDATE()) = MONTH(@fecha_nacimiento) AND DAY(GETDATE()) < DAY(@fecha_nacimiento))
               THEN 1 
               ELSE 0 
             END;
END;



CREATE FUNCTION PacienteEsMayorDeEdad(@fecha_nacimiento DATE)
RETURNS varchar(20)
AS
BEGIN
    DECLARE @edad INT;

    SET @edad = dbo.ObtenerEdadPaciente(@fecha_nacimiento);

    
    RETURN CASE 
               WHEN @edad >= 18 THEN 'mayor de edad'  
               ELSE 'menor de edad'
           END;
END;



CREATE TRIGGER RecalcularTotalTrigger
ON MedicamentosRecetados
FOR UPDATE
AS
BEGIN
    DECLARE @id_Paciente INT;
    -- Obtener el id_Paciente del registro insertado (o actualizado)
    SELECT @id_Paciente = id_Paciente FROM inserted;

    -- Actualizar el total en la tabla CostoTotal para el paciente afectado
    UPDATE CostoTotal
    SET total = (
        SELECT SUM(precio)
        FROM MedicamentosRecetados
        WHERE id_Paciente = @id_Paciente
    )
    WHERE id_Paciente = @id_Paciente;
END;
CREATE VIEW Vista_Pacientes_Historial AS
SELECT 
    P.id_Paciente,
    DP.Nombre,
    DP.DNI,
    DP.fecha_nacimiento,
    DP.Telefono,
    HC.id_Historial,
    HC.fecha_inicio
FROM 
    Paciente P
    INNER JOIN datos_personales DP ON P.DNI = DP.DNI
    LEFT JOIN Historial_Clinico HC ON P.id_Paciente = HC.id_Paciente;


CREATE VIEW Vista_Actividades_Programadas AS
SELECT 
    DP.Nombre AS Paciente,
    AM.id_actividad_medica AS ID_Actividad,
    AM.fecha AS Fecha,
    AM.hora AS Hora,
    S.estado_sala AS Sala,
    EM.turno_trabajo AS Equipo
FROM 
    Actividad_Medica AM
    INNER JOIN Sala S ON AM.id_Sala = S.id_sala
    INNER JOIN Equipo_medico EM ON AM.idEquipo = EM.id_Equipo
    INNER JOIN Paciente P ON AM.id_Paciente = P.id_Paciente
    INNER JOIN datos_personales DP ON P.DNI = DP.DNI;

CREATE VIEW Vista_Recetas_Medicamentos AS
SELECT 
    RM.id_receta,
    IM.descripcion AS Informe_Medico,
    M.nombre_medicamento,
    DR.dosis,
    DR.frecuencia
FROM 
    Receta_Medica RM
    INNER JOIN Informe_Medico IM ON RM.id_informe = IM.id_informe
    INNER JOIN Detalles_Receta DR ON RM.id_receta = DR.id_receta
    INNER JOIN Medicamento M ON DR.id_medicamento = M.id_medicamento;


CREATE VIEW Vista_Facturas_Pendientes AS
SELECT 
    DP.Nombre AS Paciente,
    F.id_Factura,
    F.costo_por_servicio,
    F.fecha_emision,
    F.estado_factura
FROM 
    Factura F
    INNER JOIN Paciente P ON F.id_Paciente = P.id_Paciente
    INNER JOIN datos_personales DP ON P.DNI = DP.DNI
WHERE 
    F.estado_factura = 'Pendiente';
