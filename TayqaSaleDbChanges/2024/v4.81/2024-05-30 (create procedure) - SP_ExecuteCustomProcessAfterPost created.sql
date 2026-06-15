
CREATE Procedure [dbo].[SP_ExecuteCustomProcessAfterPost] @generalId int
as
begin
-- bu prosedurun inteqrasiyadan sonra cagirilir. eger her hansi bir emeliyyat icra edilmeyecekse ici bu qaydada qalsin. 
-- cunku ola biler ki sehven config true qalar. bos bosuna error atmasin.
select 1
end
   