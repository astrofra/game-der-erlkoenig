//
	Include("scriptlib/nad.nut");

class PhysicBlock
{

//@parm
	type 	= "fixed";
//@endparm

	p 		= Vector();
	r 		= Vector();
	v 		= Vector();
	w 		= Vector();

	body	= 0;
	marked_for_removal
			= false;
	removal_timeout
			= 0.0;

	OnClick	= 0;

	//-----------------------
	function	OnSetup(item)
	{
		body = item;

		switch (type)
		{
			case "fixed":
				OnClick = DoNothing;
				break;

			case "draggable":
				OnClick = Drag;
				break;

			case "removeable":
				OnClick = Remove;
				break;
		}
	}

	function	DoNothing(parms)
	{}

	//---------------------
	function	Drag(parms)
	{
		local rm = ItemGetRotationMatrix(body);
		local world_item_p = parms._item_p.ApplyRotationMatrix(rm);
		world_item_p += ItemGetWorldPosition(body);
		local p_force = parms._world_mouse_3d - world_item_p;

		ItemApplyForce(body, world_item_p, p_force.MulReal(ItemGetMass(body) * 50.0));
		RendererDrawLine(g_render, world_item_p, parms._world_mouse_3d);
	}
	
	//-----------------------
	function	Remove(parms)
	{
		if (!marked_for_removal)
		{
			marked_for_removal = true;
			removal_timeout = g_clock;
			ItemWake(body);
			local str = "";
			for (local n = 0; n < 4; n++)
			{
				local	flick_delay = (n == 0 ? 0.6:0.015);
				str += "nop " + flick_delay + ";toalpha 0,0;nop 0.015;toalpha 0,1;";
			}
			ItemSetCommandList(body, str);
		}
	}

	//-----------------------------
	function	CheckBlockRemoval()
	{
		if (!marked_for_removal)
			return;
		if (0)
		{
			local	shake_timer = (g_clock - removal_timeout) * 0.07516736873;
			local	shake_amplitude = Pow(1.0 - Min(1.0, TickToSec(g_clock - removal_timeout)), 3.0);
			print("shake_timer = " + shake_timer);
			ItemSetPosition(body, ItemGetPosition(body) + Vector(cos(shake_timer), sin(shake_timer), 0).MulReal(0.05 * shake_amplitude));
			ItemComputeMatrix(body);
		}
		if ((g_clock - removal_timeout) > SecToTick(Sec(1.0)))
			SceneDeleteObject(g_scene, ItemCastToObject(body));
	}

	//------------------------
	function	OnUpdate(item)
	{
		p = ItemGetPosition(item);
		p.z = 0.0;
		ItemSetPosition(item, p);

		/*r = ItemGetRotation(item);
		r.x = 0.0;
		r.y = 0.0;
		ItemSetRotation(item, p);*/

		v = ItemGetLinearVelocity(item)
		v.z = 0.0;
		ItemSetLinearVelocity(item, v)

		w = ItemGetAngularVelocity(item)
		w.x = 0.0;
		w.y = 0.0;
		ItemSetAngularVelocity(item, w)

		CheckBlockRemoval();
	}
}