var numWeeks = 17;
var maxGamesPerWeek = 16;

// this.schedule populated from YYYYschedule.js
var picks = JSON.parse(localStorage.getItem("picks")) || {};

var refreshSchedule = function() {
    var scheduleDiv = document.getElementById("schedule");
    clearSchedule(scheduleDiv);
    var weekDivs = _.map(_.range(1, numWeeks + 1), createWeekDiv);
    _.each(weekDivs, function(div) {scheduleDiv.appendChild(div); });
};

var clearSchedule = function(div) {
    while (div.childNodes.length > 0) {
	div.removeChild(div.firstChild);
    }
};

var createWeekDiv = function(week) {
    var div = document.createElement("div");
    div.className = "week";
    div.appendChild(createWeekTable(week));
    return div;
};

var createWeekTable = function(week) {
    var table = document.createElement("table");
    table.appendChild(createCaption(week));
    table.appendChild(createHeaderRow());
    _.each(schedule[week], function(game) {
	var homeTeam = game[0];
	var awayTeam = game[1];
	table.appendChild(createGameRow(week, homeTeam, awayTeam));
    });
    while (table.childNodes.length - 2 < maxGamesPerWeek) {
	table.appendChild(createEmptyRow());
    }
    return table;
};

var createCaption = function(week) {
    var caption = document.createElement("caption");
    caption.innerHTML = "Week " + week;
    return caption;
};

var createHeaderRow = function() {
    var row = document.createElement("tr");
    row.innerHTML = "<th>Home</th><th>Away</th>";
    return row;
}

var createGameRow = function(week, homeTeam, awayTeam) {
    var row = document.createElement("tr");
    row.appendChild(createTeamCell(week, homeTeam));
    row.appendChild(createTeamCell(week, awayTeam));
    return row;
}

var createEmptyRow = function() {
    var row = document.createElement("tr");
    row.innerHTML = "<td>&nbsp;</td>";
    return row;
}

var createTeamCell = function(week, team) {
    var cell = document.createElement("td");
    cell.innerHTML = team;
    cell.style.backgroundColor = getColor(week, team);
    cell.onclick = function() {
	switch (getStatus(week, team)) {
	case "available":
	    makePick(week, team);
	    break;
	case "picked":
	    delete picks[week];
	    break;
	}
	localStorage.setItem("picks", JSON.stringify(picks));
	refreshSchedule();
    };
    return cell;
}

var getColor = function(week, team) {
    switch (getStatus(week, team)) {
    case "available": return "#00FF00";
    case "picked": return "#FFFF00";
    case "unavailable": return "#FF0000";
    }
}

var getStatus = function(week, team) {
    var weeks = _.keys(picks);
    var weekPicked = _.find(weeks, function(w) { return picks[w] === team; });
    if (weekPicked) {
	if (week < parseInt(weekPicked)) return "available";
	if (week === parseInt(weekPicked)) return "picked";
	if (week > parseInt(weekPicked)) return "unavailable";
    } else return "available";
}

var makePick = function(week, team) {
    var weeks = _.keys(picks);
    var weekPicked = _.find(weeks, function(w) { return picks[w] === team; });
    delete picks[weekPicked];
    picks[week] = team;
}
