--Проверяет определенные условия при вставке новых записей и предотвращать вставку, если условия не выполняются
---------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION check_user_resources_insert_condition()
RETURNS TRIGGER AS $user_res_trigger$
BEGIN
    IF NEW.object_type = 'water' AND NEW.type NOT IN ('crane', 'rainy', 'borehole', 'bottled', 'salty') THEN
        RAISE EXCEPTION 'Invalid combination of type and object_type for water resource';
    END IF;

    IF NEW.object_type = 'fertilizers' AND NEW.type NOT IN ('organic', 'mineral', 'organo_mineral', 'biological', 'leafy') THEN
        RAISE EXCEPTION 'Invalid combination of type and object_type for fertilizers resource';
    END IF;

    IF NEW.object_type = 'soil' AND NEW.type NOT IN ('sandy', 'clayey', 'salty', 'peat_bogs', 'loams') THEN
        RAISE EXCEPTION 'Invalid combination of type and object_type for soil resource';
    END IF;

    RETURN NEW;
END;
$user_res_trigger$ LANGUAGE plpgsql;

CREATE TRIGGER prevent_invalid_user_resources_insert
    BEFORE INSERT ON user_resources
    FOR EACH ROW
EXECUTE FUNCTION check_user_resources_insert_condition();

insert into user_resources (type, object_type, volume)
VALUES ('crane', 'water', '10 g');


--Функция проверяет, что в таблице user_resources поле volume должно быть больше 0
----------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION check_user_resources_volume_range()
RETURNS TRIGGER AS $$
BEGIN
    IF cast(NEW.volume as int) <= 0 THEN
        RAISE EXCEPTION 'Volume must be greater than 0';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER check_user_resources_volume
BEFORE INSERT OR UPDATE ON user_resources
FOR EACH ROW
EXECUTE FUNCTION check_user_resources_volume_range();

insert into user_resources (type, object_type, volume)
VALUES ('sandy', 'soil', '-1');

--Обновление количество ресурса у пользователя после полива
-----------------------------------------------------------
CREATE OR REPLACE FUNCTION check_and_update_watering_schedule()
RETURNS TRIGGER AS $$
DECLARE
    is_watering_needed BOOLEAN;
    new_water_volume VARCHAR(255);
BEGIN
    -- Проверка условий с использованием процедуры check_watering_schedule
    is_watering_needed := check_watering_schedule(NEW.flower_id, now());

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
AFTER INSERT or update ON volume
FOR EACH ROW
EXECUTE FUNCTION check_and_update_watering_schedule();

-- придумать пример (у меня чет не получилось)