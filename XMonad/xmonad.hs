-- File     : ~/.xmonad/xmonad.hs
-- Author   : Yiannis Tsiouris (yiannist)
-- Modified by: Anders Sildnes (this pretty much involves merging stuff from other config files, heh)
-- Desc     : A clean and well-documented xmonad configuration file (based on
--            the $HOME/.cabal/share/xmonad-0.10.1/man/xmonad.hs template file).
--
--            It uses:
--              * xmobar as a status bar,
--              * a ScratchPad (for a hidden terminal),
--              * a double IM layout (for Pidgin and Skype),
--              * a layout prompt (with auto-complete), and
--              * some convenient doFloat and moveTo{Mail, Web, IM} shortcuts.
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
import qualified Data.Map                        as M
import           Data.Ratio
import           System.Exit
import           System.IO

import		 XMonad.Actions.GridSelect  -- for gsConfig og ymst
import 		 XMonad.Actions.Warp	    -- for warpToScreen
import 		 Control.Monad.Writer	    -- for writer
import 		 XMonad.Layout.MultiToggle  -- for transformer
import		 XMonad.Layout.Master	    -- for mastered
import		 XMonad.Layout.Tabbed	    -- for "tabbed"
import 		 XMonad.Hooks.SetWMName


-- The preferred terminal program, which is used in a binding below and by
-- certain contrib modules.
--
myTerminal :: String
-- myTerminal = "konsole"
myTerminal = "st"
 
-- Width of the window border in pixels.
--
myBorderWidth :: Dimension
myBorderWidth = 1
 
-- modMask lets you specify which modkey you want to use. The default
-- is mod1Mask ("left alt").  You may also consider using mod3Mask
-- ("right alt"), which does not conflict with emacs keybindings. The
-- "windows key" is usually mod4Mask.
--
myModMask :: KeyMask
myModMask = mod4Mask
 
-- The mask for the numlock key. Numlock status is "masked" from the
-- current modifier status, so the keybindings will work with numlock on or
-- off. You may need to change this on some systems.
--
-- You can find the numlock modifier by running "xmodmap" and looking for a
-- modifier with Num_Lock bound to it:
--
-- > $ xmodmap | grep Num
-- > mod2        Num_Lock (0x4d)
--
-- Set numlockMask = 0 if you don't have a numlock key, or want to treat
-- numlock status separately.
--
myNumlockMask :: KeyMask
myNumlockMask = mod2Mask
 
-- The default number of workspaces (virtual screens) and their names.
-- By default we use numeric strings, but any string may be used as a
-- workspace name. The number of workspaces is determined by the length
-- of this list.
--
-- A tagging example:
--
-- > workspaces = ["web", "irc", "code" ] ++ map show [4..9]
--
myWorkspaces :: [String]
myWorkspaces = [ "1.term", "2.web", "3.code", "4.misc", "5.pdf", "6.misc", "7.torrent", "8.misc"
               , "9.spotify" ]
 
-- Border colors for unfocused and focused windows, respectively.
--
myNormalBorderColor, myFocusedBorderColor :: String
myNormalBorderColor  = "black"
myFocusedBorderColor = "red"
 
-- Default offset of drawable screen boundaries from each physical
-- screen. Anything non-zero here will leave a gap of that many pixels
-- on the given edge, on the that screen. A useful gap at top of screen
-- for a menu bar (e.g. 15)
--
-- An example, to set a top gap on monitor 1, and a gap on the bottom of
-- monitor 2, you'd use a list of geometries like so:
--
-- > defaultGaps = [(18,0,0,0),(0,18,0,0)] -- 2 gaps on 2 monitors
--
-- Fields are: top, bottom, left, right.
--
myDefaultGaps :: [(Integer, Integer, Integer, Integer)]
myDefaultGaps = [(0,0,0,0)]
 
