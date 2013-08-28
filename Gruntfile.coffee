mountFolder = (connect, dir) ->
    return connect.static(require('path').resolve(dir))

module.exports = (grunt) ->
    @loadNpmTasks('grunt-contrib-clean')
    @loadNpmTasks('grunt-contrib-coffee')
    @loadNpmTasks('grunt-contrib-connect')
    @loadNpmTasks('grunt-contrib-watch')
    @loadNpmTasks('grunt-open')

    config =
        out: 'dist'
        src: 'src'
        previewPort: 9001

    @initConfig
        config: config

        clean:
            dist: [config.out]

        watch:
            options:
                livereload: true
            exapmles:
                files: ['examples/*.html']
                tasks: [] # Simply trigger livereload
            coffee:
                files: ['<%= config.src %>/*{,/*}.coffee']
                tasks: ['coffee:dist']

        coffee:
            options:
                bare: true
            dist:
                expand: true
                cwd: '<%= config.src %>'
                src: ['**/*.coffee']
                dest: '<%= config.out %>'
                ext: '.js'

        connect:
            livereload:
                options:
                    port: config.previewPort
                    hostname: '0.0.0.0'
                    middleware: (connect) ->
                        return [
                            require('connect-livereload')()
                            mountFolder(connect, '.')
                        ]

        open:
            server:
                url: 'http://localhost:<%= config.previewPort %>/examples/index.html'

    @registerTask 'build', [
        'clean'
        'coffee'
    ]

    @registerTask 'server', [
        'build'
        'connect'
        'open'
        'watch'
    ]

    @registerTask 'default', ['build']
