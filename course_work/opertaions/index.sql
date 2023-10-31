--Индекс для ускорения поиска растений по виду и типу почвы:
CREATE INDEX idx_flowers_species_soil ON flowers(flower_species, best_soil_id);

--Индекс для ускорения поиска растений по виду и типу воды:
CREATE INDEX idx_flowers_species_water ON flowers(flower_species, best_water_id);

--Индекс для ускорения поиска растений по виду и типу удобрений:
CREATE INDEX idx_flowers_species_fertilizers ON flowers(flower_species, fertilizers_info_id);

--Индекс для ускорения поиска растений по виду и типу света:
CREATE INDEX idx_flowers_species_light ON flowers(flower_species, light_info_id);

--Индекс для ускорения поиска расписания полива для растений пользователя:
CREATE INDEX idx_user_schedule_flower_id ON user_schedule(flower_id);

--Индекс для ускорения поиска объема ресурсов для растений пользователя:
CREATE INDEX idx_user_resources_type ON user_resources(type);