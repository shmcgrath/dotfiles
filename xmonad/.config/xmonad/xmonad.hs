import XMonad

import Data.Monoid
import System.Exit

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Util.Loggers
import XMonad.Util.Run
import XMonad.Util.SpawnOnce

import qualified Data.Map

-- A tagging example:
-- > workspaces = ["web", "irc", "code" ] ++ map show [4..9]
--
shmWorkspaces    = ["1","2","3","4","5","6","7","8","9"]

-- Key Bindings
cleanDefKeys x = keys def x `Data.Map.difference` shmDelKeys x
shmKeys = cleanDefKeys <+> shmAddKeys

shmDelKeys :: XConfig Layout -> Data.Map.Map (KeyMask, KeySym) (X ())
shmDelKeys XConfig{modMask = modm} = Data.Map.fromList
    [((modm              , xK_space),  return())
    ,((modm              , xK_Return), return())
    ,((modm .|. shiftMask, xK_Return), return())
    ]

shmAddKeys :: XConfig Layout -> Data.Map.Map (KeyMask, KeySym) (X ())
shmAddKeys conf@(XConfig{modMask = modm}) = Data.Map.fromList
     -- Rotate through the available layout algorithms
    [((modm,               xK_Tab ), sendMessage NextLayout)
    --  Reset the layouts on the current workspace to default
    , ((modm .|. shiftMask, xK_Tab ), setLayout $ XMonad.layoutHook conf)
    ]


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
shmXmobarPP = def

-- Startup hook

shmStartupHook = do
    spawn "trayer-shm.sh"
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
        , normalBorderColor  = "#6272a4"
        , focusedBorderColor = "#8be9fd"
        , workspaces         = shmWorkspaces
        , keys               = shmKeys
        --, mouseBindings      = shmMouseBindings
        , layoutHook         = shmLayout
        , manageHook         = shmManageHook
        --, handleEventHook    = shmEventHook
        --, logHook            = shmLogHook
        , startupHook        = shmStartupHook
    }
