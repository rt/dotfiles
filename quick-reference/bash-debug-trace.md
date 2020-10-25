
### debugging/tracing

	#trace with -x and this will output all the expansions
	#!/bin/bash -x

the contents of the -x option is in the PS4 variable, we can configure to make more usefull

	export PS4='$LINENO + '

can turn on trace dynamically
	
	set -x #turn on tracing
