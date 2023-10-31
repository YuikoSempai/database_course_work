-- поиск кол-во записей в таблице
CREATE OR REPLACE FUNCTION get_record_count(table_name TEXT)
    RETURNS INT AS
$$
DECLARE
    record_count INT;
BEGIN
    EXECUTE format('SELECT COUNT(*) FROM %I', table_name) INTO record_count;
    RETURN record_count;
END;
$$
    LANGUAGE plpgsql;

-- select *
-- from get_record_count('pests');

-- получение ресурсов определенной категории
CREATE OR REPLACE FUNCTION get_resources_by_object_type(object object_type)
    RETURNS TABLE
            (
                type     resources_type,
                obj_type object_type,
                volume   varchar(255)
            )
AS
$$
BEGIN
    return query select *
                 from user_resources
                 where object_type = object;
END;
$$
    LANGUAGE plpgsql;

-- select *
-- from get_resources_by_object_type(CAST('water' as object_type));

-- Определение средней освещенности за 30 дней

CREATE OR REPLACE FUNCTION get_average_light_intensity()
    RETURNS FLOAT AS
$$
DECLARE
    total_intensity FLOAT := 0;
    total_entries   INT   := 0;
    start_hour      INT;
    end_hour        INT;
    schedule        RECORD;
BEGIN
    FOR schedule IN SELECT light_schedule FROM user_schedule
        LOOP
            -- Преобразуем PM в 24-часовой формат
            start_hour := parse_first_time(schedule.light_schedule);
            end_hour := parse_second_time(schedule.light_schedule);

            -- Рассчитываем среднюю освещенность
            total_intensity := start_hour;
            total_entries := total_entries + 1;
        END LOOP;

    -- Проверяем, есть ли записи в таблице
    IF total_entries = 0 THEN
        RETURN NULL;
    ELSE
        RETURN (total_intensity);
    END IF;
END;
$$
    LANGUAGE plpgsql;

-- select * from get_average_light_intensity();

-- Определение самой частой болезни у определенного растения

create or replace function get_the_most_popular_diseases()
    returns text as
$$
begin
    return (select diseases_type
            from (select count(*) as cnt, diseases_type
                  from user_diseases
                  group by diseases_type) as cdt
            where cnt = (select max(cnt)
                         from (select count(*) as cnt, diseases_type
                               from user_diseases
                               group by diseases_type) as c));
end;
$$
    language plpgsql;

-- select * from get_the_most_popular_diseases();

-- Определение количества растений, подвергшихся заражению за последнюю неделю

create or replace function get_infected_flowers_count_by_last_week()
    returns int as
$$
begin
    return (select count(*)
            from user_diseases
            where updated_at BETWEEN CURRENT_DATE - INTERVAL '1 week' AND CURRENT_DATE);
end;
$$
    language plpgsql;

select *
from get_infected_flowers_count_by_last_week();

-- Среднее высота растений каждого вида

create or replace function get_average_flowers_height()
    returns float as
$$
DECLARE
    total_height  FLOAT := 0;
    flowers_count INT   := 0;
begin
    total_height := (select sum(height) from user_flowers);
    flowers_count := (select count(*) from user_flowers);
    return total_height / flowers_count;
end;
$$
    language plpgsql;

select *
from get_average_flowers_height();

-- Определение количества растений каждого вида

create or replace function get_count_of_flowers_by_species()
    returns table
            (
                cnt     bigint,
                species flower_species
            )
as
$$
begin
    return query (select count(*), flower_species
                  from user_flowers
                  group by flower_species);
end;
$$
    language plpgsql;

select *
from get_count_of_flowers_by_species()
order by cnt desc;