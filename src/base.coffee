d3.chart "RtAbstractChart", {},
    getterSetter: (name, options = {}) ->
        options.setAttr ?= false # Don't set attribute by default
        options.redraw ?= true # Redraw by default

        prop = "_#{name}"

        return (newVal) ->
            oldVal = @[prop]
            return oldVal if arguments.length == 0 # No arguments -> getter

            @[prop] = newVal
            if newVal != oldVal
                @base.attr(name, newVal) if options.setAttr

            @trigger("change:#{name}", newVal, oldVal)

            if @data && options.redraw
                @draw(@data)

            return @ # Allows chaining

d3.chart("RtAbstractChart").extend "RtBaseChart",
    width: d3.chart('RtAbstractChart').getterSetter('width', { setAttr: true })
    height: d3.chart('RtAbstractChart').getterSetter('height', { setAttr: true })
