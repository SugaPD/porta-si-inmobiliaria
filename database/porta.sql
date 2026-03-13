
CREATE DATABASE porta;
USE porta;

CREATE TABLE roles (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL UNIQUE,
    descripcion TEXT
);

CREATE TABLE usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    telefono VARCHAR(30),
    activo BOOLEAN DEFAULT TRUE,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id_rol INT NOT NULL,

    CONSTRAINT fk_usuario_rol
        FOREIGN KEY (id_rol)
        REFERENCES roles(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

CREATE TABLE tipos_inmueble (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre_tipo VARCHAR(100) NOT NULL UNIQUE,
    descripcion TEXT
);

CREATE TABLE ubicaciones (
    id INT AUTO_INCREMENT PRIMARY KEY,
    pais VARCHAR(100) NOT NULL,
    estado VARCHAR(100),
    ciudad VARCHAR(100),
    direccion VARCHAR(255),
    codigo_postal VARCHAR(20),
    latitud DECIMAL(10,7),
    longitud DECIMAL(10,7)
);

CREATE TABLE estados_publicacion (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre_estado VARCHAR(50) NOT NULL UNIQUE,
    descripcion TEXT
);

CREATE TABLE inmuebles (
    id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(200) NOT NULL,
    descripcion TEXT,
    precio DECIMAL(12,2) NOT NULL,
    superficie DECIMAL(10,2) NOT NULL,
    habitaciones INT,
    banos INT,
    estacionamientos INT,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    id_tipo_inmueble INT NOT NULL,
    id_usuario INT NOT NULL,
    id_ubicacion INT NOT NULL,
    id_estado_publicacion INT NOT NULL,

    CONSTRAINT fk_inmueble_tipo
        FOREIGN KEY (id_tipo_inmueble)
        REFERENCES tipos_inmueble(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT fk_inmueble_usuario
        FOREIGN KEY (id_usuario)
        REFERENCES usuarios(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT fk_inmueble_ubicacion
        FOREIGN KEY (id_ubicacion)
        REFERENCES ubicaciones(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT fk_inmueble_estado
        FOREIGN KEY (id_estado_publicacion)
        REFERENCES estados_publicacion(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

CREATE TABLE multimedias (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_inmueble INT NOT NULL,
    url_archivo VARCHAR(255) NOT NULL,
    tipo_archivo VARCHAR(50),
    tamano_kb INT,
    fecha_carga TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_multimedia_inmueble
        FOREIGN KEY (id_inmueble)
        REFERENCES inmuebles(id)
        ON DELETE CASCADE
);

CREATE TABLE historiales_publicacion (
    id INT AUTO_INCREMENT PRIMARY KEY,

    id_inmueble INT NOT NULL,
    estado_anterior INT,
    estado_nuevo INT NOT NULL,
    id_usuario INT NOT NULL,

    fecha_cambio TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    comentario TEXT,

    CONSTRAINT fk_historial_inmueble
        FOREIGN KEY (id_inmueble)
        REFERENCES inmuebles(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_historial_estado_anterior
        FOREIGN KEY (estado_anterior)
        REFERENCES estados_publicacion(id)
        ON UPDATE CASCADE,

    CONSTRAINT fk_historial_estado_nuevo
        FOREIGN KEY (estado_nuevo)
        REFERENCES estados_publicacion(id)
        ON UPDATE CASCADE,

    CONSTRAINT fk_historial_usuario
        FOREIGN KEY (id_usuario)
        REFERENCES usuarios(id)
        ON UPDATE CASCADE
);
