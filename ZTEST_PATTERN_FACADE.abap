*&---------------------------------------------------------------------*
*& Report  ZTEST_PATTERN_FACADE
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT  ztest_pattern_facade.

CLASS lcl_attachment DEFINITION.

  PUBLIC SECTION.
    METHODS constructor.

ENDCLASS.

CLASS lcl_document DEFINITION.

  PUBLIC SECTION.
    METHODS add_text IMPORTING im_text TYPE string.
    METHODS add_attachment IMPORTING im_attachment TYPE REF TO lcl_attachment.

  PRIVATE SECTION.
    DATA m_text TYPE string.
    DATA mo_attachment TYPE REF TO lcl_attachment.


ENDCLASS.


CLASS lcl_email DEFINITION.

  PUBLIC SECTION.
    METHODS constructor.
    METHODS get_document RETURNING value(re_doc) TYPE REF TO lcl_document.
    METHODS send IMPORTING im_receiver TYPE string.

  PRIVATE SECTION.
    DATA mo_document TYPE REF TO lcl_document.

ENDCLASS.


CLASS lcl_email IMPLEMENTATION.

  METHOD constructor.
    CREATE OBJECT mo_document.
    WRITE:/ 'create document'.
  ENDMETHOD.

  METHOD get_document.
    re_doc = mo_document.
    RETURN.
  ENDMETHOD.

  METHOD send.
    WRITE:/ 'send email to ', im_receiver.
  ENDMETHOD.

ENDCLASS.


CLASS lcl_document IMPLEMENTATION.
  METHOD add_text.
    m_text = im_text.
    WRITE:/ 'add text'.
  ENDMETHOD.

  METHOD add_attachment.
    mo_attachment = im_attachment.
    WRITE:/ 'add attachment'.
  ENDMETHOD.

ENDCLASS.



CLASS lcl_attachment IMPLEMENTATION.
  METHOD constructor.
    WRITE:/ 'create attachment'.
  ENDMETHOD.
ENDCLASS.


CLASS lcl_email_client DEFINITION.
  PUBLIC SECTION.
    METHODS: send_mail IMPORTING im_text TYPE string
                                 im_receiver TYPE string
                                 im_attachment TYPE c.
ENDCLASS.

CLASS lcl_email_client IMPLEMENTATION.

  METHOD send_mail.

    DATA lo_mail TYPE REF TO lcl_email.
    DATA lo_doc TYPE REF TO lcl_document.

    CREATE OBJECT lo_mail.

    lo_doc = lo_mail->get_document( ).
    lo_doc->add_text( im_text ).

    IF im_attachment IS NOT INITIAL.
      DATA lo_attachment TYPE REF TO lcl_attachment.
      CREATE OBJECT lo_attachment.
      lo_doc->add_attachment( lo_attachment ).
    ENDIF.

    lo_mail->send( im_receiver ).


  ENDMETHOD.

ENDCLASS.


START-OF-SELECTION.



  DATA lo_mail_client TYPE REF TO lcl_email_client.

  CREATE OBJECT lo_mail_client.

  lo_mail_client->send_mail(
  EXPORTING
    im_text       = 'Hello World!'
    im_receiver   = 'test@test.com'
    im_attachment = 'X'
    ).