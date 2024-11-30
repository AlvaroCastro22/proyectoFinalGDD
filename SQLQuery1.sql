create table Paciente(
id_Paciente INT,
DNI varchar(8),
peso DECIMAL(5,2),
altura DECIMAL(3,2),
primary key (id_Paciente,DNI),
CONSTRAINT UQ_DNI UNIQUE (DNI),
CONSTRAINT UQ_Id UNIQUE (id_Paciente)
);
CREATE TABLE Sedes (
    id_sede INT primary key,  -- Primary Key
    ubicacion_sede VARCHAR(100),
	distrito varchar(100),
	departamento varchar(100)
	
);
create table datos_personales(
	DNI VARCHAR(8) primary key,
    Nombre VARCHAR(100),
    fecha_nacimiento DATE not null,
   Telefono VARCHAR(15),
   CONSTRAINT FK_Paciente_datos_personales FOREIGN KEY (DNI) REFERENCES Paciente(DNI) 
)

CREATE TABLE Historial_Clinico (
    id_Historial INT PRIMARY KEY,  -- Primary Key
    id_Paciente INT,
	fecha_inicio Date not null,
    FOREIGN KEY (id_Paciente) REFERENCES Paciente(id_Paciente)
);


CREATE TABLE Analisis_Laboratorio (
    id_analisis INT PRIMARY KEY,  -- Primary Key
    fecha_de_prueba DATE not null,
    tipo_de_examen VARCHAR(100) not null,
    fecha_envio_resultados DATE null,
    estado VARCHAR(50) not null
);


CREATE TABLE Informe_Medico (
    id_informe INT PRIMARY KEY,  -- Primary Key
    id_analisis INT,  -- Foreign Key
	id_Historial int,
	descripcion varchar(255) null,
    FOREIGN KEY (id_analisis) REFERENCES Analisis_Laboratorio(id_analisis),
	Foreign key (id_Historial) REFERENCES Historial_Clinico(id_Historial)
);

Create table Factura(
id_Factura int primary key,
estado_factura varchar(12),
costo_por_servicio int,
fecha_emision Date,
id_informe int,
id_Paciente int,
	CONSTRAINT FK_Factura_Informe FOREIGN KEY (id_informe) REFERENCES Informe_Medico(id_informe),
	CONSTRAINT FK_Factura_Paciente FOREIGN KEY (id_Paciente) REFERENCES Paciente(id_Paciente)
);

CREATE TABLE Receta_Medica (
    id_receta INT PRIMARY KEY,  -- Primary Key
    id_informe INT,  -- Foreign Key
	fecha_Emision Date not null,
    FOREIGN KEY (id_informe) REFERENCES Informe_Medico(id_informe)
);


CREATE TABLE Medicamento (
    id_medicamento INT PRIMARY KEY,  -- Primary Key
    nombre_medicamento VARCHAR(100) not null,
    descripcion TEXT null,
	stock int not null
);


CREATE TABLE Detalles_Receta (
    id_receta INT,  -- Foreign Key
    id_medicamento INT,  -- Foreign Key
	dosis varchar(50) not null,
	frecuencia varchar(50) not null,
    PRIMARY KEY (id_receta, id_medicamento),  -- Composite Primary Key
    FOREIGN KEY (id_receta) REFERENCES Receta_Medica(id_receta),
    FOREIGN KEY (id_medicamento) REFERENCES Medicamento(id_medicamento)
);

CREATE TABLE Sala (
    id_sala INT PRIMARY KEY,  -- Primary Key
    id_sede INT,  -- Foreign Key
    tipo_sala VARCHAR(50),
    CONSTRAINT FK_Sala_Sedes FOREIGN KEY (id_sede) REFERENCES Sedes(id_sede)
);
CREATE TABLE Sala_operaciones(
	id_sala int primary key,
	sala_esteril bit not null,

	foreign key (id_sala) references Sala(id_sala)
);
CREATE TABLE Sala_consulta(
	id_sala int primary key,
	tipo_Consulta varchar(10) not null,

	foreign key (id_sala) references Sala(id_sala)
);

CREATE TABLE Medico (
    id_medico INT PRIMARY KEY,  -- Primary Key
    nombre_medico VARCHAR(100) not null,
    especialidad VARCHAR(100) not null,
	colegiatura varchar(50) not null,
	grado_estudios varchar(50) not null
);


