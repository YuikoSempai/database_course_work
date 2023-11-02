CREATE TYPE diseases_state AS ENUM ('started', 'continuation', 'advanced');
CREATE TYPE diseases_type AS ENUM ('fungal', 'viral', 'bacterial', 'nematodes', 'physiological');
CREATE TYPE flower_species AS ENUM ('rose', 'tulip', 'sunflower', 'lavender', 'oak_tree', 'daisy', 'maple_tree', 'cactus', 'fern', 'daffodil');
CREATE TYPE resources_type AS ENUM ('sandy', 'loams', 'clayey', 'peat_bogs', 'podzolic', 'crane', 'rainy', 'borehole', 'bottled', 'salty', 'organic', 'mineral', 'organo_mineral', 'biological', 'leafy');
CREATE TYPE object_type AS ENUM ('water', 'fertilizers', 'soil');
CREATE TYPE light_type AS ENUM ('solar', 'phytolamp', 'led');

CREATE TABLE user_flowers
(
    id              SERIAL PRIMARY KEY,
    flower_species  flower_species,
    soil            resources_type,
    fertilizer_type resources_type,
    water_type      resources_type,
    height          REAL
);

CREATE TABLE user_diseases
(
    id             SERIAL PRIMARY KEY,
    flower_id int references flowers(id),
    diseases_state diseases_state,
    diseases_type  diseases_type
);

CREATE TABLE user_schedule
(
    id                   serial primary key,
    flower_id            int references user_flowers(id) not null,
    light_schedule       varchar(255),
    water_schedule       int,
    fertilizers_schedule int
);

CREATE TABLE user_volume
(
    id                 serial primary key,
    flower_id          int references user_flowers (id) not null,
    light_volume       int,
    water_volume       int,
    fertilizers_volume int
);

CREATE TABLE user_resources
(
    type        resources_type PRIMARY KEY,
    object_type object_type,
    volume      int
);

alter table user_diseases add column updated_at timestamp;

create table user_changelog
(
    id serial primary key,
    flower_id int references user_flowers(id),
    watering timestamp,
    soil_change timestamp,
    fertilizing timestamp
);