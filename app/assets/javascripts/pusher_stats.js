$(function() {
  Pusher.log = function(message) {
    if (window.console && window.console.log) {
      window.console.log(message);
    }
  };

  var pusher = new Pusher('70adc4de5349a31f06eb');
  var channel = pusher.subscribe('frontpage_stats');
  channel.bind('update_backers', function(data) {
    $('li#backers div.number').text(data.number);
    $('li#total div.amount').text(data.total);
    $('div#progress').css("width", data.percent);
  });
});