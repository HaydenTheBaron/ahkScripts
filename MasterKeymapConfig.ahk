;#######################################################################################################################
;#######################################################################################################################
;# HAYDEN'S WINDOWS 10 KEY & MOUSE CONFIG
;#######################################################################################################################
;#######################################################################################################################
SetCapsLockState, AlwaysOff ; Necessary for implementation of ToggleCapsLock later // TODO: removemme?

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;#######################################################################################################################
;# NOTES
;#######################################################################################################################

;; DESIGN GOALS
; 1. Minimize collisions with existing keyboard shortcuts
; 2. Separate shortcut types into "channels", where shortcuts of the same category
;    lie on the same channel and are triggered by the same modkey/modkey-combination.
; 3. Mnemonics
; 4. Ergonomics: Frequently used shortcuts should be easy to trigger rapidly and
;    repeatedly without strain. Infrequently used shortcuts can be more cumbersome.

;; MOD KEYS
; * Capslock -- for window management
; * AppsKey -- for launching apps and macros
; * <! (Left Alt) -- for cursor movement
; * >! (Right Alt) -- TODO: figure out channel for right alt
; * LWin -- (The regular function has been replaced by Del)
; * Backspace -- (Regular function replaced elsewhere)


;#######################################################################################################################
;# SIMPLE KEY REMAPS
;#######################################################################################################################

;; Caplock => Esc
CapsLock::SendInput, {Esc}

;; Shift + Esc => Toggle Capslock
+Esc::
    state := GetKeyState("Capslock", "T")  ; 1 if CapsLock is ON, 0 otherwise.
    if state = 1
    {
        SetCapsLockState, AlwaysOff
    }
    else
    {
        SetCapsLockState, On
    }
    return

;; Del => Virtual Windows Keypress
Delete::Send {LWin down}
Delete Up::Send {LWin up}

;#######################################################################################################################
;# TEST AND TODO
;#######################################################################################################################

; TODO: change lots of `Send`s to `SendInput`


;#######################################################################################################################
;# KEYBOARD CURSOR NAVIGATION AND EDITING
;#######################################################################################################################


;; Move cursor once
<!h:: Send {Left}
<!l:: Send {Right}
<!k:: Send {Up}
<!j:: Send {Down}

;; Move cursor by word (lr) / 5 lines (ud)
^<!h:: Send ^{Left}
^<!l:: Send ^{Right}
^<!k:: Send {Up}{Up}{Up}{Up}{Up}
^<!j:: Send {Down}{Down}{Down}{Down}{Down}

;; Move cursor once -- while highlighting
+<!h:: Send +{Left}
+<!l:: Send +{Right}
+<!k:: Send +{Up}
+<!j:: Send +{Down}

;; Move cursor by word (lr) / 5 lines (ud) -- while highlighting
^+<!h:: Send ^+{Left}
^+<!l:: Send ^+{Right}
^+<!k:: Send ^+{Up}
^+<!j:: Send ^+{Down}

;; Move cursor to beginning/end of line/page
<!6:: Send {Home}	; same key as ^
<!4:: Send {End}    ; same key as $
<!g:: Send ^{End}			
<!+g:: Send ^{Home}

;; Move cursor to beginning/end of line/page -- while highlighting
<!+6:: Send +{Home}
<!+4:: Send +{End}

;; Backpace/Delete
<!Space:: SendInput, {BackSpace}     ; Back by char
+<!Space:: SendInput, {Delete}       ; Del  by char
^<!Space:: SendInput, ^{BackSpace}   ; Back by word
^+<!Space:: SendInput, ^{Delete}     ; Del  by word

+Backspace:: SendInput, {Delete}       ; Del  by char
^+Backspace:: SendInput, ^{Delete}     ; Del  by word

;; Send 4 spaces
^+Space:: Send, {Space}{Space}{Space}{Space}


;#######################################################################################################################
;# WINDOW MANAGEMENT
;#######################################################################################################################

;;;;;;;;;;;;;;;;;;;;;;;;;
; SNAP WINDOWS
;;;;;;;;;;;;;;;;;;;;;;;;;

;; Snap current window left
; CapsLock & j::Send {LWin down}{Left}
; CapsLock & j Up::Send {LWin up}{Left}

;; Snap current window right
; CapsLock & `;::Send {LWin down}{Right}
; CapsLock & `; Up::Send {LWin up}{Right}

;; Snap current window down
; CapsLock & k::Send {LWin down}{Down}
; CapsLock & k Up::Send {LWin up}{Down}

;; Snap current window up
; CapsLock & l::Send {LWin down}{Up}
; CapsLock & l Up::Send {LWin up}{Up}

;;;;;;;;;;;;;;;;;;;;;;;;;
; CYCLE WINDOWS
;;;;;;;;;;;;;;;;;;;;;;;;;

;; cycle left a window (less recent) // TODO: figure out a way to display window graphic
; CapsLock & u::Send {Alt down}+{Tab}
; CapsLock & u Up::Send {Alt up}

;; cycle right a window (more recent)
; CapsLock & p::Send {Alt down}{Tab}
; CapsLock & p Up::Send {Alt up}

;;;;;;;;;;;;;;;;;;;;;;;;;
; DESKTOP ENVIRONMENTS
;;;;;;;;;;;;;;;;;;;;;;;;;

