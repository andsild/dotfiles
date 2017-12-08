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
-- import qualified Data.Map                        as M
import           Data.Ratio
import           System.Exit
import           System.IO

import		 XMonad.Actions.GridSelect  -- for gsConfig og ymst
import 		 Control.Monad.Writer	    -- for writer
import 		 XMonad.Layout.MultiToggle  -- for transformer
import		 XMonad.Layout.Master	    -- for mastered
import		 XMonad.Layout.Tabbed	    -- for "tabbed"
import 		 XMonad.Hooks.SetWMName

defaultTerminal :: String
defaultTerminal = "st"
 
-- The default is mod1Mask ("left alt"), mod3 is right alt, windows key is mod4
myModMask :: KeyMask
myModMask = mod4Mask
 
workspaceNames :: [String]
workspaceNames = [ "1.term", "2.web", "3.code", "4.misc", "5.pdf", "6.misc", "7.torrent", "8.misc" , "9.spotify" ]
 
-- Default offset of drawable screen boundaries from each physical.
-- (top, bottom, left, right)
screenBoundaries :: [(Integer, Integer, Integer, Integer)]
screenBoundaries = [(50,0,0,0)]

-- default tiling algorithm partitions the screen into two panes
basic :: Tall a
basic = Tall nmaster delta ratio
  where
    nmaster = 1
    -- Percent of screen to increment by when resizing panes
    delta   = 3/100
    -- Default proportion of screen occupied by master pane
    ratio   = 1/2
 
--myLayout = smartBorders $ onWorkspace "2.web" webLayout $ standardLayouts
myLayout = smartBorders $ standardLayouts
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
myManageHook = scratchpadManageHookDefault <+> (className =? "Vlc" --> doFloat) <+> manageDocks
               <+> fullscreenManageHook <+> myFloatHook
               <+> manageHook defaultConfig
  where fullscreenManageHook = composeOne [ isFullscreen -?> doFullFloat ]
 
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
myFloatHook = composeAll
    [
      className =? "Spotify"		   --> moveToSpotify
      , className =? "slack" --> moveTo2
      , className =? "Mail" --> moveTo2
    , manageDocks]
  where
    moveTo2   = doF $ W.shift "2.web"
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

newkeys = [ 
      ((myModMask .|. shiftMask, xK_Return), spawn defaultTerminal)
    , ((myModMask,               xK_p     ), spawn "dmenu_run")
    , ((myModMask .|. shiftMask, xK_c     ), kill)
    , ((myModMask,               xK_space ), sendMessage NextLayout)
 
    --  Reset the layouts on the current workspace to default
    -- , ((myModMask .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)
 
    -- Resize viewed windows to the correct size
    , ((myModMask,               xK_n     ), refresh)
 
    -- Move focus to the next window
    , ((myModMask,               xK_Tab   ), windows W.focusDown)
 
    -- Move focus to the next window
    , ((myModMask,               xK_j     ), windows W.focusDown)
 
    -- Move focus to the previous window
    , ((myModMask,               xK_k     ), windows W.focusUp  )
 
    -- Move focus to the master window
    , ((myModMask,               xK_m     ), windows W.focusMaster  )
 
    -- Swap the focused window and the master window
    , ((myModMask,               xK_Return), windows W.swapMaster)
 
    -- Swap the focused window with the next window
    , ((myModMask .|. shiftMask, xK_j     ), windows W.swapDown  )
 
    -- Swap the focused window with the previous window
    , ((myModMask .|. shiftMask, xK_k     ), windows W.swapUp    )
 
    -- Shrink the master area
    , ((myModMask,               xK_h     ), sendMessage Shrink)
 
    -- Expand the master area
    , ((myModMask,               xK_l     ), sendMessage Expand)
 
    -- Push window back into tiling
    , ((myModMask,               xK_t     ), withFocused $ windows . W.sink)
 
    -- Increment the number of windows in the master area
    , ((myModMask,               xK_comma ), sendMessage (IncMasterN 1))
 
    -- Deincrement the number of windows in the master area
    , ((myModMask,               xK_period), sendMessage (IncMasterN (-1)))
 
    -- Quit xmonad
    , ((myModMask .|. shiftMask, xK_q     ), io exitSuccess)
 
    -- Restart xmonad
    , ((myModMask,               xK_q     ), restart "xmonad" True)

    -- Launch spotify
    , ((myModMask,	       xK_s	), spawn "spotify")

    -- Launch uzbl
    , ((myModMask,	       xK_u	), spawn "qutebrowser")

    -- Launch chromium
    , ((myModMask,	       xK_c	), spawn "chromium")

    ]
    ++
 
    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
    [ ((m .|. myModMask, k), windows $ f i)
         | (i, k) <- zip (workspaceNames) [xK_1 .. xK_9]
    , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]
    ]
    ++
 
    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    --
    [((m .|. myModMask, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_e, xK_r, xK_w] [0..]
    , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]
    ]

main :: IO ()
main = do
    mapM_ spawn ["feh --bg-scale /home/andsild/.images/swahili.png"]
    
    xmproc <- spawnPipe "`which xmobar` ~/.xmonad/xmobarrc"
    -- xmonad $ withUrgencyHook NoUrgencyHook defaults {
    xmonad defaults
        --logHook = do FI.fadeInactiveLogHook 0xbbbbbbbb
          --           dynamicLogWithPP $ xmobarPP {
            --               ppOutput = hPutStrLn xmproc
              --           , ppTitle  = xmobarColor "#ff66ff" "" . shorten 50
                --         , ppUrgent = xmobarColor "yellow" "red" . xmobarStrip
                  --   }
    -- }
