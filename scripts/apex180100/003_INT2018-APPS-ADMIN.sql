prompt --application/set_environment
set define off verify off feedback off
whenever sqlerror exit sql.sqlcode rollback
--------------------------------------------------------------------------------
--
-- ORACLE Application Express (APEX) export file
--
-- You should run the script connected to SQL*Plus as the Oracle user
-- APEX_180100 or as the owner (parsing schema) of the application.
--
-- NOTE: Calls to apex_application_install override the defaults below.
--
--------------------------------------------------------------------------------
begin
wwv_flow_api.import_begin (
 p_version_yyyy_mm_dd=>'2016.08.24'
,p_default_workspace_id=>100777
);
end;
/
prompt  WORKSPACE 100777
--
-- Workspace, User Group, User, and Team Development Export:
--   Date and Time:   14:20 Monday April 23, 2018
--   Exported By:     BMAICAN
--   Export Type:     Workspace Export
--   Version:         5.1.4.00.08
--   Instance ID:     69411747885904
--
-- Import:
--   Using Instance Administration / Manage Workspaces
--   or
--   Using SQL*Plus as the Oracle user APEX_180100
 
begin
    wwv_flow_api.set_security_group_id(p_security_group_id=>100777);
end;
/
----------------
-- W O R K S P A C E
-- Creating a workspace will not create database schemas or objects.
-- This API creates only the meta data for this APEX workspace
prompt  Creating workspace INT2018-APPS-ADMIN...
begin
wwv_flow_fnd_user_api.create_company (
  p_id => 1981831394129459
 ,p_provisioning_company_id => 100777
 ,p_short_name => 'INT2018-APPS-ADMIN'
 ,p_display_name => 'INT2018-APPS-ADMIN'
 ,p_first_schema_provisioned => 'U_ONEPOINT_V7'
 ,p_company_schemas => 'U_ONEPOINT_V7'
 ,p_ws_schema => 'U_ONEPOINT_V7'
 ,p_account_status => 'ASSIGNED'
 ,p_allow_plsql_editing => 'Y'
 ,p_allow_app_building_yn => 'Y'
 ,p_allow_packaged_app_ins_yn => 'Y'
 ,p_allow_sql_workshop_yn => 'Y'
 ,p_allow_websheet_dev_yn => 'Y'
 ,p_allow_team_development_yn => 'Y'
 ,p_allow_to_be_purged_yn => 'Y'
 ,p_allow_restful_services_yn => 'Y'
 ,p_source_identifier => 'INT2018-'
 ,p_path_prefix => 'INT2018-APPS-ADMIN'
 ,p_files_version => 1
);
end;
/
----------------
-- G R O U P S
--
prompt  Creating Groups...
prompt  Creating group grants...
----------------
-- U S E R S
-- User repository for use with APEX cookie-based authentication.
--
prompt  Creating Users...
begin
wwv_flow_fnd_user_api.create_fnd_user (
  p_user_id                      => '1981793196129436',
  p_user_name                    => 'BMAICAN',
  p_first_name                   => '',
  p_last_name                    => '',
  p_description                  => '',
  p_email_address                => 'bogdan.maican@virtual7.ro',
  p_web_password                 => '789DCF01BFE94F293E5E0DEFD1C2AF3ADB0DAC3C454E7E815691BF99B6540D6411D6D7B66DCC729AB77642A172C13D4C94554811BDDACFC6155595293E8ADB1F',
  p_web_password_format          => '5;5;10000',
  p_group_ids                    => '',
  p_developer_privs              => 'ADMIN:CREATE:DATA_LOADER:EDIT:HELP:MONITOR:SQL',
  p_default_schema               => 'U_ONEPOINT_V7',
  p_account_locked               => 'N',
  p_account_expiry               => to_date('201803270818','YYYYMMDDHH24MI'),
  p_failed_access_attempts       => 0,
  p_change_password_on_first_use => 'N',
  p_first_password_use_occurred  => 'Y',
  p_allow_app_building_yn        => 'Y',
  p_allow_sql_workshop_yn        => 'Y',
  p_allow_websheet_dev_yn        => 'Y',
  p_allow_team_development_yn    => 'Y',
  p_allow_access_to_schemas      => '');
end;
/
prompt Check Compatibility...
begin
-- This date identifies the minimum version required to import this file.
wwv_flow_team_api.check_version(p_version_yyyy_mm_dd=>'2010.05.13');
end;
/
 
begin wwv_flow.g_import_in_progress := true; wwv_flow.g_user := USER; end; 
/
 
--
prompt ...news
--
begin
null;
end;
/
--
prompt ...links
--
begin
null;
end;
/
--
prompt ...bugs
--
begin
null;
end;
/
--
prompt ...events
--
begin
null;
end;
/
--
prompt ...feature types
--
begin
null;
end;
/
--
prompt ...features
--
begin
null;
end;
/
--
prompt ...feature map
--
begin
null;
end;
/
--
prompt ...tasks
--
begin
null;
end;
/
--
prompt ...feedback
--
begin
null;
end;
/
--
prompt ...task defaults
--
begin
null;
end;
/
begin
wwv_flow_api.import_end(p_auto_install_sup_obj => nvl(wwv_flow_application_install.get_auto_install_sup_obj, false));
commit;
end;
/
set verify on feedback on define on
prompt  ...done
