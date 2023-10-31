-- Для проверки, нуждается ли растение в поливе сегодня
-------------------------------------------------------
CREATE OR REPLACE FUNCTION check_watering_schedule(
    IN user_flower_id INT,
    IN current_date DATE
)
RETURNS BOOLEAN
LANGUAGE PLPGSQL
AS $$
DECLARE
    water_schedule INT;
    watering_date DATE;
BEGIN
    SELECT water_schedule INTO water_schedule
    FROM scheduler
    WHERE flower_id = user_flower_id;

    watering_date := (SELECT water_schedule FROM scheduler WHERE flower_id = user_flower_id) + current_date;

    IF watering_date = current_date THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;
END;
$$;


-- Добавление нового растения на стороне сервера
------------------------------------------------
CREATE OR REPLACE PROCEDURE add_new_plant(
    IN flower_species_param flower_species,
    IN best_climate_type_id_param INT,
    IN best_soil_id_param INT,
    IN best_water_id_param INT,
    IN light_info_id_param INT,
    IN fertilizers_info_id_param INT
)
LANGUAGE PLPGSQL
AS $$
BEGIN
    INSERT INTO flowers (flower_species, best_climate_type_id, best_soil_id, best_water_id, light_info_id, fertilizers_info_id)
    VALUES (flower_species_param, best_climate_type_id_param, best_soil_id_param, best_water_id_param, light_info_id_param, fertilizers_info_id_param);
END;
$$;


-- Добавление нового растения на стороне клиента
------------------------------------------------
CREATE OR REPLACE PROCEDURE add_new_plant(
    IN flower_species_param flower_species,
    IN soil_param resources_type,
    IN height_param REAL
)
LANGUAGE PLPGSQL
AS $$
BEGIN
    INSERT INTO user_flowers (flower_species, soil, height)
    VALUES (flower_species_param, soil_param, height_param);
END;
$$;


--Удаление растения на стороне сервера
--------------------------------------
CREATE OR REPLACE PROCEDURE delete_plant_by_id(IN plant_id INT)
LANGUAGE PLPGSQL
AS $$
BEGIN
    DELETE FROM flowers WHERE id = plant_id;
END;
$$;

--Удаление растения на стороне клиента
--------------------------------------
CREATE OR REPLACE PROCEDURE delete_plant_by_id(IN plant_id INT)
LANGUAGE PLPGSQL
AS $$
BEGIN
    DELETE FROM user_flowers WHERE id = plant_id;
END;
$$;


--Обновления информации о растении на стороне сервера
-----------------------------------------------------
CREATE OR REPLACE PROCEDURE update_plant_by_id(IN plant_id INT, 
	IN new_flower_species flower_species, 
	IN new_soil resources_type, 
	IN new_height REAL, 
	IN new_best_climate_type_id INT, 
	IN new_best_soil_id INT, 
	IN new_best_water_id INT, 
	IN new_light_info_id INT, 
	IN new_fertilizers_info_id INT)
LANGUAGE PLPGSQL
AS $$
BEGIN
    UPDATE flowers
    SET flower_species = new_flower_species,
        soil = new_soil,
        height = new_height,
        best_climate_type_id = new_best_climate_type_id,
        best_soil_id = new_best_soil_id,
        best_water_id = new_best_water_id,
        light_info_id = new_light_info_id,
        fertilizers_info_id = new_fertilizers_info_id
    WHERE id = plant_id;
END;
$$;


--Обновления информации о растении на стороне клиента
-----------------------------------------------------
CREATE OR REPLACE PROCEDURE update_user_plant_by_id(IN plant_id INT, 
     IN new_flower_species flower_species, 
     IN new_soil resources_type, 
     IN new_height REAL)
LANGUAGE PLPGSQL
AS $$
BEGIN
    UPDATE user_flowers
    SET flower_species = new_flower_species,
        soil = new_soil,
        height = new_height
    WHERE id = plant_id;
END;
$$;



--Проверяет, соответствует ли тип почвы указанному растению
-----------------------------------------------------------
CREATE OR REPLACE FUNCTION check_soil_type(IN user_plant_id INT)
RETURNS BOOLEAN
LANGUAGE PLPGSQL
AS $$
DECLARE
    user_plant_soil resources_type;
    plant_soil resources_type;
    is_matching BOOLEAN;
BEGIN
    SELECT soil INTO user_plant_soil
    FROM user_flowers
    WHERE id = user_plant_id;

    SELECT soil INTO plant_soil
    FROM flowers
    WHERE id = user_plant_id;

    is_matching := (user_plant_soil = plant_soil);

    RETURN is_matching;
END;
$$;


--Проверяет, соответствует ли тип воды указанному растению
----------------------------------------------------------
CREATE OR REPLACE FUNCTION check_water_type(IN user_plant_id INT)
RETURNS BOOLEAN
LANGUAGE PLPGSQL
AS $$
DECLARE
    user_plant_water water_type;
    plant_water water_type;
    is_matching BOOLEAN;
BEGIN
    SELECT water_type INTO user_plant_water
    FROM user_flowers
    WHERE id = user_plant_id;

    SELECT best_water_id INTO plant_water
    FROM flowers
    WHERE id = user_plant_id;

    is_matching := (user_plant_water = plant_water);

    RETURN is_matching;
END;
$$;


--Проверяет, соответствует ли тип освещения указанному растению
---------------------------------------------------------------
CREATE OR REPLACE FUNCTION check_light_type(IN user_plant_id INT)
RETURNS BOOLEAN
LANGUAGE PLPGSQL
AS $$
DECLARE
    user_plant_light light_type;
    plant_light light_type;
    is_matching BOOLEAN;
BEGIN
    SELECT light_info_id INTO user_plant_light
    FROM user_flowers
    WHERE id = user_plant_id;

    SELECT light_info_id INTO plant_light
    FROM flowers
    WHERE id = user_plant_id;

    is_matching := (user_plant_light = plant_light);

    RETURN is_matching;
END;
$$;