CREATE TABLE Enfermera (
    id_enfermero INT PRIMARY KEY,  -- Primary Key
    nombre_enfermera VARCHAR(100) not null,
    especialidad VARCHAR(100) not null,
	colegiatura varchar(50) not null,
	grado_estudios varchar(50) not null
);


CREATE TABLE Equipo_medico (
    id_medico INT,  -- Foreign Key
    id_enfermero INT,  -- Foreign Key
	turno_trabajo varchar(20) not null,
	fecha_formacion Date not null,
    PRIMARY KEY (id_medico, id_enfermero),  -- Composite Primary Key
    FOREIGN KEY (id_medico) REFERENCES Medico(id_medico),
    FOREIGN KEY (id_enfermero) REFERENCES Enfermera(id_enfermero),
	CONSTRAINT UQ_medico UNIQUE (id_medico),
	CONSTRAINT UQ_enfermero UNIQUE (id_enfermero)
);

CREATE TABLE Actividad_Medica (
    id_actividad_medica INT PRIMARY KEY,  -- Primary Key
    id_Paciente INT,  -- Foreign Key
	id_Sala INT, --Foreign Key
	id_Informe int,
    fecha DATE,
    hora TIME,
	idMedico int not null,
	idEnfermera int not null
	CONSTRAINT FK_Actividad_Medica_Informe Foreign key (id_Informe) references Informe_Medico(id_Informe),
    CONSTRAINT FK_Actividad_Medica_Paciente FOREIGN KEY (id_Paciente) REFERENCES Paciente(id_Paciente),
	CONSTRAINT FK_Actividad_Medica_Sala Foreign key (id_Sala) REFERENCES Sala(id_Sala),
	foreign key(idMedico) references Equipo_medico(id_medico),
	foreign key(idEnfermera) references Equipo_medico(id_enfermero)
);


CREATE TABLE Cita (
    id_actividad_medica INT PRIMARY KEY,  -- Primary Key
    
    especialidad VARCHAR(100) not null,
    FOREIGN KEY (id_actividad_medica) REFERENCES Actividad_Medica(id_actividad_medica)
);


CREATE TABLE Operacion (
    id_actividad_medica INT PRIMARY KEY,  -- Primary Key
    
    tipo_cirugia VARCHAR(100) not null,
    duracion TIME null,
    FOREIGN KEY (id_actividad_medica) REFERENCES Actividad_Medica(id_actividad_medica)
);

CREATE TABLE Emergencia (
    id_actividad_medica INT PRIMARY KEY,  -- Primary Key
    motivo varchar(50) not null,
    FOREIGN KEY (id_actividad_medica) REFERENCES Actividad_Medica(id_actividad_medica)
);


INSERT INTO Paciente (id_Paciente, DNI, peso) VALUES (1, '12345678', 65.50,1.75);
INSERT INTO Paciente (id_Paciente, DNI, peso) VALUES (2, '87654321', 72.30,1.80);
INSERT INTO Paciente (id_Paciente, DNI, peso) VALUES (3, '11223344', 80.25,1.53);
INSERT INTO Paciente (id_Paciente, DNI, peso) VALUES (4, '44332211', 58.40,1.75);
INSERT INTO Paciente (id_Paciente, DNI, peso) VALUES (5, '99887766', 90.00,1.73);
INSERT INTO Sedes (id_sede, ubicacion_sede, distrito, departamento) 
VALUES (1, 'Av. Gregorio Escobedo 783', 'Jesus Maria', 'Lima');

INSERT INTO datos_personales (DNI, Nombre, fecha_nacimiento, Telefono) 
VALUES ('12345678', 'Juan P�rez', '1985-05-12', '987654321');

INSERT INTO datos_personales (DNI, Nombre, fecha_nacimiento, Telefono) 
VALUES ('87654321', 'Mar�a G�mez', '1992-11-23', '912345678');

INSERT INTO datos_personales (DNI, Nombre, fecha_nacimiento, Telefono) 
VALUES ('11223344', 'Carlos Fern�ndez', '1978-03-09', '998877665');

INSERT INTO datos_personales (DNI, Nombre, fecha_nacimiento, Telefono) 
VALUES ('44332211', 'Ana Mart�nez', '2000-07-15', '934567890');

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
VALUES (2, '2024-11-10', 'Perfil lip�dico', '2024-11-15', 'Completado');

INSERT INTO Analisis_Laboratorio (id_analisis, fecha_de_prueba, tipo_de_examen, fecha_envio_resultados, estado) 
VALUES (3, '2024-11-20', 'Prueba de glucosa', NULL, 'Pendiente');

