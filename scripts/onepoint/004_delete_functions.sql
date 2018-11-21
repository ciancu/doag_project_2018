DECLARE
  v_exists number := 0;  
BEGIN
  Select count(1) 
    into v_exists
    from user_objects 
    where upper(object_name) = 'F_TEST' and object_type  ='FUNCTION';

  if v_exists > 0 then
      execute immediate 'drop function F_TEST';
  end if;
end;
/