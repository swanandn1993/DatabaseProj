use FMIS555ssn6259DB;



drop procedure InsertIntoGrootValues;

drop procedure ViewGrootValues;




Alter procedure InsertIntoGrootValues
	@loc nvarchar,
	@curDate dateTime,
	@moistLevel int


AS

Begin

Set NoCount ON

   IF (@loc IS NULL)
   BEGIN
      RAISERROR('invalid value: @loc cannot be NULL', 16, 1)
      RETURN -1
   END


      IF (@curDate IS NULL)
   BEGIN
      RAISERROR('invalid value: @curDate cannot be NULL', 16, 1)
      RETURN -1
   END

      IF (@moistLevel IS NULL)
   BEGIN
      RAISERROR('invalid value: @moistLevel cannot be NULL', 16, 1)
      RETURN -1
   END


      BEGIN TRY
      BEGIN TRAN

  Insert into  GrootValues
		Values(@loc, @curDate, @moistLevel)

      COMMIT TRAN
   END TRY
	
	Begin Catch

		 DECLARE @errMessage NVARCHAR(4000)
     DECLARE @errSeverity int
     DECLARE @errState int

     SELECT @errMessage  = ERROR_MESSAGE(),
            @errSeverity = ERROR_SEVERITY(),
            @errState    = ERROR_STATE()

      RAISERROR(@errMessage, @errSeverity, @errState)
      ROLLBACK

      return -1
   END CATCH

   return 0

END
GO


Alter procedure ViewGrootValues
	@loc nvarchar

AS

Begin

Set NoCount ON

   IF (@loc IS NULL)
   BEGIN
      RAISERROR('invalid value: @loc cannot be NULL', 16, 1)
      RETURN -1
   END



      BEGIN TRY
      BEGIN TRAN

  Select * from GrootValues
	Where location = @loc

      COMMIT TRAN
   END TRY
	
	Begin Catch

		 DECLARE @errMessage NVARCHAR(4000)
     DECLARE @errSeverity int
     DECLARE @errState int

     SELECT @errMessage  = ERROR_MESSAGE(),
            @errSeverity = ERROR_SEVERITY(),
            @errState    = ERROR_STATE()

      RAISERROR(@errMessage, @errSeverity, @errState)
      ROLLBACK

      return -1
   END CATCH

   return 0

END
GO









