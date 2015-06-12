create or replace PACKAGE cars4you
AS
  FUNCTION register_customer(
      i_forename customer.CUST_FORENAME%type,
      i_surname customer.CUST_surname%type,
      i_gender customer.gender%type,
      i_email customer.EMAIL_ADDRESS%type,
      i_phone customer.phone_number%type,
      i_ADDRESS_LINE1 customer.ADDRESS_LINE1%type,
      i_ADDRESS_LINE2 customer.ADDRESS_LINE2%type,
      i_ADDRESS_LINE3 customer.ADDRESS_LINE3%type,
      i_TOWN customer.TOWN%type,
      i_post_code customer.post_code%type,
      i_Country customer.country%type)
    RETURN NUMBER ;
  FUNCTION register_customer(
      i_forename customer.CUST_FORENAME%type,
      i_surname customer.CUST_surname%type,
      i_email customer.EMAIL_ADDRESS%type )
    RETURN NUMBER ;
  FUNCTION book_a_car(
      cust_id NUMBER,
      i_forename customer.CUST_FORENAME%type,
      i_surname customer.CUST_surname%type,
      i_email customer.EMAIL_ADDRESS%type,
      manufacturer_code     VARCHAR2,
      model_code            VARCHAR2,
      vehicle_category_code VARCHAR2,
      from_date             DATE,
      to_date               DATE)
    RETURN BOOLEAN;
  FUNCTION get_availability(
      manufacturer_code     VARCHAR2,
      model_code            VARCHAR2,
      vehicle_category_code VARCHAR2,
      start_date            DATE,
      end_date              DATE,
      o_reg_number OUT VARCHAR2 )
    RETURN BOOLEAN;
  FUNCTION get_customer_id(
      forename VARCHAR2,
      surname  VARCHAR2,
      email    VARCHAR2)
    RETURN NUMBER;
  PROCEDURE print_booking_report;
  PROCEDURE add_new_vehicle_to_fleet(
      REG_NUMBER            VARCHAR2,
      MANUFACTURER_CODE     VARCHAR2,
      MODEL_CODE            VARCHAR2,
      VEHICLE_CATEGORY_CODE VARCHAR2,
      CURRENT_MILEAGE       NUMBER,
      DAILY_HIRE_RATE       NUMBER,
      DATE_MOT_DUE          DATE);
  --PROCEDURE populate_pre_live_data;
  PROCEDURE add_new_booking_status(
      BOOKING_STATUS_CODE        VARCHAR2,
      BOOKING_STATUS_DESCRIPTION VARCHAR2);
  PROCEDURE add_new_vehicle_category(
      CATEGORY_CODE        VARCHAR2 ,
      CATEGORY_DESCRIPTION VARCHAR2 );
  PROCEDURE add_new_manufacturer(
      MANUFACTURER_CODE   VARCHAR2,
      MANUFACTURER_NAME   VARCHAR2,
      MANUFACTURER_DETALS VARCHAR2);
  PROCEDURE add_new_model(
      MODEL_CODE      VARCHAR2,
      DAILY_HIRE_RATE VARCHAR2,
      MODEL_NAME      VARCHAR2);
  PROCEDURE update_payment_status(
      i_booking_id NUMBER);
END cars4you;