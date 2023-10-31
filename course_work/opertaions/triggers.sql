--Проверяет определенные условия при вставке новых записей и предотвращать вставку, если условия не выполняются
---------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION check_user_resources_insert_condition()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.type = 'water' AND NEW.object_type NOT IN ('crane', 'rainy', 'borehole', 'bottled', 'salty') THEN
        RAISE EXCEPTION 'Invalid combination of type and object_type for water resource';
    END IF;

    IF NEW.type = 'fertilizers' AND NEW.object_type NOT IN ('organic', 'mineral', 'organo_mineral', 'biological', 'leafy') THEN
        RAISE EXCEPTION 'Invalid combination of type and object_type for fertilizers resource';
    END IF;

    IF NEW.type = 'soil' AND NEW.object_type NOT IN ('sandy', 'clay', 'silt', 'peat', 'chalk', 'loam') THEN
        RAISE EXCEPTION 'Invalid combination of type and object_type for soil resource';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;



--Функция проверяет, что в таблице user_resources поле volume должно быть больше 0
----------------------------------------------------------------------------------
CREATE TRIGGER prevent_invalid_user_resources_insert
BEFORE INSERT ON user_resources
FOR EACH ROW
EXECUTE FUNCTION check_user_resources_insert_condition();

CREATE OR REPLACE FUNCTION check_user_resources_volume_range()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.volume <= 0 THEN
        RAISE EXCEPTION 'Volume must be greater than 0';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER check_user_resources_volume
BEFORE INSERT OR UPDATE ON user_resources
FOR EACH ROW
EXECUTE FUNCTION check_user_resources_volume_range();

--Обновление количество ресурса у пользователя после полива
-----------------------------------------------------------
CREATE OR REPLACE FUNCTION check_and_update_watering_schedule()
RETURNS TRIGGER AS $$
DECLARE
    is_watering_needed BOOLEAN;
    new_water_volume VARCHAR(255);
BEGIN
    -- Проверка условий с использованием процедуры check_watering_schedule
    is_watering_needed := check_watering_schedule(NEW.flower_id, NEW.current_date);

    IF is_watering_needed THEN
        SELECT water_volume INTO new_water_volume
        FROM volume
        WHERE flower_id = NEW.flower_id;  
        
        UPDATE user_resources
        SET volume = new_water_volume
        WHERE type = 'water';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER check_and_update_watering_schedule_trigger
AFTER INSERT ON volume
FOR EACH ROW
EXECUTE FUNCTION check_and_update_watering_schedule();
