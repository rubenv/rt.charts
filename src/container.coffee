d3.chart('RtBaseChart').extend 'RtContainerChart',
    initialize: () ->
        @areas = []
        @on 'change:width', (w) => @rescale()
        @on 'change:height', (h) => @rescale()

    addChart: (chart, geometry = {}) ->
        # Default to covering the whole area
        geometry.x ?= 0
        geometry.y ?= 0
        geometry.w ?= (c) -> c.w
        geometry.h ?= (c) -> c.h

        el = @base.append('g')

        area =
            geometry: geometry
            element: el
            chart: @mixin(chart, el)
        @reposition(area)

        area.element.style("fill", "hsl(#{Math.random() * 360},100%,50%)")

        @areas.push(area)

        return area.chart

    reposition: (area) ->
        base =
            w: @base.attr('width')
            h: @base.attr('height')
        geom = area.geometry

        area.element
            .attr('transform', "translate(#{@value(geom.x, base)}, #{@value(geom.y, base)})")

        area.chart
            .width(@value(geom.w, base))
            .height(@value(geom.h, base))


    rescale: () ->
        @reposition(area) for area in @areas

    value: (def, args...) ->
        return if typeof def == 'function' then def.apply(@, args) else def
