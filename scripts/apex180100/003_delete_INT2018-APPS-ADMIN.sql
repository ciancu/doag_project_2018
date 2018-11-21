BEGIN
APEX_INSTANCE_ADMIN.REMOVE_WORKSPACE(p_workspace => 'INT2018-APPS-ADMIN',
                                     p_drop_users => 'N',
                                     p_drop_tablespaces => 'N');
END;
/