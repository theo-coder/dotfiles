  -- Base
import XMonad
import XMonad.Config.Azerty
import System.Directory
import System.IO (hPutStrLn)
import System.Exit
import qualified XMonad.StackSet as W

    -- Actions
import XMonad.Actions.CopyWindow (kill1)
import XMonad.Actions.CycleWS (moveTo, shiftTo, WSType(..), nextScreen, prevScreen)
import XMonad.Actions.GridSelect
import XMonad.Actions.MouseResize
import XMonad.Actions.Promote
import XMonad.Actions.RotSlaves (rotSlavesDown, rotAllDown)
import qualified XMonad.Actions.TreeSelect as TS
import XMonad.Actions.WindowGo (runOrRaise)
import XMonad.Actions.WithAll (sinkAll, killAll)
import qualified XMonad.Actions.Search as S

    -- Data
import Data.Char (isSpace, toUpper)
import Data.Maybe (fromJust)
import Data.Monoid
import Data.Maybe (isJust)
import Data.Tree
import qualified Data.Map as M

    -- Hooks
import XMonad.Hooks.DynamicLog (dynamicLogWithPP, wrap, xmobarPP, xmobarColor, shorten, PP(..))
import XMonad.Hooks.EwmhDesktops  -- for some fullscreen events, also for xcomposite in obs.
import XMonad.Hooks.FadeInactive
import XMonad.Hooks.ManageDocks (avoidStruts, docksEventHook, manageDocks, ToggleStruts(..), docks)
import XMonad.Hooks.ManageHelpers (isFullscreen, doFullFloat)
import XMonad.Hooks.ServerMode
import XMonad.Hooks.SetWMName
import XMonad.Hooks.WorkspaceHistory

    -- Layouts
import XMonad.Layout.GridVariants (Grid(Grid))
import XMonad.Layout.SimplestFloat
import XMonad.Layout.Spiral
import XMonad.Layout.ResizableTile
import XMonad.Layout.Tabbed
import XMonad.Layout.ThreeColumns

    -- Layouts modifiers
import XMonad.Layout.LayoutModifier
import XMonad.Layout.LimitWindows (limitWindows, increaseLimit, decreaseLimit)
import XMonad.Layout.Magnifier
import XMonad.Layout.MultiToggle (mkToggle, single, EOT(EOT), (??))
import XMonad.Layout.MultiToggle.Instances (StdTransformers(NBFULL, MIRROR, NOBORDERS))
import XMonad.Layout.NoBorders
import XMonad.Layout.Renamed
import XMonad.Layout.ShowWName
import XMonad.Layout.Simplest
import XMonad.Layout.Spacing
import XMonad.Layout.SubLayouts
import XMonad.Layout.WindowNavigation
import XMonad.Layout.WindowArranger (windowArrange, WindowArrangerMsg(..))
import qualified XMonad.Layout.ToggleLayouts as T (toggleLayouts, ToggleLayout(Toggle))
import qualified XMonad.Layout.MultiToggle as MT (Toggle(..))

    -- Prompt
import XMonad.Prompt
import XMonad.Prompt.Input
import XMonad.Prompt.FuzzyMatch
import XMonad.Prompt.Man
import XMonad.Prompt.Pass
import XMonad.Prompt.Shell
import XMonad.Prompt.Ssh
import XMonad.Prompt.Unicode
import XMonad.Prompt.XMonad
import Control.Arrow (first)

   -- Utilities
import XMonad.Util.EZConfig (additionalKeysP)
import XMonad.Util.NamedScratchpad
import XMonad.Util.Run (runProcessWithInput, safeSpawn, spawnPipe)
import XMonad.Util.SpawnOnce


myFont :: String
myFont = "xft:SauceCodePro Nerd Font Mono:regular:size=9:antialias=true:hinting=true"

myEmojiFont :: String
myEmojiFont = "xft:JoyPixels:regular:size=9:antialias=true:hinting=true"

