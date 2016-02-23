/*                                                                                                             
 ,---. ,--.              ,--.          ,--------,--.    ,--.        ,--,------.                                 
'   .-'`--,--,--,--.,---.|  |,---.     '--.  .--|  ,---.`--,--.--.,-|  |  .--. ',---.,--.--.,---. ,---.,--,--,  
`.  `-.,--|        | .-. |  | .-. :       |  |  |  .-.  ,--|  .--' .-. |  '--' | .-. |  .--(  .-'| .-. |      \ 
.-'    |  |  |  |  | '-' |  \   --.       |  |  |  | |  |  |  |  \ `-' |  | --'\   --|  |  .-'  `' '-' |  ||  | 
`-----'`--`--`--`--|  |-'`--'`----'       `--'  `--' `--`--`--'   `---'`--'     `----`--'  `----' `---'`--''--'
By FailCake :D (edunad)
A simple Thirdperson Addon. Press C (context menu) then Thirdperson 
*/

// SHARED
CreateConVar("simple_thirdperson_maxdistance", "0", { FCVAR_REPLICATED } , "Sets the max distance the player can go (0 = disabled)")
CreateConVar("simple_thirdperson_maxpitch", "0", { FCVAR_REPLICATED } , "Sets the max pitch the player can go (0 = disabled)")
CreateConVar("simple_thirdperson_maxright", "0", { FCVAR_REPLICATED } , "Sets the max right the player can go (0 = disabled)")
CreateConVar("simple_thirdperson_maxyaw", "0", { FCVAR_REPLICATED } , "Sets the max yaw the player can go (0 = disabled)")
CreateConVar("simple_thirdperson_maxup", "0", { FCVAR_REPLICATED } , "Sets the min up the player can go (0 = disabled)")

CreateConVar("simple_thirdperson_mindistance", "0", { FCVAR_REPLICATED } , "Sets the min distance the player can go (0 = disabled)")
CreateConVar("simple_thirdperson_minpitch", "0", { FCVAR_REPLICATED } , "Sets the min pitch the player can go (0 = disabled)")
CreateConVar("simple_thirdperson_minright", "0", { FCVAR_REPLICATED } , "Sets the min right the player can go (0 = disabled)")
CreateConVar("simple_thirdperson_minyaw", "0", { FCVAR_REPLICATED } , "Sets the min yaw the player can go (0 = disabled)")
CreateConVar("simple_thirdperson_minup", "0", { FCVAR_REPLICATED } , "Sets the min up the player can go (0 = disabled)")

CreateConVar("simple_thirdperson_shoulder_maxdist", "0", { FCVAR_REPLICATED } , "Sets the max shoulder distance the player can go (0 = disabled)")
CreateConVar("simple_thirdperson_shoulder_mindist", "0", { FCVAR_REPLICATED } , "Sets the min shoulder distance the player can go (0 = disabled)")
CreateConVar("simple_thirdperson_shoulder_maxup", "0", { FCVAR_REPLICATED } , "Sets the max shoulder up the player can go (0 = disabled)")
CreateConVar("simple_thirdperson_shoulder_minup", "0", { FCVAR_REPLICATED } , "Sets the min shoulder up the player can go (0 = disabled)")
CreateConVar("simple_thirdperson_shoulder_maxright", "0", { FCVAR_REPLICATED } , "Sets the max shoulder right the player can go (0 = disabled)")
CreateConVar("simple_thirdperson_shoulder_minright", "0", { FCVAR_REPLICATED } , "Sets the min shoulder right the player can go (0 = disabled)")

CreateConVar("simple_thirdperson_forcecollide", "0", { FCVAR_REPLICATED } , "Forces the player to use collide or not (0 = disabled,1 = on,2 = off)")
CreateConVar("simple_thirdperson_forceshoulder", "0", { FCVAR_REPLICATED } , "Forces the player to use shoulder view or not (0 = disabled,1 = on,2 = off)")
CreateConVar("simple_thirdperson_forcesmooth", "0", { FCVAR_REPLICATED } , "Forces the player to use smooth view or not (0 = disabled,1 = on,2 = off)")

if CLIENT then
	CreateClientConVar( "simple_thirdperson_enabled", "0", true, false )
	
	CreateClientConVar( "simple_thirdperson_smooth", "1", true, false )
	CreateClientConVar( "simple_thirdperson_smooth_mult_x", "0.3", true, false )
	CreateClientConVar( "simple_thirdperson_smooth_mult_y", "0.3", true, false )
	CreateClientConVar( "simple_thirdperson_smooth_mult_z", "0.3", true, false )
	CreateClientConVar( "simple_thirdperson_smooth_delay", "10", true, false )
	
	CreateClientConVar( "simple_thirdperson_collision", "1", true, false )
	CreateClientConVar( "simple_thirdperson_cam_distance", "100", true, false )
	CreateClientConVar( "simple_thirdperson_cam_right", "0", true, false )
	CreateClientConVar( "simple_thirdperson_cam_up", "0", true, false )
	
	CreateClientConVar( "simple_thirdperson_cam_pitch", "0", true, false )
	CreateClientConVar( "simple_thirdperson_cam_yaw", "0", true, false )
	
	CreateClientConVar( "simple_thirdperson_shoulderview_dist", "50", true, false )
	CreateClientConVar( "simple_thirdperson_shoulderview_up", "0", true, false )
	CreateClientConVar( "simple_thirdperson_shoulderview_right", "40", true, false )
	CreateClientConVar( "simple_thirdperson_shoulderview", "0", true, false )
	CreateClientConVar( "simple_thirdperson_shoulderview_bump", "1", true, false )
	
	CreateClientConVar( "simple_thirdperson_fov_smooth", "1", true, false )
	CreateClientConVar( "simple_thirdperson_fov_smooth_mult", "0.3", true, false )
	
	CreateClientConVar( "simple_thirdperson_hide_crosshair", "0", true, false )
	CreateClientConVar( "simple_thirdperson_enable_custom_crosshair", "0", true, false )
	
	CreateClientConVar( "simple_thirdperson_custom_crosshair_r", "255", true, false )
	CreateClientConVar( "simple_thirdperson_custom_crosshair_g", "230", true, false )
	CreateClientConVar( "simple_thirdperson_custom_crosshair_b", "0", true, false )
	CreateClientConVar( "simple_thirdperson_custom_crosshair_a", "240", true, false )
end

