import           XMonad                          hiding ((|||))
import           XMonad.Hooks.DynamicLog
import           XMonad.Hooks.FadeInactive       as FI
import           XMonad.Hooks.ManageDocks
import           XMonad.Hooks.ManageHelpers
import           XMonad.Hooks.UrgencyHook
import           XMonad.Layout.DecorationMadness
import           XMonad.Layout.IM
import           XMonad.Layout.LayoutCombinators (JumpToLayout (..), (|||))
import           XMonad.Layout.Named
import           XMonad.Layout.NoBorders
import           XMonad.Layout.PerWorkspace
import           XMonad.Layout.Reflect
import           XMonad.Prompt
import           XMonad.Prompt.Input
import qualified XMonad.StackSet                 as W
import           XMonad.Util.Run                 (spawnPipe)
import           XMonad.Util.Scratchpad
import           XMonad.Util.EZConfig(additionalKeys)
import qualified Data.Map                        as M
import           Data.Ratio
import           System.Exit
import           System.IO
import           System.Cmd (system)

import     Control.Monad.Writer	    -- for writer
import 		 XMonad.Layout.MultiToggle  -- for transformer
import		 XMonad.Layout.Master	    -- for mastered
import		 XMonad.Layout.Tabbed	    -- for "tabbed"
import 		 XMonad.Hooks.SetWMName

defaultTerminal :: String
defaultTerminal = "gnome-terminal"
 
-- The default is mod1Mask ("left alt"), mod3 is right alt, windows key is mod4
myModMask :: KeyMask
myModMask = mod4Mask
 
workspaceNames :: [String]
workspaceNames = [ "1.term", "2.web", "3.code", "4.misc", "5.pdf", "6.misc", "7.background", "8.social" , "9.spotify" ]

-- default tiling algorithm partitions the screen into two panes
basic :: Tall a
basic = Tall nmaster resizeWindowDelta masterWindowDefaultRatio
  where
    nmaster = 1
    resizeWindowDelta = 3/100
    masterWindowDefaultRatio = 1/2
 
--myLayout = smartBorders $ onWorkspace "2.web" webLayout $ standardLayouts
-- myLayout = smartBorders $ standardLayouts
myLayout = avoidStruts $ standardLayouts
  where
    standardLayouts = tall ||| wide ||| full ||| circle
    tall   = named "tall"   $ avoidStruts basic
    wide   = named "wide"   $ avoidStruts $ Mirror basic
    circle = named "circle" $ avoidStruts circleSimpleDefaultResizable
    full   = named "full"   $ noBorders Full

webLayout = named "webby" -- $ avoidStruts $ Mirror basic
 
