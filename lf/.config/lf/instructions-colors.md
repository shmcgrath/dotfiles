use [vivid](https://github.com/sharkdp/vivid) to make LS_COLORS for cyberdream

Use nvim to properly format colors

To split items (colon separated) onto individual lines:
:%s/:/\r/g

To add spacing instead of =:
:%s/=/   /gcc

OR

run color-gen-lf.pl
