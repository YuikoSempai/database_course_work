CREATE TYPE quality AS ENUM ('bad', 'normal', 'good');
CREATE TYPE type_light AS ENUM ('solar', 'phytolamp', 'led');
CREATE TYPE type_diseases AS ENUM ('fungal', 'viral', 'bacterial', 'nematodes', 'physiological');
CREATE TYPE water_type AS ENUM ('crane', 'rainy', 'borehole', 'bottled', 'salty');
CREATE TYPE fertilizer_type AS ENUM ('organic', 'mineral', 'organo_mineral', 'biological', 'leafy');
CREATE TYPE climate_types AS ENUM ('polar', 'temperate', 'tropical', 'alpine', 'dry', 'humid continental', 'subtropical', 'tundra');
CREATE TYPE soils_type AS ENUM ('sandy', 'clay', 'silt', 'peat', 'chalk', 'loam');

CREATE TABLE IF NOT EXISTS climate_type(
  id SERIAL PRIMARY KEY,
  name climate_types NOT NULL,
  temperature INT,
  precipitation INT
);

CREATE TABLE IF NOT EXISTS soils (
  id SERIAL PRIMARY KEY,
  type soils_type NOT NULL,
  pH REAL,
  humidity quality,
  acidity quality,
  drainage quality,
  fertility quality,
  climate_type_id INT,
  FOREIGN KEY (climate_type_id) REFERENCES climate_type(id)
);

CREATE TABLE IF NOT EXISTS  light_info (
  id SERIAL PRIMARY KEY,
  type_light type_light,
  description varchar(255)
);

CREATE TABLE IF NOT EXISTS  water_info (
  id SERIAL PRIMARY KEY,
  water_type water_type,
  description varchar(255)
);

CREATE TABLE IF NOT EXISTS  fertilizers (
  id SERIAL PRIMARY KEY,
  fertilizer_type fertilizer_type,
  description varchar(255)
);
CREATE TABLE IF NOT EXISTS  flowers (
  id SERIAL PRIMARY KEY,
  flower_species VARCHAR(255) NOT NULL,
  best_climate_type_id INT,
  best_soil_id INT,
  best_water_id INT,
  light_info_id INT,
  fertilizers_info_id INT,
  FOREIGN KEY (best_climate_type_id) REFERENCES climate_type(id),
  FOREIGN KEY (best_soil_id) REFERENCES soils(id),
  FOREIGN KEY (best_water_id) REFERENCES water_info(id),
  FOREIGN KEY (light_info_id) REFERENCES light_info(id),
  FOREIGN KEY (fertilizers_info_id) REFERENCES fertilizers(id)
);

CREATE TABLE IF NOT EXISTS  pests (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  type VARCHAR(255) NOT NULL,
  description VARCHAR(255),
  carrier_flowers INT,
  FOREIGN KEY (carrier_flowers) REFERENCES flowers(id)
);

CREATE TABLE IF NOT EXISTS  diseases (
  id SERIAL PRIMARY KEY,
  exposed_flowers INT,
  carrier_pests INT,
  type type_diseases,
  name VARCHAR(255) NOT NULL,
  link VARCHAR(255),
  FOREIGN KEY (exposed_flowers) REFERENCES flowers(id),
  FOREIGN KEY (carrier_pests) REFERENCES pests(id)
);

CREATE TABLE IF NOT EXISTS  pests_diseases (
  pest_id INT,
  diseases_id INT,
  PRIMARY KEY (pest_id, diseases_id),
  FOREIGN KEY (pest_id) REFERENCES pests(id),
  FOREIGN KEY (diseases_id) REFERENCES diseases(id)
);

CREATE TABLE IF NOT EXISTS  flowers_diseases (
  flower_diseases_id INT PRIMARY KEY,
  flower_id INT,
  diseases_id INT,
  FOREIGN KEY (flower_id) REFERENCES flowers(id),
  FOREIGN KEY (diseases_id) REFERENCES diseases(id)
);

CREATE TABLE IF NOT EXISTS  flowers_pests (
  flower_pests_id INT PRIMARY KEY,
  flower_id INT,
  pests_id INT,
  FOREIGN KEY (flower_id) REFERENCES flowers(id),
  FOREIGN KEY (pests_id) REFERENCES pests(id)
);

CREATE TABLE IF NOT EXISTS scheduler (
    id SERIAL PRIMARY KEY,
    flower_id INT REFERENCES flowers(id),
    light_schedule VARCHAR not null,
    water_schedule VARCHAR not null,
    fertilizers_schedule varchar not null
);

CREATE TABLE IF NOT EXISTS volume (
    id SERIAL PRIMARY KEY,
    flower_id INT REFERENCES flowers(id),
    light_volume VARCHAR not null,
    water_volume VARCHAR not null,
    fertilizers_volume VARCHAR not null
)


