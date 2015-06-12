Execution plan:

step 1: Run your script 1 DML queries 
step 2: Run 'DDL_Script_to_create_a_table_for_trigger_insert'
step 3: Create Trigger using 'trigger_to_track_the_booking'
step 4: Execute cars4you pkg specification script 'cars4you_pkg_specification'
step 5: Execute cars4you pkg body script 'cars4you_pkg_body'
step 6: Execute mail util pkg specification script 'mail_util_specification'
step 7: Execute mail util pkg body script 'mail_util_specification'



Step 8: populate the pre live data using below script
begin
cars4you.populate_pre_live_data;
end;
/

step 9: add vehicle to your fleet
begin
cars4you.add_new_vehicle_to_fleet('TS05 6389','FRD','ECOSP','SMALL',10,100,'12-jan-2008');
end;
/

step 10: you can register your customer or you can directly book a car without prior registration,this procedure will take care of registering and booking.

declare
  booking_status boolean;
begin
booking_status:= cars4you.book_a_car
  (
    null,---cust id if you already know it ow pass ur email then your customer id will be searched and booking will be done against it
      'ABC',---forname
    'ABCD',--surname
       'abcxyz@xyz.com',--email id (if you forgot the cust id then pass ur email then your customer id will be searched and booking will be done against it)
   'FRD',---which company car you want to book
   'ECOSP',--which model you want
    'SMALL',---what type of vehicle you want ('SMALL','FAMILY','VAN')
   '02-mar-2015',--- start date
   '08-mar-2015'--end date
  );
  dbms_output.put_line('is Booking successful: '||case booking_status when true then 'true' when false then 'false' end);
end;
/

OR

--if you remember your customer_id then pass cust_id

declare
  booking_status boolean;
begin
booking_status:= cars4you.book_a_car
  (
    null,---cust id if you already know it ow pass ur email then your customer id will be searched and booking will be done against it
      null,---forname
    null,--surname
      'a.scola@gmail.com',--email id (if you forgot the cust id then pass ur email then your customer id will be searched and booking will be done against it)
   'FRD',---which company car you want to book
   'ECOSP',--which model you want
    'SMALL',---what type of vehicle you want ('SMALL','FAMILY','VAN')
   '12-mar-2015',--- start date
   '16-mar-2015'--end date
  );
  dbms_output.put_line('is Booking successful: '||case booking_status when true then 'true' when false then 'false' end);
end;
/


step 11: we have to pay the amount at the time of hire.
begin
cars4you.update_payment_status(42--booking id
);
end;



step 12: If you want to pull today's booking details report 

begin
cars4you.print_booking_report;
end;

