#ifndef CONFIG_USER_H
#define CONFIG_USER_H

#undef TAPPING_TOGGLE

#include "../../config.h"

//#undef TAPPING_TERM 
//#define TAPPING_TERM    100
#define IGNORE_MOD_TAP_INTERRUPT
//#define TAPPING_FORCE_HOLD  if this is defined it'll break OSM
#define PERMISSIVE_HOLD            // I think this gets the quick backspace wo/the enter
#define PREVENT_STUCK_MODIFIERS
//#include "./visualizer.h"

#endif
