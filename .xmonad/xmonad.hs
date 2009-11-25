import XMonad 
import XMonad.Actions.PhysicalScreens
import Data.Ratio ((%))
import XMonad.Layout.Magnifier
import XMonad.Layout.ToggleLayouts
import XMonad.Layout.Grid
import XMonad.Layout.Tabbed
import XMonad.Layout.NoBorders
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig
import qualified XMonad.StackSet as W
import System.IO
import XMonad.Hooks.ManageHelpers

main = do
     xmproc <- spawnPipe "xmobar ~/.xmobarrc"
     xmonad $ defaultConfig
            { workspaces = myWorkspaces 
            , manageHook = manageDocks <+> composeOne [
                                                     
                                                      isFullscreen -?> doFullFloat
               
                                                      ]

            , layoutHook = avoidStruts $ myLayoutHook 
            , modMask    = mod4Mask
            , terminal   = "urxvt"
            , logHook = dynamicLogWithPP $ xmobarPP
                        { ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor "green" "" . shorten 50 
                        }
            } `additionalKeys` myKeys
myKeys =
       [ ((mod4Mask .|. shiftMask, xK_z), spawn "xscreensaver-command -lock")
            , ((controlMask, xK_Print), spawn "sleep 0.2; scrot -s")
            , ((0, xK_Print), spawn "scrot")
            , ((mod4Mask .|. shiftMask, xK_space), sendMessage ToggleLayout )

       ]
       ++
       [((mod4Mask .|. mask, key), f sc)
         | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
         , (f, mask) <- [(viewScreen, 0), (sendToScreen, shiftMask)]]

       ++
       [((m .|. mod4Mask, k), windows $ f i)
         | (i, k) <- zip myWorkspaces [xK_1 .. xK_9]
         , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]
      
       
myWorkspaces = ["1","2","3","4","5","6","7","8","9"]

myLayoutHook = toggleLayouts (noBorders $ smartBorders Full) (noBorders $ smartBorders simpleTabbed)  ||| tiled ||| Mirror tiled ||| Grid
             where
                tiled = Tall nmaster delta ratio
                nmaster = 1
                ratio = 1/2
                delta = 3/100 