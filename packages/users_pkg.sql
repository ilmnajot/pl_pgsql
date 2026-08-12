create or replace procedure users_crud(
    p_fName in varchar,
    p_lName in varchar,
    p_email in varchar,
    p_age in numeric
) as
$$
declare
    v_exists boolean;
begin
    select exists(select 1 from users where email = p_email) into v_exists;

    if v_exists then
        perform users_exceptions.validate_text(p_fName, 'fName');
        perform users_exceptions.validate_text(p_lName, 'lName');
        update users
        set fname = p_fName,
            lname = p_lName,
            age   = p_age
        where email = p_email;

    end if;
    commit;
    if not v_exists then
        perform users_exceptions.validate_text(p_fName, 'fName');
        perform users_exceptions.validate_text(p_lName, 'lName');
        perform users_exceptions.validate_text(p_email, 'email');
        perform users_exceptions.validate_email(p_email, '@', 'email');

        insert into users(fname, lname, email, age)
        values (p_fName, p_lName, p_email, p_age);
        commit;
    end if;
end;
$$ language plpgsql;

select *
from users;

call users_crud(
        'Alisher', 'null', '222@', 23
     );