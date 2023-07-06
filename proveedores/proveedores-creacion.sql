CREATE TABLE proveedores (
    id_prov VARCHAR(10) PRIMARY KEY,
    prov_nombre VARCHAR (50),
    categoria INT,
    ciudad VARCHAR(100)
);

CREATE TABLE componentes (
    id_comp VARCHAR(10) PRIMARY KEY,
    comp_nombre VARCHAR (50),
    color VARCHAR(20),
    peso INT,
    ciudad VARCHAR(100)
);

CREATE TABLE articulos (
    id_art VARCHAR(10) PRIMARY KEY,
    art_nombre VARCHAR(50),
    ciudad VARCHAR (50)
);

CREATE TABLE envios (
    id_prov VARCHAR(10),
    id_comp VARCHAR(10),
    id_art VARCHAR(10),
    cantidad INT,
    CONSTRAINT prov_env_fk FOREIGN KEY (id_prov) REFERENCES proveedores(id_prov),
    CONSTRAINT comp_env_fk FOREIGN KEY (id_comp) REFERENCES componentes(id_comp),
    CONSTRAINT art_env_fk FOREIGN KEY (id_art) REFERENCES articulos (id_art)
);

INSERT INTO
    proveedores (id_prov, prov_nombre, categoria, ciudad)
VALUES
    ('P1', 'Carlos', 20, 'La Plata'),
    ('P2', 'Juan', 10, 'Cap. Fed.'),
    ('P3', 'José', 30, 'La Plata'),
    ('P4', 'Dora', 20, 'La Plata'),
    ('P5', 'Eva', 30, 'Bernal');
    
INSERT INTO
    componentes (id_comp, comp_nombre, color, peso, ciudad)
VALUES
    ('C1', 'X3A', 'Rojo', 12, 'La Plata'),
    ('C2', 'B85', 'Verde', 17, 'Cap. Fed.'),
    ('C3', 'C4B', 'Azul', 17, 'Quilmes'),
    ('C4', 'C4B', 'Rojo', 14, 'La Plata'),
    ('C5', 'VT8', 'Azul', 12, 'Cap. Fed.'),
    ('C6', 'C30', 'Rojo', 19, 'La Plata');

INSERT INTO
    articulos (id_art, art_nombre, ciudad)
VALUES
    ('T1', 'Clasificadora', 'Cap. Fed.'),
    ('T2', 'Perforadora', 'Quilmes'),
    ('T3', 'Lectora', 'Bernal'),
    ('T4', 'Consola', 'Bernal'),
    ('T5', 'Mezcladora', 'La Plata'),
    ('T6', 'Terminal', 'Berazategui'),
    ('T7', 'Cinta', 'La Plata');

INSERT INTO
    envios (id_prov, id_comp, id_art, cantidad)
VALUES
    ('P1', 'C1', 'T1', 200),
    ('P1', 'C1', 'T4', 700),
    ('P2', 'C3', 'T1', 400),
    ('P2', 'C3', 'T2', 200),
    ('P2', 'C3', 'T3', 200),
    ('P2', 'C3', 'T4', 500),
    ('P2', 'C3', 'T5', 600),
    ('P2', 'C3', 'T6', 400),
    ('P2', 'C3', 'T7', 800),
    ('P2', 'C5', 'T2', 100),
    ('P3', 'C3', 'T1', 200),
    ('P3', 'C4', 'T2', 100),
    ('P4', 'C6', 'T3', 300),
    ('P4', 'C6', 'T7', 300),
    ('P5', 'C2', 'T2', 200),
    ('P5', 'C2', 'T4', 100),
    ('P5', 'C5', 'T4', 500),
    ('P5', 'C5', 'T7', 100),
    ('P5', 'C6', 'T2', 200),
    ('P5', 'C1', 'T4', 100),
    ('P5', 'C3', 'T4', 200),
    ('P5', 'C4', 'T4', 800),
    ('P5', 'C5', 'T5', 400),
    ('P5', 'C6', 'T4', 500);