d3.chart('RtBaseChart').extend 'RtAxisChart',
    initialize: () ->
        chart = @

        @base.classed 'rt-axis-chart', true
        @on 'change:width', (w) => @draw()
        @on 'change:height', (h) => @draw()

    draw: () ->
        return if !@scale()
        if !@axis
            @axis = d3.svg.axis()
                .scale(@scale())
                .orient(@orient() || 'left')
                .ticks(@ticks() || 5)

        @base.call(@axis)

    scale: d3.chart('RtAbstractChart').getterSetter('scale')
    orient: d3.chart('RtAbstractChart').getterSetter('orient')
    ticks: d3.chart('RtAbstractChart').getterSetter('ticks')

d3.chart('RtContainerChart').extend 'RtBarAxisChart',
    initialize: () ->
        @base.classed 'rt-bar-axis-chart', true

        axisMargin = 30
        vPadding = 10

        barChart = @addChart 'RtBarChart',
            x: (c) -> axisMargin
            y: vPadding
            w: (c) -> c.w - axisMargin
            h: (c) -> c.h - 2 * vPadding

        @addChart 'RtHorizontalBarChart',
            x: (c) -> axisMargin
            y: vPadding
            w: (c) -> (c.w - axisMargin) / 2
            h: (c) -> (c.h - 2 * vPadding) / 2

        axisChart = @addChart 'RtAxisChart',
            y: vPadding
            x: axisMargin
            w: axisMargin
            h: (c) -> c.h - 2 * vPadding

        axisChart.scale(barChart.bars)
            .orient('left')
            .ticks(6)
