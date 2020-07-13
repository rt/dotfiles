#include QMK_KEYBOARD_H
#include "debug.h"
#include "action_layer.h"
#include "version.h"
#include "ryan.h"

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
/* 0: Basic QWERTY layer
 *
 * ,---------------------------------------------.           ,---------------------------------------------.
 * |   `    |  1  |  2  |  3  |  4  |  5  | Esc  |           | Esc  |  6  |  7  |  8  |  9  |  0  |   Del  |
 * |--------+-----+-----+-----+-----+------------|           |------+-----+-----+-----+-----+-----+--------|
 * |  Tab   |  Q  |  W  |  E  |  R  |  T  |  [{  |           |  ]}  |  Y  |  U  |  I  |  O  |  P  |  BSPC  |
 * |--------+-----+-----+-----+-----+-----|      |           |      |-----+-----+-----+-----+-----+--------|
 * |  ESC   |  A  |  S  |  D  |  F  |  G  |------|           |------|  H  |  J  |  K  |  L  |  ;  |    '   |
 * |--------+-----+-----+-----+-----+-----|  L1  |           |  L1  |-----+-----+-----+-----+-----+--------|
 * | LShift |  Z  |  X  |  C  |  V  |  B  |      |           |      |  N  |  M  |  ,  |  .  |  /  | Enter  |
 * `--------+-----+-----+-----+-----+------------'           `------------+-----+-----+-----+-----+--------'
 *   | Num  |Ctrl | Alt |LGUI |Lower|                                     |Raise|Left |Down | Up  |Right |
 *   `------------------------------'                                     `------------------------------'
 *                                   ,------------.          ,------------.
 *                                   |Play |Mouse |          | Num  |Mouse|
 *                              ,----|-----|------|          |------+-----+-----.
 *                              |    |     | Alt  |          | Alt  |     |     |
 *                              |BSPC|LOWER|------|          |------|RAISE|Space|
 *                              |    |     | LGUI |          | LGUI |     |     |
 *                              `-----------------'          `------------------'
 */
[_QWERTY] = LAYOUT_ergodox(
  // left hand
  KC_GRV,   KC_1,    KC_2,    KC_3,    KC_4,    KC_5, KC_ESC,
  QWER_L00, QWER_L01, QWER_L02, QWER_L03, QWER_L04, QWER_L05, KC_LBRACKET,
  QWER_L10, QWER_L11, QWER_L12, QWER_L13, QWER_L14, QWER_L15,
  QWER_L20, QWER_L21, QWER_L22, QWER_L23, QWER_L24, QWER_L25, KC_FN1,
  _______, QWER_L30, QWER_L31, QWER_L32, QWER_L33, 

                                                  KC_MPLY,  _______,
                                                            KC_LALT,
                                      QWER_L34,  QWER_L35,    KC_LGUI,

  // right hand
  KC_ESC,      KC_6, KC_7,  KC_8,    KC_9,    KC_0,                KC_DEL,
  KC_RBRACKET, QWER_R00, QWER_R01, QWER_R02, QWER_R03, QWER_R04, QWER_R05,
               QWER_R10, QWER_R11, QWER_R12, QWER_R13, QWER_R14, QWER_R15,
  KC_FN1,      QWER_R20, QWER_R21, QWER_R22, QWER_R23, QWER_R24, QWER_R25,
               QWER_R32, QWER_R33, QWER_R34, QWER_R35, _______,

  KC_LCTL, _______,
  KC_LALT,
  KC_LGUI,  QWER_R30,      QWER_R31
),

