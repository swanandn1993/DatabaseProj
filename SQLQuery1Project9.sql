USE [FMIS555ssn6259DB];
-- done

--Change meeting time


ALTER PROCEDURE ChangeMeetingTime
   @meetingID int,
   @newTimeSlotID int,
   @newMeetingID int OUTPUT 

AS
BEGIN

SET NOCOUNT ON;

   -- check inputs

   IF (@meetingID IS NULL)
   BEGIN
      RAISERROR('invalid value: @meetingID cannot be NULL', 16, 1)
      RETURN -1
   END

   IF (@newTimeSlotID IS NULL)
   BEGIN
      RAISERROR('invalid value: @newTimeSlotID cannot be NULL', 16, 1)
      RETURN -1
   END

   
   -- is the new time slot already taken?
   IF EXISTS(SELECT * FROM Meeting WHERE timeSlotID = @newTimeSlotID)
   BEGIN
      RAISERROR('invalid value: @newTimeSlotID already used', 16, 1)
      return -2
   END

   -- get the requesterID
   DECLARE @requesterID int

   SELECT @requesterID = requesterID
   FROM   Meeting
   WHERE  meetingID = @meetingID

   DECLARE @occurred bit = 0 -- zero means it has not occurred

   -- OK, ready to do a transaction
   SET TRANSACTION ISOLATION LEVEL READ COMMITTED

 
   
   BEGIN TRY
      BEGIN TRAN
         INSERT INTO Meeting
         (requesterID, timeSlotID, occurred)
         VALUES
            (@requesterID, @newTimeSlotID, @occurred)

         SET @newMeetingID = @@IDENTITY

         DELETE FROM Meeting
         WHERE  meetingID = @meetingID
      COMMIT TRAN
   END TRY
   BEGIN CATCH
     
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






-- RemoveTimeSlotID



ALTER PROCEDURE RemoveTimeSlotID
    @timeSlotID	int,
	@ownerID	int

AS
BEGIN

SET NOCOUNT ON;

   -- check inputs

   IF (@timeSlotID IS NULL)
   BEGIN
      RAISERROR('invalid value: @timeSlotID cannot be NULL', 16, 1)
      RETURN -1
   END

   IF (@ownerID IS NULL)
   BEGIN
      RAISERROR('invalid value: @ownerID cannot be NULL', 16, 1)
      RETURN -1
   END

   
   -- is the new time slot already taken?
   IF EXISTS(SELECT * FROM Meeting WHERE timeSlotID = @timeSlotID)
   BEGIN
      RAISERROR('invalid value: @TimeSlotID is being used', 16, 1)
      return -2
   END


   -- OK, ready to do a transaction
   SET TRANSACTION ISOLATION LEVEL READ COMMITTED

 
   
   BEGIN TRY
      BEGIN TRAN

  DELETE  [TimeSlot]
  WHERE   timeSlotID = @timeSlotID and
		timeSlotSetID in (	
			select timeSlotSetID
			from TimeSlotSet
			where ownerUserID = @ownerID)

      COMMIT TRAN
   END TRY
   BEGIN CATCH
     
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






-- ClearDay




ALTER PROCEDURE ClearDay

    @date	Date

AS
BEGIN

SET NOCOUNT ON;

   -- check inputs

   IF (@date IS NULL)
   BEGIN
      RAISERROR('invalid value: @date cannot be NULL', 16, 1)
      RETURN -1
   END


   -- OK, ready to do a transaction
   SET TRANSACTION ISOLATION LEVEL READ COMMITTED

   -- is the time slot already taken for a meeting?
   IF EXISTS(SELECT * FROM Meeting WHERE timeSlotID in (select timeSlotID from TimeSlot
														where Convert(date, beginTime) = Convert(date, @date)))
   BEGIN
      RAISERROR('invalid value: @TimeSlotID is being used', 16, 1)
      return -2
   END
   
   BEGIN TRY
      BEGIN TRAN

		DELETE  [TimeSlot]
		WHERE   Convert(date, beginTime) = Convert(date, @date)

      COMMIT TRAN
   END TRY
   BEGIN CATCH
     
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