d3.chart('RtBaseChart').extend('RtBarChart', {
  initialize: function() {
    var chart;
    chart = this;
    this.w = this.base.attr('width');
    this.h = this.base.attr('height');
    this.x = d3.scale.ordinal().rangeRoundBands([0, this.w], .1);
    this.y = d3.scale.linear().range([this.h, 0]);
    this.base.classed('rt-bar-chart', true);
    this.layer('bars', this.base, {
      dataBind: function(data) {
        var max;
        chart.data = data;
        chart.x.domain(data.map(function(d) {
          return d.name;
        }));
        max = d3.max(data, function(d) {
          return d.value;
        });
        chart.y.domain([0, max]);
        return this.selectAll('rect').data(data);
      },
      insert: function() {
        return this.append('rect').attr('class', 'bar');
      },
      events: {
        merge: function() {
          return this.attr('x', function(d, i) {
            return chart.x(i);
          }).attr('y', function(d) {
            return chart.y(d.value);
          }).attr('height', function(d) {
            return chart.h - chart.y(d.value);
          }).attr('width', chart.x.rangeBand());
        }
      }
    });
    this.on('change:width', function(w) {
      return chart.x.rangeRoundBands([0, w], .1);
    });
    return this.on('change:height', function(h) {
      return chart.y.range([h, 0]);
    });
  }
});
