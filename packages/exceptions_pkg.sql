create schema users_exceptions;


create or replace function users_exceptions.validate_user(
    p_user_id numeric
) returns void as
$$
declare
    v_exists boolean;
begin
    if p_user_id is null then
        raise exception 'ID is Required'
            using errcode = '45002';
    end if;
    select exists(select 1 from users where id = p_user_id) into v_exists;
    if not v_exists then
        raise exception 'USER NOT FOUND' using errcode = '45003';
    end if;
exception
    when no_data_found then
        raise exception 'User not found';
end;
$$ language plpgsql;


create or replace function users_exceptions.validate_text(
    p_text text,
    p_field_name text
) returns void as
$$
begin
    if p_text is null or trim(p_text) = '' then
        raise exception 'Required: %', p_field_name
            using errcode = '45001';
    end if;
end;
$$ language plpgsql;


create or replace function users_exceptions.validate_email(
    p_text text,
    p_search text,
    p_field_name text
) returns void as
$$
begin
    if p_text is null or trim(p_text) = '' then
        raise exception 'Required: %', p_field_name
            using errcode = '45005';
    end if;
    if position(p_search in p_text) = 0 then
        raise exception 'Invalid format for: %. Must contain: "%"', p_field_name, p_search using errcode = 45004;
    end if;
end;
$$ language plpgsql;

