-- CREAR TABLA DE POKEMONES
-- CREATE TABLE Pokemones (
--     id_pokemon PRIMARY KEY SERIAL UNIQUE,
--     nombre_pokemon TEXT(20) UNIQUE NOT NULL,
--     tipo TEXT (20) NOT NULL,
--     habilidad VARCHAR(20) NOT NULL,
--     salud INT CHECK(salud > 0 and salud =< 50 ) NOT NULL,
--     experiencia INT CHECK(experiencia > 0 and experiencia =< 100 ) NOT NULL
-- )

-- CODIGO CORREGIDO CON CHAT GPT, CAMBIO EL TEXT A VARCHAR YA QUE TEXT NO ADMITE MAXIMO DE CARACTERES Y CORRIGIO LA
-- CONDICION DE CHECK, EL ORDEN EN QUE COLOQUE LAS CONDICIONES, LE SACO EL UNIQUE AL ID YA QUE ES UNA CLAVE PRIMARIA Y OTROS ERRORES
-- DE SINTAXIS. En SQL, una clave primaria (PRIMARY KEY) implica automáticamente una restricción de unicidad y
-- no permite valores nulos.  

CREATE TABLE Pokemones (
    id_pokemon SERIAL PRIMARY KEY,
    nombre_pokemon VARCHAR(20) UNIQUE NOT NULL,
    tipo VARCHAR(20) NOT NULL,
    habilidad VARCHAR(20) NOT NULL,
    salud INT CHECK(salud > 0 AND salud <= 50) NOT NULL,
    experiencia_pokemon INT CHECK(experiencia > 0 AND experiencia <= 100) NOT NULL
);


-- CREAR TABLA DE ENTRENADORES

CREATE TABLE Entrenadores (
    id_entrenador SERIAL PRIMARY KEY,
    nombre_entrenador VARCHAR(20) UNIQUE NOT NULL,
    edad INT NOT NULL,
    gimnasio VARCHAR(20) NOT NULL,
    experiencia_entrenador INT CHECK(experiencia_entrenador > 0 AND experiencia_entrenador <= 100) NOT NULL,
    medallas INT CHECK (medallas <= 8) NOT NULL
);

-- -- COMANDOS PARA INSERTAR DATOS EN LA TABLA POKEMONES
-- INSERT INTO Pokemon VALUES (1, 'Pikachu', 'Eléctrico', 'Impactrueno', 30, 20),
-- INSERT INTO Pokemon VALUES (2, 'Starmie', 'Agua', 'Rayo Burbuja', 35, 25),
-- INSERT INTO Pokemon VALUES (3, 'Onix', 'Roca', 'Golpe Roca', 45, 30),
-- INSERT INTO Pokemon VALUES (4, 'Alakazam', 'Psíquico', 'Confusión', 40, 35),
-- INSERT INTO Pokemon VALUES (5, 'Blaziken', 'Fuego', 'Patada Ígnea', 50, 40);

-- CORRECCION DE CHAT GPT, ME MOSTRO UNA FORMA MAS EFICIENTE DE CARGAR LOS DATOS
-- Si el campo id está configurado como autoincremental (como en muchas bases de datos SQL),
-- no necesitas especificarlo en la lista de columnas ni en los valores que estás insertando.
-- El sistema de base de datos asignará automáticamente un valor único para cada fila nueva.


-- INSERTAR DATOS EN LA TABLA ENTRENADORES
INSERT INTO Pokemones (nombre_pokemon, tipo, habilidad, salud, experiencia_pokemon) VALUES 
('Blaziken', 'Fuego', 'Patada Ígnea', 50, 40),
('Pikachu', 'Eléctrico', 'Impactrueno', 30, 20),
('Alakazam', 'Psíquico', 'Confusión', 40, 35),
('Starmie', 'Agua', 'Rayo Burbuja', 35, 25),
('Onix', 'Roca', 'Golpe Roca', 45, 30);

-- VER

SELECT * FROM Pokemones

-- COMANDOS PARA INSERTAR DATOS EN TABLA ENTRENADORES

