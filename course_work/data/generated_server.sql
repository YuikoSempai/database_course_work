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
VALUES ('sandy', 6.5, 'normal', 'bad', 'good', 'normal', 1),
       ('clay', 7.0, 'good', 'normal', 'bad', 'good', 2),
       ('silt', 6.8, 'normal', 'good', 'normal', 'normal', 3),
       ('peat', 5.5, 'good', 'bad', 'bad', 'normal', 4),
       ('chalk', 8.0, 'normal', 'normal', 'good', 'normal', 5),
       ('loam', 6.0, 'normal', 'good', 'normal', 'good', 6);

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
VALUES ('Aphids', 'Insect', 'Small, sap-sucking insects that can damage plants.', 2),
       ('Whiteflies', 'Insect', 'Tiny insects with powdery white wings that feed on plant sap.', 1),
       ('Spider Mites', 'Arachnid', 'Tiny pests that are not true insects, but can cause damage to plants.', 3),
       ('Fungus Gnats', 'Insect', 'Small flying insects that infest soil and can damage roots.', 6);

INSERT INTO diseases (exposed_flowers, carrier_pests, type, name, link)
VALUES (2, 1, 'fungal', 'Powdery Mildew', 'https://en.wikipedia.org/wiki/Powdery_mildew'),
       (3, 2, 'viral', 'Yellow Mosaic Virus', 'https://en.wikipedia.org/wiki/Yellow_mosaic_virus'),
       (4, 3, 'bacterial', 'Fire Blight', 'https://en.wikipedia.org/wiki/Fire_blight'),
       (6, 4, 'nematodes', 'Root-Knot Nematodes', 'https://en.wikipedia.org/wiki/Root-knot_nematode');

-- Связи между вредителями и болезнями
INSERT INTO pests_diseases (pest_id, diseases_id)
VALUES (1, 1),
       (2, 2),
       (3, 3),
       (4, 4);

-- Связи между цветами и болезнями
INSERT INTO flowers_diseases (flower_diseases_id, flower_id, diseases_id)
VALUES (1, 1, 1),
       (2, 2, 2),
       (3, 3, 3),
       (4, 4, 4),
       (5, 5, 1),
       (6, 6, 4);

-- Связи между цветами и вредителями
INSERT INTO flowers_pests (flower_pests_id, flower_id, pests_id)
VALUES (1, 1, 1),
       (2, 2, 2),
       (3, 3, 3),
       (4, 4, 4),
       (5, 5, 1),
       (6, 6, 4);

-- light_schedule - time interval (_ AM - _ PM)
-- water_schedule - once per {count_of_days}
-- fertilizers_schedule - once per {count_of_days}
INSERT INTO scheduler (flower_id, light_schedule, water_schedule, fertilizers_schedule)
VALUES (1, '8 AM - 6 PM', '2', '7'),
       (2, '9 AM - 5 PM', '3', '10'),
       (3, '10 AM - 4 PM', '7', '14'),
       (4, '7 AM - 7 PM', '1', '5'),
       (5, '8 AM - 6 PM', '2', 'Once a week'),
       (6, '10 AM - 3 PM', '14', 'Once a month');

-- light_volume lux
-- water_volume ml
-- fertilizers_volume ml
INSERT INTO volume (flower_id, light_volume, water_volume, fertilizers_volume)
VALUES (1, '5000', '200', '50'),
       (2, '3000', '150', '30'),
       (3, '4000', '250', '40'),
       (4, '6000', '300', '60'),
       (5, '4500', '180', '45'),
       (6, '2000', '100', '20');
