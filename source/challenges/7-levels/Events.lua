-- Event system with callbacks
Events = {}

EVENT_TYPES = {
	EVENTS_READY = "EVENTS_READY",
	PANELS_CHAPTER_SELECTED = "PANELS_CHAPTER_SELECTED",
	PANELS_STARTED = "PANELS_STARTED",
}


--[[

When using events we want to follow the same pattern.
To fire an event, we provide a type and a payload. 

example: 
Events.fire(Events.EVENTS_READY, eventsReadyPayload)

Depending on your callback, the payload can be a simple string or number or more complex object 
see Example usage below 	
]]

-- All events that can be fired & subscribed too

-- Function to subscribe to an event
function Events.subscribe(eventName, callback)
  if not Events[eventName] then
	Events[eventName] = {}
  end
  table.insert(Events[eventName], callback)
end

-- Function to fire an event
function Events.fire(eventName, ...)
  local callbacks = Events[eventName]
  if callbacks then
	for _, callback in ipairs(callbacks) do
	  callback(...)
	end
  end
end

-- Example usage
function actionCallback(payload)
  -- we con conditionally check for nested data 
  if type(payload) == "table" then  
  	if payload and payload.message then
	  print("Events ready message:", payload.message)
  	end
  
  	if payload and payload.total then
	  local total = "" .. payload.total
	  return print("Events ready total:", total)
  	end
  end
  
  if type(payload) == "string" then
	return print("Events ready:", payload)
  end
end

Events.subscribe("EVENTS_READY", actionCallback)

local eventsReadyPayload = {
  message = "Events ready and waiting for subscriptions",
  total = 42
}

Events.fire(EVENT_TYPES.EVENTS_READY, eventsReadyPayload)


print("Events ready:", EVENT_TYPES.EVENTS_READY)
