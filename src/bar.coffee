d3.chart('RtBaseChart').extend 'RtBarChart',
    initialize: () ->
        chart = @

        @w = @base.attr('width')
        @h = @base.attr('height')

        @categories = d3.scale.ordinal().rangeRoundBands([0, @categoriesLength()], .1)
        @bars = d3.scale.linear().range([@barLength(), 0])

        @base.classed 'rt-bar-chart', true

        @layer 'bars', @base,
            dataBind: (data) ->
                chart.data = data
                chart.categories.domain(data.map((d) -> d.name))

                max = d3.max(data, (d) -> d.value)
                chart.bars.domain([0, max])

                return @selectAll('rect').data(data)

            insert: () ->
                return @append('rect')
                    .attr('class', 'bar')

            events:
                merge: () ->
                    @attr('x', (d, i) -> chart.categories(i))
                    .attr('y', (d) -> chart.bars(d.value))
                    .attr('height', (d) -> chart.h - chart.bars(d.value))
                    .attr('width', chart.categories.rangeBand())

        @on 'change:width', (w) -> chart.rescale()
        @on 'change:height', (h) -> chart.rescale()

    rescale: () ->
        @w = @base.attr('width')
        @h = @base.attr('height')

        @categories.rangeRoundBands([0, @categoriesLength()], .1)
        @bars.range([@barLength(), 0])

    barLength: () -> @h
    categoriesLength: () -> @w

d3.chart('RtBarChart').extend 'RtHorizontalBarChart',
    initialize: () ->
        chart = @

        @base.classed 'rt-horizontal-bar-chart', true

        @layer('bars'). on 'merge', () ->
            @attr('x', 0)
            .attr('y', (d, i) -> chart.categories(i))
            .attr('height', chart.categories.rangeBand())
            .attr('width', (d) -> chart.w - chart.bars(d.value))

    barLength: () -> @w
    categoriesLength: () -> @h
