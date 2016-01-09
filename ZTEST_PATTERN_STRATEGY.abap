*&---------------------------------------------------------------------*
*& Report  ZTEST_PATTERN_STRATEGY
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT  ztest_pattern_strategy.

INTERFACE lif_strategy.
  METHODS: execute_algorithm.
ENDINTERFACE.

CLASS lcl_context DEFINITION.

  PUBLIC SECTION.
    METHODS: constructor.
    METHODS: execute.
    METHODS: set_strategy IMPORTING im_strategy TYPE REF TO lif_strategy.
    METHODS: get_strategy RETURNING value(re_strategy) TYPE REF TO lif_strategy.


  PRIVATE SECTION.
    DATA mo_strategy TYPE REF TO lif_strategy.


ENDCLASS.

CLASS lcl_concrete_strategy_a DEFINITION.

  PUBLIC SECTION.
    INTERFACES lif_strategy.

ENDCLASS.

CLASS lcl_concrete_strategy_b DEFINITION.

  PUBLIC SECTION.
    INTERFACES lif_strategy.

ENDCLASS.

CLASS lcl_concrete_strategy_c DEFINITION.

  PUBLIC SECTION.
    INTERFACES lif_strategy.

ENDCLASS.

CLASS lcl_context IMPLEMENTATION.

  METHOD constructor.
    CREATE OBJECT mo_strategy TYPE lcl_concrete_strategy_a.
  ENDMETHOD.

  METHOD execute.
    mo_strategy->execute_algorithm( ).
  ENDMETHOD.

  METHOD set_strategy.
    mo_strategy = im_strategy.
  ENDMETHOD.

  METHOD get_strategy.
    re_strategy = mo_strategy.
  ENDMETHOD.

ENDCLASS.


CLASS lcl_concrete_strategy_a IMPLEMENTATION.

  METHOD lif_strategy~execute_algorithm.
    WRITE:/ 'Algorithm: Dijkstra'.
  ENDMETHOD.

ENDCLASS.


CLASS lcl_concrete_strategy_b IMPLEMENTATION.

  METHOD lif_strategy~execute_algorithm.
    WRITE:/ 'Algorithm: Kruskal'.
  ENDMETHOD.

ENDCLASS.


CLASS lcl_concrete_strategy_c IMPLEMENTATION.

  METHOD lif_strategy~execute_algorithm.
    WRITE:/ 'Algorithm: Floodfill'.
  ENDMETHOD.


ENDCLASS.



START-OF-SELECTION.

  DATA go_context TYPE REF TO lcl_context.
  DATA go_new_strategy TYPE REF TO lif_strategy.

  CREATE OBJECT go_context.

  go_context->execute( ).

  CREATE OBJECT go_new_strategy TYPE lcl_concrete_strategy_b.
  go_context->set_strategy( im_strategy = go_new_strategy  ).

  go_context->execute( ).