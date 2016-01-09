*&---------------------------------------------------------------------*
*& Report  ZTEST_PATTERN_STATE
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT ztest_pattern_state.

INTERFACE lif_state.

  METHODS: open.
  METHODS: close.


ENDINTERFACE.

CLASS lcl_door DEFINITION.

  PUBLIC SECTION.
    METHODS: constructor.
    METHODS: set_current_state IMPORTING im_state TYPE REF TO lif_state.

    METHODS: open.
    METHODS: close.

  PRIVATE SECTION.
    DATA: mo_current_state TYPE REF TO lif_state.

ENDCLASS.

CLASS lcl_open DEFINITION.

  PUBLIC SECTION.
    INTERFACES lif_state.
    METHODS: constructor IMPORTING im_context TYPE REF TO lcl_door.

  PRIVATE SECTION.
    DATA: mo_context TYPE REF TO lcl_door.

ENDCLASS.

CLASS lcl_close DEFINITION.

  PUBLIC SECTION.
    INTERFACES lif_state.
    METHODS: constructor IMPORTING im_context TYPE REF TO lcl_door.

  PRIVATE SECTION.
    DATA: mo_context TYPE REF TO lcl_door.

ENDCLASS.


CLASS lcl_door IMPLEMENTATION.

  METHOD constructor.
    DATA lo_state TYPE REF TO lif_state.

    CREATE OBJECT lo_state TYPE lcl_close
      EXPORTING
        im_context = me.

    me->set_current_state( lo_state ).
  ENDMETHOD.

  METHOD set_current_state.
    mo_current_state = im_state.
  ENDMETHOD.

  METHOD open.
    mo_current_state->open( ).
  ENDMETHOD.

  METHOD close.
    mo_current_state->close( ).
  ENDMETHOD.

ENDCLASS.


CLASS lcl_close IMPLEMENTATION.

  METHOD constructor.
    mo_context = im_context.
  ENDMETHOD.

  METHOD lif_state~close.
    WRITE:/ 'It is closed!'.
  ENDMETHOD.

  METHOD lif_state~open.
    DATA lo_state TYPE REF TO lif_state.

    WRITE:/ 'Door is open'.

    CREATE OBJECT lo_state TYPE lcl_open
      EXPORTING
        im_context = mo_context.

    mo_context->set_current_state( lo_state ).
  ENDMETHOD.

ENDCLASS.


CLASS lcl_open IMPLEMENTATION.

  METHOD constructor.
    mo_context = im_context.
  ENDMETHOD.

  METHOD lif_state~close.
    DATA lo_state TYPE REF TO lif_state.

    WRITE:/ 'Door is closed'.

    CREATE OBJECT lo_state TYPE lcl_close
      EXPORTING
        im_context = mo_context.

    mo_context->set_current_state( lo_state ).
  ENDMETHOD.

  METHOD lif_state~open.
    WRITE:/ 'It is open!'.
  ENDMETHOD.

ENDCLASS.


START-OF-SELECTION.

  DATA lo_door TYPE REF TO lcl_door.

  CREATE OBJECT lo_door.

  lo_door->open( ).
  lo_door->open( ).
  lo_door->close( ).
  lo_door->open( ).
  lo_door->close( ).