d3.chart('RtBaseChart').extend('RtBarChart', {
  initialize: function() {
    var chart;
    chart = this;
    this.w = this.base.attr('width');
    this.h = this.base.attr('height');
    this.categories = d3.scale.ordinal().rangeRoundBands([0, this.categoriesLength()], .1);
    this.bars = d3.scale.linear().range([this.barLength(), 0]);
    this.base.classed('rt-bar-chart', true);
    this.layer('bars', this.base, {
      dataBind: function(data) {
        var max;
        chart.data = data;
        chart.categories.domain(data.map(function(d) {
          return d.name;
        }));
        max = d3.max(data, function(d) {
          return d.value;
        });
        chart.bars.domain([0, max]);
        return this.selectAll('rect').data(data);
      },
      insert: function() {
        return this.append('rect').attr('class', 'bar');
      },
      events: {
        merge: function() {
          return chart.updateBar(this);
        }
      }
    });
    this.on('change:width', function(w) {
      return chart.rescale();
    });
    return this.on('change:height', function(h) {
      return chart.rescale();
    });
  },
  rescale: function() {
    this.w = this.base.attr('width');
    this.h = this.base.attr('height');
    this.categories.rangeRoundBands([0, this.categoriesLength()], .1);
    return this.bars.range([this.barLength(), 0]);
  },
  barLength: function() {
    return this.h;
  },
  categoriesLength: function() {
    return this.w;
  },
  updateBar: function(bar) {
    var _this = this;
    return bar.attr('x', function(d, i) {
      return _this.categories(i);
    }).attr('y', function(d) {
      return _this.bars(d.value);
    }).attr('height', function(d) {
      return _this.h - _this.bars(d.value);
    }).attr('width', this.categories.rangeBand());
  }
});

d3.chart('RtBarChart').extend('RtHorizontalBarChart', {
  initialize: function() {
    var chart;
    chart = this;
    return this.base.classed('rt-horizontal-bar-chart', true);
  },
  barLength: function() {
    return this.w;
  },
  categoriesLength: function() {
    return this.h;
  },
  updateBar: function(bar) {
    var _this = this;
    return bar.attr('x', 0).attr('y', function(d, i) {
      return _this.categories(i);
    }).attr('height', this.categories.rangeBand()).attr('width', function(d) {
      return _this.w - _this.bars(d.value);
    });
  }
});