[_COLE] = LAYOUT_ergodox(
  // left hand
  KC_GRV,   KC_1,    KC_2,    KC_3,    KC_4,    KC_5, KC_ESC,
  COLE_L00, COLE_L01, COLE_L02, COLE_L03, COLE_L04, COLE_L05, KC_LBRACKET,
  COLE_L10, COLE_L11, COLE_L12, COLE_L13, COLE_L14, COLE_L15,
  COLE_L20, COLE_L21, COLE_L22, COLE_L23, COLE_L24, COLE_L25, KC_FN1,
  _______, COLE_L30, COLE_L31, COLE_L32, COLE_L33, 

                                                  KC_MPLY,  _______,
                                                            KC_LALT,
                                      COLE_L34,  COLE_L35,    KC_LGUI,

  // right hand
  KC_ESC,      KC_6, KC_7,  KC_8,    KC_9,    KC_0,                KC_DEL,
  KC_RBRACKET, COLE_R00, COLE_R01, COLE_R02, COLE_R03, COLE_R04, COLE_R05,
               COLE_R10, COLE_R11, COLE_R12, COLE_R13, COLE_R14, COLE_R15,
  KC_FN1,      COLE_R20, COLE_R21, COLE_R22, COLE_R23, COLE_R24, COLE_R25,
               COLE_R32, COLE_R33, COLE_R34, COLE_R35, _______,

  KC_LCTL, _______,
  KC_LALT,
  KC_LGUI,  COLE_R30,      COLE_R31
),


[_LOWER] = LAYOUT_ergodox(
  // left hand
  VRSN,    KC_F1,   KC_F2,   KC_F3,   KC_F4,   KC_F5,   KC_F11,
  LOW_L00, LOW_L01, LOW_L02, LOW_L03, LOW_L04, LOW_L05, _______,
  LOW_L10, LOW_L11, LOW_L12, LOW_L13, LOW_L14, LOW_L15,
  LOW_L20, LOW_L21, LOW_L22, LOW_L23, LOW_L24, LOW_L25, _______,
  _______, LOW_L30, LOW_L31, LOW_L32, LOW_L33,

                                                  _______, _______,
                                                           _______,
                                        LOW_L34, LOW_L35, _______,

  // right hand
  KC_F12, KC_F6,  KC_F7,   KC_F8,   KC_F9,   KC_F10,  KC_F11,
  _______, LOW_R00, LOW_R01, LOW_R02, LOW_R03, LOW_R04, LOW_R05,
            LOW_R10, LOW_R11, LOW_R12, LOW_R13, LOW_R14, LOW_R15,
  _______, LOW_R20, LOW_R21, LOW_R22, LOW_R23, LOW_R24, LOW_R25,
                    LOW_R32, LOW_R33, LOW_R34, LOW_R35, _______,

  _______, _______,
  _______,
  _______, LOW_R30,  LOW_R31
),

[_RAISE] = LAYOUT_ergodox(
  // left hand
  VRSN,    KC_F1,   KC_F2,   KC_F3,   KC_F4,   KC_F5,   KC_F11,
  RAIS_L00, RAIS_L01, RAIS_L02, RAIS_L03, RAIS_L04, RAIS_L05, _______,
  RAIS_L10, RAIS_L11, RAIS_L12, RAIS_L13, RAIS_L14, RAIS_L15,
  RAIS_L20, RAIS_L21, RAIS_L22, RAIS_L23, RAIS_L24, RAIS_L25, _______,
  _______, RAIS_L30, RAIS_L31, RAIS_L32, RAIS_L33,

                                                  _______, _______,
                                                           _______,
                                        RAIS_L34, RAIS_L35, _______,

  // right hand
  KC_F12, KC_F6,  KC_F7,   KC_F8,   KC_F9,   KC_F10,  KC_F11,
  _______, RAIS_R00, RAIS_R01, RAIS_R02, RAIS_R03, RAIS_R04, RAIS_R05,
            RAIS_R10, RAIS_R11, RAIS_R12, RAIS_R13, RAIS_R14, RAIS_R15,
  _______, RAIS_R20, RAIS_R21, RAIS_R22, RAIS_R23, RAIS_R24, RAIS_R25,
                    RAIS_R32, RAIS_R33, RAIS_R34, RAIS_R35, _______,

  _______, _______,
  _______,
  _______, RAIS_R30,  RAIS_R31
),

