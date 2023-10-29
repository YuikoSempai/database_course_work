-- height in sm
INSERT INTO user_flowers (flower_species, soil, height)
VALUES ('rose', 'sandy', 50.0),
       ('tulip', 'loams', 30.0),
       ('sunflower', 'clayey', 150.0),
       ('lavender', 'peat_bogs', 60.0),
       ('oak_tree', 'podzolic', 300.0),
       ('daisy', 'crane', 20.0),
       ('maple_tree', 'rainy', 200.0),
       ('cactus', 'borehole', 10.0),
       ('fern', 'sandy', 40.0),
       ('daffodil', 'loams', 25.0);

-- light_schedule - time interval (_ AM - _ PM)
-- water_schedule - once per {count_of_days}
-- fertilizers_schedule - once per {count_of_days}
INSERT INTO user_schedule (flower_id, light_schedule, water_schedule, fertilizers_schedule)
VALUES
    (1, '8 AM - 6 PM', 'Every 2 days', '1'),
    (2, '9 AM - 5 PM', 'Every 3 days', 'Once every 10 days'),
    (3, '10 AM - 4 PM', 'Once a week', 'Once every 2 weeks'),
    (4, '7 AM - 7 PM', 'Every day', 'Once every 5 days'),
    (5, '8 AM - 6 PM', 'Every 2 days', 'Once a week'),
    (6, '10 AM - 3 PM', 'Once every 2 weeks', 'Once a month'),
    (7, '9 AM - 5 PM', 'Every 3 days', 'Once every 10 days'),
    (8, '10 AM - 4 PM', 'Once a week', 'Once every 2 weeks'),
    (9, '7 AM - 7 PM', 'Every day', 'Once every 5 days'),
    (10, '8 AM - 6 PM', 'Every 2 days', 'Once a week');

INSERT INTO user_volume (flower_id, light_volume, water_volume, fertilizers_volume)
VALUES
    (1, '5000 lux', '200 ml', '50 ml'),
    (2, '3000 lux', '150 ml', '30 ml'),
    (3, '4000 lux', '250 ml', '40 ml'),
    (4, '6000 lux', '300 ml', '60 ml'),
    (5, '4500 lux', '180 ml', '45 ml'),
    (6, '2000 lux', '100 ml', '20 ml'),
    (7, '3500 lux', '160 ml', '35 ml'),
    (8, '4800 lux', '220 ml', '48 ml'),
    (9, '3800 lux', '170 ml', '38 ml'),
    (10, '4200 lux', '190 ml', '42 ml');

INSERT INTO user_resources (type, object_type, volume)
VALUES
    ('sandy', 'soil', '300 g'),
    ('loams', 'soil', '320 g'),
    ('clayey', 'soil', '350 g'),
    ('peat_bogs', 'soil', '400 g'),
    ('podzolic', 'soil', '330 g'),
    ('crane', 'water', '200 ml'),
    ('rainy', 'water', '220 ml'),
    ('borehole', 'water', '250 ml'),
    ('bottled', 'water', '180 ml'),
    ('salty', 'water', '210 ml'),
    ('organic', 'fertilizers', '5 g'),
    ('mineral', 'fertilizers', '8 g'),
    ('organo_mineral', 'fertilizers', '7 g'),
    ('biological', 'fertilizers', '6 g'),
    ('leafy', 'fertilizers', '10 g');

