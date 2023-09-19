import "CoreLibs/object"

--[[
StoryTree is a helper for Panels to structure the content into tree so that we can create a choose your own style adventure. 	
]]
StoryTree = {}

function StoryTree.watch(Panels)
	print("StoryTree is now watching Panels")
	currentSeqIndex = Panels.getCurrentSeqIndex()
	print("StoryTree knows that Panels has a currentSeqIndex: ", currentSeqIndex)
	
	function onPanelsStarted(message)
	  print("StoryTree heard Panels started:", message)
	end
	
	Events.subscribe(EVENT_TYPES.PANELS_STARTED, onPanelsStarted)
	

	function onPanelsChapterSelected(payload)
	  if type(payload) == "table" then  
		  if payload and payload.message then
		  print("Events ready message:", payload.message)
		  end
	  
		  if payload and payload.currentSeqIndex then
		  local total = "" .. payload.currentSeqIndex
		  return print("Events ready total:", total)
		  end
	  end
	end
	
	Events.subscribe(EVENT_TYPES.PANELS_CHAPTER_SELECTED, onPanelsChapterSelected)
end



