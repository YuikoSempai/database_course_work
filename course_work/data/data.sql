-- Server
INSERT INTO climate_type (name, temperature, precipitation)
VALUES ('polar', -20.5, 400),
       ('temperate', 10.0, 900),
       ('tropical', 25.5, 1500),
       ('alpine', 5.0, 700),
       ('dry', 30.0, 200),
       ('humid continental', 12.5, 1000),
       ('subtropical', 20.0, 1200),
       ('tundra', -10.0, 300);

INSERT INTO soils (type, ph, humidity, acidity, drainage, fertility, climate_type_id)
VALUES ('sandy', 6.5, 'normal', 'neutral', 'good', 'normal', 1),
       ('clay', 7.0, 'good', 'alkaline', 'bad', 'good', 2),
       ('silt', 6.8, 'normal', 'neutral', 'normal', 'normal', 3),
       ('peat', 5.5, 'good', 'acidic', 'bad', 'normal', 4),
       ('chalk', 8.0, 'normal', 'alkaline', 'good', 'normal', 5),
       ('loam', 6.0, 'normal', 'neutral', 'normal', 'good', 6);

INSERT INTO light_info (type_light, description)
VALUES ('solar', 'Provides natural sunlight for plants.'),
       ('phytolamp', 'Uses specialized lamps designed to mimic natural sunlight spectrum for plants.'),
       ('led', 'Utilizes LED lights with specific light wavelengths for plant growth.');


INSERT INTO water_info (water_type, description)
VALUES ('crane', 'Tap water from a municipal source.'),
       ('rainy', 'Rainwater collected for irrigation.'),
       ('borehole', 'Water obtained from a drilled well.'),
       ('bottled', 'Commercially bottled water for plants.'),
       ('salty', 'Water with higher salinity content, not suitable for all plants.');


INSERT INTO fertilizers (fertilizer_type, description)
VALUES ('organic', 'Derived from natural sources, such as compost or animal manure.'),
       ('mineral', 'Manufactured from chemical compounds, providing specific nutrients.'),
       ('organo_mineral', 'A blend of organic and mineral fertilizers for balanced nutrition.'),
       ('biological', 'Contains beneficial microorganisms to enhance soil health and nutrient absorption.'),
       ('leafy', 'Formulated for plants with high foliage, providing nutrients for leafy growth.');


INSERT INTO flowers (flower_species, best_climate_type_id, best_soil_id, best_water_id, light_info_id,
                     fertilizers_info_id)
VALUES ('Rose', 2, 6, 1, 1, 1),
       ('Tulip', 2, 3, 2, 1, 2),
       ('Orchid', 3, 4, 3, 2, 3),
       ('Sunflower', 1, 1, 1, 1, 4),
       ('Lily', 2, 3, 2, 3, 2),
       ('Cactus', 6, 5, 4, 3, 5);

INSERT INTO pests (name, type, description, carrier_flowers)
VALUES ('name', 'type', 'description', 1);

INSERT INTO diseases (exposed_flowers, carrier_pests, type, name, link)
VALUES (1, 1, 'fungal', 'name', 'link');

INSERT INTO pests_diseases (pest_id, diseases_id)
VALUES (1, 1);

INSERT INTO flowers_diseases (flower_diseases_id, flower_id, diseases_id)
VALUES (1, 1, 1);

INSERT INTO flowers_pests (flower_pests_id, flower_id, pests_id)
VALUES (1, 1, 1);

-- Client