#include QMK_KEYBOARD_H


// Each layer gets a name for readability, which is then used in the keymap matrix below.
// The underscores don't mean anything - you can have a layer called STUFF or any other name.
// Layer names don't all need to be of the same length, obviously, and you can also skip them
// entirely and just use numbers.
#define _QWERTY 0

enum custom_keycodes {
  QWERTY = SAFE_RANGE,
  CD_SHOP,
  VIM_WORK_LIST_ROUTES,
  VIM_WORK_LIST_CONTROLLERS,
  VIM_WORK_LIST_COMPONENTS,
  VIM_WORK_LIST_TEMPLATES,
  VIM_WORK_LIST_STYLES,
  VIM_WORK_LIST_HANDLEBAR_HELPERS,
  VIM_WORK_LIST_STORES,
  VIM_WORK_LIST_MODELS,
  VIM_WORK_LIST_ACTIONS,
  VIM_WORK_GET_MIGRATIONS_SHARED,
  VIM_WORK_GET_MIGRATIONS_CLIENT,
  VIM_WORK_GOTO_TP,
};

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {

/* Qwerty
 * ,-----------------------------------------------------------------------------------.
 * |      |      |      |      |      |      |      |      |      |      |      |      |
 * |------+------+------+------+------+-------------+------+------+------+------+------|
 * |Routes|Ctrlrs|Compts|Tmplts|Styles|      |      |      |      |      |      |      |
 * |------+------+------+------+------+------|------+------+------+------+------+------|
 * |Stores|Models|Actns |MigSh |MigCl |      |      |      |      |      |      |      |
 * |------+------+------+------+------+------+------+------+------+------+------+------|
 * |CdShop|      |      |      |      |      |      |      |      |      |      |      |
 * `-----------------------------------------------------------------------------------'
 */
[_QWERTY] = LAYOUT_ortho_4x12( \
  XXXXXX,  XXXXXX,    XXXXXX,    XXXXXXX,    XXXXXXX,    XXXXXX,  XXXXXX,  XXXXXX,    XXXXXX,    XXXXXXX,    XXXXXXX,    XXXXXX, \
  VIM_WORK_LIST_ROUTES,  VIM_WORK_LIST_CONTROLLERS,    VIM_WORK_LIST_COMPONENTS,    VIM_WORK_LIST_TEMPLATES,    VIM_WORK_LIST_STYLES,    VIM_WORK_LIST_HANDLEBAR_HELPERS,  XXXXXXX,    XXXXXXX,    XXXXXXX,    XXXXXXX,    XXXXXXX,    XXXXXXX, \
  VIM_WORK_LIST_STORES,  VIM_WORK_LIST_MODELS,    VIM_WORK_LIST_ACTIONS,    VIM_WORK_GET_MIGRATIONS_SHARED,    VIM_WORK_GET_MIGRATIONS_CLIENT,    XXXXXXX,  XXXXXXX,    XXXXXXX,    XXXXXXX,    XXXXXXX,    XXXXXXX,    XXXXXXX, \
  CD_SHOP,  XXXXXXX,    XXXXXXX,    XXXXXXX,    XXXXXXX,    XXXXXXX,  CD_SHOP,    XXXXXXX,    XXXXXXX,    XXXXXXX,    XXXXXXX,    XXXXXXX \
),

};

void persistent_default_layer_set(uint16_t default_layer) {
  eeconfig_update_default_layer(default_layer);
  default_layer_set(default_layer);
}

bool process_record_user(uint16_t keycode, keyrecord_t *record) {
  switch (keycode) {
    case QWERTY:
      if (record->event.pressed) {
        persistent_default_layer_set(1UL<<_QWERTY);
      }
      return false;
      break;
    case CD_SHOP:
      if (record->event.pressed) {
        SEND_STRING(":CdShopping"SS_TAP(X_ENTER));
      }
        break;
    case VIM_WORK_LIST_ROUTES:
      if (record->event.pressed) {
        SEND_STRING(":WorkListRoutes"SS_TAP(X_ENTER));
      }
        break;
    case VIM_WORK_LIST_CONTROLLERS:
      if (record->event.pressed) {
        SEND_STRING(":WorkListControllers"SS_TAP(X_ENTER));
      }
        break;
    case VIM_WORK_LIST_COMPONENTS:
      if (record->event.pressed) {
        SEND_STRING(":WorkListComponents"SS_TAP(X_ENTER));
      }
        break;
    case VIM_WORK_LIST_HANDLEBAR_HELPERS:
      if (record->event.pressed) {
        SEND_STRING(":WorkListHandlebarHelpers"SS_TAP(X_ENTER));
      }
        break;
    case VIM_WORK_LIST_TEMPLATES:
      if (record->event.pressed) {
        SEND_STRING(":WorkListTemplates"SS_TAP(X_ENTER));
      }
        break;
    case VIM_WORK_LIST_ACTIONS:
      if (record->event.pressed) {
        SEND_STRING(":WorkListActions"SS_TAP(X_ENTER));
      }
        break;
    case VIM_WORK_LIST_MODELS:
      if (record->event.pressed) {
        SEND_STRING(":WorkListModels"SS_TAP(X_ENTER));
      }
        break;
    case VIM_WORK_LIST_STORES:
      if (record->event.pressed) {
        SEND_STRING(":WorkListStores"SS_TAP(X_ENTER));
      }
        break;
    case VIM_WORK_LIST_STYLES:
      if (record->event.pressed) {
        SEND_STRING(":WorkListStyles"SS_TAP(X_ENTER));
      }
        break;
    case VIM_WORK_GET_MIGRATIONS_SHARED:
      if (record->event.pressed) {
        SEND_STRING(":WorkGetMigrationsShared"SS_TAP(X_ENTER));
      }
        break;
    case VIM_WORK_GET_MIGRATIONS_CLIENT:
      if (record->event.pressed) {
        SEND_STRING(":WorkGetMigrationsClient"SS_TAP(X_ENTER));
      }
        break;
    case VIM_WORK_GOTO_TP:
      if (record->event.pressed) {
        SEND_STRING(":WorkGotoTp"SS_TAP(X_ENTER));
      }
        break;
  }
  return true;
}
