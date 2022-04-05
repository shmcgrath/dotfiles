#!/usr/bin/env bash
killall trayer
trayer \
	--edge top \
	--align right \
	--margin 0 \
	--widthtype request \
	--SetDockType true \
	--SetPartialStrut true \
	--height 17 \
	--transparent true \
	--tint 0x44475a \
	--alpha 0 \
	--expand true \
	--padding 0 \
	--monitor "primary" \
	--iconspacing 3 \
	&
