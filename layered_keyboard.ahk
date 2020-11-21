#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#HotkeyInterval 1000000000
#MaxHotkeysPerInterval 9999999999999

; # Windows
; ^ Control
; ! Alt

; Remapping the common shortcuts:
^q::^x ;cut
^j::^c ;copy
^k::^v ;paste
^;::^z ;undo
^o::^s ;save		
^l::^p ;print

#SingleInstance Force ; Allow only one running instance of script.
CoordMode, ToolTip, Screen  ; Place ToolTips at absolute screen coordinates:

kbd_layer := 0

tooltip_duration := 2000
	
noti_x := A_ScreenWidth//2-400
noti_y := A_ScreenHeight//2-100

;//////////////////////////////////////////////////////////////
; notications
;//////////////////////////////////////////////////////////////
PopUp(msg){
  global noti_x
  global noti_y
  Tooltip, % "`n`n`t`t " . msg . "`t`t`t`n`n ", %noti_x%, %noti_y%
  ; SetTimer, RemoveToolTip, %tooltip_duration%
  SetTimer, RemoveToolTip, -2000
}

RemoveToolTip:
ToolTip
return

SetLayer(num){
  global kbd_layer
  kbd_layer := num
  If(num = 0){
    PopUp("layer 0 (Normal)")
  } Else If(num = 1){
    PopUp("layer 1")
  } Else If(num = 2){
    PopUp("layer 2")
  } Else If(num = 3){
    PopUp("layer 3")
  }
}
return

/::Backspace
-::Enter
Tab::Escape
LCtrl::Tab
LShift::LCtrl
RShift::RWin
RCtrl::
  SetLayer(0)
return

#If kbd_layer=0

  LAlt::
    SetLayer(1)
  return

  RAlt::
    #IfWinActive
    SetLayer(2)
  return

  +'::"
  +,::<
  +.::>
  +p::P
  +y::Y
  +f::F
  +g::G
  +c::C
  +r::R
  +l::L

  +a::A
  +o::O
  +e::E
  +u::U
  +i::I
  +d::D
  +h::H
  +t::T
  +n::N
  +s::S

  +`;::Send {:}
  +q::Q
  +j::J
  +k::K
  +x::X
  +b::B
  +m::M
  +w::W
  +v::V
  +z::Z

  $space::
    send {LShift down} 
    Spacedown := A_TickCount
  Return 
   
  $+space up::
    send {LShift up}   
    if (A_PriorHotkey == "$space") 
      Send {Space}
  Return

return ; end kbd_layer= 0

#If kbd_layer=1

  LAlt Up::
    SetLayer(0)
  return
  RAlt::
    SetLayer(3)
  return
  
  a::_
  o::{
  e::}
  u::=
  i::Send {+}
  d::-
  h::Left 
  t::(
  n::)
  s::/

  '::!
  ,::@
  .::#
  f::Send {`%}
  g::Send {*}
  c::[
  r::]
  l::Right

  j::Down
  k::Up
  b::$
  m::&
  w::^

return ; end kbd_layer= 1

#If kbd_layer=2

  RAlt Up::
    SetLayer(0)
  return
  LAlt::
    SetLayer(3)
  return

  a::á 
  A::Á
  o::ó
  O::Ó
  e::é
  E::É
  u::ú
  U::Ú
  i::í
  I::Í
  d::
    Send !{F4}
    keyWait, d
  return
  h:: ;one-key alt-tab (tested on Windows 7)
    vAltTabTickCount := A_TickCount
    if WinActive("ahk_class TaskSwitcherWnd")
      SendInput, {Tab}
    else
    {
      SendInput, {Alt Down}{Tab}
      SetTimer, AltTabSendTab, 500
    }
  return
  t::return
  n::ñ
  N::Ñ
  s::return

  '::1
  ,::2
  .::3
  p::4
  y::5
  f::6
  g::7
  c::8
  r::9
  l::0

  q::Send {``}
  j::^#Left
  k::^#Right
  b::?
  m::~

return ; end kbd_layer= 2

AltTabSendTab:
  if GetKeyState("h", "P")
    vAltTabTickCount := A_TickCount
  if WinActive("ahk_class TaskSwitcherWnd") && !(A_TickCount - vAltTabTickCount > 400)
    return

  SendInput, {Alt Up}
  SetTimer, AltTabSendTab, Off
return

#If kbd_layer=3

  LAlt Up::
    SetLayer(2)
  return
  RAlt Up::
    SetLayer(1)
  return

return ; end kbd_layer= 3