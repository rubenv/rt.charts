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
                chart.categories.domain(data.map((d) -> d.key))

                max = d3.max(data, (d) -> d.value)
                chart.bars.domain([0, max])

                return @selectAll('rect').data(data)

            insert: () ->
                return @append('rect')
                    .attr('class', 'bar')

            events:
                merge: () -> chart.updateBar(@)

        @on 'change:width', (w) -> chart.rescale()
        @on 'change:height', (h) -> chart.rescale()

    rescale: () ->
        @w = @base.attr('width')
        @h = @base.attr('height')

        @categories.rangeRoundBands([0, @categoriesLength()], .1)
        @bars.range([@barLength(), 0])

    barLength: () -> @h
    categoriesLength: () -> @w

    updateBar: (bar) ->
        bar.attr('x', (d, i) => @categories(i))
        .attr('y', (d) => @bars(d.value))
        .attr('height', (d) => @h - @bars(d.value))
        .attr('width', @categories.rangeBand())

d3.chart('RtBarChart').extend 'RtHorizontalBarChart',
    initialize: () ->
        chart = @

        @base.classed 'rt-horizontal-bar-chart', true

    barLength: () -> @w
    categoriesLength: () -> @h

    updateBar: (bar) ->
        bar.attr('x', 0)
        .attr('y', (d, i) => @categories(i))
        .attr('height', @categories.rangeBand())
        .attr('width', (d) => @w - @bars(d.value))
