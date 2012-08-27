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
import System.IO
import qualified XMonad.StackSet as W


-- SPAWNS {{
-- trayer'
trayer' = "trayer --edge top --align left --SetDockType true --SetPartialStrut false --expand true --widthtype percent --width 5 --transparent true --tint 0x000000 --height 16"
-- dropbox'
dropbox' = "dropbox -d"
-- feh'
--feh' = "feh --bg-center ~/wallpaper"
feh' = "feh --bg-center ~/Dropbox/rkmathi/media/pict/vocaloid/22395662.jpg"
-- SPAWNS }}


-- SETTINGS {{
-- Workspaces'
workspaces' = [ "1:term",       "2:web",        "3:mikutter",
                "4:msg",        "5:file",       "6:image",
                "7:pdf",        "8:vm",         "9:misc"    ]

-- ManageHook'
manageHook' :: ManageHook
manageHook' = (composeAll . concat $
    [ [resource  =? r --> doIgnore              | r <- myIgnores  ]
    , [name      =? n --> doCenterFloat         | n <- myNames    ]
    , [className =? c --> doShift "1:term"      | c <- myTerms    ]
    , [className =? c --> doShift "2:web"       | c <- myWebs     ]
    , [className =? c --> doShift "3:mikutter"  | c <- myMikutters]
    , [className =? c --> doShift "4:msg"       | c <- myMsgs     ]
    , [className =? c --> doShift "5:file"      | c <- myFiles    ]
    , [className =? c --> doShift "6:image"     | c <- myImages   ]
    , [className =? c --> doShift "7:pdf"       | c <- myPdfs     ]
    , [className =? c --> doShift "8:vm"        | c <- myVms      ]
    , [className =? c --> doShift "9:misc"      | c <- myMiscs    ]
    , [className =? c --> doCenterFloat         | c <- myFloats   ]
    ])
    where
        -- role & name
        role = stringProperty "WM_WINDOW_ROLE"
        name = stringProperty "WM_NAME"
        -- resources
        myIgnores  = ["desktop", "desktop_window",
                      "notify-osd", "stalonetray", "trayer"]
        -- names
        myNames    = ["Google Chrome Options", "bashrun"]
        -- classnames
        myTerms    = ["Gnome-terminal","Sakura"]
        myWebs     = ["Google-chrome", "Firefox"]
        myMikutters= ["Mikutter.rb"]
        myMsgs     = ["Xchat", "Skype"]
        myFiles    = ["Thunar"]
        myImages   = ["Comix", "Gimp"]
        myPdfs     = ["Acroread", "Xpdf"]
        myVms      = ["VirtualBox"]
        myMiscs    = []
        myFloats   = ["Save As...", "Downloads",
                      "Gimp", "Mikutter.rb"]

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
                                             , "lyx"
                                             , "gedit"
                                             , "mikutter"
                                             , "gwit"
                                             , "firefox-bin"
                                             , "libreoffice"
                                             , "vlc"
                                             , "skype"
                                             , "thunar"
                                             , "comix"
                                             , "acroread"]
                                             )
                    ]

-- dzen*'
dzenStatus' = "dzen2 -x '70' -w '920' -ta 'l'" ++ dzenStyle'
dzenConky'  = "conky -c ~/.xmonad/conkyrc | dzen2 -x '990' -w '450' -ta 'r'" ++ dzenStyle'
dzenStyle'  =" -h '16' -fg '#777777' -bg '#222222'"
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
        spawn feh'
        xmonad $ withUrgencyHook NoUrgencyHook $ defaultConfig
            { modMask           = mod4Mask
--            , terminal          = "sakura"
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