if CLIENT then	
	
	local Editor = {}

	Editor.DelayPos = nil
	Editor.ViewPos = nil
	
	Editor.ShoulderToggle = GetConVar( "simple_thirdperson_shoulderview" ):GetBool()
	Editor.EnableToggle = GetConVar( "simple_thirdperson_enabled" ):GetBool()
	Editor.CollisionToggle = GetConVar( "simple_thirdperson_collision" ):GetBool()
	Editor.FOVToggle = GetConVar( "simple_thirdperson_fov_smooth" ):GetBool()
	Editor.SmoothToggle = GetConVar( "simple_thirdperson_smooth" ):GetBool()
	Editor.ShoulderBumpToggle = GetConVar( "simple_thirdperson_shoulderview_bump" ):GetBool()
	
	Editor.CustomCrossToggle = GetConVar( "simple_thirdperson_enable_custom_crosshair" ):GetBool()
	Editor.CrossToggle = GetConVar( "simple_thirdperson_hide_crosshair" ):GetBool()
	
	list.Set(
		"DesktopWindows", 
		"ThirdPerson",
		{
			title = "Simple Third Person",
			icon = "icon32/zoom_extend.png",
			width = 300,
			height = 170,
			onewindow = true,
			init = function(icn, pnl)
				BuildMenu(pnl)
			end
		}
	)
	
	function BuildMenu(PNL)
	
		if Editor.PANEL != nil then
			Editor.PANEL:Remove()
		end
		
		if PNL == nil then	
			PNL = vgui.Create( "DFrame" )
			PNL:SetSize( 300, 170 )
			PNL:SetVisible( true )
			PNL:SetDraggable( true )
			PNL:ShowCloseButton( true )
			PNL:MakePopup()
		end

		Editor.PANEL = PNL
		Editor.PANEL:SetPos(ScrW() - 310,40)
		
		Editor.PANEL.Sheet = Editor.PANEL:Add( "DPropertySheet" )
		Editor.PANEL.Sheet:Dock(LEFT)
		Editor.PANEL.Sheet:SetSize( 290, 0 )
		Editor.PANEL.Sheet:SetPos(5,0)
		
		Editor.PANEL.Settings = Editor.PANEL.Sheet:Add( "DPanelSelect" )
		Editor.PANEL.Sheet:AddSheet( "Settings", Editor.PANEL.Settings, "icon16/cog_edit.png" )
		
		Editor.PANEL.CameraSettings = Editor.PANEL.Sheet:Add( "DPanelSelect" )
		Editor.PANEL.Sheet:AddSheet( "Camera", Editor.PANEL.CameraSettings, "icon16/camera_edit.png" )
		
		Editor.PANEL.SmoothSettings = Editor.PANEL.Sheet:Add( "DPanelSelect" )
		Editor.PANEL.Sheet:AddSheet( "Smooth", Editor.PANEL.SmoothSettings, "icon16/chart_line.png" )
		
		Editor.PANEL.ShoulderSettings = Editor.PANEL.Sheet:Add( "DPanelSelect" )
		Editor.PANEL.Sheet:AddSheet( "Shoulder", Editor.PANEL.ShoulderSettings, "icon16/camera_go.png" )
		
		Editor.PANEL.CrossSettings = Editor.PANEL.Sheet:Add( "DPanelSelect" )
		Editor.PANEL.Sheet:AddSheet( "Crosshair", Editor.PANEL.CrossSettings, "icon16/collision_on.png" )
		
		Editor.PANEL.CreditsSettings = Editor.PANEL.Sheet:Add( "DPanelSelect" )
		Editor.PANEL.Sheet:AddSheet( "Credits :D", Editor.PANEL.CreditsSettings, "icon16/star.png" )
		
		Editor.PANEL.EnableThrd = Editor.PANEL.Settings:Add( "DButton" )
		Editor.PANEL.EnableThrd:SizeToContents()
		
		if Editor.EnableToggle then
			Editor.PANEL.EnableThrd:SetText("Disable ThirdPerson")
			Editor.PANEL.EnableThrd:SetTextColor(Color(150,0,0))
		else
			Editor.PANEL.EnableThrd:SetText("Enable ThirdPerson")
			Editor.PANEL.EnableThrd:SetTextColor(Color(0,150,0))
		end
		
		Editor.PANEL.EnableThrd:SetPos(10,6)
		Editor.PANEL.EnableThrd:SetSize(250,20)
		Editor.PANEL.EnableThrd.DoClick = function()

			Editor.EnableToggle = !Editor.EnableToggle
			RunConsoleCommand("simple_thirdperson_enabled",BoolToInt(Editor.EnableToggle))
			
			if Editor.EnableToggle then
				Editor.PANEL.EnableThrd:SetText("Disable ThirdPerson")
				Editor.PANEL.EnableThrd:SetTextColor(Color(150,0,0))
			else
				Editor.PANEL.EnableThrd:SetText("Enable ThirdPerson")
				Editor.PANEL.EnableThrd:SetTextColor(Color(0,150,0))
			end
					
		end

		Editor.PANEL.Lbl_SPLIT = Editor.PANEL.Settings:Add("DLabel")
		Editor.PANEL.Lbl_SPLIT:SetPos(20,29)
		Editor.PANEL.Lbl_SPLIT:SetText("------------------------ RESETS ------------------------")
		Editor.PANEL.Lbl_SPLIT:SizeToContents() 
	
		Editor.PANEL.ResetCam = Editor.PANEL.Settings:Add( "DButton" )
		Editor.PANEL.ResetCam:SizeToContents()
		Editor.PANEL.ResetCam:SetText("Camera Reset")
		Editor.PANEL.ResetCam:SetPos(10,46)
		Editor.PANEL.ResetCam:SetSize(120,20)
		Editor.PANEL.ResetCam.DoClick = function()
			RunConsoleCommand("simple_thirdperson_cam_distance",100)
			RunConsoleCommand("simple_thirdperson_cam_right",0)
			RunConsoleCommand("simple_thirdperson_cam_up",0)
			RunConsoleCommand("simple_thirdperson_cam_yaw",0)
			RunConsoleCommand("simple_thirdperson_cam_pitch",0)
			chat.AddText(Color(255,255,255),"[",Color(255,155,0),"Simple ThirdPerson",Color(255,255,255),"] Camera Reset !")
			Editor.PANEL:Close()
		end
		
		Editor.PANEL.ResetShoulder = Editor.PANEL.Settings:Add( "DButton" )
		Editor.PANEL.ResetShoulder:SizeToContents()
		Editor.PANEL.ResetShoulder:SetText("ShoulderView Reset")
		Editor.PANEL.ResetShoulder:SetPos(140,46)
		Editor.PANEL.ResetShoulder:SetSize(120,20)
		Editor.PANEL.ResetShoulder.DoClick = function()
			RunConsoleCommand("simple_thirdperson_shoulderview_dist",50)
			RunConsoleCommand("simple_thirdperson_shoulderview_up",0)
			RunConsoleCommand("simple_thirdperson_shoulderview_right",40)
			chat.AddText(Color(255,255,255),"[",Color(255,155,0),"Simple ThirdPerson",Color(255,255,255),"] ShoulderView Reset !")
			Editor.PANEL:Close()
		end
		
		Editor.PANEL.ResetSmooth = Editor.PANEL.Settings:Add( "DButton" )
		Editor.PANEL.ResetSmooth:SizeToContents()
		Editor.PANEL.ResetSmooth:SetText("Smooth Settings Reset")
		Editor.PANEL.ResetSmooth:SetPos(10,76)
		Editor.PANEL.ResetSmooth:SetSize(130,20)
		Editor.PANEL.ResetSmooth.DoClick = function()
			RunConsoleCommand("simple_thirdperson_smooth",1)
			RunConsoleCommand("simple_thirdperson_smooth_mult_x",0.3)
			RunConsoleCommand("simple_thirdperson_smooth_mult_y",0.3)
			RunConsoleCommand("simple_thirdperson_smooth_mult_z",0.3)
			RunConsoleCommand("simple_thirdperson_smooth_delay",10)
			chat.AddText(Color(255,255,255),"[",Color(255,155,0),"Simple ThirdPerson",Color(255,255,255),"] Smooth Reset !")
			Editor.PANEL:Close()
		end
		
		Editor.PANEL.ResetFOV = Editor.PANEL.Settings:Add( "DButton" )
		Editor.PANEL.ResetFOV:SizeToContents()
		Editor.PANEL.ResetFOV:SetText("FOV Settings Reset")
		Editor.PANEL.ResetFOV:SetPos(145,76)
		Editor.PANEL.ResetFOV:SetSize(115,20)
		Editor.PANEL.ResetFOV.DoClick = function()
			RunConsoleCommand("simple_thirdperson_fov_smooth",1)
			RunConsoleCommand("simple_thirdperson_fov_smooth_mult",0.3)
			chat.AddText(Color(255,255,255),"[",Color(255,155,0),"Simple ThirdPerson",Color(255,255,255),"] FOV Reset !")
			Editor.PANEL:Close()
		end
		
		
		// ---------------- PANEL CAMERA ---------------- //
		
		Editor.PANEL.CollisionButton = Editor.PANEL.CameraSettings:Add( "DButton" )
		Editor.PANEL.CollisionButton:SizeToContents()
		
			if Editor.CollisionToggle then
				Editor.PANEL.CollisionButton:SetText("Disable Camera Collision")
				Editor.PANEL.CollisionButton:SetTextColor(Color(150,0,0))
			else
				Editor.PANEL.CollisionButton:SetText("Enable Camera Collision")
				Editor.PANEL.CollisionButton:SetTextColor(Color(0,150,0))
			end
			
		Editor.PANEL.CollisionButton:SetText("Toggle Camera Collision")
		Editor.PANEL.CollisionButton:SetPos(10,6)
		Editor.PANEL.CollisionButton:SetSize(250,20)
		Editor.PANEL.CollisionButton.DoClick = function()
		
			Editor.CollisionToggle = !Editor.CollisionToggle
			RunConsoleCommand("simple_thirdperson_collision",BoolToInt(Editor.CollisionToggle))	
			
			if Editor.CollisionToggle then
				Editor.PANEL.CollisionButton:SetText("Disable Camera Collision")
				Editor.PANEL.CollisionButton:SetTextColor(Color(150,0,0))
			else
				Editor.PANEL.CollisionButton:SetText("Enable Camera Collision")
				Editor.PANEL.CollisionButton:SetTextColor(Color(0,150,0))
			end
								
		end
		
		Editor.PANEL.CamDistanceTxt = Editor.PANEL.CameraSettings:Add("DLabel")
		Editor.PANEL.CamDistanceTxt:SetPos(10,35)
		Editor.PANEL.CamDistanceTxt:SetText("Camera Distance : ")
		Editor.PANEL.CamDistanceTxt:SizeToContents() 
		
		Editor.PANEL.CamDistanceLb = Editor.PANEL.CameraSettings:Add("DTextEntry")
		Editor.PANEL.CamDistanceLb:SetPos(110,30)
		Editor.PANEL.CamDistanceLb:SetValue(GetConVar( "simple_thirdperson_cam_distance" ):GetFloat())
		Editor.PANEL.CamDistanceLb:SetSize(40,20)
		Editor.PANEL.CamDistanceLb:SetNumeric(true)	
		Editor.PANEL.CamDistanceLb:SetUpdateOnType( true )
		
		Editor.PANEL.CamDistanceLb.OnTextChanged  = function()
			RunConsoleCommand("simple_thirdperson_cam_distance",Editor.PANEL.CamDistanceLb:GetValue())
			Editor.PANEL.CamDistance_PRF:SetValue(Editor.PANEL.CamDistanceLb:GetValue())
		end
		
		Editor.PANEL.CamDistance_PRF = Editor.PANEL.CameraSettings:Add("DNumberScratch")
		Editor.PANEL.CamDistance_PRF:SetPos(155,32)
		Editor.PANEL.CamDistance_PRF:SetValue(GetConVar( "simple_thirdperson_cam_distance" ):GetFloat())
		Editor.PANEL.CamDistance_PRF:SetMin( -100 )
		Editor.PANEL.CamDistance_PRF:SetMax( 1000 )
		Editor.PANEL.CamDistance_PRF.OnValueChanged  = function()
			Editor.PANEL.CamDistanceLb:SetValue(Editor.PANEL.CamDistance_PRF:GetTextValue())
			RunConsoleCommand("simple_thirdperson_cam_distance",Editor.PANEL.CamDistance_PRF:GetTextValue())
		end
		
		
		Editor.PANEL.CamYawTxt = Editor.PANEL.CameraSettings:Add("DLabel")
		Editor.PANEL.CamYawTxt:SetPos(150,62)
		Editor.PANEL.CamYawTxt:SetText("| Yaw : ")
		Editor.PANEL.CamYawTxt:SizeToContents() 
		
		Editor.PANEL.CamYawLb = Editor.PANEL.CameraSettings:Add("DTextEntry")
		Editor.PANEL.CamYawLb:SetPos(190,57)
		Editor.PANEL.CamYawLb:SetValue(GetConVar( "simple_thirdperson_cam_yaw" ):GetFloat())
		Editor.PANEL.CamYawLb:SetSize(40,20)
		Editor.PANEL.CamYawLb:SetNumeric(true)
		Editor.PANEL.CamYawLb:SetUpdateOnType( true )
		Editor.PANEL.CamYawLb.OnTextChanged  = function()
			RunConsoleCommand("simple_thirdperson_cam_yaw",Editor.PANEL.CamYawLb:GetValue())
			Editor.PANEL.CamYawLb_PRF:SetValue(Editor.PANEL.CamYawLb:GetValue())
		end
		
		Editor.PANEL.CamYawLb_PRF = Editor.PANEL.CameraSettings:Add("DNumberScratch")
		Editor.PANEL.CamYawLb_PRF:SetPos(235,59)
		Editor.PANEL.CamYawLb_PRF:SetValue(GetConVar( "simple_thirdperson_cam_yaw" ):GetFloat())
		Editor.PANEL.CamYawLb_PRF:SetMin( 0 )
		Editor.PANEL.CamYawLb_PRF:SetMax( 360 )
		Editor.PANEL.CamYawLb_PRF.OnValueChanged  = function()
			RunConsoleCommand("simple_thirdperson_cam_yaw",Editor.PANEL.CamYawLb_PRF:GetTextValue())
			Editor.PANEL.CamYawLb:SetValue(Editor.PANEL.CamYawLb_PRF:GetTextValue())	
		end
		

		Editor.PANEL.CamPitchTxt = Editor.PANEL.CameraSettings:Add("DLabel")
		Editor.PANEL.CamPitchTxt:SetPos(160,85)
		Editor.PANEL.CamPitchTxt:SetText("| Pitch : ")
		Editor.PANEL.CamPitchTxt:SizeToContents() 
		
		Editor.PANEL.CamPitchLb = Editor.PANEL.CameraSettings:Add("DTextEntry")
		Editor.PANEL.CamPitchLb:SetPos(200,80)
		Editor.PANEL.CamPitchLb:SetValue(GetConVar( "simple_thirdperson_cam_pitch" ):GetFloat())
		Editor.PANEL.CamPitchLb:SetSize(40,20)
		Editor.PANEL.CamPitchLb:SetNumeric(true)
		Editor.PANEL.CamPitchLb:SetUpdateOnType( true )
		Editor.PANEL.CamPitchLb.OnTextChanged  = function()
			RunConsoleCommand("simple_thirdperson_cam_pitch",Editor.PANEL.CamPitchLb:GetValue())
			Editor.PANEL.CamPitchLb_PRF:SetValue(Editor.PANEL.CamPitchLb:GetValue())
		end
		
		Editor.PANEL.CamPitchLb_PRF = Editor.PANEL.CameraSettings:Add("DNumberScratch")
		Editor.PANEL.CamPitchLb_PRF:SetPos(245,82)
		Editor.PANEL.CamPitchLb_PRF:SetValue(GetConVar( "simple_thirdperson_cam_pitch" ):GetFloat())
		Editor.PANEL.CamPitchLb_PRF:SetMin( 0 )
		Editor.PANEL.CamPitchLb_PRF:SetMax( 360 )
		Editor.PANEL.CamPitchLb_PRF.OnValueChanged  = function()
			RunConsoleCommand("simple_thirdperson_cam_pitch",Editor.PANEL.CamPitchLb_PRF:GetTextValue())
			Editor.PANEL.CamPitchLb:SetValue(Editor.PANEL.CamPitchLb_PRF:GetTextValue())
		end
		
		Editor.PANEL.CamUpTxt = Editor.PANEL.CameraSettings:Add("DLabel")
		Editor.PANEL.CamUpTxt:SetPos(10,62)
		Editor.PANEL.CamUpTxt:SetText("Camera Up : ")
		Editor.PANEL.CamUpTxt:SizeToContents() 
		
		Editor.PANEL.CamUpTxtLB = Editor.PANEL.CameraSettings:Add("DTextEntry")
		Editor.PANEL.CamUpTxtLB:SetPos(80,57)
		Editor.PANEL.CamUpTxtLB:SetValue(GetConVar( "simple_thirdperson_cam_up" ):GetFloat())
		Editor.PANEL.CamUpTxtLB:SetSize(40,20)
		Editor.PANEL.CamUpTxtLB:SetNumeric(true)
		Editor.PANEL.CamUpTxtLB:SetUpdateOnType( true )
		Editor.PANEL.CamUpTxtLB.OnTextChanged  = function()
			RunConsoleCommand("simple_thirdperson_cam_up",Editor.PANEL.CamUpTxtLB:GetValue())
			Editor.PANEL.CamUpTxtLB_PRF:SetValue(Editor.PANEL.CamUpTxtLB:GetValue())
		end
		
		Editor.PANEL.CamUpTxtLB_PRF = Editor.PANEL.CameraSettings:Add("DNumberScratch")
		Editor.PANEL.CamUpTxtLB_PRF:SetPos(125,59)
		Editor.PANEL.CamUpTxtLB_PRF:SetValue(GetConVar( "simple_thirdperson_cam_up" ):GetFloat())
		Editor.PANEL.CamUpTxtLB_PRF:SetMin( -1000 )
		Editor.PANEL.CamUpTxtLB_PRF:SetMax( 1000 )
		Editor.PANEL.CamUpTxtLB_PRF.OnValueChanged  = function()
			RunConsoleCommand("simple_thirdperson_cam_up",Editor.PANEL.CamUpTxtLB_PRF:GetTextValue())
			Editor.PANEL.CamUpTxtLB:SetValue(Editor.PANEL.CamUpTxtLB_PRF:GetTextValue())	
		end
		
		Editor.PANEL.CamLeftTxt = Editor.PANEL.CameraSettings:Add("DLabel")
		Editor.PANEL.CamLeftTxt:SetPos(10,85)
		Editor.PANEL.CamLeftTxt:SetText("Camera Right : ")
		Editor.PANEL.CamLeftTxt:SizeToContents() 
		
		Editor.PANEL.CamLeftTxtLB = Editor.PANEL.CameraSettings:Add("DTextEntry")
		Editor.PANEL.CamLeftTxtLB:SetPos(90,80)
		Editor.PANEL.CamLeftTxtLB:SetValue(GetConVar( "simple_thirdperson_cam_right" ):GetFloat())
		Editor.PANEL.CamLeftTxtLB:SetSize(40,20)
		Editor.PANEL.CamLeftTxtLB:SetNumeric(true)
		Editor.PANEL.CamLeftTxtLB:SetUpdateOnType( true )
		Editor.PANEL.CamLeftTxtLB.OnTextChanged  = function()
			RunConsoleCommand("simple_thirdperson_cam_right",Editor.PANEL.CamLeftTxtLB:GetValue())
			Editor.PANEL.CamLeftTxtLB_PRF:SetValue(Editor.PANEL.CamLeftTxtLB:GetValue())
		end
		
		Editor.PANEL.CamLeftTxtLB_PRF = Editor.PANEL.CameraSettings:Add("DNumberScratch")	
		Editor.PANEL.CamLeftTxtLB_PRF:SetPos(135,82)
		Editor.PANEL.CamLeftTxtLB_PRF:SetValue(GetConVar( "simple_thirdperson_cam_right" ):GetFloat())
		Editor.PANEL.CamLeftTxtLB_PRF:SetMin( -1000 )
		Editor.PANEL.CamLeftTxtLB_PRF:SetMax( 1000 )
		Editor.PANEL.CamLeftTxtLB_PRF.OnValueChanged  = function()
			RunConsoleCommand("simple_thirdperson_cam_right",Editor.PANEL.CamLeftTxtLB_PRF:GetTextValue())
			Editor.PANEL.CamLeftTxtLB:SetValue(Editor.PANEL.CamLeftTxtLB_PRF:GetTextValue())	
		end
		
		// ---------------- PANEL SMOOTH ---------------- //
		
		Editor.PANEL.SmoothButton = Editor.PANEL.SmoothSettings:Add( "DButton" )
		Editor.PANEL.SmoothButton:SizeToContents()
		
		if Editor.SmoothToggle then
			Editor.PANEL.SmoothButton:SetText("Disable Camera Smoothing")
			Editor.PANEL.SmoothButton:SetTextColor(Color(150,0,0))
		else
			Editor.PANEL.SmoothButton:SetText("Enable Camera Smoothing")
			Editor.PANEL.SmoothButton:SetTextColor(Color(0,150,0))
		end

		Editor.PANEL.SmoothButton:SetPos(10,6)
		Editor.PANEL.SmoothButton:SetSize(250,20)
		Editor.PANEL.SmoothButton.DoClick = function()
			Editor.SmoothToggle = !Editor.SmoothToggle
			RunConsoleCommand("simple_thirdperson_smooth",BoolToInt(Editor.SmoothToggle))	

			if Editor.SmoothToggle then
				Editor.PANEL.SmoothButton:SetText("Disable Camera Smoothing")
				Editor.PANEL.SmoothButton:SetTextColor(Color(150,0,0))
			else
				Editor.PANEL.SmoothButton:SetText("Enable Camera Smoothing")
				Editor.PANEL.SmoothButton:SetTextColor(Color(0,150,0))
			end					
		end
		
		Editor.PANEL.SmoothFOVButton = Editor.PANEL.SmoothSettings:Add( "DButton" )
		Editor.PANEL.SmoothFOVButton:SizeToContents()
		
		if Editor.FOVToggle then
			Editor.PANEL.SmoothFOVButton:SetText("Disable FOV Smoothing")
			Editor.PANEL.SmoothFOVButton:SetTextColor(Color(150,0,0))
		else
			Editor.PANEL.SmoothFOVButton:SetText("Enable FOV Smoothing")
			Editor.PANEL.SmoothFOVButton:SetTextColor(Color(0,150,0))
		end
		
		Editor.PANEL.SmoothFOVButton:SetPos(10,30)
		Editor.PANEL.SmoothFOVButton:SetSize(250,20)
		Editor.PANEL.SmoothFOVButton.DoClick = function()
			Editor.FOVToggle = !Editor.FOVToggle
			RunConsoleCommand("simple_thirdperson_fov_smooth",BoolToInt(Editor.FOVToggle))

			if Editor.FOVToggle then
				Editor.PANEL.SmoothFOVButton:SetText("Disable FOV Smoothing")
				Editor.PANEL.SmoothFOVButton:SetTextColor(Color(150,0,0))
			else
				Editor.PANEL.SmoothFOVButton:SetText("Enable FOV Smoothing")
				Editor.PANEL.SmoothFOVButton:SetTextColor(Color(0,150,0))
			end					
		end
		
		Editor.PANEL.CamSmoothDeTxt = Editor.PANEL.SmoothSettings:Add("DLabel")
		Editor.PANEL.CamSmoothDeTxt:SetPos(10,60)
		Editor.PANEL.CamSmoothDeTxt:SetText("Smooth Delay : ")
		Editor.PANEL.CamSmoothDeTxt:SizeToContents() 
		
		Editor.PANEL.CamSmoDelayLb = Editor.PANEL.SmoothSettings:Add("DTextEntry")
		Editor.PANEL.CamSmoDelayLb:SetPos(90,55)
		Editor.PANEL.CamSmoDelayLb:SetValue(math.Round(GetConVar( "simple_thirdperson_smooth_delay" ):GetFloat(),2))
		Editor.PANEL.CamSmoDelayLb:SetSize(40,20)
		Editor.PANEL.CamSmoDelayLb:SetNumeric(true)
		Editor.PANEL.CamSmoDelayLb:SetUpdateOnType( true )
		Editor.PANEL.CamSmoDelayLb.OnTextChanged  = function()
			RunConsoleCommand("simple_thirdperson_smooth_delay",Editor.PANEL.CamSmoDelayLb:GetValue())
			Editor.PANEL.CamSmoDelayLb_PRF:SetValue(Editor.PANEL.CamSmoDelayLb:GetValue())
		end
		
		Editor.PANEL.CamSmoDelayLb_PRF = Editor.PANEL.SmoothSettings:Add("DNumberScratch")
		Editor.PANEL.CamSmoDelayLb_PRF:SetPos(135,57)
		Editor.PANEL.CamSmoDelayLb_PRF:SetValue(math.Round(GetConVar( "simple_thirdperson_smooth_delay" ):GetFloat(),2))
		Editor.PANEL.CamSmoDelayLb_PRF:SetMin( 1 )
		Editor.PANEL.CamSmoDelayLb_PRF:SetMax( 100 )
		Editor.PANEL.CamSmoDelayLb_PRF.OnValueChanged  = function()
			RunConsoleCommand("simple_thirdperson_smooth_delay",Editor.PANEL.CamSmoDelayLb_PRF:GetTextValue())
			Editor.PANEL.CamSmoDelayLb:SetValue(Editor.PANEL.CamSmoDelayLb_PRF:GetTextValue())	
		end
		
		
		Editor.PANEL.CamSmoothMultXTxt = Editor.PANEL.SmoothSettings:Add("DLabel")
		Editor.PANEL.CamSmoothMultXTxt:SetPos(160,60)
		Editor.PANEL.CamSmoothMultXTxt:SetText("| Mult X : ")
		Editor.PANEL.CamSmoothMultXTxt:SizeToContents() 
		
		Editor.PANEL.CamSmoothMultXTxtLb = Editor.PANEL.SmoothSettings:Add("DTextEntry")
		Editor.PANEL.CamSmoothMultXTxtLb:SetPos(210,55)
		Editor.PANEL.CamSmoothMultXTxtLb:SetValue(math.Round(GetConVar( "simple_thirdperson_smooth_mult_x" ):GetFloat(),2))
		Editor.PANEL.CamSmoothMultXTxtLb:SetSize(40,20)
		Editor.PANEL.CamSmoothMultXTxtLb:SetNumeric(true)
		Editor.PANEL.CamSmoothMultXTxtLb:SetUpdateOnType( true )
		Editor.PANEL.CamSmoothMultXTxtLb.OnTextChanged  = function()
			RunConsoleCommand("simple_thirdperson_smooth_mult_x",Editor.PANEL.CamSmoothMultXTxtLb:GetValue())
			Editor.PANEL.CamSmoothMultXTxtLb_PRF:SetValue(Editor.PANEL.CamSmoothMultXTxtLb:GetValue())
		end
		
		Editor.PANEL.CamSmoothMultXTxtLb_PRF = Editor.PANEL.SmoothSettings:Add("DNumberScratch")
		Editor.PANEL.CamSmoothMultXTxtLb_PRF:SetPos(255,57)
		Editor.PANEL.CamSmoothMultXTxtLb_PRF:SetValue(math.Round(GetConVar( "simple_thirdperson_smooth_mult_x" ):GetFloat(),2))
		Editor.PANEL.CamSmoothMultXTxtLb_PRF:SetMin( 0.01 )
		Editor.PANEL.CamSmoothMultXTxtLb_PRF:SetMax( 1 )
		Editor.PANEL.CamSmoothMultXTxtLb_PRF.OnValueChanged  = function()
			RunConsoleCommand("simple_thirdperson_smooth_mult_x",Editor.PANEL.CamSmoothMultXTxtLb_PRF:GetTextValue())
			Editor.PANEL.CamSmoothMultXTxtLb:SetValue(Editor.PANEL.CamSmoothMultXTxtLb_PRF:GetTextValue())
		end
		
		
		Editor.PANEL.CamSmoothMultYTxt = Editor.PANEL.SmoothSettings:Add("DLabel")
		Editor.PANEL.CamSmoothMultYTxt:SetPos(10,85)
		Editor.PANEL.CamSmoothMultYTxt:SetText("Mult Y : ")
		Editor.PANEL.CamSmoothMultYTxt:SizeToContents() 
		
		Editor.PANEL.CamSmoothMultYTxtLb = Editor.PANEL.SmoothSettings:Add("DTextEntry")
		Editor.PANEL.CamSmoothMultYTxtLb:SetPos(50,80)
		Editor.PANEL.CamSmoothMultYTxtLb:SetValue(math.Round(GetConVar( "simple_thirdperson_smooth_mult_y" ):GetFloat(),2))
		Editor.PANEL.CamSmoothMultYTxtLb:SetSize(40,20)
		Editor.PANEL.CamSmoothMultYTxtLb:SetNumeric(true)
		Editor.PANEL.CamSmoothMultYTxtLb:SetUpdateOnType( true )
		Editor.PANEL.CamSmoothMultYTxtLb.OnTextChanged  = function()
			RunConsoleCommand("simple_thirdperson_smooth_mult_y",Editor.PANEL.CamSmoothMultYTxtLb:GetValue())
			Editor.PANEL.CamSmoothMultYTxtLb_PRF:SetValue(Editor.PANEL.CamSmoothMultYTxtLb:GetValue())
		end
		
		Editor.PANEL.CamSmoothMultYTxtLb_PRF = Editor.PANEL.SmoothSettings:Add("DNumberScratch")
		Editor.PANEL.CamSmoothMultYTxtLb_PRF:SetPos(95,82)
		Editor.PANEL.CamSmoothMultYTxtLb_PRF:SetValue(math.Round(GetConVar( "simple_thirdperson_smooth_mult_y" ):GetFloat(),2))
		Editor.PANEL.CamSmoothMultYTxtLb_PRF:SetMin( 0.01 )
		Editor.PANEL.CamSmoothMultYTxtLb_PRF:SetMax( 1 )
		Editor.PANEL.CamSmoothMultYTxtLb_PRF.OnValueChanged  = function()
			RunConsoleCommand("simple_thirdperson_smooth_mult_y",Editor.PANEL.CamSmoothMultYTxtLb_PRF:GetTextValue())
			Editor.PANEL.CamSmoothMultYTxtLb:SetValue(Editor.PANEL.CamSmoothMultYTxtLb_PRF:GetTextValue())
		end
		
		Editor.PANEL.CamSmoothMultZTxt = Editor.PANEL.SmoothSettings:Add("DLabel")
		Editor.PANEL.CamSmoothMultZTxt:SetPos(120,85)
		Editor.PANEL.CamSmoothMultZTxt:SetText("| Mult Z : ")
		Editor.PANEL.CamSmoothMultZTxt:SizeToContents() 
		
		Editor.PANEL.CamSmoothMultZTxtLb = Editor.PANEL.SmoothSettings:Add("DTextEntry")
		Editor.PANEL.CamSmoothMultZTxtLb:SetPos(170,80)
		Editor.PANEL.CamSmoothMultZTxtLb:SetValue(math.Round(GetConVar( "simple_thirdperson_smooth_mult_z" ):GetFloat(),2))
		Editor.PANEL.CamSmoothMultZTxtLb:SetSize(40,20)
		Editor.PANEL.CamSmoothMultZTxtLb:SetNumeric(true)
		Editor.PANEL.CamSmoothMultZTxtLb:SetUpdateOnType( true )
		Editor.PANEL.CamSmoothMultZTxtLb.OnTextChanged  = function()
			Editor.PANEL.CamSmoothMultZTxtLb_PRF:SetValue(Editor.PANEL.CamSmoothMultZTxtLb:GetValue())
			RunConsoleCommand("simple_thirdperson_smooth_mult_z",Editor.PANEL.CamSmoothMultZTxtLb:GetValue())
		end
		
		Editor.PANEL.CamSmoothMultZTxtLb_PRF = Editor.PANEL.SmoothSettings:Add("DNumberScratch")
		Editor.PANEL.CamSmoothMultZTxtLb_PRF:SetPos(215,82)
		Editor.PANEL.CamSmoothMultZTxtLb_PRF:SetValue(math.Round(GetConVar( "simple_thirdperson_smooth_mult_z" ):GetFloat(),2))
		Editor.PANEL.CamSmoothMultZTxtLb_PRF:SetMin( 0.01 )
		Editor.PANEL.CamSmoothMultZTxtLb_PRF:SetMax( 1 )
		Editor.PANEL.CamSmoothMultZTxtLb_PRF.OnValueChanged  = function()
			RunConsoleCommand("simple_thirdperson_smooth_mult_z",Editor.PANEL.CamSmoothMultZTxtLb_PRF:GetTextValue())
			Editor.PANEL.CamSmoothMultZTxtLb:SetValue(Editor.PANEL.CamSmoothMultZTxtLb_PRF:GetTextValue())
		end
		
		// ---------------- PANEL SHOULDERVIEW ---------------- //
		
		Editor.PANEL.ShoulderButton = Editor.PANEL.ShoulderSettings:Add( "DButton" )
		Editor.PANEL.ShoulderButton:SizeToContents()
		
		if Editor.ShoulderToggle then
				Editor.PANEL.ShoulderButton:SetText("Disable ShoulderView")
				Editor.PANEL.ShoulderButton:SetTextColor(Color(150,0,0))
			else
				Editor.PANEL.ShoulderButton:SetText("Enable ShoulderView")
				Editor.PANEL.ShoulderButton:SetTextColor(Color(0,150,0))
		end		
		
		Editor.PANEL.ShoulderButton:SetPos(10,6)
		Editor.PANEL.ShoulderButton:SetSize(250,20)
		Editor.PANEL.ShoulderButton.DoClick = function()
			Editor.ShoulderToggle = !Editor.ShoulderToggle
			RunConsoleCommand("simple_thirdperson_shoulderview",BoolToInt(Editor.ShoulderToggle))
			if Editor.ShoulderToggle then
				Editor.PANEL.ShoulderButton:SetText("Disable ShoulderView")
				Editor.PANEL.ShoulderButton:SetTextColor(Color(150,0,0))
			else
				Editor.PANEL.ShoulderButton:SetText("Enable ShoulderView")
				Editor.PANEL.ShoulderButton:SetTextColor(Color(0,150,0))
			end						
		end
		
		Editor.PANEL.ShoulderBumpButton = Editor.PANEL.ShoulderSettings:Add( "DButton" )
		Editor.PANEL.ShoulderBumpButton:SizeToContents()
		
		if Editor.ShoulderBumpToggle then
				Editor.PANEL.ShoulderBumpButton:SetText("Disable ShoulderView Bump")
				Editor.PANEL.ShoulderBumpButton:SetTextColor(Color(150,0,0))
		else
				Editor.PANEL.ShoulderBumpButton:SetText("Enable ShoulderView Bump")
				Editor.PANEL.ShoulderBumpButton:SetTextColor(Color(0,150,0))
		end	
		
		Editor.PANEL.ShoulderBumpButton:SetPos(10,30)
		Editor.PANEL.ShoulderBumpButton:SetSize(250,20)
		Editor.PANEL.ShoulderBumpButton.DoClick = function()
			Editor.ShoulderBumpToggle = !Editor.ShoulderBumpToggle
			RunConsoleCommand("simple_thirdperson_shoulderview_bump",BoolToInt(Editor.ShoulderBumpToggle))	
			if Editor.ShoulderBumpToggle then
					Editor.PANEL.ShoulderBumpButton:SetText("Disable ShoulderView Bump")
					Editor.PANEL.ShoulderBumpButton:SetTextColor(Color(150,0,0))
			else
					Editor.PANEL.ShoulderBumpButton:SetText("Enable ShoulderView Bump")
					Editor.PANEL.ShoulderBumpButton:SetTextColor(Color(0,150,0))
			end						
		end
		
		Editor.PANEL.ShoulderDistTxt = Editor.PANEL.ShoulderSettings:Add("DLabel")
		Editor.PANEL.ShoulderDistTxt:SetPos(10,60)
		Editor.PANEL.ShoulderDistTxt:SetText("Shoulder Dist : ")
		Editor.PANEL.ShoulderDistTxt:SizeToContents() 
		
		Editor.PANEL.ShoulderDistLb = Editor.PANEL.ShoulderSettings:Add("DTextEntry")
		Editor.PANEL.ShoulderDistLb:SetPos(90,55)
		Editor.PANEL.ShoulderDistLb:SetValue(math.Round(GetConVar( "simple_thirdperson_shoulderview_dist" ):GetFloat(),2))
		Editor.PANEL.ShoulderDistLb:SetSize(40,20)
		Editor.PANEL.ShoulderDistLb:SetNumeric(true)
		Editor.PANEL.ShoulderDistLb:SetUpdateOnType( true )
		Editor.PANEL.ShoulderDistLb.OnTextChanged  = function()
			RunConsoleCommand("simple_thirdperson_shoulderview_dist",Editor.PANEL.ShoulderDistLb:GetValue())
				Editor.PANEL.ShoulderDistLb_PRF:SetValue(Editor.PANEL.ShoulderDistLb:GetValue())
		end
		
		Editor.PANEL.ShoulderDistLb_PRF = Editor.PANEL.ShoulderSettings:Add("DNumberScratch")
		Editor.PANEL.ShoulderDistLb_PRF:SetPos(135,57)
		Editor.PANEL.ShoulderDistLb_PRF:SetValue(math.Round(GetConVar( "simple_thirdperson_shoulderview_dist" ):GetFloat(),2))
		Editor.PANEL.ShoulderDistLb_PRF:SetMin( -100 )
		Editor.PANEL.ShoulderDistLb_PRF:SetMax( 1000 )
		Editor.PANEL.ShoulderDistLb_PRF.OnValueChanged  = function()
			RunConsoleCommand("simple_thirdperson_shoulderview_dist",Editor.PANEL.ShoulderDistLb_PRF:GetTextValue())
			Editor.PANEL.ShoulderDistLb:SetValue(Editor.PANEL.ShoulderDistLb_PRF:GetTextValue())
		end
		
		
		Editor.PANEL.ShoulderUPTxt = Editor.PANEL.ShoulderSettings:Add("DLabel")
		Editor.PANEL.ShoulderUPTxt:SetPos(10,85)
		Editor.PANEL.ShoulderUPTxt:SetText("Shoulder Up : ")
		Editor.PANEL.ShoulderUPTxt:SizeToContents() 
		
		Editor.PANEL.ShoulderUpLb = Editor.PANEL.ShoulderSettings:Add("DTextEntry")
		Editor.PANEL.ShoulderUpLb:SetPos(80,80)
		Editor.PANEL.ShoulderUpLb:SetValue(math.Round(GetConVar( "simple_thirdperson_shoulderview_up" ):GetFloat(),2))
		Editor.PANEL.ShoulderUpLb:SetSize(40,20)
		Editor.PANEL.ShoulderUpLb:SetNumeric(true)
		Editor.PANEL.ShoulderUpLb:SetUpdateOnType( true )
		Editor.PANEL.ShoulderUpLb.OnTextChanged  = function()
			RunConsoleCommand("simple_thirdperson_shoulderview_up",Editor.PANEL.ShoulderUpLb:GetValue())
			Editor.PANEL.ShoulderUpLb_PRF:SetValue(Editor.PANEL.ShoulderUpLb:GetValue())
		end
		
		
		Editor.PANEL.ShoulderUpLb_PRF = Editor.PANEL.ShoulderSettings:Add("DNumberScratch")
		Editor.PANEL.ShoulderUpLb_PRF:SetPos(125,82)
		Editor.PANEL.ShoulderUpLb_PRF:SetValue(math.Round(GetConVar( "simple_thirdperson_shoulderview_up" ):GetFloat(),2))
		Editor.PANEL.ShoulderUpLb_PRF:SetMin( -1000 )
		Editor.PANEL.ShoulderUpLb_PRF:SetMax( 1000 )
		Editor.PANEL.ShoulderUpLb_PRF.OnValueChanged  = function()
			RunConsoleCommand("simple_thirdperson_shoulderview_up",Editor.PANEL.ShoulderUpLb_PRF:GetTextValue())
			Editor.PANEL.ShoulderUpLb:SetValue(Editor.PANEL.ShoulderUpLb_PRF:GetTextValue())
		end
		
		Editor.PANEL.ShoulderRIGTxt = Editor.PANEL.ShoulderSettings:Add("DLabel")
		Editor.PANEL.ShoulderRIGTxt:SetPos(180,60)
		Editor.PANEL.ShoulderRIGTxt:SetText("Shoulder Right")
		Editor.PANEL.ShoulderRIGTxt:SizeToContents() 
		
		Editor.PANEL.ShoulderRIGLb = Editor.PANEL.ShoulderSettings:Add("DTextEntry")
		Editor.PANEL.ShoulderRIGLb:SetPos(182,80)
		Editor.PANEL.ShoulderRIGLb:SetValue(math.Round(GetConVar( "simple_thirdperson_shoulderview_right" ):GetFloat(),2))
		Editor.PANEL.ShoulderRIGLb:SetSize(40,20)
		Editor.PANEL.ShoulderRIGLb:SetNumeric(true)
		Editor.PANEL.ShoulderRIGLb:SetUpdateOnType( true )
		Editor.PANEL.ShoulderRIGLb.OnTextChanged  = function()
			RunConsoleCommand("simple_thirdperson_shoulderview_right",Editor.PANEL.ShoulderRIGLb:GetValue())
			Editor.PANEL.ShoulderRIGLb_PRF:SetValue(Editor.PANEL.ShoulderRIGLb:GetValue())
		end
		
		Editor.PANEL.ShoulderRIGLb_PRF = Editor.PANEL.ShoulderSettings:Add("DNumberScratch")
		Editor.PANEL.ShoulderRIGLb_PRF:SetPos(227,82)
		Editor.PANEL.ShoulderRIGLb_PRF:SetValue(math.Round(GetConVar( "simple_thirdperson_shoulderview_right" ):GetFloat(),2))
		Editor.PANEL.ShoulderRIGLb_PRF:SetMin( -1000 )
		Editor.PANEL.ShoulderRIGLb_PRF:SetMax( 1000 )
		Editor.PANEL.ShoulderRIGLb_PRF.OnValueChanged  = function()
			RunConsoleCommand("simple_thirdperson_shoulderview_right",Editor.PANEL.ShoulderRIGLb_PRF:GetTextValue())
			Editor.PANEL.ShoulderRIGLb:SetValue(Editor.PANEL.ShoulderRIGLb_PRF:GetTextValue())
		end
		
		
		// ---------------- CROSSHAIR CAMERA ---------------- //
		
		Editor.PANEL.CustomCrossButton = Editor.PANEL.CrossSettings:Add( "DButton" )
		Editor.PANEL.CustomCrossButton:SizeToContents()
		
		if Editor.CustomCrossToggle then
				Editor.PANEL.CustomCrossButton:SetText("Disable Custom Crosshair")
				Editor.PANEL.CustomCrossButton:SetTextColor(Color(150,0,0))
			else
				Editor.PANEL.CustomCrossButton:SetText("Enable Custom Crosshair")
				Editor.PANEL.CustomCrossButton:SetTextColor(Color(0,150,0))
		end		
		
		Editor.PANEL.CustomCrossButton:SetPos(10,6)
		Editor.PANEL.CustomCrossButton:SetSize(250,20)
		Editor.PANEL.CustomCrossButton.DoClick = function()
			Editor.CustomCrossToggle = !Editor.CustomCrossToggle
			RunConsoleCommand("simple_thirdperson_enable_custom_crosshair",BoolToInt(Editor.CustomCrossToggle))
			if Editor.CustomCrossToggle then
				Editor.PANEL.CustomCrossButton:SetText("Disable Custom Crosshair")
				Editor.PANEL.CustomCrossButton:SetTextColor(Color(150,0,0))
			else
				Editor.PANEL.CustomCrossButton:SetText("Enable Custom Crosshair")
				Editor.PANEL.CustomCrossButton:SetTextColor(Color(0,150,0))
			end						
		end
		
		Editor.PANEL.CrossButton = Editor.PANEL.CrossSettings:Add( "DButton" )
		Editor.PANEL.CrossButton:SizeToContents()
		
		if Editor.CrossToggle then
				Editor.PANEL.CrossButton:SetText("Hide Default Crosshair")
				Editor.PANEL.CrossButton:SetTextColor(Color(150,0,0))
		else
				Editor.PANEL.CrossButton:SetText("Show Default Crosshair")
				Editor.PANEL.CrossButton:SetTextColor(Color(0,150,0))
		end	
		
		Editor.PANEL.CrossButton:SetPos(10,30)
		Editor.PANEL.CrossButton:SetSize(250,20)
		Editor.PANEL.CrossButton.DoClick = function()
			Editor.CrossToggle = !Editor.CrossToggle
			RunConsoleCommand("simple_thirdperson_hide_crosshair",BoolToInt(Editor.CrossToggle))	
			if Editor.CrossToggle then
					Editor.PANEL.CrossButton:SetText("Hide Default Crosshair")
					Editor.PANEL.CrossButton:SetTextColor(Color(150,0,0))
			else
					Editor.PANEL.CrossButton:SetText("Show Default Crosshair")
					Editor.PANEL.CrossButton:SetTextColor(Color(0,150,0))
			end						
		end
		
		
		
		Editor.PANEL.RCrossTxt = Editor.PANEL.CrossSettings:Add("DLabel")
		Editor.PANEL.RCrossTxt:SetPos(10,60)
		Editor.PANEL.RCrossTxt:SetText("Red : ")
		Editor.PANEL.RCrossTxt:SizeToContents() 
		
		Editor.PANEL.RCrossTxtLb = Editor.PANEL.CrossSettings:Add("DTextEntry")
		Editor.PANEL.RCrossTxtLb:SetPos(50,55)
		Editor.PANEL.RCrossTxtLb:SetValue(math.abs(GetConVar( "simple_thirdperson_custom_crosshair_r" ):GetInt()))
		Editor.PANEL.RCrossTxtLb:SizeToContents()
		Editor.PANEL.RCrossTxtLb:SetNumeric(true)
		Editor.PANEL.RCrossTxtLb:SetUpdateOnType( true )
		Editor.PANEL.RCrossTxtLb.OnTextChanged  = function()
			local RValue = tonumber(Editor.PANEL.RCrossTxtLb:GetValue())
			if RValue == nil then return end
			local RVal = math.abs(RValue)
			if RVal > 255 then RVal = 255 end
			RunConsoleCommand("simple_thirdperson_custom_crosshair_r",tostring(RVal))
		end
		
		Editor.PANEL.GCrossTxt = Editor.PANEL.CrossSettings:Add("DLabel")
		Editor.PANEL.GCrossTxt:SetPos(120,60)
		Editor.PANEL.GCrossTxt:SetText("| Green : ")
		Editor.PANEL.GCrossTxt:SizeToContents() 
		
		Editor.PANEL.GCrossTxtLb = Editor.PANEL.CrossSettings:Add("DTextEntry")
		Editor.PANEL.GCrossTxtLb:SetPos(170,55)
		Editor.PANEL.GCrossTxtLb:SetValue(math.abs(GetConVar( "simple_thirdperson_custom_crosshair_g" ):GetInt()))
		Editor.PANEL.GCrossTxtLb:SizeToContents()
		Editor.PANEL.GCrossTxtLb:SetNumeric(true)
		Editor.PANEL.GCrossTxtLb:SetUpdateOnType( true )
		Editor.PANEL.GCrossTxtLb.OnTextChanged  = function()
			local GValue = tonumber(Editor.PANEL.GCrossTxtLb:GetValue())
			if GValue == nil then return end
			local GVal = math.abs(GValue)
			if GVal > 255 then GVal = 255 end
			RunConsoleCommand("simple_thirdperson_custom_crosshair_g",tostring(GVal))
		end
		
		Editor.PANEL.BCrossTxt = Editor.PANEL.CrossSettings:Add("DLabel")
		Editor.PANEL.BCrossTxt:SetPos(10,85)
		Editor.PANEL.BCrossTxt:SetText("Blue : ")
		Editor.PANEL.BCrossTxt:SizeToContents() 
		
		Editor.PANEL.BCrossTxtLb = Editor.PANEL.CrossSettings:Add("DTextEntry")
		Editor.PANEL.BCrossTxtLb:SetPos(50,80)
		Editor.PANEL.BCrossTxtLb:SetValue(math.abs(GetConVar( "simple_thirdperson_custom_crosshair_b" ):GetInt()))
		Editor.PANEL.BCrossTxtLb:SizeToContents()
		Editor.PANEL.BCrossTxtLb:SetNumeric(true)
		Editor.PANEL.BCrossTxtLb:SetUpdateOnType( true )
		Editor.PANEL.BCrossTxtLb.OnTextChanged  = function()
			local BValue = tonumber(Editor.PANEL.BCrossTxtLb:GetValue())
			if BValue == nil then return end
			local BVal = math.abs(BValue)
			if BVal > 255 then BVal = 255 end
			RunConsoleCommand("simple_thirdperson_custom_crosshair_b",tostring(BVal))
		end
		
		Editor.PANEL.ACrossTxt = Editor.PANEL.CrossSettings:Add("DLabel")
		Editor.PANEL.ACrossTxt:SetPos(120,85)
		Editor.PANEL.ACrossTxt:SetText("| Alpha : ")
		Editor.PANEL.ACrossTxt:SizeToContents() 
		
		Editor.PANEL.ACrossTxtLb = Editor.PANEL.CrossSettings:Add("DTextEntry")
		Editor.PANEL.ACrossTxtLb:SetPos(170,80)
		Editor.PANEL.ACrossTxtLb:SetValue(math.abs(GetConVar( "simple_thirdperson_custom_crosshair_a" ):GetInt()))
		Editor.PANEL.ACrossTxtLb:SizeToContents()
		Editor.PANEL.ACrossTxtLb:SetNumeric(true)
		Editor.PANEL.ACrossTxtLb:SetUpdateOnType( true )
		Editor.PANEL.ACrossTxtLb.OnTextChanged  = function()
			local AValue = tonumber(Editor.PANEL.ACrossTxtLb:GetValue())
			if AValue == nil then return end
			local AVal = math.abs(AValue)
			if AVal > 255 then AVal = 255 end
			RunConsoleCommand("simple_thirdperson_custom_crosshair_a",tostring(AVal))
		end
		
		
		// ---------------- Credits CAMERA ---------------- //
		Editor.PANEL.CreedTxt = Editor.PANEL.CreditsSettings:Add("DLabel")
		Editor.PANEL.CreedTxt:SetPos(98,80)
		Editor.PANEL.CreedTxt:SetText("By FailCake :D")
		Editor.PANEL.CreedTxt:SizeToContents() 
		
		Editor.PANEL.CreedImg = Editor.PANEL.CreditsSettings:Add("DImageButton")
		Editor.PANEL.CreedImg:SetPos( 100, 10 )
		Editor.PANEL.CreedImg:SetSize( 64, 64 )
		Editor.PANEL.CreedImg:SetImage( "icon32/zoom_extend.png" )
		Editor.PANEL.CreedImg.DoClick = function()
			gui.OpenURL("http://steamcommunity.com/id/edunad")
		end
	end
	
	function ServerBool(cmd_server,cmd_client)
		
		local srv_shoulder = GetConVar(cmd_server):GetInt()
		
		if srv_shoulder == 0 then
			return IntToBool(GetConVar( cmd_client ):GetInt())
		elseif srv_shoulder == 1 then
			return true
		elseif srv_shoulder == 2 then
			return false
		end
	end
	
	function ServerNumber(cmd_server_max,cmd_server_min,cmd_client,default)
	
		local value = default
		
		local SrvMax = GetConVar( cmd_server_max ):GetFloat() or 0
		local SrvMin = GetConVar( cmd_server_min ):GetFloat() or 0
		
		local ClnVal = GetConVar( cmd_client ):GetFloat()
		
		if SrvMin > SrvMax then return ClnVal end
		
		if SrvMax != 0 and SrvMin != 0 then
			if ClnVal <= SrvMax and ClnVal >= SrvMin then
				value = ClnVal
			else
				value = SrvMax
			end
		else
			value = ClnVal
		end
		
		return value
	end
	
	function IntToBool(int)
		if int == 1 then
			return true
		else
			return false
		end
	end
	
	function BoolToInt(bol)
		if bol then
			return 1
		else
			return 0
		end
	end
	
	concommand.Add( "simple_thirdperson_shoulder_toggle", function()
		Editor.ShoulderToggle = !Editor.ShoulderToggle
		RunConsoleCommand("simple_thirdperson_shoulderview",BoolToInt(Editor.ShoulderToggle))
	end)
	
	concommand.Add( "simple_thirdperson_crosshair_toggle", function()
		Editor.CrossToggle = !Editor.CrossToggle
		RunConsoleCommand("simple_thirdperson_hide_crosshair",BoolToInt(Editor.CrossToggle))
	end)
	
	concommand.Add( "simple_thirdperson_custom_crosshair_toggle", function()
		Editor.CustomCrossToggle = !Editor.CustomCrossToggle
		RunConsoleCommand("simple_thirdperson_enable_custom_crosshair",BoolToInt(Editor.CustomCrossToggle))
	end)
	
	concommand.Add( "simple_thirdperson_enable_toggle", function()
		Editor.EnableToggle = !Editor.EnableToggle
		RunConsoleCommand("simple_thirdperson_enabled",BoolToInt(Editor.EnableToggle))
	end)
	
	concommand.Add( "stp", function()
		Editor.EnableToggle = !Editor.EnableToggle
		RunConsoleCommand("simple_thirdperson_enabled",BoolToInt(Editor.EnableToggle))
	end)
	
	hook.Add("ShouldDrawLocalPlayer", "SimpleTP.ShouldDraw", function(ply)
		if GetConVar( "simple_thirdperson_enabled" ):GetBool() then
			return true
		end
	end)

	hook.Add("HUDShouldDraw", "SimpleTP.HUDShouldDraw", function(name)
		if GetConVar( "simple_thirdperson_enabled" ):GetBool() and GetConVar( "simple_thirdperson_enable_custom_crosshair" ):GetBool() or GetConVar( "simple_thirdperson_hide_crosshair" ):GetBool() then
			if name == "CHudCrosshair" then
				return false
			end
		end
	end)
	
	hook.Add("HUDPaint", "SimpleTP.HUDPaint", function()
	
		if !GetConVar( "simple_thirdperson_enable_custom_crosshair" ):GetBool() then return end
	
		local ply = LocalPlayer()
		
		local t = {}
		t.start = ply:GetShootPos()
		t.endpos = t.start + ply:GetAimVector() * 9000
		t.filter = ply
		
		local tr = util.TraceLine(t)
		local pos = tr.HitPos:ToScreen()
		
		local dist = (tr.HitPos - t.start):Length()

		if dist < 3500 then
		
			local R = GetConVar( "simple_thirdperson_custom_crosshair_r" ):GetInt()
			local G = GetConVar( "simple_thirdperson_custom_crosshair_g" ):GetInt()
			local B = GetConVar( "simple_thirdperson_custom_crosshair_b" ):GetInt()
			local A = GetConVar( "simple_thirdperson_custom_crosshair_a" ):GetInt()
			surface.SetDrawColor(R, G, B, A)
			
			surface.DrawLine(pos.x - 5, pos.y, pos.x - 8, pos.y)
			surface.DrawLine(pos.x + 5, pos.y, pos.x + 8, pos.y)
	
			surface.DrawLine(pos.x, pos.y - 5, pos.x, pos.y - 8)
			surface.DrawLine(pos.x, pos.y + 5, pos.x, pos.y + 8)
			
		end
		
	end)
	
	hook.Add("CalcView","SimpleTP.CameraView",function(ply, pos, angles, fov)
	
		if GetConVar( "simple_thirdperson_enabled" ):GetBool() and IsValid(ply) then
		
			if Editor.DelayPos == nil then
				Editor.DelayPos = ply:EyePos()
			end
			
			if Editor.ViewPos == nil then
				Editor.ViewPos = ply:EyePos()
			end
			

			Editor.DelayFov = fov
			
			local view = {}
		
			local Forward = ServerNumber("simple_thirdperson_maxdistance","simple_thirdperson_mindistance","simple_thirdperson_cam_distance")
			
			local Up = ServerNumber("simple_thirdperson_maxup","simple_thirdperson_minup","simple_thirdperson_cam_up")
			local Right = ServerNumber("simple_thirdperson_maxright","simple_thirdperson_minright","simple_thirdperson_cam_right")
			
			local Pitch = ServerNumber("simple_thirdperson_maxpitch","simple_thirdperson_minpitch","simple_thirdperson_cam_pitch")
			local Yaw = ServerNumber("simple_thirdperson_maxyaw","simple_thirdperson_minyaw","simple_thirdperson_cam_yaw")
			
			if ServerBool("simple_thirdperson_forceshoulder","simple_thirdperson_shoulderview") then
			
				if GetConVar( "simple_thirdperson_shoulderview_bump" ):GetBool() and ply:GetMoveType() != MOVETYPE_NOCLIP then
					angles.pitch = angles.pitch + (ply:GetVelocity():Length() / 300) * math.sin(CurTime() * 10)
					angles.roll = angles.roll + (ply:GetVelocity():Length() / 300) * math.cos(CurTime() * 10)
				end
				
				Forward = ServerNumber("simple_thirdperson_shoulder_maxdist","simple_thirdperson_shoulder_mindist","simple_thirdperson_shoulderview_dist")
				Up = ServerNumber("simple_thirdperson_shoulder_maxup","simple_thirdperson_shoulder_minup","simple_thirdperson_shoulderview_up")
				Right = ServerNumber("simple_thirdperson_shoulder_maxright","simple_thirdperson_shoulder_minright","simple_thirdperson_shoulderview_right")
			else
			
				angles.p = angles.p + Pitch
				angles.y = angles.y + Yaw
			
			end
			
			if ServerBool("simple_thirdperson_forcesmooth","simple_thirdperson_smooth") then
			
				Editor.DelayPos = Editor.DelayPos + (ply:GetVelocity() * (FrameTime() / GetConVar( "simple_thirdperson_smooth_delay" ):GetFloat()))
				Editor.DelayPos.x = math.Approach(Editor.DelayPos.x, pos.x, math.abs(Editor.DelayPos.x - pos.x) * GetConVar( "simple_thirdperson_smooth_mult_x" ):GetFloat())
				Editor.DelayPos.y = math.Approach(Editor.DelayPos.y, pos.y, math.abs(Editor.DelayPos.y - pos.y) * GetConVar( "simple_thirdperson_smooth_mult_y" ):GetFloat())
				Editor.DelayPos.z = math.Approach(Editor.DelayPos.z, pos.z, math.abs(Editor.DelayPos.z - pos.z) * GetConVar( "simple_thirdperson_smooth_mult_z" ):GetFloat())

			else
				Editor.DelayPos = pos
			end
			
			if GetConVar( "simple_thirdperson_fov_smooth" ):GetBool() then
				Editor.DelayFov = Editor.DelayFov + 20
				fov = math.Approach(fov, Editor.DelayFov, math.abs(Editor.DelayFov - fov) * GetConVar( "simple_thirdperson_fov_smooth_mult" ):GetFloat())
			else
				fov = Editor.DelayFov
			end
			
			if ServerBool("simple_thirdperson_forcecollide","simple_thirdperson_collision") then
			
				local traceData = {}
				traceData.start = Editor.DelayPos
				traceData.endpos = traceData.start + angles:Forward() * -Forward
				traceData.endpos = traceData.endpos + angles:Right() * Right
				traceData.endpos = traceData.endpos + angles:Up() * Up
				traceData.filter = ply
				
				local trace = util.TraceLine(traceData)
				
				pos = trace.HitPos
				
				if trace.Fraction < 1.0 then
					pos = pos + trace.HitNormal * 5
				end
				
				view.origin = pos
			else
			
				local View = Editor.DelayPos + ( angles:Forward()* -Forward )
				View = View + ( angles:Right() * Right )
				View = View + ( angles:Up() * Up )
				
				view.origin = View
				
			end

			view.angles = angles
			view.fov = fov
		 
			return view

		end
	end)

	concommand.Add( "simple_thirdperson_menu",function() BuildMenu(nil) end)
end