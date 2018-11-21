DECLARE
    l_apex_user_id   NUMBER;
BEGIN
    SELECT
        user_id
    INTO
        l_apex_user_id
    FROM
        APEX_180100.WWV_FLOW_FND_USER
    WHERE
        user_name = 'ADMIN'
    ORDER BY last_update_date DESC;

    UPDATE APEX_180100.WWV_FLOW_FND_USER
        SET
            web_password = 'Welcome1!',
            CHANGE_PASSWORD_ON_FIRST_USE = 'N'
    WHERE
            user_name = 'ADMIN'
        AND
            user_id = l_apex_user_id;

    COMMIT;
    EXECUTE IMMEDIATE 'alter session set current_schema = APEX_180100';
    APEX_180100.wwv_flow_security.g_security_group_id := 10;
    APEX_180100.wwv_flow_fnd_user_api.UNLOCK_ACCOUNT('ADMIN');
    COMMIT;
END;
/