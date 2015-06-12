CREATE OR REPLACE TRIGGER Track_Booking BEFORE
  INSERT OR
  UPDATE OR
  DELETE ON booking FOR EACH row BEGIN CASE WHEN INSERTING THEN
      INSERT
      INTO booking_hist
        (
          BOOKING_ID ,
          BOOKING_STATUS_CODE ,
          customer_id,
          REG_NUMBER ,
          DATE_FROM ,
          DATE_TO ,
          CONFIRM_LETTER_SENT_FLAG ,
          PAYMENT_RECEIVED_FLAG ,
          booking_date,
          date_updated
        )
        VALUES
        (
          :new.BOOKING_ID ,
          :new.BOOKING_STATUS_CODE ,
          :new.customer_id,
          :new.REG_NUMBER ,
          :new.DATE_FROM ,
          :new.DATE_TO ,
          :new.CONFIRM_LETTER_SENT_FLAG ,
          :new.PAYMENT_RECEIVED_FLAG ,
          TRUNC(sysdate),
          TRUNC(sysdate)
        );
    WHEN UPDATING THEN
      UPDATE booking_hist
      SET BOOKING_STATUS_CODE       =:new.BOOKING_STATUS_CODE ,
        CONFIRM_LETTER_SENT_FLAG    =:new.CONFIRM_LETTER_SENT_FLAG,
        PAYMENT_RECEIVED_FLAG       =:new.PAYMENT_RECEIVED_FLAG ,
        date_updated                =TRUNC(sysdate)
      WHERE booking_hist.booking_id =:new.booking_id;
    WHEN DELETING THEN
      DELETE FROM booking_hist WHERE booking_id=:old.Booking_id;
    END CASE;
  END;
  
/