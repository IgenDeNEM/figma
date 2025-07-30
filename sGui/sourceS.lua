function showInfobox(player, type, msg)
    triggerClientEvent(player, "showInfobox", resourceRoot, type, msg)
end

function thousandsStepper(amount)
    local formatted = amount
    while true do
      formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", "%1 %2")
      if k == 0 then
        break
      end
    end
    return formatted
  end