myLayoutPrompt :: X ()
myLayoutPrompt = inputPromptWithCompl myXPConfig "Layout"
                 (mkComplFunFromList' allLayouts) ?+ (sendMessage . JumpToLayout)
  where
    allLayouts = ["tall", "wide", "circle", "full"]
 
    myXPConfig :: XPConfig
    myXPConfig = defaultXPConfig {
        autoComplete= Just 1000
    }

myManageHook :: ManageHook
myManageHook = scratchpadManageHookDefault <+> (className =? "vlc" --> doFloat) <+> manageDocks
               <+> fullscreenManageHook <+> myFloatHook
               <+> manageHook defaultConfig
  where fullscreenManageHook = composeOne [ isFullscreen -?> doFullFloat ]
 
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
myFloatHook = composeAll
    [
      className =? "Spotify"		   --> moveToSpotify
      , className =? "Godot_Engine" --> floatMe
      , className =? "slack" --> moveTo8
      , className =? "slack" --> moveTo8
      , className =? "Mail" --> moveTo8
    , manageDocks]
  where
    floatMe   = doF $ W.shift "7.background"
    moveTo8   = doF $ W.shift "8.social"
    moveToSpotify = doF $ W.shift "9.spotify"
 
    classNotRole :: (String, String) -> Query Bool
    classNotRole (c,r) = className =? c <&&> role /=? r
 
    role = stringProperty "WM_WINDOW_ROLE"
 
myLogHook :: X ()
myLogHook = fadeInactiveLogHook 0.8

dzenFont             = "-*-montecarlo-medium-r-normal-*-11-*-*-*-*-*-*-*"
colorBlack           = "#020202" --Background (Dzen_BG)
colorBlackAlt        = "#1c1c1c" --Black Xdefaults
colorGray            = "#444444" --Gray       (Dzen_FG2)
colorWhiteAlt        = "#9d9d9d" --White dark (Dzen_FG)
colorGreen           = "#66ff66"

myTitleTheme :: Theme
myTitleTheme = defaultTheme
	{
	 fontName            = dzenFont
        , inactiveBorderColor = colorBlackAlt
        , inactiveColor       = colorBlack
        , inactiveTextColor   = colorGray
        , activeBorderColor   = colorGray
        , activeColor         = colorBlackAlt
        , activeTextColor     = colorWhiteAlt
        , urgentBorderColor   = colorGray
        , urgentTextColor     = colorGreen
        , decoHeight          = 14 
} 
 
defaults = defaultConfig {
   -- simple stuff
      terminal           = defaultTerminal
    , focusFollowsMouse  = True
    , borderWidth        = 1
    , modMask            = myModMask
    , workspaces         = workspaceNames
    , normalBorderColor  = "black"
    , focusedBorderColor = "red"
    , layoutHook         = myLayout
    , manageHook         = myManageHook
--    , logHook            = myLogHook
    , startupHook        = return () >> setWMName "LG3D"
    } `additionalKeys` newkeys

toggleFloat w = windows (\s -> if M.member w (W.floating s)
                then W.sink w s
                else (W.float w (W.RationalRect (1/3) (1/4) (1/2) (4/5)) s))

newkeys = [ 
      ((myModMask .|. shiftMask, xK_Return), spawn defaultTerminal)
    , ((myModMask .|. shiftMask, xK_c     ), kill)
    , ((myModMask,               xK_space ), sendMessage NextLayout)
    , ((myModMask,               xK_n     ), refresh)
    , ((myModMask,               xK_Tab   ), windows W.focusDown)
    , ((myModMask,               xK_j     ), windows W.focusDown)
    , ((myModMask,               xK_k     ), windows W.focusUp  )
    , ((myModMask,               xK_Return), windows W.swapMaster)
    , ((myModMask .|. shiftMask, xK_j     ), windows W.swapDown  )
    , ((myModMask .|. shiftMask, xK_k     ), windows W.swapUp    )
    , ((myModMask,               xK_h     ), sendMessage Shrink)
    , ((myModMask,               xK_l     ), sendMessage Expand)
    , ((myModMask,               xK_comma ), sendMessage (IncMasterN 1))
    , ((myModMask,               xK_period), sendMessage (IncMasterN (-1)))
    , ((myModMask,	             xK_v	), spawn "vivaldi")
    , ((myModMask,	             xK_d	), spawn "d")
    , ((myModMask,	       xK_s	), spawn "spotify")
    , ((myModMask,	       xK_u	), spawn "qutebrowser")
    , ((myModMask,               xK_o     ), spawn "~/dotfiles/Bash/rofiFiles.sh")
    , ((myModMask,               xK_p     ), spawn "rofi -modi run -show run")
    , ((myModMask,               xK_i     ), spawn "slock")
 
    -- Push window back into tiling
    , ((myModMask,               xK_t     ), withFocused $ windows . W.sink)
    , ((myModMask .|. shiftMask, xK_f     ), withFocused $ toggleFloat)


    ]
    ++
 
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    [ ((m .|. myModMask, k), windows $ f i)
         | (i, k) <- zip (workspaceNames) [xK_1 .. xK_9]
    , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]
    ]
    ++
 
    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    [((m .|. myModMask, key), screenWorkspace sc >>= flip whenJust (windows . f))
      | (key, sc) <- zip [xK_e, xK_q, xK_w, xK_r] [0..]
    , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]
    ]

main :: IO ()
main = do
    mapM_ spawn [
      "feh --bg-scale $(find ~/.images/ -type f | shuf | head -n1)"
      , "setxkbmap  -option eurosign:e,grp:switch,grp:alt_shift_toggle,grp_led:scroll us,no"
      ]
    
    xmproc <- spawnPipe "xmobar ~/.xmonad/xmobarrc"
    xmonad defaults
