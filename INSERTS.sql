
use pruebaTrabajo;


EXEC sp_rename 'Sala.tipo_sala', 'estado_sala', 'COLUMN';

INSERT INTO Paciente (id_Paciente, DNI, peso) VALUES (1, '12345678', 65.50);
INSERT INTO Paciente (id_Paciente, DNI, peso) VALUES (2, '87654321', 72.30);
INSERT INTO Paciente (id_Paciente, DNI, peso) VALUES (3, '11223344', 80.25);
INSERT INTO Paciente (id_Paciente, DNI, peso) VALUES (4, '44332211', 58.40);
INSERT INTO Paciente (id_Paciente, DNI, peso) VALUES (5, '99887766', 90.00);
INSERT INTO Sedes (id_sede, ubicacion_sede, distrito, departamento) 
VALUES (1, 'Av. Gregorio Escobedo 783', 'Jesus Maria', 'Lima');

INSERT INTO datos_personales (DNI, Nombre, fecha_nacimiento, Telefono) 
VALUES ('12345678', 'Juan Pérez', '1985-05-12', '987654321');

INSERT INTO datos_personales (DNI, Nombre, fecha_nacimiento, Telefono) 
VALUES ('87654321', 'María Gómez', '1992-11-23', '912345678');

INSERT INTO datos_personales (DNI, Nombre, fecha_nacimiento, Telefono) 
VALUES ('11223344', 'Carlos Fernández', '1978-03-09', '998877665');

INSERT INTO datos_personales (DNI, Nombre, fecha_nacimiento, Telefono) 
VALUES ('44332211', 'Ana Martínez', '2000-07-15', '934567890');

INSERT INTO datos_personales (DNI, Nombre, fecha_nacimiento, Telefono) 
VALUES ('99887766', 'Luisa Castro', '1989-02-27', '911223344');

INSERT INTO Historial_Clinico (id_Historial, id_Paciente, fecha_inicio) 
VALUES (1, 1, '2023-01-15');

INSERT INTO Historial_Clinico (id_Historial, id_Paciente, fecha_inicio) 
VALUES (2, 2, '2022-06-10');

INSERT INTO Historial_Clinico (id_Historial, id_Paciente, fecha_inicio) 
VALUES (3, 3, '2021-11-20');

INSERT INTO Historial_Clinico (id_Historial, id_Paciente, fecha_inicio) 
VALUES (4, 4, '2020-08-05');

INSERT INTO Historial_Clinico (id_Historial, id_Paciente, fecha_inicio) 
VALUES (5, 5, '2019-04-12');

INSERT INTO Analisis_Laboratorio (id_analisis, fecha_de_prueba, tipo_de_examen, fecha_envio_resultados, estado) 
VALUES (1, '2024-11-01', 'Hemograma completo', '2024-11-05', 'Completado');

INSERT INTO Analisis_Laboratorio (id_analisis, fecha_de_prueba, tipo_de_examen, fecha_envio_resultados, estado) 
VALUES (2, '2024-11-10', 'Perfil lipídico', '2024-11-15', 'Completado');

INSERT INTO Analisis_Laboratorio (id_analisis, fecha_de_prueba, tipo_de_examen, fecha_envio_resultados, estado) 
VALUES (3, '2024-11-20', 'Prueba de glucosa', NULL, 'Pendiente');

INSERT INTO Analisis_Laboratorio (id_analisis, fecha_de_prueba, tipo_de_examen, fecha_envio_resultados, estado) 
VALUES (4, '2024-11-25', 'Función hepática', NULL, 'En Proceso');

INSERT INTO Analisis_Laboratorio (id_analisis, fecha_de_prueba, tipo_de_examen, fecha_envio_resultados, estado) 
VALUES (5, '2024-10-30', 'Examen de orina', '2024-11-02', 'Completado');

INSERT INTO Informe_Medico (id_informe, id_analisis, id_Historial, descripcion) 
VALUES (1, 1, 1, 'Hemograma completo muestra valores normales.');

INSERT INTO Informe_Medico (id_informe, id_analisis, id_Historial, descripcion) 
VALUES (2, 2, 2, 'Perfil lipídico indica niveles elevados de colesterol.');

INSERT INTO Informe_Medico (id_informe, id_analisis, id_Historial, descripcion) 
VALUES (3, 3, 3, 'Prueba de glucosa aún pendiente de resultados.');

INSERT INTO Informe_Medico (id_informe, id_analisis, id_Historial, descripcion) 
VALUES (4, 4, 4, 'Función hepática presenta indicadores dentro del rango normal.');

