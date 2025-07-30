local currentState = false

function setSSAOEffectState(effectState)
	currentState = not currentState
	local state
	if effectState then
		state = enableAO()
	else
		state = disableAO()
	end		
	return state
end

function getSSAOEffectState()
	return currentState
end
