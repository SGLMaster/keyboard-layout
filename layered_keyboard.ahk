#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#HotkeyInterval 1000000000
#MaxHotkeysPerInterval 9999999999999
#Warn

; # Windows
; ^ Control
; ! Alt

#SingleInstance Force ; Allow only one running instance of script.
CoordMode, ToolTip, Screen  ; Place ToolTips at absolute screen coordinates:

kbd_layer := 0

tooltip_duration := 2000
	
noti_x := A_ScreenWidth
noti_y := A_ScreenHeight

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

*`::return
*1::return
*2::return
*3::return
*4::return
*5::return
*6::return
*7::return
*8::return
*9::return
*0::return
*-::return
*=::return
*]::return
*\::return

[::Backspace
'::Enter
Tab::Escape
LCtrl::Tab
LShift::LCtrl
RShift::RWin
RCtrl::
  SetLayer(0)
return

#If kbd_layer=0

  *LAlt::
    SetLayer(1)
  return
  *RAlt::
    #IfWinActive
    SetLayer(2)
  return

  a::a
  s::o
  d::e
  f::u
  g::i
  h::d
  j::h
  k::t
  l::n
  SC027::s
  +a::A
  +s::O
  +d::E
  +f::U
  +g::I
  +h::D
  +j::H
  +k::T
  +l::N
  +SC027::S
  
  q::'
  w::,
  e::.
  r::p
  t::y
  y::f
  u::g
  i::c
  o::r
  p::l
  +q::"
  +w::<
  +e::>
  +r::P
  +t::Y
  +y::F
  +u::G
  +i::C
  +o::R
  +p::L

  z::;
  x::q
  c::j
  v::k
  b::x
  n::b
  m::m
  ,::w
  .::v
  /::z
  +z::send {:}
  +x::Q
  +c::J
  +v::K
  +b::X
  +n::B
  +m::M
  +,::W
  +.::V
  +/::Z

  $space::
    send {LShift down} 
  return 
   
  $+space up::
    send {LShift up}   
    if (A_PriorHotkey == "$space") 
      SendInput {Space}
  return

; end kbd_layer= 0

#If kbd_layer=1

  *LAlt Up::
    SetLayer(0)
  return
  *RAlt::
    SetLayer(3)
  return
  
  a::[
  s::{
  d::}
  f::]
  g::Send {+}
  h::-
  j::Left 
  k::(
  l::)
  SC027::/
  +a::return
  +s::return
  +d::return
  +f::return
  +g::return
  +h::return
  +j::return
  +k::return
  +l::return
  +SC027::return

  q::!
  w::@
  e::#
  r::$
  t::send, `%
  y::^
  u::&
  i::*
  o::=
  p::Right
  +q::return
  +w::return
  +e::return
  +r::return
  +t::return
  +y::return
  +u::return
  +i::return
  +o::return
  +p::return

  z::~
  x::`
  c::Down
  v::Up
  b::|
  n::\
  m::?
  ,::return
  .::return
  /::return
  +z::return
  +x::return
  +c::return
  +v::return
  +b::return
  +n::return
  +m::return
  +,::return
  +.::return
  +/::return

; end kbd_layer= 1

#If kbd_layer=2

  *RAlt Up::
    SetLayer(0)
  return
  *LAlt::
    SetLayer(3)
  return

  a::á 
  s::ó
  d::é
  f::ú
  g::í
  h::
    Send !{F4}
    keyWait, h
  return
  j:: ;one-key alt-tab (tested on Windows 7)
    vAltTabTickCount := A_TickCount
    if WinActive("ahk_class TaskSwitcherWnd")
      SendInput, {Tab}
    else
    {
      SendInput, {Alt Down}{Tab}
      SetTimer, AltTabSendTab, 500
    }
  return
  k::return
  l::ñ
  SC027::_
  +a::Á
  +s::Ó
  +d::É
  +f::Ú
  +g::Í
  +l::Ñ

  q::1
  w::2
  e::3
  r::4
  t::5
  y::6
  u::7
  i::8
  o::9 
  p::0

  z::return
  x::return
  c::^#Left
  v::^#Right
  b::return
  n::return
  m::#Up
  ,::return
  .::return
  /::return

; end kbd_layer= 2

#If kbd_layer=3

  *LAlt Up::
    SetLayer(2)
  return
  *RAlt Up::
    SetLayer(1)
  return

  a::F6
  s::F7
  d::F8
  f::F9
  g::F10
  h::send {Blind}{Volume_Down}
  j::send {Blind}{Volume_Up}
  k::return
  l::return
  SC027::return

  q::F1
  w::F2
  e::F3
  r::F4
  t::F5
  y::return
  u::Send {Blind}{Volume_Down}
  i::send {Volume_Up}
  o::send {Volume_Down}
  p::send {Volume_Up}

  z::F11
  x::F12
  c::End
  v::Home
  b::return
  n::return
  m::return
  ,::return
  .::return
  /::return

; end kbd_layer= 3

AltTabSendTab:
  if GetKeyState("j", "P")
    vAltTabTickCount := A_TickCount
  if WinActive("ahk_class TaskSwitcherWnd") && !(A_TickCount - vAltTabTickCount > 400)
    return

  SendInput, {Alt Up}
  SetTimer, AltTabSendTab, Off
return