INSERT INTO Informe_Medico (id_informe, id_analisis, id_Historial, descripcion) 
VALUES (5, 5, 5, 'Examen de orina muestra rastros de infección.');

INSERT INTO Factura (id_Factura, estado_factura, costo_por_servicio, fecha_emision, id_informe, id_Paciente) 
VALUES 
(1, 'Pagado', 250, '2024-11-01', 1, 1),
(2, 'Pendiente', 400, '2024-11-05', 2, 2),
(3, 'Pagado', 300, '2024-11-10', 3, 3),
(4, 'Pagado', 150, '2024-11-15', 4, 4),
(5, 'Pendiente', 500, '2024-11-20', 5, 5);

INSERT INTO Receta_Medica (id_receta, id_informe, fecha_emision) 
VALUES 
(1, 1, '2024-11-02'),
(2, 2, '2024-11-06'),
(3, 3, '2024-11-11'),
(4, 4, '2024-11-16'),
(5, 5, '2024-11-21');

INSERT INTO Medicamento (id_medicamento, nombre_medicamento, descripcion, stock) 
VALUES 
(1, 'Paracetamol', 'Alivia el dolor y reduce la fiebre', 50),
(2, 'Ibuprofeno', 'Antiinflamatorio y analgésico', 30),
(3, 'Amoxicilina', 'Antibiótico de amplio espectro', 20),
(4, 'Loratadina', 'Antihistamínico para alergias', 15),
(5, 'Omeprazol', 'Protector gástrico para acidez', 40),
(6, 'Metformina', 'Tratamiento para la diabetes tipo 2', 25),
(7, 'Aspirina', 'Reduce dolor, fiebre e inflamación', 60),
(8, 'Clorfenamina', 'Alivia síntomas de alergias', 10),
(9, 'Salbutamol', 'Broncodilatador para el asma', 35),
(10, 'Ciprofloxacino', 'Antibiótico para infecciones bacterianas', 18);

INSERT INTO Detalles_Receta (id_receta, id_medicamento, dosis, frecuencia) 
VALUES 
(1, 1, '500 mg', 'Cada 8 horas'),
(1, 2, '200 mg', 'Cada 12 horas'),
(2, 3, '1 cápsula', 'Cada 6 horas'),
(3, 4, '10 ml', 'Una vez al día'),
(4, 5, '20 mg', 'Cada 24 horas');


INSERT INTO Sala (id_sala, id_sede, estado_sala) 
VALUES 
(1, 1, 'disponible'),
(2, 1, 'ocupada'),
(3, 1, 'disponible'),
(4, 1, 'ocupada'),
(5, 1, 'disponible'),
(6, 1, 'ocupada'),
(7, 1, 'disponible'),
(8, 1, 'ocupada'),
(9, 1, 'disponible'),
(10, 1, 'ocupada');

INSERT INTO Sala_operaciones (id_sala, sala_esteril) 
VALUES 
(3, 1),  
(5, 0),  
(10, 0),  
(1, 0),  
(8, 1); 

INSERT INTO Sala_consulta (id_sala, tipo_Consulta) 
VALUES 
(2, 'General'),     
(4, 'Urgencias'),  
(6, 'Pediatría'),  
(7, 'Urgencias'),  
(9, 'Cirugía'); 


INSERT INTO Medico (id_medico, nombre_medico, especialidad, colegiatura, grado_estudios) 
VALUES 
(1, 'Dr. Luis Fernández', 'Cardiología', 'M12345', 'Licenciatura'),
(2, 'Dra. Marta Gómez', 'Cirugía', 'M23456', 'Licenciatura'),
(3, 'Dr. Roberto Pérez', 'Neurología', 'M34567', 'Maestría'),
(4, 'Dra. Patricia Ruiz', 'Pediatría', 'M45678', 'Licenciatura'),
(5, 'Dr. José Martínez', 'Traumatología', 'M56789', 'Especialidad'),
(6, 'Dra. Ana López', 'Oncología', 'M67890', 'Maestría');

INSERT INTO Enfermera (id_enfermero, nombre_enfermera, especialidad, colegiatura, grado_estudios) 
VALUES 
(1, 'Ana García', 'Pediatría', 'E12345', 'Licenciatura'),
(2, 'Carlos López', 'Quirófano', 'E23456', 'Licenciatura'),
(3, 'Laura Martínez', 'Urgencias', 'E34567', 'Licenciatura'),
(4, 'Juan Pérez', 'Rehabilitación', 'E45678', 'Técnico'),
(5, 'Marta Sánchez', 'Oncología', 'E56789', 'Licenciatura'),
(6, 'Elena Rodríguez', 'Cuidados Intensivos', 'E67890', 'Maestría');