INSERT INTO Analisis_Laboratorio (id_analisis, fecha_de_prueba, tipo_de_examen, fecha_envio_resultados, estado) 
VALUES (4, '2024-11-25', 'Funci�n hep�tica', NULL, 'En Proceso');

INSERT INTO Analisis_Laboratorio (id_analisis, fecha_de_prueba, tipo_de_examen, fecha_envio_resultados, estado) 
VALUES (5, '2024-10-30', 'Examen de orina', '2024-11-02', 'Completado');

INSERT INTO Informe_Medico (id_informe, id_analisis, id_Historial, descripcion) 
VALUES (1, 1, 1, 'Hemograma completo muestra valores normales.');

INSERT INTO Informe_Medico (id_informe, id_analisis, id_Historial, descripcion) 
VALUES (2, 2, 2, 'Perfil lip�dico indica niveles elevados de colesterol.');

INSERT INTO Informe_Medico (id_informe, id_analisis, id_Historial, descripcion) 
VALUES (3, 3, 3, 'Prueba de glucosa a�n pendiente de resultados.');

INSERT INTO Informe_Medico (id_informe, id_analisis, id_Historial, descripcion) 
VALUES (4, 4, 4, 'Funci�n hep�tica presenta indicadores dentro del rango normal.');

INSERT INTO Informe_Medico (id_informe, id_analisis, id_Historial, descripcion) 
VALUES (5, 5, 5, 'Examen de orina muestra rastros de infecci�n.');

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
(2, 'Ibuprofeno', 'Antiinflamatorio y analg�sico', 30),
(3, 'Amoxicilina', 'Antibi�tico de amplio espectro', 20),
(4, 'Loratadina', 'Antihistam�nico para alergias', 15),
(5, 'Omeprazol', 'Protector g�strico para acidez', 40),
(6, 'Metformina', 'Tratamiento para la diabetes tipo 2', 25),
(7, 'Aspirina', 'Reduce dolor, fiebre e inflamaci�n', 60),
(8, 'Clorfenamina', 'Alivia s�ntomas de alergias', 10),
(9, 'Salbutamol', 'Broncodilatador para el asma', 35),
(10, 'Ciprofloxacino', 'Antibi�tico para infecciones bacterianas', 18);

INSERT INTO Detalles_Receta (id_receta, id_medicamento, dosis, frecuencia) 
VALUES 
(1, 1, '500 mg', 'Cada 8 horas'),
(1, 2, '200 mg', 'Cada 12 horas'),
(2, 3, '1 c�psula', 'Cada 6 horas'),
(3, 4, '10 ml', 'Una vez al d�a'),
(4, 5, '20 mg', 'Cada 24 horas');

select * from Sala;
EXEC sp_rename 'Sala.tipo_sala', 'estado_sala', 'COLUMN';
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
(6, 'Pediatr�a'),  
(7, 'Urgencias'),  
(9, 'Cirug�a'); 


INSERT INTO Medico (id_medico, nombre_medico, especialidad, colegiatura, grado_estudios) 
VALUES 
(1, 'Dr. Luis Fern�ndez', 'Cardiolog�a', 'M12345', 'Licenciatura'),
(2, 'Dra. Marta G�mez', 'Cirug�a', 'M23456', 'Licenciatura'),
(3, 'Dr. Roberto P�rez', 'Neurolog�a', 'M34567', 'Maestr�a'),
(4, 'Dra. Patricia Ruiz', 'Pediatr�a', 'M45678', 'Licenciatura'),
(5, 'Dr. Jos� Mart�nez', 'Traumatolog�a', 'M56789', 'Especialidad'),
(6, 'Dra. Ana L�pez', 'Oncolog�a', 'M67890', 'Maestr�a');

INSERT INTO Enfermera (id_enfermero, nombre_enfermera, especialidad, colegiatura, grado_estudios) 
VALUES 
(1, 'Ana Garc�a', 'Pediatr�a', 'E12345', 'Licenciatura'),
(2, 'Carlos L�pez', 'Quir�fano', 'E23456', 'Licenciatura'),
(3, 'Laura Mart�nez', 'Urgencias', 'E34567', 'Licenciatura'),
(4, 'Juan P�rez', 'Rehabilitaci�n', 'E45678', 'T�cnico'),
(5, 'Marta S�nchez', 'Oncolog�a', 'E56789', 'Licenciatura'),
(6, 'Elena Rodr�guez', 'Cuidados Intensivos', 'E67890', 'Maestr�a');

