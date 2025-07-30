addEventHandler( "onClientResourceStart", getResourceRootElement( getThisResource()),
	function()
		triggerEvent( "switchDynamicSky", resourceRoot, true )
		addCommandHandler( "sDynamicSky",
			function()
				triggerEvent( "switchDynamicSky", resourceRoot, not dsEffectEnabled )
			end
		)
	end
)

function switchDynamicSky( dsOn )
	if dsOn then
		startDynamicSky()
	else
		stopDynamicSky()
	end
end

addEvent( "switchDynamicSky", true )
addEventHandler( "switchDynamicSky", resourceRoot, switchDynamicSky )

addEventHandler( "onClientResourceStop", getResourceRootElement( getThisResource()),stopDynamicSky)
