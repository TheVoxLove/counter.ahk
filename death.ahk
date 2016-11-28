#Persistent
#InstallKeybdHook
#SingleInstance force

Gosub, StartUp

IncreaseButton = %IncButton%
DecreaseButton = %DecButton%
ResetButton = %RCButton%

Hotkey, %IncreaseButton%, IncreaseCounter
Hotkey, %DecreaseButton%, DecreaseCounter
Hotkey, %ResetButton%, ResetCounter

IncreaseCounter:
  if PopUp = 0
  {
    IfNotExist, %filePath%
      FileAppend, 0, %filePath%
    FileReadLine, counterVar, %filePath%, 1
    counterVar := ++counterVar
    FileDelete, %filePath%
    FileAppend, %counterVar%, %filePath%
  }
  return

DecreaseCounter:
  if PopUp = 0
  {
    IfNotExist, %filePath%
      FileAppend, 0, %filePath%
    FileReadLine, counterVar, %filePath%, 1
    if counterVar = 0
      return
    counterVar := --counterVar
    FileDelete, %filePath%
    FileAppend, %counterVar%, %filePath%
  }
  return

ResetCounter:
  if PopUp = 0
  {
    IfNotExist, %filePath%
      FileAppend, 0, %filePath%
    FileReadLine, counterVar, %filePath%, 1
    counterVar = 0
    FileDelete, %filePath%
    FileAppend, %counterVar%, %filePath%
  }
  return