myModMask :: KeyMask
myModMask = mod4Mask

myTerminal :: String
myTerminal = "alacritty"

myBrowser :: String
myBrowser = "brave "

myEditor :: String
myEditor = "code "

myBorderWidth :: Dimension
myBorderWidth = 2

myNormColor :: String
myNormColor = "#282c34"

myFocusColor :: String
myFocusColor = "#46d9ff"

altMask :: KeyMask
altMask = mod1Mask

windowCount :: X (Maybe String)
windowCount = gets $ Just . show . length . W.integrate' . W.stack . W.workspace . W.current . windowset

myStartupHook :: X ()
myStartupHook = do
  spawnOnce "lxsession &"
  spawnOnce "setxkbmap fr &"
  spawnOnce "nitrogen --restore &"
  --spawnOnce "xinput set-prop 'eGalax Inc. eGalaxTouch EXC3200-2505-09.00.00.00' --type=float 'Coordinate Transformation Matrix' 0.5 0 0.5 0 1 0 0 0 1"
  spawnOnce "picom --experimental-backends --config /home/theo/.config/picom/picom.conf &"
  spawnOnce "nm-applet &"
  spawnOnce "volumeicon &"
  spawnOnce "trayer --edge top --align right --widthtype request --padding 1 --iconspacing 3 --SetDockType true --SetPartialStrut true --expand true --transparent true --alpha 0 --tint 0x282c34 --height 24 &"

myColorizer :: Window -> Bool -> X (String, String)
myColorizer = colorRangeFromClassName
                  (0x28,0x2c,0x34)
                  (0x28,0x2c,0x34)
                  (0xc7,0x92,0xea)
                  (0xc0,0xa7,0x9a)
                  (0x28,0x2c,0x34)

mygridConfig :: p -> GSConfig Window
mygridConfig colorizer = (buildDefaultGSConfig myColorizer)
    {
      gs_cellheight   = 40,
      gs_cellwidth    = 200,
      gs_cellpadding  = 6,
      gs_originFractX = 0.5,
      gs_originFractY = 0.5,
      gs_font         = myFont
    }

spawnSelected' :: [(String, String)] -> X ()
spawnSelected' lst = gridselect conf lst >>= flip whenJust spawn
    where conf = def
                    {
                      gs_cellheight   = 40,
                      gs_cellwidth    = 200,
                      gs_cellpadding  = 6,
                      gs_originFractX = 0.5,
                      gs_originFractY = 0.5,
                      gs_font         = myFont
                    }

myAppGrid = [
    ("Audacity", "audacity"),
    ("Deadbeef", "deadbeef"),
    ("Emacs", "emacsclient -c -a emacs"),
    ("Firefox", "audacity"),
    ("Geany", "audacity"),
    ("Geary", "audacity"),
    ("Gimp", "audacity"),
    ("Kdenlive", "audacity"),
    ("LibreOffice Impress", "audacity"),
    ("LibreOffice Writer", "audacity"),
    ("OBS", "audacity"),
    ("PCManFM", "audacity")
  ]

treeselectAction :: TS.TSConfig (X ()) -> X ()
treeselectAction a = TS.treeselectAction a
    [
      Node (TS.TSNode "+ Accessories" "Accessory applications" (return ()))
      [
        Node (TS.TSNode "Calculator" "Gui version of qalc" (spawn "qalculate-gtk")) []
      ]
    ]

tsDefaultConfig :: TS.TSConfig a
tsDefaultConfig = TS.TSConfig {
    TS.ts_hidechildren  = True,
    TS.ts_background    = 0xdd282c34,
    TS.ts_font          = myFont,
    TS.ts_node          = (0xffd0d0d0, 0xff1c1f24),
    TS.ts_nodealt       = (0xffd0d0d0, 0xff282c34),
    TS.ts_highlight    = (0xffffffff, 0xff755999)
    , TS.ts_extra        = 0xffd0d0d0
    , TS.ts_node_width   = 200
    , TS.ts_node_height  = 20
    , TS.ts_originX      = 100
    , TS.ts_originY      = 100
    , TS.ts_indent       = 80
    , TS.ts_navigate     = myTreeNavigation
  }

