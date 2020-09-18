#NoEnv                      ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn                     ; Enable warnings to assist with detecting common errors.
#SingleInstance FORCE       ; Skip invocation dialog box and silently replace previously executing instance of this script.
SendMode Input              ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


;================================================================================================
;  CapsLock processing.  Must double tap CapsLock to toggle CapsLock mode on or off.
;================================================================================================
; Must double tap CapsLock to toggle CapsLock mode on or off.
CapsLock::
    KeyWait, CapsLock                                                   ; Wait forever until Capslock is released.
    KeyWait, CapsLock, D T0.2                                           ; ErrorLevel = 1 if CapsLock not down within 0.2 seconds.
    if ((ErrorLevel = 0) && (A_PriorKey = "CapsLock") )                 ; Is a double tap on CapsLock?
        {
        SetCapsLockState, % GetKeyState("CapsLock","T") ? "Off" : "On"  ; Toggle the state of CapsLock LED
        }
return

;===============================================================================================
; Bind capslock and ijkl to up, left, down, right and u, o to Home & End, h & ; to control+left, control+right
;===============================================================================================

CapsLock & u::Send,  {blind}{Home}
CapsLock & o::Send,  {blind}{End}
CapsLock & j::Send,  {blind}{Left}
CapsLock & k::Send,  {blind}{Down}
CapsLock & l::Send,  {blind}{Right}
CapsLock & i::Send,  {blind}{Up}
CapsLock & h::Send,  ^{Left}
CapsLock & `;::Send, ^{Right}

;================================================================================================
; Hot keys with CapsLock modifier.  See https://autohotkey.com/docs/Hotkeys.htm#combo
;================================================================================================
; Get DEFINITION of selected word.    
;CapsLock & d::
;    ClipboardGet()
;    Run, http://www.google.com/search?q=define+%clipboard%     ; Launch with contents of clipboard
;    ClipboardRestore()
;Return

; GOOGLE the selected text.
CapsLock & g::
    ClipboardGet()
    Run, http://www.google.com/search?q=%clipboard%             ; Launch with contents of clipboard
    ClipboardRestore()
Return

; Do THESAURUS of selected word
;CapsLock & t::
;    ClipboardGet()
;    Run http://www.thesaurus.com/browse/%Clipboard%             ; Launch with contents of clipboard
;   ClipboardRestore()
;Return

; Do WIKIPEDIA of selected word
CapsLock & w::
    ClipboardGet()
    Run, https://en.wikipedia.org/wiki/%clipboard%              ; Launch with contents of clipboard
    ClipboardRestore()
Return

;+++++++++++++++++++++++++++++++++++++++++++++++++++++++++

;================================================================================================
; Clipboard helper functions.
;================================================================================================
ClipboardGet()
{
    OldClipboard:= ClipboardAll                         ;Save existing clipboard.
    Clipboard:= ""
    Send, ^c                                            ;Copy selected test to clipboard
    ClipWait 0
    If ErrorLevel
        {
        MsgBox, No Text Selected!
        Return
        }
}


ClipboardRestore()
{
    Clipboard:= OldClipboard
}