------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
--
myKeys :: XConfig Layout -> M.Map (KeyMask, KeySym) (X ())
myKeys conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $
 
    -- launch a terminal
    [ ((modMask .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)
 
    -- launch gmrun
    , ((modMask,               xK_p     ), spawn "dmenu_run")
    -- close focused window
    , ((modMask .|. shiftMask, xK_c     ), kill)
 
     -- Rotate through the available layout algorithms
    , ((modMask,               xK_space ), sendMessage NextLayout)
 
    --  Reset the layouts on the current workspace to default
    , ((modMask .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)
 
    -- Resize viewed windows to the correct size
    , ((modMask,               xK_n     ), refresh)
 
    -- Move focus to the next window
    , ((modMask,               xK_Tab   ), windows W.focusDown)
 
    -- Move focus to the next window
    , ((modMask,               xK_j     ), windows W.focusDown)
 
    -- Move focus to the previous window
    , ((modMask,               xK_k     ), windows W.focusUp  )
 
    -- Move focus to the master window
    , ((modMask,               xK_m     ), windows W.focusMaster  )
 
    -- Swap the focused window and the master window
    , ((modMask,               xK_Return), windows W.swapMaster)
 
    -- Swap the focused window with the next window
    , ((modMask .|. shiftMask, xK_j     ), windows W.swapDown  )
 
    -- Swap the focused window with the previous window
    , ((modMask .|. shiftMask, xK_k     ), windows W.swapUp    )
 
    -- Shrink the master area
    , ((modMask,               xK_h     ), sendMessage Shrink)
 
    -- Expand the master area
    , ((modMask,               xK_l     ), sendMessage Expand)
 
    -- Push window back into tiling
    , ((modMask,               xK_t     ), withFocused $ windows . W.sink)
 
    -- Increment the number of windows in the master area
    , ((modMask,               xK_comma ), sendMessage (IncMasterN 1))
 
    -- Deincrement the number of windows in the master area
    , ((modMask,               xK_period), sendMessage (IncMasterN (-1)))
 
    -- Quit xmonad
    , ((modMask .|. shiftMask, xK_q     ), io exitSuccess)
 
    -- Restart xmonad
    , ((modMask,               xK_q     ), restart "xmonad" True)

    -- Launch pretty menu with active apps
    , ((modMask, 	       xK_a	), warpToCentre >> goToSelected gsConfig)

    -- Launch spotify
    , ((modMask,	       xK_s	), spawn "spotify")

    -- Launch uzbl
    , ((modMask,	       xK_u	), spawn "qutebrowser")

    -- Launch chromium
    , ((modMask,	       xK_c	), spawn "chromium")

    ]
    ++
 
    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
    [ ((m .|. modMask, k), windows $ f i)
         | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
    , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]
    ]
    ++
 
    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    --
    [((m .|. modMask, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_r, xK_e, xK_w] [0..]
    , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]
    ]
 
-- Meny-ting
warpToCentre = gets (W.screen . W.current . windowset) >>= \x -> warpToScreen x  0.5 0.5

------------------------------------------------------------------------
-- Layouts:
 
-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
--
-- The available layouts.  Note that each layout is separated by |||,
-- which denotes layout choice.
--
 
-- default tiling algorithm partitions the screen into two panes
basic :: Tall a
basic = Tall nmaster delta ratio
  where
    -- The default number of windows in the master pane
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
	--where
	--nmaster = 3
 
-- Set up the Layout prompt
myLayoutPrompt :: X ()
myLayoutPrompt = inputPromptWithCompl myXPConfig "Layout"
                 (mkComplFunFromList' allLayouts) ?+ (sendMessage . JumpToLayout)
  where
    allLayouts = ["tall", "wide", "circle", "full"]
 
    myXPConfig :: XPConfig
    myXPConfig = defaultXPConfig {
        autoComplete= Just 1000
    }

 
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
myManageHook :: ManageHook
myManageHook = scratchpadManageHookDefault <+> manageDocks
               <+> fullscreenManageHook <+> myFloatHook
               <+> manageHook defaultConfig
  where fullscreenManageHook = composeOne [ isFullscreen -?> doFullFloat ]
 
myFloatHook = composeAll
    [
      --className =? "Opera"		   --> moveToWeb
--    , className =? "Uzbl-core"		   --> moveToWeb
      className =? "Spotify"		   --> moveToSpotify
--    , className =? "Eclipse"		   --> moveToCode
    , manageDocks]
  where
    --moveToWeb   = doF $ W.shift "2.web"
--    moveToCode  = doF $ W.shift "3.code"
    moveToSpotify = doF $ W.shift "9.spotify"
 
    classNotRole :: (String, String) -> Query Bool
    classNotRole (c,r) = className =? c <&&> role /=? r
 
    role = stringProperty "WM_WINDOW_ROLE"
 
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True
 
------------------------------------------------------------------------
-- Startup hook
 
-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.
myStartupHook :: X ()
myStartupHook = return ()
 
------------------------------------------------------------------------
-- Status bars and logging
-- 
-- Perform an arbitrary action on each internal state change or X event.
-- See the 'DynamicLog' extension for examples.
--
myLogHook :: X ()
myLogHook = fadeInactiveLogHook 0.8

-----------------------------------------------------------------------
---- Themes

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
 
------------------------------------------------------------------------
-- Default Config
-- A structure containing your configuration settings, overriding
-- fields in the default config. Any you don't override, will
-- use the defaults defined in xmonad/XMonad/Config.hs
--
-- No need to modify this.
--
defaults = defaultConfig {
   -- simple stuff
      terminal           = myTerminal
    , focusFollowsMouse  = myFocusFollowsMouse
    , borderWidth        = myBorderWidth
    , modMask            = myModMask
    , workspaces         = myWorkspaces
    , normalBorderColor  = myNormalBorderColor
    , focusedBorderColor = myFocusedBorderColor
 
   -- key bindings
    , keys               = myKeys
 
   -- hooks, layouts
    , layoutHook         = myLayout
    , manageHook         = myManageHook
--    , logHook            = myLogHook
    , startupHook        = myStartupHook >> setWMName "LG3D"
}

gsConfig = defaultGSConfig { gs_navigate = fix $ \self ->
    let navKeyMap = M.mapKeys ((,) 0) $ M.fromList $
                [(xK_Escape, cancel)
                ,(xK_Return, select)
                ,(xK_slash , substringSearch self)]
           ++  
            map (\(k,a) -> (k,a >> self))
                [   
              (xK_Left  , move (-1,0 ))
                ,(xK_h     , move (-1,0 ))
               ,(xK_n     , move (-1,0 ))
                ,(xK_Right , move (1,0  ))  
                ,(xK_l     , move (1,0  ))  
                ,(xK_i     , move (1,0  ))  
                ,(xK_Down  , move (0,1  ))  
                ,(xK_j     , move (0,1  ))  
                ,(xK_e     , move (0,1  ))  
                ,(xK_Up    , move (0,-1 ))
                ,(xK_u     , move (0,-1 ))
               ,(xK_y     , move (-1,-1))
                ,(xK_m     , move (1,-1 ))
                ,(xK_space , setPos (0,0))
                ]   
    in makeXEventhandler $ shadowWithKeymap navKeyMap (const self) }
 
------------------------------------------------------------------------
-- Now run xmonad with all the defaults we set up.
 
-- Run xmonad with the settings you specify. No need to modify this.
--
main :: IO ()
main = do
    mapM_ spawn ["feh --bg-scale /home/andsild/.images/swahili.png"]
    
    xmproc <- spawnPipe "`which xmobar` ~/.xmobarrc"
    xmonad $ withUrgencyHook NoUrgencyHook defaults {
        --logHook = do FI.fadeInactiveLogHook 0xbbbbbbbb
          --           dynamicLogWithPP $ xmobarPP {
            --               ppOutput = hPutStrLn xmproc
              --           , ppTitle  = xmobarColor "#ff66ff" "" . shorten 50
                --         , ppUrgent = xmobarColor "yellow" "red" . xmobarStrip
                  --   }
		  layoutHook = myLayout
    }

-- EOF