myTreeNavigation = M.fromList
    [ ((0, xK_Escape),   TS.cancel)
    , ((0, xK_Return),   TS.select)
    , ((0, xK_space),    TS.select)
    , ((0, xK_Up),       TS.movePrev)
    , ((0, xK_Down),     TS.moveNext)
    , ((0, xK_Left),     TS.moveParent)
    , ((0, xK_Right),    TS.moveChild)
    , ((0, xK_k),        TS.movePrev)
    , ((0, xK_j),        TS.moveNext)
    , ((0, xK_h),        TS.moveParent)
    , ((0, xK_l),        TS.moveChild)
    , ((0, xK_o),        TS.moveHistBack)
    , ((0, xK_i),        TS.moveHistForward)
    , ((0, xK_a),        TS.moveTo ["+ Accessories"])
    ]

myXPConfig :: XPConfig
myXPConfig = def
    {
      font                = myFont
      , bgColor             = "#282c34"
      , fgColor             = "#bbc2cf"
      , bgHLight            = "#c792ea"
      , fgHLight            = "#000000"
      , borderColor         = "#535974"
      , promptBorderWidth   = 0
      , promptKeymap        = myXPKeymap
      , position            = Top
      -- , position            = CenteredAt { xpCenterY = 0.3, xpWidth = 0.3 }
      , height              = 23
      , historySize         = 256
      , historyFilter       = id
      , defaultText         = []
      , autoComplete        = Just 100000  -- set Just 100000 for .1 sec
      , showCompletionOnTab = False
      -- , searchPredicate     = isPrefixOf
      , searchPredicate     = fuzzyMatch
      , defaultPrompter     = id $ map toUpper  -- change prompt to UPPER
      -- , defaultPrompter     = unwords . map reverse . words  -- reverse the prompt
      -- , defaultPrompter     = drop 5 .id (++ "XXXX: ")  -- drop first 5 chars of prompt and add XXXX:
      , alwaysHighlight     = True
      , maxComplRows        = Nothing      -- set to 'Just 5' for 5 rows

    }

myXPConfig' :: XPConfig
myXPConfig' = myXPConfig
    {
      autoComplete = Nothing
    }

emojiXPConfig :: XPConfig
emojiXPConfig = myXPConfig
    {
      font = myEmojiFont
    }

calcPrompt c ans =
  inputPrompt c (trim ans) ?+ \input ->
    liftIO(runProcessWithInput "qalc" [input] "") >>= calcPrompt c
  where
    trim = f . f
      where f = reverse . dropWhile isSpace

