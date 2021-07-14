; this has been tested on 1.12.2 against this farm: https://www.youtube.com/watch?v=Y31TEbKjSpg

; Globle values
wintitle := Minecraft X-AHK V0.4
targettitle := none
targetwinclass := GLFW30 ;This is the Class of a Java program used to check we have a Minecraft prog
ModeText := Empty
id := 0

; ctrl + alt + f starts the loop.  Every 1/2 second the right mouse button is clicked.
^!f::
	BreakLoop = 0
	Loop
	{
		if (BreakLoop = 1)
		{
			BreakLoop = 0
			break
		}

		;Sleep 50
		;ControlClick, , Minecraft* 1.16.3 - Multiplayer (3rd-party Server), ,Right, , NAD
		;Sleep 100
		;ControlClick, , Minecraft* 1.16.3 - Multiplayer (3rd-party Server), ,Right, , NAU
		Sleep 500 ; click delay in ms.  Faster values (like 100ms) break the cycle after one item is caught.
		MouseClick, Right
	}
Return

^!r::
	BreakLoop = 0
	Loop
	{
		if (BreakLoop = 1)
		{
			BreakLoop = 0
			break
		}

		Sleep 100
		MouseClick, WheelDown
	}
Return

; starts long delay for gold farm; ctrl + alt + g
^!g::
	BreakLoop = 0
	SwingCount = 0
	Loop
	{
		if (BreakLoop = 1)
		{
			BreakLoop = 0
			break
		}
		
		Sleep 500
		MouseClick, Left
		Click, Down, Right
		Sleep 2300
		Click, Up, Right
	}
Return

^!x::
	BreakLoop = 0
	Loop
	{
		if (BreakLoop = 1)
		{
			BreakLoop = 0
			break
		}
		Sleep 10000
		Send {LShift down}
		Sleep 250
		Click, Down, Right
		Sleep 240
		Click, Up, Right
		Send {LShift up}
		Sleep 250
	}
Return

; ctrl + alt + c starts the loop. This is for concrete and fortuneing ores
^!c::
		Click, Down, Right
		Sleep 1000
		Click, Down, Left
		;Sleep 180000	; 3 mins
		;Sleep 90000	;1.5 mins
		Sleep 60000	;1 minute
		Click, Up, Left
		Sleep 250
		Click, Up, Right
Return

+^!c::
		Click, Up, Left
		Sleep 250
		Click, Up, Right
Return

; ctrl + alt + i starts the loop. This is for ice farm. shift + ctrl + alt + i ends the loop
^!i::
		Click, Down, Left
		Sleep 250
		Click, Down, Right
Return

+^!i::
		Click, Up, Left
		Sleep 250
		Click, Up, Right
Return

; starts long delay for gold farm; ctrl + alt + g

^!t::
	BreakLoop = 0
	Loop
	{
		if (BreakLoop = 1)
		{
			BreakLoop = 0
			break
		}

		MouseClick, Right
		Sleep 10000
	}
Return

^!k::
	BreakLoop = 0
	Loop
	{
		MouseClick, Right
	}
Return

; Pressing pause will stop it
Pause::
	BreakLoop = 1
return


