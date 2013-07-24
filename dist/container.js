var __slice = [].slice;

d3.chart('RtBaseChart').extend('RtContainerChart', {
  initialize: function() {
    var _this = this;
    this.areas = [];
    this.on('change:width', function(w) {
      return _this.rescale();
    });
    return this.on('change:height', function(h) {
      return _this.rescale();
    });
  },
  addChart: function(chart, geometry) {
    var area, el;
    if (geometry == null) {
      geometry = {};
    }
    if (geometry.x == null) {
      geometry.x = 0;
    }
    if (geometry.y == null) {
      geometry.y = 0;
    }
    if (geometry.w == null) {
      geometry.w = function(c) {
        return c.w;
      };
    }
    if (geometry.h == null) {
      geometry.h = function(c) {
        return c.h;
      };
    }
    el = this.base.append('g');
    area = {
      geometry: geometry,
      element: el,
      chart: this.mixin(chart, el)
    };
    this.reposition(area);
    area.element.style("fill", "hsl(" + (Math.random() * 360) + ",100%,50%)");
    this.areas.push(area);
    return area.chart;
  },
  reposition: function(area) {
    var base, geom;
    base = {
      w: this.base.attr('width'),
      h: this.base.attr('height')
    };
    geom = area.geometry;
    area.element.attr('transform', "translate(" + (this.value(geom.x, base)) + ", " + (this.value(geom.y, base)) + ")");
    return area.chart.width(this.value(geom.w, base)).height(this.value(geom.h, base));
  },
  rescale: function() {
    var area, _i, _len, _ref, _results;
    _ref = this.areas;
    _results = [];
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      area = _ref[_i];
      _results.push(this.reposition(area));
    }
    return _results;
  },
  value: function() {
    var args, def;
    def = arguments[0], args = 2 <= arguments.length ? __slice.call(arguments, 1) : [];
    if (typeof def === 'function') {
      return def.apply(this, args);
    } else {
      return def;
    }
  }
});
