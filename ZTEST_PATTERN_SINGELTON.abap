*&---------------------------------------------------------------------*
*& Report  ZTEST_PATTERN_SINGELTON
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT  ztest_pattern_singelton.


CLASS lcl_singelton DEFINITION CREATE PRIVATE.

  PUBLIC SECTION.

    CLASS-METHODS: get_instance RETURNING value(re_singelton) TYPE REF TO lcl_singelton.
    METHODS: set_name IMPORTING im_name TYPE string,
      get_name RETURNING value(re_name) TYPE string.
  PRIVATE SECTION.
    METHODS constructor.
    CLASS-DATA mo_singelton TYPE REF TO lcl_singelton.
    DATA mv_name TYPE string.


ENDCLASS.


CLASS lcl_singelton IMPLEMENTATION.

  METHOD get_instance.

    IF mo_singelton IS INITIAL.
      CREATE OBJECT mo_singelton.
    ENDIF.

    re_singelton = mo_singelton.

  ENDMETHOD.

  METHOD get_name.
    re_name = mv_name.
  ENDMETHOD.

  METHOD set_name.
    mv_name = im_name.
  ENDMETHOD.

  METHOD constructor.

  ENDMETHOD.

ENDCLASS.


START-OF-SELECTION.

  DATA lo_object1 TYPE REF TO lcl_singelton.
  DATA lo_object2 TYPE REF TO lcl_singelton.


  lo_object1 = lcl_singelton=>get_instance( ).
  lo_object1->set_name( 'Hello World' ).
  lo_object2 = lcl_singelton=>get_instance( ).

  DATA: lv_string TYPE string.

  lv_string = lo_object1->get_name( ).

  WRITE:/ lv_string.

  lv_string = lo_object2->get_name( ).

  WRITE:/ lv_string.