[_NAV] = LAYOUT_ergodox(
  // left hand
  _______, _______, _______, _______, _______, _______, _______,
  NAV_L00, NAV_L01, NAV_L02, NAV_L03, NAV_L04, NAV_L05, _______,
  NAV_L10, NAV_L11, NAV_L12, NAV_L13, NAV_L14, NAV_L15,
  NAV_L20, NAV_L21, NAV_L22, NAV_L23, NAV_L24, NAV_L25, _______,
  _______, NAV_L30, NAV_L31, NAV_L32, NAV_L33, 

                                                  _______, _______,
                                                           _______,
                                        NAV_L34, NAV_L35, _______,

  // right hand
  _______, _______, _______, _______, _______, _______, _______,
  _______, NAV_R00, NAV_R01, NAV_R02, NAV_R03, NAV_R04, NAV_R05,
           NAV_R10, NAV_R11, NAV_R12, NAV_R13, NAV_R14, NAV_R15,
  _______, NAV_R20, NAV_R21, NAV_R22, NAV_R23, NAV_R24, NAV_R25,
                    NAV_R32, NAV_R33, NAV_R34, NAV_R35, _______,

  _______, _______,
  _______,
  _______, NAV_R30,  NAV_R31
),

[_GIT] = LAYOUT_ergodox(
  // left hand
  _______, _______, _______, _______, _______, _______, _______,
  GIT_L00, GIT_L01, GIT_L02, GIT_L03, GIT_L04, GIT_L05, _______,
  GIT_L10, GIT_L11, GIT_L12, GIT_L13, GIT_L14, GIT_L15,
  GIT_L20, GIT_L21, GIT_L22, GIT_L23, GIT_L24, GIT_L25, _______,
  _______, GIT_L30, GIT_L31, GIT_L32, GIT_L33,

                                                  _______, _______,
                                                           _______,
                                        GIT_L34, GIT_L35, _______,

  // right hand
  _______, _______, _______, _______, _______, _______, _______,
  _______, GIT_R00, GIT_R01, GIT_R02, GIT_R03, GIT_R04, GIT_R05,
           GIT_R10, GIT_R11, GIT_R12, GIT_R13, GIT_R14, GIT_R15,
  _______, GIT_R20, GIT_R21, GIT_R22, GIT_R23, GIT_R24, GIT_R25,
                    GIT_R32, GIT_R33, GIT_R34, GIT_R35, _______,

  _______, _______,
  _______,
  _______, GIT_R30,  GIT_R31
),
[_VHOME] = LAYOUT_ergodox(
  // left hand
  _______, _______, _______, _______, _______, _______, _______,
  VHOME_L00, VHOME_L01, VHOME_L02, VHOME_L03, VHOME_L04, VHOME_L05, _______,
  VHOME_L10, VHOME_L11, VHOME_L12, VHOME_L13, VHOME_L14, VHOME_L15,
  VHOME_L20, VHOME_L21, VHOME_L22, VHOME_L23, VHOME_L24, VHOME_L25, _______,
  _______, VHOME_L30, VHOME_L31, VHOME_L32, VHOME_L33,

                                                  _______, _______,
                                                           _______,
                                        VHOME_L34, VHOME_L35, _______,

  // right hand
  _______, _______, _______, _______, _______, _______, _______,
  _______, VHOME_R00, VHOME_R01, VHOME_R02, VHOME_R03, VHOME_R04, VHOME_R05,
           VHOME_R10, VHOME_R11, VHOME_R12, VHOME_R13, VHOME_R14, VHOME_R15,
  _______, VHOME_R20, VHOME_R21, VHOME_R22, VHOME_R23, VHOME_R24, VHOME_R25,
                    VHOME_R32, VHOME_R33, VHOME_R34, VHOME_R35, _______,

  _______, _______,
  _______,
  _______, VHOME_R30,  VHOME_R31
),
[_VHNAV] = LAYOUT_ergodox(
  // left hand
  _______, _______, _______, _______, _______, _______, _______,
  VHNAV_L00, VHNAV_L01, VHNAV_L02, VHNAV_L03, VHNAV_L04, VHNAV_L05, _______,
  VHNAV_L10, VHNAV_L11, VHNAV_L12, VHNAV_L13, VHNAV_L14, VHNAV_L15,
  VHNAV_L20, VHNAV_L21, VHNAV_L22, VHNAV_L23, VHNAV_L24, VHNAV_L25, _______,
  _______, VHNAV_L30, VHNAV_L31, VHNAV_L32, VHNAV_L33,

                                                  _______, _______,
                                                           _______,
                                        VHNAV_L34, VHNAV_L35, _______,

  // right hand
  _______, _______, _______, _______, _______, _______, _______,
  _______, VHNAV_R00, VHNAV_R01, VHNAV_R02, VHNAV_R03, VHNAV_R04, VHNAV_R05,
           VHNAV_R10, VHNAV_R11, VHNAV_R12, VHNAV_R13, VHNAV_R14, VHNAV_R15,
  _______, VHNAV_R20, VHNAV_R21, VHNAV_R22, VHNAV_R23, VHNAV_R24, VHNAV_R25,
                    VHNAV_R32, VHNAV_R33, VHNAV_R34, VHNAV_R35, _______,

  _______, _______,
  _______,
  _______, VHNAV_R30,  VHNAV_R31
),
[_VWORK] = LAYOUT_ergodox(
  // left hand
  _______, _______, _______, _______, _______, _______, _______,
  VWORK_L00, VWORK_L01, VWORK_L02, VWORK_L03, VWORK_L04, VWORK_L05, _______,
  VWORK_L10, VWORK_L11, VWORK_L12, VWORK_L13, VWORK_L14, VWORK_L15,
  VWORK_L20, VWORK_L21, VWORK_L22, VWORK_L23, VWORK_L24, VWORK_L25, _______,
  _______, VWORK_L30, VWORK_L31, VWORK_L32, VWORK_L33,

                                                  _______, _______,
                                                           _______,
                                        VWORK_L34, VWORK_L35, _______,

  // right hand
  _______, _______, _______, _______, _______, _______, _______,
  _______, VWORK_R00, VWORK_R01, VWORK_R02, VWORK_R03, VWORK_R04, VWORK_R05,
           VWORK_R10, VWORK_R11, VWORK_R12, VWORK_R13, VWORK_R14, VWORK_R15,
  _______, VWORK_R20, VWORK_R21, VWORK_R22, VWORK_R23, VWORK_R24, VWORK_R25,
                    VWORK_R32, VWORK_R33, VWORK_R34, VWORK_R35, _______,

  _______, _______,
  _______,
  _______, VWORK_R30,  VWORK_R31
),
[_VWNAV] = LAYOUT_ergodox(
  // left hand
  _______, _______, _______, _______, _______, _______, _______,
  VWNAV_L00, VWNAV_L01, VWNAV_L02, VWNAV_L03, VWNAV_L04, VWNAV_L05, _______,
  VWNAV_L10, VWNAV_L11, VWNAV_L12, VWNAV_L13, VWNAV_L14, VWNAV_L15,
  VWNAV_L20, VWNAV_L21, VWNAV_L22, VWNAV_L23, VWNAV_L24, VWNAV_L25, _______,
  _______, VWNAV_L30, VWNAV_L31, VWNAV_L32, VWNAV_L33,

                                                  _______, _______,
                                                           _______,
                                        VWNAV_L34, VWNAV_L35, _______,

  // right hand
  _______, _______, _______, _______, _______, _______, _______,
  _______, VWNAV_R00, VWNAV_R01, VWNAV_R02, VWNAV_R03, VWNAV_R04, VWNAV_R05,
           VWNAV_R10, VWNAV_R11, VWNAV_R12, VWNAV_R13, VWNAV_R14, VWNAV_R15,
  _______, VWNAV_R20, VWNAV_R21, VWNAV_R22, VWNAV_R23, VWNAV_R24, VWNAV_R25,
                    VWNAV_R32, VWNAV_R33, VWNAV_R34, VWNAV_R35, _______,

  _______, _______,
  _______,
  _______, VWNAV_R30,  VWNAV_R31
),
[_INAV] = LAYOUT_ergodox(
  // left hand
  _______, _______, _______, _______, _______, _______, _______,
  INAV_L00, INAV_L01, INAV_L02, INAV_L03, INAV_L04, INAV_L05, _______,
  INAV_L10, INAV_L11, INAV_L12, INAV_L13, INAV_L14, INAV_L15,
  INAV_L20, INAV_L21, INAV_L22, INAV_L23, INAV_L24, INAV_L25, _______,
  _______, INAV_L30, INAV_L31, INAV_L32, INAV_L33,

                                                  _______, _______,
                                                           _______,
                                        INAV_L34, INAV_L35, _______,

  // right hand
  _______, _______, _______, _______, _______, _______, _______,
  _______, INAV_R00, INAV_R01, INAV_R02, INAV_R03, INAV_R04, INAV_R05,
           INAV_R10, INAV_R11, INAV_R12, INAV_R13, INAV_R14, INAV_R15,
  _______, INAV_R20, INAV_R21, INAV_R22, INAV_R23, INAV_R24, INAV_R25,
                    INAV_R32, INAV_R33, INAV_R34, INAV_R35, _______,

  _______, _______,
  _______,
  _______, INAV_R30,  INAV_R31
),
[_CHROME] = LAYOUT_ergodox(
  // left hand
  _______, _______, _______, _______, _______, _______, _______,
  CHROME_L00, CHROME_L01, CHROME_L02, CHROME_L03, CHROME_L04, CHROME_L05, _______,
  CHROME_L10, CHROME_L11, CHROME_L12, CHROME_L13, CHROME_L14, CHROME_L15,
  CHROME_L20, CHROME_L21, CHROME_L22, CHROME_L23, CHROME_L24, CHROME_L25, _______,
  _______, CHROME_L30, CHROME_L31, CHROME_L32, CHROME_L33,

                                                  _______, _______,
                                                           _______,
                                        CHROME_L34, CHROME_L35, _______,

  // right hand
  _______, _______, _______, _______, _______, _______, _______,
  _______, CHROME_R00, CHROME_R01, CHROME_R02, CHROME_R03, CHROME_R04, CHROME_R05,
           CHROME_R10, CHROME_R11, CHROME_R12, CHROME_R13, CHROME_R14, CHROME_R15,
  _______, CHROME_R20, CHROME_R21, CHROME_R22, CHROME_R23, CHROME_R24, CHROME_R25,
                    CHROME_R32, CHROME_R33, CHROME_R34, CHROME_R35, _______,

  _______, _______,
  _______,
  _______, CHROME_R30,  CHROME_R31
),

