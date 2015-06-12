create or replace PACKAGE body mail_util
IS
  -- Write a MIME header
PROCEDURE write_mime_header(
    p_conn  IN OUT nocopy utl_smtp.connection ,
    p_name  IN VARCHAR2 ,
    p_value IN VARCHAR2 )
IS
BEGIN
  utl_smtp.write_data ( p_conn , p_name || ': ' || p_value || utl_tcp.crlf );
END;
function send_mail(
    p_sender    IN VARCHAR2 ,
    p_recipient IN VARCHAR2 ,
    p_subject   IN VARCHAR2 ,
    p_message   IN VARCHAR2 )
return boolean
is
  l_conn utl_smtp.connection;
  nls_charset VARCHAR2(255);
BEGIN
  -- get characterset
  SELECT value
  INTO nls_charset
  FROM nls_database_parameters
  WHERE parameter = 'NLS_CHARACTERSET';
  -- establish connection and autheticate
  l_conn := utl_smtp.open_connection (g_smtp_host, g_smtp_port);
  utl_smtp.ehlo(l_conn, g_smtp_domain);
  -- set from/recipient
  utl_smtp.command(l_conn, 'MAIL FROM: <'||p_sender||'>');
  utl_smtp.command(l_conn, 'RCPT TO: <'||p_recipient||'>');
  -- write mime headers
  utl_smtp.open_data (l_conn);
  write_mime_header (l_conn, 'From', p_sender);
  write_mime_header (l_conn, 'To', p_recipient);
  write_mime_header (l_conn, 'Subject', p_subject);
  write_mime_header (l_conn, 'Content-Type', 'text/plain');
  write_mime_header (l_conn, 'X-Mailer', g_mailer_id);
  utl_smtp.write_data (l_conn, utl_tcp.crlf);
  -- write message body
  utl_smtp.write_data (l_conn, p_message);
  utl_smtp.close_data (l_conn);
  -- end connection
  utl_smtp.quit (l_conn);
  return true;
EXCEPTION
WHEN OTHERS THEN
  BEGIN
    utl_smtp.quit(l_conn);
  EXCEPTION
  WHEN OTHERS THEN
    NULL;
  
  END;
  raise_application_error(-20000,'Failed to send mail due to the following error: ' || sqlerrm);
    return false;
  
END;
END;