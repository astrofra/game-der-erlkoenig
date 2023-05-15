Include("scriptlib/nad.nut")

class	CommandListDeleter
{
	scene			= 0
	item_list		= 0
	current_item	= 0
	n				= 0
	
	constructor()
	{
		item_list	= []
	}
	
	function	RegisterItem(_item)
	{
		item_list.append(_item)
	}
	
	function	Update()
	{
		foreach(n,current_item in item_list)
			if (ItemIsCommandListDone(current_item))
			{
				SceneDeleteObject(ItemGetScene(current_item), ItemCastToObject(current_item))
				item_list.remove(n)
				//return
			}
	}
}