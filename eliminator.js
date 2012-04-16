var ELIMINATOR = (function () {
    'use strict';

    var GAMES_PER_WEEK = 16;
    var NUM_WEEKS = 17;
    var PICKS = JSON.parse(localStorage.getItem('picks')) || {};
    // var SCHEDULE populated in schedule-YYYY.js

    var pub = {};

    function makePick(team, week) {
        var weekPicked = getWeekPicked(team);
        delete PICKS[weekPicked];
        PICKS[week] = team;
    };

    function getWeekPicked(team) {
        return _.find(_.keys(PICKS), function (w) { return PICKS[w] === team; });
    };

    function getStatus(team, week) {
        var weekPicked = getWeekPicked(team);
        if (!weekPicked || week < parseInt(weekPicked, 10)) {
            return 'available';
        } else if (week === parseInt(weekPicked, 10)) {
            return 'picked';
        } else {
            return 'used';
        }
    };

    function getColor(team, week) {
        switch (getStatus(team, week)) {
        case 'available':
            return '#00FF00';
        case 'picked':
            return '#FFFF00';
        case 'used':
            return '#FF0000';
        }
    };

    function createTeamCell(team, week) {
        var cell = document.createElement('td');
        cell.innerHTML = team;
        cell.style.backgroundColor = getColor(team, week);
        cell.onclick = function () {
            if (getStatus(team, week) === 'picked') {
                delete PICKS[week];
            } else {
                makePick(team, week);
            }
            localStorage.setItem('picks', JSON.stringify(PICKS));
            pub.refreshSchedule();
        };
        return cell;
    };

    function createCaption(week) {
        var caption = document.createElement('caption');
        caption.innerHTML = 'Week ' + week;
        return caption;
    };

    function createHeaderRow() {
        var row = document.createElement('tr');
        row.innerHTML = '<th>Home</th><th>Away</th>';
        return row;
    };

    function createGameRow(week, homeTeam, awayTeam) {
        var row = document.createElement('tr');
        row.appendChild(createTeamCell(homeTeam, week));
        row.appendChild(createTeamCell(awayTeam, week));
        return row;
    };

    function createEmptyRow() {
        var row = document.createElement('tr');
        row.innerHTML = '<td>&nbsp;</td>';
        return row;
    };

    function createWeekTable(week) {
        var table = document.createElement('table');
        table.appendChild(createCaption(week));
        table.appendChild(createHeaderRow());
        _.each(SCHEDULE[week], function (game) {
            table.appendChild(createGameRow(week, game[0], game[1]));
        });
        while (table.childNodes.length - 2 < GAMES_PER_WEEK) {
            table.appendChild(createEmptyRow());
        }
        return table;
    };

    function createWeekDiv(week) {
        var div = document.createElement('div');
        div.className = 'week';
        div.appendChild(createWeekTable(week));
        return div;
    };

    function clearSchedule(div) {
        while (div.childNodes.length > 0) {
            div.removeChild(div.firstChild);
        }
    };

    pub.refreshSchedule = function () {
        var scheduleDiv = document.getElementById('schedule');
        var weekDivs = _.map(_.range(1, NUM_WEEKS + 1), createWeekDiv);
        clearSchedule(scheduleDiv);
        _.each(weekDivs, function (div) { scheduleDiv.appendChild(div); });
    };

    return pub;
}());
