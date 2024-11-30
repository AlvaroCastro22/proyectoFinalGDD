create database pruebaTrabajo;
use pruebaTrabajo;

create table Paciente(
id_Paciente INT,
DNI varchar(8),
peso DECIMAL(5,2),
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



CREATE TABLE Enfermero (
    id_enfermero INT PRIMARY KEY,  -- Primary Key
    nombre_enfermera VARCHAR(100) not null,
    especialidad VARCHAR(100) not null,
	colegiatura varchar(50) not null,
	grado_estudios varchar(50) not null
);
CREATE TABLE Equipo_medico (
    id_Equipo INT  PRIMARY KEY , 
    
	turno_trabajo varchar(20) not null,
	fecha_formacion Date not null,
    
);
CREATE TABLE AsignacionMedicoEquipo (
    id_equipo_medico INT, 
    id_medico INT,
    PRIMARY KEY (id_equipo_medico, id_medico),
    CONSTRAINT FK_AsignacionMedicoEquipo_EquipoMedico FOREIGN KEY (id_equipo_medico) 
    REFERENCES Equipo_medico(id_Equipo),
    CONSTRAINT FK_AsignacionMedicoEquipo_Medico FOREIGN KEY (id_medico) 
    REFERENCES Medico(id_medico)
);
CREATE TABLE AsignacionEnfermeroEquipo (
    id_equipo_medico INT, 
    id_enfermero INT,
    PRIMARY KEY (id_equipo_medico, id_enfermero),
    CONSTRAINT FK_AsignacionEnfermeroEquipo_EquipoMedico FOREIGN KEY (id_equipo_medico) 
    REFERENCES Equipo_medico(id_Equipo),
    CONSTRAINT FK_AsignacionEnfermeroEquipo_Medico FOREIGN KEY (id_enfermero) 
    REFERENCES Enfermero(id_enfermero)
);
CREATE TABLE Actividad_Medica (
    id_actividad_medica INT PRIMARY KEY,  -- Primary Key
    id_Paciente INT,  -- Foreign Key
	id_Sala INT, --Foreign Key
	id_Informe int,
    fecha DATE,
    hora TIME,
	idEquipo int not null
	CONSTRAINT FK_Actividad_Medica_Informe Foreign key (id_Informe) references Informe_Medico(id_Informe),
    CONSTRAINT FK_Actividad_Medica_Paciente FOREIGN KEY (id_Paciente) REFERENCES Paciente(id_Paciente),
	CONSTRAINT FK_Actividad_Medica_Sala Foreign key (id_Sala) REFERENCES Sala(id_Sala),
	foreign key(idEquipo) references Equipo_medico(id_Equipo)
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