;; Open Desktops overview
; CapsLock & Space::Send #{Tab}

;; Cycle left a desktop environment
#If GetKeyState("Shift", "P")
; CapsLock & j::Send ^#{Left}
#If

;; Cycle right a desktop environment
#If GetKeyState("Shift", "P")
; CapsLock & `;::Send ^#{Right}
#If

;;;;;;;;;;;;;;;;;;;;;;;;;
; OTHER
;;;;;;;;;;;;;;;;;;;;;;;;;

; CapsLock & x:: Send !{F4} ;; Close the current window
; CapsLock & d:: Send #d ;; Show desktop


;#######################################################################################################################
;# LAUNCH MACROS
;#######################################################################################################################

;; TODO: for apps: check to see if the app is open. If so, navigate to that app. Else open a new instance of the app.

;; NOTE on web browsers
;;
;; Different browsers are used for different kinds of service to make it easier to find the right
;; browser window when managing windows, and also to make it easier for rescuetime to categorize time.
;;
;; Firefox -- used for standalone productive "apps". e.g: gmail, todoist, google calendar, rescuetime, etc
;; Firefox Developer -- used to launch productive sites that are not standalone apps. e.g.: canvas
;; Chrome -- used to launch neutral productivity things 


;; firefox-dev := "C:\Program Files\Firefox Developer Edition\firefox.exe" TODO: use variables for default browsers.



;; Run
AppsKey::
RCtrl:: Send #r

;; Edit Autohotkey config in terminal
AppsKey & a::
RCtrl & a::
    Send, #r
    WinWait, Run
    Send, bash.exe {Enter}
    Sleep, 200
    Send, cd /mnt/c/Users/hleba/Desktop/ahkScripts/{Enter}
    Sleep, 200
    Send, code  MasterKeymapConfig.ahk{Enter}
    return

;; Terminal
AppsKey & t::
RCtrl & t::
    Send #r ;; Use this instead of `Run` so that .exe's on path can be run from this terminal instance
    WinWait, Run
    Send wt.exe{Enter}
    return

;; (Productive) Browser
AppsKey & b::
RCtrl & b::
    Run, firefox.exe
    return

;; Instructure Canvas
AppsKey & i::
RCtrl & i::
    Send #r
    WinWait, Run
    Sleep, 200
    ;; TODO: replace with browser variable
    Send vivaldi https://utah.instructure.com/login{Enter}
    return

;; Gmail
AppsKey & g::
RCtrl & g::
    Send #r
    WinWait, Run
    Sleep, 200
    Send vivaldi https://mail.google.com/{Enter}
    return
    

;; Wolfram Alpha
AppsKey & w::
RCtrl & w::
    Send #r
    WinWait, Run
    Sleep, 200
    Send vivaldi https://www.wolframalpha.com{Enter}
    return

;; (1) Canvas: CS3505
AppsKey & 1::
RCtrl & 1::
    Send #r
    WinWait, Run
    Sleep, 200
    Send vivaldi https://utah.instructure.com/courses/601744{Enter}
    return

;; (2) Canvas: CS4150
AppsKey & 2::
RCtrl & 2::
    Send #r
    WinWait, Run
    Sleep, 200
    Send vivaldi https://utah.instructure.com/courses/603207{Enter}
    return

;; (3) Canvas: CS3200
AppsKey & 3::
RCtrl & 3::
    Send #r
    WinWait, Run
    Sleep, 200
    Send vivaldi https://utah.instructure.com/courses/602726{Enter}
    return

;; (4) Canvas: CS3011
AppsKey & 4::
RCtrl & 4::
    Send #r
    WinWait, Run
    Sleep, 200
    Send vivaldi https://utah.instructure.com/courses/600743{Enter}
    return
   
;; Google Calendar
AppsKey & c::
RCtrl & c::
    Send #r
    WinWait, Run
    Send vivaldi https://calendar.google.com/calendar/{Enter}
    return

;; ToDoist
AppsKey & d::
RCtrl & d::
    Send #r
    WinWait, Run
    Send vivaldi todoist.com {Enter}
    return

;; Messages
AppsKey & m::
RCtrl & m::
    Send #r
    WinWait, Run
    Send vivaldi https://messages.google.com/web{Enter}
    return

;; VS Code
AppsKey & v::
RCtrl & v::
    Send #r
    WinWait, Run
    Send code{Enter}
    return

;; VcXSrv (L for Linux)
AppsKey & l::
RCtrl & l::
    Send #r
    WinWait, Run
    Send "C:\Program Files\VcXsrv\vcxsrv.exe"{Enter}
    Sleep, 1000
    Send #r
    WinWait, Run
    Send bash.exe{Enter}
    Sleep, 500
    Send startlxde{Enter}
    Sleep, 500
    Send #{Down}
    return

;; Exist.io
AppsKey & e::
RCtrl & e::
    Send #r
    WinWait, Run
    Send vivaldi https://exist.io/dashboard/{Enter}
    return

;; Rescue Time
AppsKey & r::
RCtrl & r::
    Send #r
    WinWait, Run
    Send vivaldi https://www.rescuetime.com/dashboard{Enter}
    return
    

;#######################################################################################################################
;# OTHER HOTKEYS
;#######################################################################################################################

^+Escape::
    ExitApp
    return
