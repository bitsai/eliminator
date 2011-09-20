numWeeks = 17
numGames = 16

picks = (JSON.parse localStorage.getItem 'picks') or {}
schedule = JSON.parse '{
  "1": [["DEN","OAK"],["MIA","NE"],["NYJ","DAL"],["ARI","CAR"],
        ["SF","SEA"],["SD","MIN"],["WAS","NYG"],["HOU","IND"],
        ["BAL","PIT"],["JAC","TEN"],["TB","DET"],["STL","PHI"],
        ["KC","BUF"],["CLE","CIN"],["CHI","ATL"],["NO","GB"]],
  "2": [["NYJ","JAC"],["NO","CHI"],["TEN","BAL"],["PIT","SEA"],
        ["WAS","ARI"],["CAR","GB"],["MIN","TB"],["DET","KC"],
        ["BUF","OAK"],["IND","CLE"],["SF","DAL"],["NE","SD"],
        ["MIA","HOU"],["DEN","CIN"],["ATL","PHI"],["NYG","STL"]],
  "3": [["BUF","NE"],["CIN","SF"],["CLE","MIA"],["TEN","DEN"],
        ["MIN","DET"],["NO","HOU"],["PHI","NYG"],["CAR","JAC"],
        ["SD","KC"],["OAK","NYJ"],["STL","BAL"],["SEA","ARI"],
        ["TB","ATL"],["CHI","GB"],["IND","PIT"],["DAL","WAS"]],
  "4": [["CHI","CAR"],["CIN","BUF"],["CLE","TEN"],["DAL","DET"],
        ["STL","WAS"],["PHI","SF"],["KC","MIN"],["JAC","NO"],
        ["HOU","PIT"],["SEA","ATL"],["ARI","NYG"],["SD","MIA"],
        ["GB","DEN"],["OAK","NE"],["BAL","NYJ"],["TB","IND"]],
  "5": [["BUF","PHI"],["IND","KC"],["MIN","ARI"],["NYG","SEA"],
        ["TEN","PIT"],["CAR","NO"],["JAC","CIN"],["HOU","OAK"],
        ["SF","TB"],["NE","NYJ"],["DEN","SD"],["ATL","GB"],
        ["DET","CHI"]],
  "6": [["ATL","CAR"],["CIN","IND"],["DET","SF"],["GB","STL"],
        ["WAS","PHI"],["NYG","BUF"],["PIT","JAC"],["BAL","HOU"],
        ["OAK","CLE"],["NE","DAL"],["TB","NO"],["CHI","MIN"],
        ["NYJ","MIA"]],
  "7": [["CLE","SEA"],["DET","ATL"],["TEN","HOU"],["MIA","DEN"],
        ["NYJ","SD"],["TB","CHI"],["CAR","WAS"],["ARI","PIT"],
        ["OAK","KC"],["DAL","STL"],["MIN","GB"],["NO","IND"],
        ["JAC","BAL"]],
  "8": [["TEN","IND"],["STL","NO"],["NYG","MIA"],["CAR","MIN"],
        ["BAL","ARI"],["HOU","JAC"],["BUF","WAS"],["DEN","DET"],
        ["SF","CLE"],["PIT","NE"],["SEA","CIN"],["PHI","DAL"],
        ["KC","SD"]],
  "9": [["BUF","NYJ"],["DAL","SEA"],["NO","TB"],["IND","ATL"],
        ["KC","MIA"],["WAS","SF"],["HOU","CLE"],["OAK","DEN"],
        ["TEN","CIN"],["NE","NYG"],["ARI","STL"],["SD","GB"],
        ["PIT","BAL"],["PHI","CHI"]],
  "10": [["SD","OAK"],["ATL","NO"],["CHI","DET"],["CIN","PIT"],
        ["CLE","STL"],["DAL","BUF"],["IND","JAC"],["KC","DEN"],
        ["MIA","WAS"],["PHI","ARI"],["TB","HOU"],["CAR","TEN"],
        ["SEA","BAL"],["SF","NYG"],["NYJ","NE"],["GB","MIN"]],
  "11": [["DEN","NYJ"],["ATL","TEN"],["CLE","JAC"],["DET","CAR"],
        ["GB","TB"],["WAS","DAL"],["BAL","CIN"],["MIA","BUF"],
        ["MIN","OAK"],["SF","ATL"],["STL","SEA"],["CHI","SD"],
        ["NYG","PHI"],["NE","KC"]],
  "12": [["DET","GB"],["DAL","MIA"],["BAL","SF"],["ATL","MIN"],
        ["CIN","CLE"],["TEN","TB"],["IND","CAR"],["JAC","HOU"],
        ["STL","ARI"],["NYJ","BUF"],["OAK","CHI"],["SEA","WAS"],
        ["PHI","NE"],["SD","DEN"],["KC","PIT"],["NO","NYG"]],
  "13": [["PIT","PHI"],["BUF","TEN"],["CHI","KC"],["CLE","BAL"],
        ["MIA","OAK"],["NO","DET"],["PIT","CIN"],["TB","CAR"],
        ["WAS","NYJ"],["HOU","ATL"],["MIN","DEN"],["SF","STL"],
        ["NYG","GB"],["ARI","DAL"],["NE","IND"],["JAC","SD"]],
  "14": [["PIT","CLE"],["CIN","HOU"],["DET","MIN"],["GB","OAK"],
        ["TEN","NO"],["MIA","PHI"],["NYJ","KC"],["WAS","NE"],
        ["CAR","ATL"],["JAC","TB"],["BAL","IND"],["DEN","CHI"],
        ["ARI","SF"],["SD","BUF"],["DAL","NYG"],["SEA","STL"]],
  "15": [["ATL","JAC"],["TB","DAL"],["BUF","MIA"],["CHI","SEA"],
        ["IND","TEN"],["KC","GB"],["STL","CIN"],["MIN","NO"],
        ["NYG","WAS"],["HOU","CAR"],["OAK","DET"],["PHI","NYJ"],
        ["ARI","CLE"],["DEN","NE"],["SD","BAL"],["SF","PIT"]],
  "16": [["IND","HOU"],["BUF","DEN"],["CIN","ARI"],["TEN","JAC"],
        ["KC","OAK"],["NE","MIA"],["NYJ","NYG"],["PIT","STL"],
        ["WAS","MIN"],["CAR","TB"],["BAL","CLE"],["DET","SD"],
        ["SEA","SF"],["DAL","PHI"],["GB","CHI"],["NO","ATL"]],
  "17": [["ATL","TB"],["CIN","BAL"],["CLE","PIT"],["GB","DET"],
        ["JAC","IND"],["HOU","TEN"],["STL","SF"],["MIA","NYJ"],
        ["MIN","CHI"],["NE","BUF"],["NO","CAR"],["NYG","DAL"],
        ["PHI","WAS"],["ARI","SEA"],["OAK","SD"],["DEN","KC"]]
  }'

