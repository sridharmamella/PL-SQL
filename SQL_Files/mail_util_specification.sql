create or replace PACKAGE mail_util
IS
  g_smtp_host VARCHAR2 (256)            := 'localhost';
  g_smtp_port pls_integer               := 1925;
  g_smtp_domain VARCHAR2 (256)          := 'gmail.com';
  g_mailer_id   CONSTANT VARCHAR2 (256) := 'Sending From Cars4you.com';
  -- send mail using UTL_SMTP
  function send_mail(
      p_sender    IN VARCHAR2 ,
      p_recipient IN VARCHAR2 ,
      p_subject   IN VARCHAR2 ,
      p_message   IN VARCHAR2 ) return boolean;
END;