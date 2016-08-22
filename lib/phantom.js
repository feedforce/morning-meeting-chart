var system = require('system');
var page = require('webpage').create();

page.viewportSize = {
  width:  1920,
  height: 1080
};

page.open(system.args[1], function() {
  setTimeout(function() {
    var js = page.evaluate(function () {
      return document.getElementById('highcharts-0').innerHTML;
    });

    console.log(js);
    phantom.exit();
  }, 1000);
});
