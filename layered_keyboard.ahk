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
    PopUp("layer 1 (Raise)")
  } Else If(num = 2){
    PopUp("layer 2 (Lower)")
  }
}
return

'::`;
":: Send {:}
`;::'
+`;::"
/::Backspace
-::Enter
Tab::Escape
LCtrl::Tab
LShift::LCtrl
RShift::RWin

$*LAlt::
#IfWinActive
SetLayer(2)
keyWait, LAlt
SetLayer(0)
return

$*RAlt::
#IfWinActive
SetLayer(1)
keyWait, RAlt
SetLayer(0)
return

$space::
   send {LShift down} 
   Spacedown := A_TickCount
Return 
   
$+space up::
   send {LShift up}   
   if (A_TickCount - Spacedown < 200) 
      Send {Space}
Return

#If kbd_layer=0

return ; end kbd_layer= 0

#If kbd_layer=1
  
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
  d::return
  h::return
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

return ; end kbd_layer= 1

#If kbd_layer=2
  
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
  g::[
  c::]
  r::Send {*}
  l::Right

  j::Down
  k::Up
  b::$
  m::&
  w::^

return ; end kbd_layer= 2