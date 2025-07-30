local latestNews = {
    newsTitle = "Aranybank",
    newsDate = "2025.02.15",
    newsBadge = {
        [1] = {"Hotfix", "sightblue"},
        [3] = {"Update", "sightgreen"},
        [4] = {"Aranybankrablás", "sightyellow"},
    }
}

addEvent("requestNewsData", true)
addEventHandler("requestNewsData", resourceRoot, function()
    triggerClientEvent(client, "gotNewsData", client, latestNews.newsTitle, latestNews.newsDate, latestNews.newsBadge)
end)