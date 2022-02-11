# easy-align

https://github.com/junegunn/vim-easy-align

ga key in visual mode, or ga followed by a motion or a text object to start interactive mode

(Optional) Enter keys to cycle between alignment mode (left, right, or center)
(Optional) N-th delimiter (default: 1)
1          Around the 1st occurrences of delimiters
2          Around the 2nd occurrences of delimiters
...
*          Around all occurrences of delimiters
**         Left-right alternating alignment around all delimiters
-          Around the last occurrences of delimiters (-1)
-2         Around the second to last occurrences of delimiters
...

Delimiter key (a single keystroke; <Space>, =, :, ., |, &, #, ,) 

or an arbitrary regular expression followed by <CTRL-X>

=       Around the 1st occurrences
2=      Around the 2nd occurrences
*=      Around all occurrences
**=     Left/Right alternating alignment around all occurrences
<Enter> Switching between left/right/center alignment modes


**Live Interactive Mode**

Never got this to work.

:LiveEasyAlign


