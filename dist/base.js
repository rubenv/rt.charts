d3.chart("RtAbstractChart", {}, {
  getterSetter: function(name, options) {
    var prop;
    if (options == null) {
      options = {};
    }
    if (options.setAttr == null) {
      options.setAttr = false;
    }
    if (options.redraw == null) {
      options.redraw = true;
    }
    prop = "_" + name;
    return function(newVal) {
      var oldVal;
      oldVal = this[prop];
      if (arguments.length === 0) {
        return oldVal;
      }
      this[prop] = newVal;
      if (newVal !== oldVal) {
        if (options.setAttr) {
          this.base.attr(name, newVal);
        }
      }
      this.trigger("change:" + name, newVal, oldVal);
      if (this.data && options.redraw) {
        this.draw(this.data);
      }
      return this;
    };
  }
});

d3.chart("RtAbstractChart").extend("RtBaseChart", {
  width: d3.chart('RtAbstractChart').getterSetter('width', {
    setAttr: true
  }),
  height: d3.chart('RtAbstractChart').getterSetter('height', {
    setAttr: true
  })
});