[_IDEA] = LAYOUT_ergodox(
  // left hand
  _______, _______, _______, _______, _______, _______, _______,
  IDEA_L00, IDEA_L01, IDEA_L02, IDEA_L03, IDEA_L04, IDEA_L05, _______,
  IDEA_L10, IDEA_L11, IDEA_L12, IDEA_L13, IDEA_L14, IDEA_L15,
  IDEA_L20, IDEA_L21, IDEA_L22, IDEA_L23, IDEA_L24, IDEA_L25, _______,
  _______, IDEA_L30, IDEA_L31, IDEA_L32, IDEA_L33,

                                                  _______, _______,
                                                           _______,
                                        IDEA_L34, IDEA_L35, _______,

  // right hand
  _______, _______, _______, _______, _______, _______, _______,
  _______, IDEA_R00, IDEA_R01, IDEA_R02, IDEA_R03, IDEA_R04, IDEA_R05,
           IDEA_R10, IDEA_R11, IDEA_R12, IDEA_R13, IDEA_R14, IDEA_R15,
  _______, IDEA_R20, IDEA_R21, IDEA_R22, IDEA_R23, IDEA_R24, IDEA_R25,
                     IDEA_R32, IDEA_R33, IDEA_R34, IDEA_R35, _______,

  _______, _______,
  _______,
  _______, IDEA_R30,  IDEA_R31
),

