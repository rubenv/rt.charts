d3.chart('RtBaseChart').extend('RtAxisChart', {
  initialize: function() {
    var chart,
      _this = this;
    chart = this;
    this.base.classed('rt-axis-chart', true);
    this.on('change:width', function(w) {
      return _this.draw();
    });
    return this.on('change:height', function(h) {
      return _this.draw();
    });
  },
  draw: function() {
    if (!this.scale()) {
      return;
    }
    if (!this.axis) {
      this.axis = d3.svg.axis().scale(this.scale()).orient(this.orient() || 'left').ticks(this.ticks() || 5);
    }
    return this.base.call(this.axis);
  },
  scale: d3.chart('RtAbstractChart').getterSetter('scale'),
  orient: d3.chart('RtAbstractChart').getterSetter('orient'),
  ticks: d3.chart('RtAbstractChart').getterSetter('ticks')
});

d3.chart('RtContainerChart').extend('RtBarAxisChart', {
  initialize: function() {
    var axisChart, axisMargin, barChart, vPadding;
    this.base.classed('rt-bar-axis-chart', true);
    axisMargin = 30;
    vPadding = 10;
    barChart = this.addChart('RtBarChart', {
      x: function(c) {
        return axisMargin;
      },
      y: vPadding,
      w: function(c) {
        return c.w - axisMargin;
      },
      h: function(c) {
        return c.h - 2 * vPadding;
      }
    });
    this.addChart('RtHorizontalBarChart', {
      x: function(c) {
        return axisMargin;
      },
      y: vPadding,
      w: function(c) {
        return (c.w - axisMargin) / 2;
      },
      h: function(c) {
        return (c.h - 2 * vPadding) / 2;
      }
    });
    axisChart = this.addChart('RtAxisChart', {
      y: vPadding,
      x: axisMargin,
      w: axisMargin,
      h: function(c) {
        return c.h - 2 * vPadding;
      }
    });
    return axisChart.scale(barChart.bars).orient('left').ticks(6);
  }
});
