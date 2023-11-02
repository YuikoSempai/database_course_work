-- height in sm
INSERT INTO user_flowers (flower_species, soil, fertilizer_type, water_type, height)
VALUES
    ('rose', 'sandy', 'organic', 'crane', 0.8),
    ('tulip', 'loams', 'mineral', 'rainy', 0.3),
    ('sunflower', 'clayey', 'organo_mineral', 'bottled', 2.0),
    ('lavender', 'peat_bogs', 'biological', 'borehole', 0.6),
    ('oak_tree', 'podzolic', 'leafy', 'salty', 10.0),
    ('daisy', 'crane', 'organic', 'bottled', 0.4),
    ('maple_tree', 'rainy', 'mineral', 'crane', 8.0),
    ('cactus', 'borehole', 'organo_mineral', 'salty', 0.5),
    ('fern', 'bottled', 'biological', 'crane', 0.4),
    ('daffodil', 'salty', 'leafy', 'borehole', 0.3);


-- light_schedule - time interval (_ AM - _ PM)
-- water_schedule - once per {count_of_days}
-- fertilizers_schedule - once per {count_of_days}
INSERT INTO user_schedule (flower_id, light_schedule, water_schedule, fertilizers_schedule)
VALUES (1, '8 AM - 6 PM', 2, 1),
       (2, '9 AM - 5 PM', 3, 10),
       (3, '10 AM - 4 PM', 7, 14),
       (4, '7 AM - 7 PM', 1, 5),
       (5, '8 AM - 6 PM', 2, 7),
       (6, '10 AM - 3 PM', 14, 30),
       (7, '9 AM - 5 PM', 3, 10),
       (8, '10 AM - 4 PM', 7, 14),
       (9, '7 AM - 7 PM', 1, 5),
       (10, '8 AM - 6 PM', 2, 7);

INSERT INTO user_volume (flower_id, light_volume, water_volume, fertilizers_volume)
VALUES (1, 5000, 200, 50),
       (2, 3000, 150, 30),
       (3, 4000, 250, 40),
       (4, 6000, 300, 60),
       (5, 4500, 180, 45),
       (6, 2000, 100, 20),
       (7, 3500, 160, 35),
       (8, 4800, 220, 48),
       (9, 3800, 170, 38),
       (10, 4200, 190, 42);

INSERT INTO user_resources (type, object_type, volume)
VALUES ('sandy', 'soil', 300),
       ('loams', 'soil', 320),
       ('clayey', 'soil', 350),
       ('peat_bogs', 'soil', 400),
       ('podzolic', 'soil', 330),
       ('crane', 'water', 200),
       ('rainy', 'water', 220),
       ('borehole', 'water', 250),
       ('bottled', 'water', 180),
       ('salty', 'water', 210),
       ('organic', 'fertilizers', 5),
       ('mineral', 'fertilizers', 5),
       ('organo_mineral', 'fertilizers', 7),
       ('biological', 'fertilizers', 6),
       ('leafy', 'fertilizers', 10);

INSERT INTO user_diseases (flower_id, diseases_state, diseases_type)
VALUES (1, 'started', 'fungal'),
       (2, 'continuation', 'viral'),
       (3, 'advanced', 'bacterial'),
       (4, 'started', 'nematodes'),
       (5, 'continuation', 'physiological'),
       (6, 'continuation', 'physiological');

INSERT INTO user_changelog (flower_id, watering, soil_change, fertilizing)
VALUES (1, '2023-10-26 10:00:00', '2023-10-25 14:30:00', '2023-10-24 12:45:00'),
       (2, '2023-10-27 09:15:00', '2023-10-26 16:20:00', '2023-10-25 11:55:00'),
       (3, '2023-10-27 12:30:00', '2023-10-26 18:00:00', '2023-10-25 09:30:00'),
       (4, '2023-10-28 11:20:00', '2023-10-27 15:40:00', '2023-10-26 13:10:00');