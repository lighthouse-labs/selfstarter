$(function () {
  $('#container').highcharts({
    chart: {
      type: 'area'
    },
    title: {
      text: 'Timeline graph of backers'
    },
    xAxis: {
      type: 'date',
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
          return this.value / 1000 +'k';
        }
      }
    },
    tooltip: {
      pointFormat: '<b>{point.y:,.0f} people</b><br/>backed on {point.x}'
    },
    plotOptions: {
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
      name: 'Brainwash Machine',
      data: [
        { "x": 1325676960000,
          "y": 1005
        }, 
        {
          "x": 1325875140000,
          "y": 2033
                  /*null, null, null, null, null, 6 , 11, 32, 110, 235, 369, 640,
                                1005, 1436, 2063, 3057, 4618, 6444, 9822, 15468, 20434, 24126,
                                27387, 29459, 31056, 31982, 32040, 31233, 29224, 27342, 26662,
                                26956, 27912, 28999, 28965, 27826, 25579, 25722, 24826, 24605,
                                24304, 23464, 23708, 24099, 24357, 24237, 24401, 24344, 23586,
                                22380, 21004, 17287, 14747, 13076, 12555, 12144, 11009, 10950,
                                10871, 10824, 10577, 10527, 10475, 10421, 10358, 10295, 10104 */
        }
      ]
    }]
  });
});
    