myXPKeymap :: M.Map (KeyMask,KeySym) (XP ())
myXPKeymap = M.fromList $
    map (first $ (,) controlMask)
    [
      (xK_z, killBefore),
      (xK_k, killAfter),
      (xK_a, startOfLine),
      (xK_e, endOfLine),
      (xK_m, deleteString Next),
      (xK_b, moveCursor Prev),
      (xK_f, moveCursor Next),
      (xK_BackSpace, killWord Prev),
      (xK_y, pasteString),
      (xK_g, quit),
      (xK_bracketleft, quit)
    ]
    ++
    map (first $ (,) altMask)
    [
      (xK_BackSpace, killWord Prev),
      (xK_f, moveWord Next),
      (xK_b, moveWord Prev),
      (xK_d, killWord Next),
      (xK_n, moveHistory W.focusUp'),
      (xK_p, moveHistory W.focusDown')
    ]
    ++
    map (first $ (,) 0)
    [ (xK_Return, setSuccess True >> setDone True)
     , (xK_KP_Enter, setSuccess True >> setDone True)
     , (xK_BackSpace, deleteString Prev)
     , (xK_Delete, deleteString Next)
     , (xK_Left, moveCursor Prev)
     , (xK_Right, moveCursor Next)
     , (xK_Home, startOfLine)
     , (xK_End, endOfLine)
     , (xK_Down, moveHistory W.focusUp')
     , (xK_Up, moveHistory W.focusDown')
     , (xK_Escape, quit)
     ]
archwiki, ebay, news, reddit, urban, yacy :: S.SearchEngine

archwiki = S.searchEngine "archwiki" "https://wiki.archlinux.org/index.php?search="
ebay     = S.searchEngine "ebay" "https://www.ebay.com/sch/i.html?_nkw="
news     = S.searchEngine "news" "https://news.google.com/search?q="
reddit   = S.searchEngine "reddit" "https://www.reddit.com/search/?q="
urban    = S.searchEngine "urban" "https://www.urbandictionary.com/define.php?term="
yacy     = S.searchEngine "yacy" "http://localhost:8090/yacysearch.html?query="

-- This is the list of search engines that I want to use. Some are from
-- XMonad.Actions.Search, and some are the ones that I added above.
searchList :: [(String, S.SearchEngine)]
searchList = [ ("a", archwiki)
             , ("d", S.duckduckgo)
             , ("e", ebay)
             , ("g", S.google)
             , ("h", S.hoogle)
             , ("i", S.images)
             , ("n", news)
             , ("r", reddit)
             , ("s", S.stackage)
             , ("t", S.thesaurus)
             , ("v", S.vocabulary)
             , ("b", S.wayback)
             , ("u", urban)
             , ("w", S.wikipedia)
             , ("y", S.youtube)
             , ("S-y", yacy)
             , ("z", S.amazon)
             ]

myScratchPads :: [NamedScratchpad]
myScratchPads = [ NS "terminal" spawnTerm findTerm manageTerm
                , NS "mocp" spawnMocp findMocp manageMocp
                ]
  where
    spawnTerm  = myTerminal ++ " -n scratchpad 'fish'"
    findTerm   = resource =? "scratchpad"
    manageTerm = customFloating $ W.RationalRect l t w h
               where
                 h = 0.9
                 w = 0.9
                 t = 0.95 -h
                 l = 0.95 -w
    spawnMocp  = myTerminal ++ " -n mocp 'mocp'"
    findMocp   = resource =? "mocp"
    manageMocp = customFloating $ W.RationalRect l t w h
               where
                 h = 0.9
                 w = 0.9
                 t = 0.95 -h
                 l = 0.95 -w

--Makes setting the spacingRaw simpler to write. The spacingRaw module adds a configurable amount of space around windows.
mySpacing :: Integer -> l a -> XMonad.Layout.LayoutModifier.ModifiedLayout Spacing l a
mySpacing i = spacingRaw False (Border i i i i) True (Border i i i i) True

-- Below is a variation of the above except no borders are applied
-- if fewer than two windows. So a single window has no gaps.
mySpacing' :: Integer -> l a -> XMonad.Layout.LayoutModifier.ModifiedLayout Spacing l a
mySpacing' i = spacingRaw True (Border i i i i) True (Border i i i i) True

-- Defining a bunch of layouts, many that I don't use.
-- limitWindows n sets maximum number of windows displayed for layout.
-- mySpacing n sets the gap size around the windows.
tall     = renamed [Replace "tall"]
           $ windowNavigation
           $ addTabs shrinkText myTabTheme
           $ subLayout [] (smartBorders Simplest)
           $ limitWindows 12
           $ mySpacing 8
           $ ResizableTall 1 (3/100) (1/2) []
magnify  = renamed [Replace "magnify"]
           $ windowNavigation
           $ addTabs shrinkText myTabTheme
           $ subLayout [] (smartBorders Simplest)
           $ magnifier
           $ limitWindows 12
           $ mySpacing 8
           $ ResizableTall 1 (3/100) (1/2) []
monocle  = renamed [Replace "monocle"]
           $ windowNavigation
           $ addTabs shrinkText myTabTheme
           $ subLayout [] (smartBorders Simplest)
           $ limitWindows 20 Full
floats   = renamed [Replace "floats"]
           $ windowNavigation
           $ addTabs shrinkText myTabTheme
           $ subLayout [] (smartBorders Simplest)
           $ limitWindows 20 simplestFloat
grid     = renamed [Replace "grid"]
           $ windowNavigation
           $ addTabs shrinkText myTabTheme
           $ subLayout [] (smartBorders Simplest)
           $ limitWindows 12
           $ mySpacing 0
           $ mkToggle (single MIRROR)
           $ Grid (16/10)
spirals  = renamed [Replace "spirals"]
           $ windowNavigation
           $ addTabs shrinkText myTabTheme
           $ subLayout [] (smartBorders Simplest)
           $ mySpacing' 8
           $ spiral (6/7)
threeCol = renamed [Replace "threeCol"]
           $ windowNavigation
           $ addTabs shrinkText myTabTheme
           $ subLayout [] (smartBorders Simplest)
           $ limitWindows 7
           $ ThreeCol 1 (3/100) (1/2)
threeRow = renamed [Replace "threeRow"]
           $ windowNavigation
           $ addTabs shrinkText myTabTheme
           $ subLayout [] (smartBorders Simplest)
           $ limitWindows 7
           -- Mirror takes a layout and rotates it by 90 degrees.
           -- So we are applying Mirror to the ThreeCol layout.
           $ Mirror
           $ ThreeCol 1 (3/100) (1/2)
tabs     = renamed [Replace "tabs"]
           -- I cannot add spacing to this layout because it will
           -- add spacing between window and tabs which looks bad.
           $ tabbed shrinkText myTabTheme

-- setting colors for tabs layout and tabs sublayout.
myTabTheme = def { fontName            = myFont
                 , activeColor         = "#46d9ff"
                 , inactiveColor       = "#313846"
                 , activeBorderColor   = "#46d9ff"
                 , inactiveBorderColor = "#282c34"
                 , activeTextColor     = "#282c34"
                 , inactiveTextColor   = "#d0d0d0"
                 }

-- Theme for showWName which prints current workspace when you change workspaces.
myShowWNameTheme :: SWNConfig
myShowWNameTheme = def
    { swn_font              = "xft:Ubuntu:bold:size=60"
    , swn_fade              = 1.0
    , swn_bgcolor           = "#1c1f24"
    , swn_color             = "#ffffff"
    }

-- The layout hook
myLayoutHook = avoidStruts $ mouseResize $ windowArrange $ T.toggleLayouts floats
               $ mkToggle (NBFULL ?? NOBORDERS ?? EOT) myDefaultLayout
             where
               myDefaultLayout =     tall
                                 ||| magnify
                                 ||| noBorders monocle
                                 ||| floats
                                 ||| noBorders tabs
                                 ||| grid
                                 ||| spirals
                                 ||| threeCol
                                 ||| threeRow

-- myWorkspaces = [" 1 ", " 2 ", " 3 ", " 4 ", " 5 ", " 6 ", " 7 ", " 8 ", " 9 "]
myWorkspaces = [" dev ", " www ", " sys ", " doc ", " vbox ", " chat ", " mus ", " vid ", " gfx "]
myWorkspaceIndices = M.fromList $ zipWith (,) myWorkspaces [1..] -- (,) == \x y -> (x,y)

clickable ws = "<action=xdotool key super+"++show i++">"++ws++"</action>"
    where i = fromJust $ M.lookup ws myWorkspaceIndices

myManageHook :: XMonad.Query (Data.Monoid.Endo WindowSet)
myManageHook = composeAll
     -- using 'doShift ( myWorkspaces !! 7)' sends program to workspace 8!
     -- I'm doing it this way because otherwise I would have to write out the full
     -- name of my workspaces, and the names would very long if using clickable workspaces.
     [ title =? "Mozilla Firefox"     --> doShift ( myWorkspaces !! 1 )
     , className =? "mpv"     --> doShift ( myWorkspaces !! 7 )
     , className =? "Gimp"    --> doShift ( myWorkspaces !! 8 )
     , className =? "Gimp"    --> doFloat
     , title =? "Oracle VM VirtualBox Manager"     --> doFloat
     , className =? "VirtualBox Manager" --> doShift  ( myWorkspaces !! 4 )
     , (className =? "firefox" <&&> resource =? "Dialog") --> doFloat  -- Float Firefox Dialog
     ] <+> namedScratchpadManageHook myScratchPads

myLogHook :: X ()
myLogHook = fadeInactiveLogHook fadeAmount
    where fadeAmount = 0.9

myKeys = azertyKeys <+> keys defaultConfig 

newKeys = 
  [
    -- Recompile and restart xmonad
    ("M-S-r", spawn "xmonad --recompile; xmonad --restart"),
    -- Exit xmonad
    ("M-S-e", io exitSuccess),
    -- Lock the screen
    ("M-x", spawn "betterlockscreen --lock"),

    -- Run Prompt
    ("M-S-<Return>", shellPrompt myXPConfig),
    -- Calc Prompt
    ("M-p c", calcPrompt myXPConfig' "qalc"),
    -- Man Prompt
    ("M-p m", manPrompt myXPConfig),
    -- Pass Prompt
    --("M-p p", passPrompt myXPConfig),
    --("M-p g", passGeneratePrompt myXPConfig),
    --("M-p r", passRemovePrompt myXPConfig)
    -- Ssh Prompt
    ("M-p s", sshPrompt myXPConfig),
    -- Unicode Prompt
    --("M-p u", mkUnicodePrompt "xsel" ["-b"] "/home/theo/.xmonad/UnicodeData.txt" emojiXPConfig)
    ("M-p x", xmonadPrompt myXPConfig),

    -- Launch terminal
    ("M-<Return>", spawn (myTerminal)),
    -- Launch Browser
    ("M-b", spawn (myBrowser)),
    -- Launch htop
    ("C-M1-<Delete>", spawn (myTerminal ++ " -e htop")),

    -- Kill Window
    ("M-S-q", kill1),
    -- Kill all Windows
    ("M-S-a", killAll),

    -- Switch workspace to next Monitor
    ("M-;", nextScreen),
    -- Switch workspace to prev Monitor
    ("M-,", prevScreen),

    -- Toggles float layout
    ("M-f", sendMessage (T.Toggle "floats")),
    -- Push floating window back into tile
    ("M-t", withFocused $ windows . W.sink),
    -- Push all floating windows back into tile
    ("M-S-t", sinkAll),

    -- Decrease window gap
    ("M-d", decWindowSpacing 4),
    -- Increase window gap
    ("M-i", incWindowSpacing 4),
    -- Decrease screen gap
    ("M-S-d", decScreenSpacing 4),
    -- Increase screen gap
    ("M-S-i", incScreenSpacing 4),

    -- Grid select
    ("C-g g", spawnSelected' myAppGrid),
    -- Go to selected window
    ("C-g t", goToSelected $ mygridConfig myColorizer),
    -- Bring selected window
    ("C-g b", bringSelected $ mygridConfig myColorizer),

    -- Tree Select
    ("C-t t", treeselectAction tsDefaultConfig),

    -- Focus master
    ("M-m", windows W.focusMaster),
    -- Focus next
    ("M-<R>", windows W.focusDown),
    -- Focus prev
    ("M-<L>", windows W.focusUp),
    -- Swap focused to master
    ("M-S-m", windows W.swapMaster),
    -- Swap focused with next
    ("M-S-<R>", windows W.swapDown),
    -- Swap focused with prev
    ("M-S-<L>", windows W.swapUp),
    -- Swap focused to master, other keep order
    ("M-<Backspace>", promote),
    -- Rotate all windows except master and keep focus
    ("M-S-<Tab>", rotSlavesDown),
    -- Rotate all the windows in the current stack
    ("M-C-<Tab>", rotAllDown),

    -- Switch to next layout
    ("M-<Tab>", sendMessage NextLayout),
    ("M-C-M1-<Up>", sendMessage Arrange),
    ("M-C-M1-<Down>", sendMessage DeArrange),
    -- Toggle noborder/full
    ("M-<Space>", sendMessage (MT.Toggle NBFULL) >> sendMessage ToggleStruts),
    -- Toggle struts
    ("M-S-<Space>", sendMessage ToggleStruts),
    -- Toggle noborder
    ("M-S-n", sendMessage $ MT.Toggle NOBORDERS),

    -- Increase clients in master pane
    ("M-S-<Up>", sendMessage (IncMasterN 1)),
    -- Decrease clients in master pane
    ("M-S-<Down>", sendMessage (IncMasterN (-1))),
    -- Increase number of windows
    ("M-C-<Up>", increaseLimit),
    -- Decrease number of windows
    ("M-C-<Down>", decreaseLimit),

    -- Shrink Window horiz
    ("M-h", sendMessage Shrink),
    -- Expand Window horiz
    ("M-l", sendMessage Expand),
    -- Shrink Window vert
    ("M-M1-j", sendMessage MirrorShrink),
    -- Expand Window vert
    ("M-M1-k", sendMessage MirrorExpand),

    -- Push or pull window to tabbed sublayout
    ("M-C-h", sendMessage $ pullGroup L),
    ("M-C-l", sendMessage $ pullGroup R),
    ("M-C-k", sendMessage $ pullGroup U),
    ("M-C-j", sendMessage $ pullGroup D),
    ("M-C-m", withFocused (sendMessage . MergeAll)),
    ("M-C-u", withFocused (sendMessage . UnMerge)),
    ("M-C-:", withFocused (sendMessage . UnMergeAll)),
    ("M-C-;", onGroup W.focusUp'),
    ("M-C-,", onGroup W.focusDown'),

    -- Scratchpads
    ("M-C-<Return>", namedScratchpadAction myScratchPads "terminal"),
    ("M-C-c", namedScratchpadAction myScratchPads "mocp"),

    -- Multimedia
    ("<XF86AudioPlay>", spawn "playerctl play-pause"),
    ("<XF86AudioPrev>", spawn "playerctl previous"),
    ("<XF86AudioNext>", spawn "playerctl next"),
    ("<XF86AudioMute>", spawn "pactl set-sink-mute @DEFAULT_SINK@ toggle"),
    ("<XF86AudioLowerVolume>", spawn "pactl set-sink-volume @DEFAULT_SINK@ -5%"),
    ("<XF86AudioRaiseVolume>", spawn "pactl set-sink-volume @DEFAULT_SINK@ +5%"),
    ("<Print>", spawn "flameshot gui")
  ]
  




main :: IO ()
main = do
  xmproc0 <- spawnPipe "xmobar -x 0 /home/theo/.xmonad/xmobarrc"
  xmproc1 <- spawnPipe "xmobar -x 1 /home/theo/.xmonad/xmobarrc2"

  --xmonad $ docks defaultConfig {
  xmonad $ ewmh def {
    manageHook = ( isFullscreen --> doFullFloat ) <+> myManageHook <+> manageDocks,
    handleEventHook = serverModeEventHookCmd <+> serverModeEventHook <+> serverModeEventHookF "XMONAD_PRINT" (io . putStrLn) <+> docksEventHook,
    modMask = myModMask,
    terminal = myTerminal,
    startupHook = myStartupHook,
    layoutHook = showWName' myShowWNameTheme $ myLayoutHook,
    workspaces = myWorkspaces,
    borderWidth = myBorderWidth,
    normalBorderColor = myNormColor,
    focusedBorderColor = myFocusColor,
    keys = myKeys,
    logHook = workspaceHistoryHook <+> myLogHook <+> dynamicLogWithPP xmobarPP
                        { ppOutput = \x -> hPutStrLn xmproc0 x >> hPutStrLn xmproc1 x 
                        , ppCurrent = xmobarColor "#98be65" "" . wrap "[" "]" -- Current workspace in xmobar
                        , ppVisible = xmobarColor "#98be65" ""                -- Visible but not current workspace
                        , ppHidden = xmobarColor "#82AAFF" "" . wrap "" ""   -- Hidden workspaces in xmobar
                        , ppHiddenNoWindows = xmobarColor "#c792ea" ""        -- Hidden workspaces (no windows)
                        , ppTitle = xmobarColor "#b3afc2" "" . shorten 60     -- Title of active window in xmobar
                        , ppSep =  "<fc=#666666> <fn=1>|</fn> </fc>"          -- Separators in xmobar
                        , ppUrgent = xmobarColor "#C45500" "" . wrap "!" "!"  -- Urgent workspace
                        , ppExtras  = [windowCount]                           -- # of windows current workspace
                        , ppOrder  = \(ws:l:t:ex) -> [ws,l]++ex++[t]
                        }
} `additionalKeysP` newKeys


help :: String
help = "ok"
--help = unlines ["The default modifier key is 'alt'. Default keybindings:",
--    "",
--    "-- launching and killing programs",
--    "mod-Shift-Enter  Launch xterminal",
--    "mod-p            Launch dmenu",
--    "mod-Shift-p      Launch gmrun",
--    "mod-Shift-c      Close/kill the focused window",
--    "mod-Space        Rotate through the available layout algorithms",
--    "mod-Shift-Space  Reset the layouts on the current workSpace to default",
--    "mod-n            Resize/refresh viewed windows to the correct size",
--    "",
--    "-- move focus up or down the window stack",
--    "mod-Tab        Move focus to the next window",
--    "mod-Shift-Tab  Move focus to the previous window",
--    "mod-j          Move focus to the next window",
--    "mod-k          Move focus to the previous window",
--    "mod-m          Move focus to the master window",
--    "",
--    "-- modifying the window order",
--    "mod-Return   Swap the focused window and the master window",
--    "mod-Shift-j  Swap the focused window with the next window",
--    "mod-Shift-k  Swap the focused window with the previous window",
--    "",
--    "-- resizing the master/slave ratio",
--    "mod-h  Shrink the master area",
--    "mod-l  Expand the master area",
--    "",
--    "-- floating layer support",
--    "mod-t  Push window back into tiling; unfloat and re-tile it",
--    "",
--    "-- increase or decrease number of windows in the master area",
--    "mod-comma  (mod-,)   Increment the number of windows in the master area",
--    "mod-period (mod-.)   Deincrement the number of windows in the master area",
--    "",
--    "-- quit, or restart",
--    "mod-Shift-q  Quit xmonad",
--    "mod-q        Restart xmonad",
--    "mod-[1..9]   Switch to workSpace N",
--    "",
--    "-- Workspaces & screens",
--    "mod-Shift-[1..9]   Move client to workspace N",
--    "mod-{w,e,r}        Switch to physical/Xinerama screens 1, 2, or 3",
--    "mod-Shift-{w,e,r}  Move client to screen 1, 2, or 3",
--    "",
--    "-- Mouse bindings: default actions bound to mouse events",
--    "mod-button1  Set the window to floating mode and move by dragging",
--    "mod-button2  Raise the window to the top of the stack",
--    "mod-button3  Set the window to floating mode and resize by dragging"]
--