StartUp:
  iniLocation = %A_ScriptDir%\Settings.ini
  Gosub, MakeIni
  Gosub, ReadKeys
  Gosub, SetFilePath
  PopUp = 1
  MsgBox, 4, Script, Would you like to configure the hotkeys?
  IfMsgBox, No
  {
    Gosub, WriteReadKeys
    PopUp = 0
    return
  }
  IfMsgBox, Yes
  {
    Gui, Add, Text,, Increment Key:
    Gui, Add, Text,, Decrement Key:
    Gui, Add, Text,, Reset Counter Key:
    Gui, Add, Text,, File Name:
    Gui, Add, Button, ym W80 vIncButton gButtonInc, %IncButton%
    Gui, Add, Button, W80 vDecButton gButtonDec, %DecButton%
    Gui, Add, Button, W80 vRCButton gButtonRC, %RCButton%
    Gui, Add, Edit, W80 vFileName, %FileName%
    Gui, Add, Button, xm W100, &Default
    Gui, Add, Button, Default W100 xm, OK
    Gui, Show, W210, Configuration
    return
    GuiClose:
      if A_GuiEvent = Normal
        Gui Destroy
        PopUp = 0
      return
    ButtonOK:
      Gui, Submit
      Gosub, WriteReadKeys
      Gosub, SetFilePath
      PopUp = 0
      return
    ButtonInc:
      prevVar := IncButton
      Input, IncButton, L1, {LControl}{RControl}{LAlt}{RAlt}{LShift}{RShift}{LWin}{RWin}{AppsKey}{F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Left}{Right}{Up}{Down}{Home}{End}{PgUp}{PgDn}{Del}{Ins}{BS}{Capslock}{Numlock}{PrintScreen}{Pause}
      IncButton := ExtraKeys(IncButton)
      if(IncButton = DecButton || IncButton = RCButton)
        IncButton := prevVar
      GuiControl,, IncButton, %IncButton%
      return
    ButtonDec:
      prevVar := DecButton
      Input, DecButton, L1, {LControl}{RControl}{LAlt}{RAlt}{LShift}{RShift}{LWin}{RWin}{AppsKey}{F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Left}{Right}{Up}{Down}{Home}{End}{PgUp}{PgDn}{Del}{Ins}{BS}{Capslock}{Numlock}{PrintScreen}{Pause}
      DecButton := ExtraKeys(DecButton)
      if(DecButton = IncButton || DecButton = RCButton)
        DecButton := prevVar
      GuiControl,, DecButton, %DecButton%
      return
    ButtonRC:
      prevVar := RCButton
      Input, RCButton, L1, {LControl}{RControl}{LAlt}{RAlt}{LShift}{RShift}{LWin}{RWin}{AppsKey}{F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Left}{Right}{Up}{Down}{Home}{End}{PgUp}{PgDn}{Del}{Ins}{BS}{Capslock}{Numlock}{PrintScreen}{Pause}
      RCButton := ExtraKeys(RCButton)
      if(RCButton = IncButton || RCButton = DecButton)
        RCButton := prevVar
      GuiControl,, RCButton, %RCButton%
      return
    ButtonDefault:
      IncButton = F12
      GuiControl,, IncButton, %IncButton%
      DecButton = F11
      GuiControl,, DecButton, %DecButton%
      RCButton = F10
      GuiControl,, RCButton, %RCButton%
      return
    ExtraKeys(var)
    {
      If ErrorLevel = EndKey:F1
        var = F1
      If ErrorLevel = EndKey:F2
        var = F2
      If ErrorLevel = EndKey:F3
        var = F3
      If ErrorLevel = EndKey:F4
        var = F4
      If ErrorLevel = EndKey:F5
        var = F5
      If ErrorLevel = EndKey:F6
        var = F6
      If ErrorLevel = EndKey:F7
        var = F7
      If ErrorLevel = EndKey:F8
        var = F8
      If ErrorLevel = EndKey:F9
        var = F9
      If ErrorLevel = EndKey:F10
        var = F10
      If ErrorLevel = EndKey:F11
        var = F11
      If ErrorLevel = EndKey:F12
        var = F12
      If ErrorLevel = EndKey:LControl
        var = LControl
      If ErrorLevel = EndKey:RControl
        var = RControl
      If ErrorLevel = EndKey:LAlt
        var = LAlt
      If ErrorLevel = EndKey:RAlt
        var = RAlt
      If ErrorLevel = EndKey:LShift
        var = LShift
      If ErrorLevel = EndKey:RShift
        var = RShift
      If ErrorLevel = EndKey:LWin
        var = LWin
      If ErrorLevel = EndKey:RWin
        var = RWin
      If ErrorLevel = EndKey:AppsKey
        var = AppsKey
      If ErrorLevel = EndKey:Left
        var = Left
      If ErrorLevel = EndKey:Right
        var = Right
      If ErrorLevel = EndKey:Up
        var = Up
      If ErrorLevel = EndKey:Down
        var = Down
      If ErrorLevel = EndKey:Home
        var = Home
      If ErrorLevel = EndKey:End
        var = End
      If ErrorLevel = EndKey:PgUp
        var = PgUp
      If ErrorLevel = EndKey:PgDn
        var = PgDn
      If ErrorLevel = EndKey:Delete
        var = Delete
      If ErrorLevel = EndKey:Insert
        var = Insert
      If ErrorLevel = EndKey:Backspace
        var = Backspace
      If ErrorLevel = EndKey:Capslock
        var = Capslock
      If ErrorLevel = EndKey:Numlock
        var = Numlock
      If ErrorLevel = EndKey:PrintScreen
        var = PrintScreen
      If ErrorLevel = EndKey:Pause
        var = Pause
      return var
    }
  }
  return

SetFilePath:
  filePath = %A_ScriptDir%\%fileName%.txt
  return

MakeIni:
  IfNotExist, %iniLocation%
  {
    IniWrite, F12, %iniLocation%, Controls, IncrementKey
    IniWrite, F11, %iniLocation%, Controls, DecrementKey
    IniWrite, F10, %iniLocation%, Controls, ResetKey
    IniWrite, Counter, %iniLocation%, Settings, fileName
  }
  return

WriteKeys:
  IniWrite, %IncButton%, %iniLocation%, Controls, IncrementKey
  IniWrite, %DecButton%, %iniLocation%, Controls, DecrementKey
  IniWrite, %RCButton%, %iniLocation%, Controls, ResetKey
  IniWrite, %fileName%, %iniLocation%, Settings, fileName
  return

ReadKeys:
  IniRead, IncButton, %iniLocation%, Controls, IncrementKey
  IniRead, DecButton, %iniLocation%, Controls, DecrementKey
  IniRead, RCButton, %iniLocation%, Controls, ResetKey
  IniRead, fileName, %iniLocation%, Settings, fileName
  return

WriteReadKeys:
  Gosub, WriteKeys
  Gosub, ReadKeys
  return
