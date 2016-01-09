*&---------------------------------------------------------------------*
*& Report  ZTEST_PATTERN_DECORATOR
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT  ztest_pattern_decorator.

CLASS lcl_a_component DEFINITION ABSTRACT.

  PUBLIC SECTION.
    METHODS: operate ABSTRACT.

ENDCLASS.

CLASS lcl_concrete_component_a DEFINITION INHERITING FROM lcl_a_component.

  PUBLIC SECTION.
    METHODS: operate REDEFINITION.

ENDCLASS.

CLASS lcl_concrete_component_a IMPLEMENTATION.

  METHOD operate.
    WRITE:/ 'ConcreteComponentA operates'.
  ENDMETHOD.

ENDCLASS.

CLASS lcl_concrete_component_b DEFINITION INHERITING FROM lcl_a_component.

  PUBLIC SECTION.
    METHODS: operate REDEFINITION.

ENDCLASS.

CLASS lcl_concrete_component_b IMPLEMENTATION.

  METHOD operate.
    WRITE:/ 'ConcreteComponentB operates'.
  ENDMETHOD.

ENDCLASS.

CLASS lcl_a_decorater DEFINITION ABSTRACT INHERITING FROM lcl_a_component.

  PUBLIC SECTION.
    METHODS: constructor IMPORTING im_component TYPE REF TO lcl_a_component.


  PROTECTED SECTION.
    DATA: mo_component TYPE REF TO lcl_a_component.
ENDCLASS.

CLASS lcl_a_decorater IMPLEMENTATION.

  METHOD constructor.
    super->constructor( ).
    me->mo_component = im_component.
  ENDMETHOD.

ENDCLASS.

CLASS lcl_concrete_decorator1 DEFINITION INHERITING FROM lcl_a_decorater.

  PUBLIC SECTION.
    METHODS: constructor IMPORTING im_component TYPE REF TO lcl_a_component.
    METHODS: operate REDEFINITION.

ENDCLASS.


CLASS lcl_concrete_decorator1 IMPLEMENTATION.

  METHOD constructor.
    super->constructor( im_component ).
  ENDMETHOD.

  METHOD operate.
    mo_component->operate( ).
    WRITE:/ 'ConcreteDecorator1 operates!'.
  ENDMETHOD.

ENDCLASS.

CLASS lcl_concrete_decorator2 DEFINITION INHERITING FROM lcl_a_decorater.

  PUBLIC SECTION.
    METHODS: constructor IMPORTING im_component TYPE REF TO lcl_a_component.
    METHODS: operate REDEFINITION.

ENDCLASS.


CLASS lcl_concrete_decorator2 IMPLEMENTATION.

  METHOD constructor.
    super->constructor( im_component ).
  ENDMETHOD.

  METHOD operate.
    mo_component->operate( ).
    WRITE:/ 'ConcreteDecorator2 operates!'.
  ENDMETHOD.

ENDCLASS.

CLASS lcl_concrete_decorator3 DEFINITION INHERITING FROM lcl_a_decorater.

  PUBLIC SECTION.
    METHODS: constructor IMPORTING im_component TYPE REF TO lcl_a_component.
    METHODS: operate REDEFINITION.

ENDCLASS.

CLASS lcl_concrete_decorator3 IMPLEMENTATION.

  METHOD constructor.
    super->constructor( im_component ).
  ENDMETHOD.

  METHOD operate.
    mo_component->operate( ).
    WRITE:/ 'ConcreteDecorator3 operates!'.
  ENDMETHOD.

ENDCLASS.


START-OF-SELECTION.

  DATA lo_comp_a TYPE REF TO lcl_a_component.
  DATA lo_comp_b TYPE REF TO lcl_a_component.
  DATA lo_tmp TYPE REF TO lcl_a_component.

  CREATE OBJECT lo_comp_a TYPE lcl_concrete_component_a.
  lo_comp_a->operate( ).

  WRITE:/.
  WRITE:/ '-------- ComponentA ---------'.
  WRITE:/.

  lo_tmp = lo_comp_a.

  CREATE OBJECT lo_comp_a TYPE lcl_concrete_decorator1
    EXPORTING
      im_component = lo_tmp.

  lo_comp_a->operate( ).


  WRITE:/.
  WRITE:/ '-------- ComponentB ---------'.
  WRITE:/.

  CREATE OBJECT lo_comp_b TYPE lcl_concrete_component_b.

  lo_tmp = lo_comp_b.

  CREATE OBJECT lo_comp_b TYPE lcl_concrete_decorator2
    EXPORTING
      im_component = lo_tmp.

  lo_tmp = lo_comp_b.

  CREATE OBJECT lo_comp_b TYPE lcl_concrete_decorator3
    EXPORTING
      im_component = lo_tmp.

  lo_tmp = lo_comp_b.

  CREATE OBJECT lo_comp_b TYPE lcl_concrete_decorator1
    EXPORTING
      im_component = lo_tmp.

  lo_comp_b->operate( ).