[_SFT] = LAYOUT_ergodox(
  // left hand
  _______,    _______, _______, _______, _______, _______, _______,
  SFT_L00, SFT_L01, SFT_L02, SFT_L03, SFT_L04, SFT_L05, _______,
  SFT_L10, SFT_L11, SFT_L12, SFT_L13, SFT_L14, SFT_L15,
  SFT_L20, SFT_L21, SFT_L22, SFT_L23, SFT_L24, SFT_L25, _______,
  _______, SFT_L30, SFT_L31, SFT_L32, SFT_L33,

                                                  _______, _______,
                                                           _______,
                                        SFT_L34, SFT_L35, _______,

  // right hand
  _______, _______, _______, _______,  _______, _______, _______,
  _______, SFT_R00, SFT_R01, SFT_R02, SFT_R03, SFT_R04, SFT_R05,
            SFT_R10, SFT_R11, SFT_R12, SFT_R13, SFT_R14, SFT_R15,
  _______, SFT_R20, SFT_R21, SFT_R22, SFT_R23, SFT_R24, SFT_R25,
                    SFT_R32, SFT_R33, SFT_R34, SFT_R35, _______,

  _______, _______,
  _______,
  _______, SFT_R30,  SFT_R31
),

[_MISC] = LAYOUT_ergodox(
  // left hand
  _______,    _______, _______, _______, _______, _______, _______,
  MISC_L00, MISC_L01, MISC_L02, MISC_L03, MISC_L04, MISC_L05, _______,
  MISC_L10, MISC_L11, MISC_L12, MISC_L13, MISC_L14, MISC_L15,
  MISC_L20, MISC_L21, MISC_L22, MISC_L23, MISC_L24, MISC_L25, _______,
  _______, MISC_L30, MISC_L31, MISC_L32, MISC_L33,

                                                  _______, _______,
                                                           _______,
                                        MISC_L34, MISC_L35, _______,

  // right hand
  _______, _______, _______, _______,  _______, _______, _______,
  _______, MISC_R00, MISC_R01, MISC_R02, MISC_R03, MISC_R04, MISC_R05,
            MISC_R10, MISC_R11, MISC_R12, MISC_R13, MISC_R14, MISC_R15,
  _______, MISC_R20, MISC_R21, MISC_R22, MISC_R23, MISC_R24, MISC_R25,
                    MISC_R32, MISC_R33, MISC_R34, MISC_R35, _______,

  _______, _______,
  _______,
  _______, MISC_R30,  MISC_R31
),

