d3.chart('RtBaseChart').extend 'RtBarChart',
    initialize: () ->
        chart = @

        @w = @base.attr('width')
        @h = @base.attr('height')

        @x = d3.scale.ordinal().rangeRoundBands([0, @w], .1)
        @y = d3.scale.linear().range([@h, 0])

        @base.classed 'rt-bar-chart', true

        @layer 'bars', @base,
            dataBind: (data) ->
                chart.data = data
                chart.x.domain(data.map((d) -> d.name))

                max = d3.max(data, (d) -> d.value)
                chart.y.domain([0, max])

                return @selectAll('rect').data(data)

            insert: () ->
                return @append('rect')
                    .attr('class', 'bar')

            events:
                merge: () ->
                    @attr('x', (d, i) -> chart.x(i))
                    .attr('y', (d) -> chart.y(d.value))
                    .attr('height', (d) -> chart.h - chart.y(d.value))
                    .attr('width', chart.x.rangeBand())

        @on 'change:width', (w) -> chart.x.rangeRoundBands([0, w], .1)
        @on 'change:height', (h) -> chart.y.range([h, 0])