INSERT INTO Entrenadores (nombre_entrenador, edad, gimnasio, experiencia_entrenador, medallas) VALUES 
('Ash Ketchum', 10, 'Ninguno', 80, 8),
('Misty', 12, 'Ciudad Celeste', 70, 4),
('Brock', 15, 'Ciudad Plateada', 75, 6),
('Sabrina', 21, 'Ciudad Azafrán', 85, 4),
('May', 10, 'Ninguno', 60, 5);   

SELECT * FROM Entrenadores

-- -- CREAR TABLA INTERMEDIA

-- CREATE TABLE Equipos (
--     id_entrenador INT,
--     id_pokemon INT,
--     FOREIGN KEY (id_entrenador) REFERENCES Entrenadores(id_entrenador),
--     FOREIGN KEY (id_pokemon) REFERENCES Pokemones(id_pokemon)

-- )
-- LE PEDI A CHAT GPT SI SE PUEDE CREAR UN RENSTRICCION PARA QUE NO SE PUEDAN REPETIR LAS PAREJAS
-- ME DIJO QUE PUEDE LOGRARSE UTILIZANDO UNA PRIMARY KEY EN LA TABLA QUE TOMA DE ARGUMENTO LOS DOS DATOS UNICOS (LOS IDS)

CREATE TABLE Equipos (
    id_entrenador INT,
    id_pokemon INT,
    PRIMARY KEY (id_entrenador, id_pokemon),
    FOREIGN KEY (id_entrenador) REFERENCES Entrenadores(id_entrenador) ON DELETE CASCADE,
    FOREIGN KEY (id_pokemon) REFERENCES Pokemones(id_pokemon) ON DELETE CASCADE
);

-- COMANDOS PARA INSERTAR LOS IDS DE ENTRENADORES Y POKEMONES

INSERT INTO Equipos (id_entrenador, id_pokemon) VALUES 
(1, 2),
(2, 4),
(3, 5),
(4, 3),
(5, 1);

SELECT * FROM Equipos

CREATE TABLE Batallas (
    id_batalla SERIAL PRIMARY KEY,
    fecha DATE NOT NULL,
    id_entrenador_1 INT,
    id_pokemon_1 INT,
    id_entrenador_2 INT,
    id_pokemon_2 INT,
    resultado VARCHAR(20) NOT NULL,
    FOREIGN KEY (id_entrenador_1) REFERENCES Entrenadores(id_entrenador) ON DELETE CASCADE,
    FOREIGN KEY (id_pokemon_1) REFERENCES Pokemones(id_pokemon) ON DELETE CASCADE,
    FOREIGN KEY (id_entrenador_2) REFERENCES Entrenadores(id_entrenador) ON DELETE CASCADE,
    FOREIGN KEY (id_pokemon_2) REFERENCES Pokemones(id_pokemon) ON DELETE CASCADE
);

INSERT INTO Batallas (fecha, id_entrenador_1, id_pokemon_1, id_entrenador_2, id_pokemon_2, resultado) VALUES
('2024-07-01', 1, 1, 2, 2, 'Victoria Entrenador 1'),
('2024-07-02', 2, 2, 3, 3, 'Victoria Entrenador 2'),
('2024-07-03', 1, 3, 3, 1, 'Empate'),
('2024-07-04', 4, 4, 5, 5, 'Victoria Entrenador 1');

SELECT * FROM Batallas

-- UPDATE
UPDATE Pokemones
SET nombre_pokemon = 'Pikachuu'
WHERE nombre_pokemon = 'Pikachu';

-- DELETE

DELETE FROM Entrenadores
WHERE id_entrenador = 1;

-- MULTITABLA
-- UNION ENTRE ENTRENADOR Y POQUEMON
SELECT 
    e.id_entrenador,
    e.nombre_entrenador,
    e.gimnasio,
    p.id_pokemon,
    p.nombre_pokemon

    FROM Entrenadores e
    JOIN Equipos eq ON e.id_entrenador = eq.id_entrenador
    JOIN Pokemones p ON eq.id_pokemon = p.id_pokemon;



