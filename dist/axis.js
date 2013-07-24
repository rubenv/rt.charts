d3.chart('RtContainerChart').extend('RtAxisChart', {
  initialize: function() {
    var chart, chart1, chart2;
    chart = this;
    this.base.classed('rt-axis-chart', true);
    chart1 = this.addChart('RtBarChart', {
      w: function(c) {
        return c.w / 2;
      }
    });
    return chart2 = this.addChart('RtHorizontalBarChart', {
      y: function(c) {
        return c.h / 2;
      },
      h: function(c) {
        return c.h / 4;
      }
    });
  }
});
