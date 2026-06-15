
create or alter function [dbo].[FN_MGM_GetLastOperationDataForClient](
    @UserId bigint,
    @Firm smallint,
    @Id int
)
    returns table
        as
        return
        select 
			  cast((case
                         when OperationType = 31 then                               4   --Debit
                         when OperationType = 33 then                               14  --Debit and Credit
                         when OperationType = 32 then                               3   --Credit
						 when OperationType = 41 then                               5   --Cariler arasinda transfer

                         when OperationType in (7, 11, 9, 10, 8) then               1  ---medaxil
                         when OperationType in (12, 16, 14, 15, 13) then            2   --mexaric

						 when OperationType = 1  then                               81  --satış sifarişi 
                         when OperationType = 2  then                               38  --satis fakturasi
                         when OperationType = 3  then                               33  ---satış qaytarma fakturası
						 when OperationType = 4  then                               82  --satınalma sifarişi
                         when OperationType = 5  then                               31  --satınalma fakturası
                         when OperationType = 6  then                               36  -- satınalma qaytarma fakturası
                         

                         else   12
               end) as smallint)          as OperationType,                                                                             
               Date                       as Date,
               DocNumber                  as DocNumber,
               Salesman.Name              as EmployeeName,
               Amount                     as Amount
        from OP_ClientLastOperation Operation with (nolock)
        left join MD_Salesman Salesman on Salesman.TigerId = Operation.EmployeeId and Operation.Firm = Salesman.Firm
        where Operation.Firm = @Firm
          and Operation.ClientId = @Id 




		  