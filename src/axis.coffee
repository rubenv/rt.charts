d3.chart('RtContainerChart').extend 'RtAxisChart',
    initialize: () ->
        chart = @

        @base.classed 'rt-axis-chart', true

        chart1 = @addChart 'RtBarChart',
            w: (c) -> c.w / 2

        chart2 = @addChart 'RtHorizontalBarChart',
            y: (c) -> c.h / 2
            h: (c) -> c.h / 4
