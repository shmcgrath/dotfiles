import XMonad

import Data.Monoid
import System.Exit

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Prompt
import XMonad.Prompt.XMonad
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Util.Loggers
import XMonad.Util.Run
import XMonad.Util.SpawnOnce

import qualified Data.Map
import qualified XMonad.StackSet

------------------------------------------------------------------------
-- General Variables
shmSans :: String
shmSans = "xft:FreeSans:regular:size=12:antialias=true:hinting=true"

shmXPConfig :: XPConfig
shmXPConfig = def
      { font                = shmSans
      , bgColor             = "#292929"
      , fgColor             = "#a2a2a2"
      , bgHLight            = "#5879af"
      , fgHLight            = "#a2a2a2"
      , borderColor         = "#777777"
      , promptBorderWidth   = 3
      , position            = CenteredAt { xpCenterY = 0.3, xpWidth = 0.3 }
      , height              = 24
      , historySize         = 256
      , historyFilter       = id
      , defaultText         = []
      , autoComplete        = Nothing
      , showCompletionOnTab = False
      , complCaseSensitivity = CaseInSensitive
      , alwaysHighlight     = True
      }

------------------------------------------------------------------------
-- Workspaces
-- A tagging example:
-- > workspaces = ["web", "irc", "code" ] ++ map show [4..9]
--
shmWorkspaces    = ["1","2","3","4","5","6","7","8","9"]

------------------------------------------------------------------------
-- Key Bindings
cleanDefKeys x = keys def x `Data.Map.difference` shmDelKeys x
shmKeys = cleanDefKeys <+> shmAddKeys

shmDelKeys :: XConfig Layout -> Data.Map.Map (KeyMask, KeySym) (X ())
shmDelKeys XConfig{modMask = modm} = Data.Map.fromList
    [((modm              , xK_space),  return())
    ,((modm              , xK_Return), return())
    ,((modm .|. shiftMask, xK_Return), return())
    ,((modm              , xK_p), return())
    ,((modm .|. shiftMask, xK_p), return())
    ,((modm              , xK_q), return())
    ,((modm .|. shiftMask, xK_q), return())
    ,((modm              , xK_Tab), return())
    ,((modm .|. shiftMask, xK_Tab), return())
    ,((modm              , xK_question), return())
    ,((modm .|. shiftMask, xK_slash), return())
    ]

shmAddKeys :: XConfig Layout -> Data.Map.Map (KeyMask, KeySym) (X ())
shmAddKeys conf@(XConfig{modMask = modm}) = Data.Map.fromList
     -- Rotate through the available layout algorithms
    [((modm,               xK_Tab ), sendMessage NextLayout)
    --  Reset the layouts on the current workspace to default
    ,((modm .|. shiftMask, xK_Tab ), setLayout $ XMonad.layoutHook conf)
    ,((modm              , xK_F12), xmonadPrompt shmXPConfig)
    ,((modm .|. shiftMask, xK_q), kill)
    ,((modm .|. shiftMask, xK_m), windows XMonad.StackSet.swapMaster)
    ]

------------------------------------------------------------------------
shmLayout = tiled ||| Mirror tiled ||| Full
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled   = Tall nmaster delta ratio

     -- The default number of windows in the master pane
     nmaster = 1

     -- Default proportion of screen occupied by master pane
     ratio   = 1/2

     -- Percent of screen to increment by when resizing panes
     delta   = 3/100

------------------------------------------------------------------------
-- Window rules:

-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
--
shmManageHook = composeAll
    [ isDialog --> doFloat
    , className =? "MPlayer"        --> doFloat
    , className =? "Gimp"           --> doFloat
    , resource  =? "desktop_window" --> doIgnore
    , resource  =? "kdesktop"       --> doIgnore ]

------------------------------------------------------------------------
-- Status bars and logging

-- Perform an arbitrary action on each internal state change or X event.
-- See the 'XMonad.Hooks.DynamicLog' extension for examples.
--
--shmLogHook = return ()

shmXmobarPP :: PP
shmXmobarPP = def {
	  ppSep = xmobarColor "#ff79c6" "" " || "
	, ppTitleSanitize = xmobarStrip
	, ppOrder = \(ws:l:t:xs) -> [l,ws]++xs++[t]
}


-- Startup hook

shmStartupHook = do
    spawn "trayer-shm.sh"
    spawnOnce "feh --no-fehbg --bg-fill ~/.config/wallpaper/paris02.jpg"
    spawnOnce "/usr/bin/dropbox &"
    spawnOnce "dunst &"
    spawnOnce "sxhkd &"

main :: IO ()
main =
  xmonad . ewmhFullscreen . ewmh
  . withEasySB (statusBarProp "xmobar /home/shmcg/.config/xmobar/xmobarrc" (pure shmXmobarPP)) defToggleStrutsKey
  $ shmConfig

shmConfig = def {
          terminal           = "alacritty"
        , focusFollowsMouse  = False
        , clickJustFocuses   = True
        , borderWidth        = 3
        , modMask            = mod4Mask
        , normalBorderColor  = "#4e4e4e"
        , focusedBorderColor = "#cfcfcf"
        , workspaces         = shmWorkspaces
        , keys               = shmKeys
        --, mouseBindings      = shmMouseBindings
        , layoutHook         = shmLayout
        , manageHook         = shmManageHook
        --, handleEventHook    = shmEventHook
        --, logHook            = shmLogHook
        , startupHook        = shmStartupHook
    }