@refreshWeeks = () ->
  weeksDiv = document.getElementById 'weeks'
  for _ in weeksDiv.childNodes
    weeksDiv.removeChild weeksDiv.firstChild
  for week in [1..numWeeks]
    div = document.createElement 'div'
    div.className = 'week'
    div.appendChild createWeekTable week
    weeksDiv.appendChild div

createWeekTable = (week) ->
  table = document.createElement 'table'
  table.appendChild createCaption week
  table.appendChild createHeaderRow()
  if week of schedule
    for [homeTeam, awayTeam] in schedule[week]
      table.appendChild createGameRow week, homeTeam, awayTeam
  for _ in [0...table.childNodes.length - 2 - numGames]
    table.appendChild createEmptyRow()
  table

createCaption = (week) ->
  caption = document.createElement 'caption'
  caption.innerHTML = 'Week ' + week
  caption

createHeaderRow = () ->
  row = document.createElement 'tr'
  homeHeader = document.createElement 'th'
  homeHeader.innerHTML = 'Home'
  row.appendChild homeHeader
  awayHeader = document.createElement 'th'
  awayHeader.innerHTML = 'Away'
  row.appendChild awayHeader
  row

createGameRow = (week, homeTeam, awayTeam) ->
  row = document.createElement 'tr'
  row.appendChild createTeamCell week, homeTeam
  row.appendChild createTeamCell week, awayTeam
  row

createEmptyRow = () ->
  row = document.createElement 'tr'
  cell = document.createElement 'td'
  cell.innerHTML = '&nbsp;'
  row.appendChild cell
  row

createTeamCell = (week, team) ->
  cell = document.createElement 'td'
  cell.innerHTML = team
  cell.style.backgroundColor = getColor week, team
  cell.onclick = () ->
    switch getTeamStatus week, team
      when 'available' then makePick week, team
      when 'picked' then delete picks[week]
    localStorage.setItem 'picks', JSON.stringify picks
    refreshWeeks()
  cell

getColor = (week, team) ->
  switch getTeamStatus week, team
    when 'available' then '#00FF00'
    when 'picked' then '#FFFF00'
    when 'unavailable' then '#FF0000'

getTeamStatus = (week, team) ->
  for pickedWeek, pickedTeam of picks
    if team == pickedTeam
      if week == (parseInt pickedWeek) then return 'picked'
      if week > (parseInt pickedWeek) then return 'unavailable'
  'available'

makePick = (week, team) ->
  for pickedWeek, pickedTeam of picks
    if team == pickedTeam then delete picks[pickedWeek]
  picks[week] = team
