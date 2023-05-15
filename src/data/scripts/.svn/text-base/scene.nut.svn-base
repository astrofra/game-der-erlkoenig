	Include("scriptlib/nad.nut");

class	PlayScene
{

	mouse_x			= 0.0
	mouse_y			= 0.0
	x				= 0.0
	y				= 0.0
	x_speed			= 0.0
	y_speed			= 0.0

	game_plane		= 0

	mouse_cursor	= 0

	current_cam		= 0
	mouse_3d		= Vector()
	world_mouse_3d	= Vector()
	ray_dir			= Vector(0,0,1)
	hit				= false

	pick			= 0

	item_grabbed	= 0
	instance_grabbed
					= 0
	item_p			= 0

	intro_theme_sfx	= 0
	intro_theme_channel
					= 0

	//------------------------
	function	OnSetup(scene)
	{
		print("PlayScene::OnSetup()")
		x			= 0.0
		y			= 0.0

		current_cam = SceneGetCurrentCamera(scene)

		mouse_cursor = SceneFindItem(scene, "mouse")

		intro_theme_sfx = EngineLoadSound(g_engine, "data/sounds/erlkonig_trumpet_loop_16.wav")

		MixerChannelSetGain(g_mixer, intro_theme_channel, 0.125)
		MixerChannelSetPitch(g_mixer, intro_theme_channel, 0.35)
		
		game_plane = SceneFindItem(scene, "game_plane")

		ScenePhysicEnableDeactivation(scene, false)

		//MixerChannelStart(g_mixer, intro_theme_channel, intro_theme_sfx);	
	}

	//------------------------
	function	OnUpdate(scene)
	{
		mouse_x = MousePoolFunction(DeviceAxisX) / 65536.0
		mouse_y = MousePoolFunction(DeviceAxisY) / 65536.0

		x = (mouse_x - 0.5) * ItemGetScale(game_plane).x
		y = (0.5 - mouse_y) * ItemGetScale(game_plane).y

		mouse_3d.x = x
		mouse_3d.y = y
		mouse_3d.z = ItemGetPosition(game_plane).z - Mtr(0.5)
		ItemSetPosition(mouse_cursor, mouse_3d)

		world_mouse_3d = ItemGetWorldPosition(mouse_cursor)
		ray_dir = world_mouse_3d - ItemGetWorldPosition(CameraGetItem(current_cam))
		hit = SceneCollisionRaytrace(scene, world_mouse_3d, ray_dir, 2, CollisionTraceAll)

		local	mouse_button
		mouse_button = MousePoolFunction(DeviceButton0)

		if (item_grabbed == 0)
		{
			if (hit.hit)
			{
				ItemSetScale(mouse_cursor, Vector(1,1,1))
				if (mouse_button)
				{
					RendererDrawCross(g_render, hit.p)
					item_grabbed = ShapeGetItem(hit.shape)
					hit.p.z = ItemGetWorldPosition(item_grabbed).z
					item_p = hit.p.ApplyMatrix(ItemGetInverseMatrix(item_grabbed))

					instance_grabbed = ItemGetScriptInstance(item_grabbed)
				}
			}
			else
				ItemSetScale(mouse_cursor, Vector(0.8,0.8,0.8))
		}
		else
		{
			instance_grabbed.OnClick({_item_p = item_p, _world_mouse_3d = world_mouse_3d})

			if (!mouse_button)
			{
				item_grabbed = 0
			}
		}
		//mouse_3d.Print()
	}

}