[_ADJUST] = LAYOUT_ergodox(
  // left hand
  VRSN,    _______, _______, _______, _______, _______, _______,
  ADJ_L00, ADJ_L01, ADJ_L02, ADJ_L03, ADJ_L04, ADJ_L05, _______,
  ADJ_L10, ADJ_L11, ADJ_L12, ADJ_L13, ADJ_L14, ADJ_L15,
  ADJ_L20, ADJ_L21, ADJ_L22, ADJ_L23, ADJ_L24, ADJ_L25, _______,
  _______, ADJ_L30, ADJ_L31, ADJ_L32, ADJ_L33,

                                                  _______, _______,
                                                           _______,
                                        ADJ_L34, ADJ_L35, _______,

  // right hand
  _______, _______, _______, _______,  _______, _______, _______,
  _______, ADJ_R00, ADJ_R01, ADJ_R02, ADJ_R03, ADJ_R04, ADJ_R05,
            ADJ_R10, ADJ_R11, ADJ_R12, ADJ_R13, ADJ_R14, ADJ_R15,
  _______, ADJ_R20, ADJ_R21, ADJ_R22, ADJ_R23, ADJ_R24, ADJ_R25,
                    ADJ_R32, ADJ_R33, ADJ_R34, ADJ_R35, _______,

  _______, _______,
  _______,
  _______, ADJ_R30,  ADJ_R31
),

};

const macro_t *action_get_macro(keyrecord_t *record, uint8_t id, uint8_t opt)
{
  // MACRODOWN only works in this function
  switch(id) {
    case 0:
      if (record->event.pressed) {
        SEND_STRING (QMK_KEYBOARD "/" QMK_KEYMAP " @ " QMK_VERSION);
      }
      break;
    case 1:
      if (record->event.pressed) { // For resetting EEPROM
        eeconfig_init();
      }
      break;
  }
  return MACRO_NONE;
};


