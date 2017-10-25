*&---------------------------------------------------------------------*
*& Include zabapgit_user_exit
*&---------------------------------------------------------------------*

CLASS lcl_user_exit DEFINITION CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES:
      lif_exit.

  PRIVATE SECTION.
    METHODS:
      is_online_repo
        IMPORTING iv_repo_url             TYPE csequence
        RETURNING VALUE(r_is_online_repo) TYPE abap_bool.

ENDCLASS.

CLASS lcl_user_exit IMPLEMENTATION.

  METHOD lif_exit~change_local_host.
* default behavior
    RETURN.
  ENDMETHOD.

  METHOD lif_exit~allow_sap_objects.
    rv_allowed = abap_false.
  ENDMETHOD.

  METHOD lif_exit~change_proxy_url.

    IF is_online_repo( iv_repo_url ) = abap_false .
      CLEAR: c_proxy_url.
    ENDIF.

  ENDMETHOD.

  METHOD lif_exit~change_proxy_port.

    IF is_online_repo( iv_repo_url ) = abap_false .
      CLEAR: c_proxy_port.
    ENDIF.

  ENDMETHOD.

  METHOD lif_exit~change_proxy_authentication.

    IF is_online_repo( iv_repo_url ) = abap_false .
      CLEAR: c_proxy_authentication.
    ENDIF.

  ENDMETHOD.

  METHOD is_online_repo.

    r_is_online_repo = boolc( contains( val   = iv_repo_url
                                        regex = `github|gitlab|bitbucket` ) ).

  ENDMETHOD.

ENDCLASS.
