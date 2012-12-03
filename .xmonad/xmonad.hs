import System.IO
import XMonad
import XMonad.Actions.CycleWindows
import XMonad.Actions.CycleWS
import XMonad.Actions.DwmPromote
import XMonad.Actions.GridSelect
import XMonad.Actions.WindowGo
import XMonad.Config.Desktop
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.UrgencyHook
import XMonad.Layout.MultiToggle
import XMonad.Layout.MultiToggle.Instances
import XMonad.Layout.Named
import XMonad.Layout.NoBorders
import XMonad.Util.EZConfig
import XMonad.Util.Run(spawnPipe)

-- SPAWNS {{
trayer'     = "trayer --edge top --align left --SetDockType true --SetPartialStrut false --expand true --widthtype percent --width 5 --transparent true --tint 0x000000 --height 16"
dropbox'    = "dropbox -d"
nmapplet'   = "nm-applet"
skype'      = "skype"
feh'        = "feh --bg-fill ~/Dropbox/rkmathi/media/pict/wallpaper"
-- SPAWNS }}


-- SETTINGS {{
workspaces' = [ "1:term", "2:web", "3:mikutter", "4:file", "5:misc" ]
manageHook' :: ManageHook
manageHook' = (composeAll . concat $
    [ [resource  =? r --> doIgnore              | r <- myIgnores  ]
    , [name      =? n --> doCenterFloat         | n <- myNames    ]
    , [className =? c --> doCenterFloat         | c <- myFloats   ]
    , [className =? c --> doShift "1:term"      | c <- myTerms    ]
    , [className =? c --> doShift "2:web"       | c <- myWebs     ]
    , [className =? c --> doShift "3:mikutter"  | c <- myMikutters]
    , [className =? c --> doShift "4:file"      | c <- myFiles    ]
    , [className =? c --> doShift "5:misc"      | c <- myMiscs    ]
    ])
    where
        -- role & name
        role = stringProperty "WM_WINDOW_ROLE"
        name = stringProperty "WM_NAME"
        myIgnores  = ["desktop", "desktop_window",
                      "notify-osd", "stalonetray", "trayer"]
        myNames    = ["Google Chrome Options", "bashrun"]
        myFloats   = ["Save As...", "Downloads", "Gimp", "Mikutter.rb",
                      "Mirage"]
        myTerms    = ["Gnome-terminal", "Sakura"]
        myWebs     = ["Google-chrome", "Firefox"]
        myMikutters= ["Mikutter.rb"]
        myFiles    = ["Thunar", "Mirage", "Searchmonkey2"]
        myMiscs    = ["Lyx", "Skype"]

-- Layout'
tall        = Tall 1 (10/100) (1/2)
layoutHook' = mkToggle1 FULL $ desktopLayoutModifiers
                               (named "V" tall ||| (named "H" $ Mirror tall))

-- logHook'
logHook' h = dynamicLogWithPP $ dzenPP' { ppOutput = hPutStrLn h }

-- additionalKeysP'
additionalKeysP' =  [
      ("M-q",   spawn "xmonad --recompile; xmonad --restart")
    , ("C-M-x", spawn "xlock -mode blank")
    , ("C-M-q", spawn "gksu 'shutdown -h now'")
    , ("S-M-,", moveTo Prev NonEmptyWS)
    , ("S-M-.", moveTo Next NonEmptyWS)
    , ("M-f",   sendMessage $ Toggle FULL)
    , ("M-`",   goToSelected  defaultGSConfig)
    , ("<Print>", spawn "gnome-screenshot")
    , ("S-M-`", spawnSelected defaultGSConfig ["gnome-terminal"
                                             , "google-chrome"
                                             , "mikutter"
                                             , "thunar"
                                             , "lyx"]
      )]

-- dzen*'
dzenStatus' = "dzen2 -x '70' -w '920' -ta 'l'" ++ dzenStyle'
dzenConky'  = "conky -c ~/.xmonad/conkyrc | dzen2 -x '990' -w '450' -ta 'r'" ++ dzenStyle'
dzenStyle'  = " -h '16' -fg '#777777' -bg '#000000'"
dzenPP'     = dzenPP
    { ppCurrent = dzenColor "#33ffff" ""
        . wrap " " " "
    , ppHidden  = dzenColor "#cccc33" ""
        . wrap " " " "
    , ppHiddenNoWindows = dzenColor "#777777" ""
        . wrap " " " "
    , ppUrgent  = dzenColor "#ff0000" ""
        . wrap " " " "
    , ppSep     = " "
    , ppLayout  = dzenColor "#ffff00" ""
        . wrap " " " "
    , ppTitle   = dzenColor "#ffffff" ""
        . wrap " " " " . shorten 100 . dzenEscape
    }
-- SETTINGS }}


-- MAIN {{
main = do
        status <- spawnPipe dzenStatus'
        conky  <- spawnPipe dzenConky'
        spawn trayer'
        spawn dropbox'
        spawn nmapplet'
        spawn skype'
        spawn feh'
        xmonad $ withUrgencyHook NoUrgencyHook $ defaultConfig
            { modMask           = mod4Mask
            , terminal          = "gnome-terminal"
            , borderWidth       = 1
            , normalBorderColor = "77ff77"
            , focusedBorderColor= "ff77ff"
            , workspaces        = workspaces'
            , layoutHook        = layoutHook'
            , manageHook        = manageDocks <+> manageHook'
            , logHook           = logHook' status
            }
            `additionalKeysP`additionalKeysP'
-- MAIN }}
