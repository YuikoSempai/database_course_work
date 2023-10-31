-- функция для парса времени формата '{time} AM - {time} PM'
CREATE OR REPLACE FUNCTION parse_first_time(time_range TEXT)
    RETURNS int
AS
$$
BEGIN
    RETURN CAST(SUBSTRING(time_range FROM '^[0-9]+') AS INT);
END;
$$
    LANGUAGE plpgsql;

create or replace function parse_second_time(time_range text)
    returns int as
$$
begin
    return cast(substring(time_range from '[^.][0-9]+') AS INT);
end
$$
 language plpgsql;

select parse_first_time(s.light_schedule) from user_schedule s;
select parse_second_time(s.light_schedule) from user_schedule s;