$(function () {

  $.getJSON('/preorder.json', function(data) {
    var daily_data = [];
    var count = data.length
    var start_date = new Date(data[0][0]);
    var start_point = Date.parse(data[0][0]);
    var end_date = new Date(data[count-1][0]);
    for(var i = start_date, index = 0; i <= end_date;) {
      if (i.toUTCString() == new Date(data[index][0]).toUTCString()) {
        daily_data.push(data[index][1]);
        index++;
      } else {
        daily_data.push(0);
      }
      i.setDate(i.getDate() + 1);
    }

    // for(var i = 0; i < data.length; i++) {

    //   daily_data.push({x: Date.parse(data[i][0]), y: data[i][1]});
    // }
    $('#container').highcharts({
      chart: {
        type: 'area'
      },
      title: {
        text: 'Timeline graph of backers'
      },
      xAxis: {
        type: 'datetime',
        labels: {
          formatter: function() {
            return Highcharts.dateFormat('%d %b %Y', this.value); // clean, unformatted number for year
          }
        }
      },
      yAxis: {
        title: {
          text: 'Number of backers'
        },
        labels: {
          formatter: function() {
            return this.value;
          }
        }
      },
      tooltip: {
        pointFormat: '<b>{point.y:,.0f} people</b>'
      },
      plotOptions: {
        series: {
          pointStart: start_point,
          pointInterval: 24 * 3600 * 1000 // one day
        },
        area: {
          marker: {
            enabled: false,
            symbol: 'circle',
            radius: 2,
            states: {
              hover: {
                enabled: true
              }
            }
          }
        }
      },
      series: [{
        name: 'Brainwashing Machine',
        data: daily_data
      }]
    });
  });
});
    
