#global module:false

"use strict"

module.exports = (grunt) ->
  grunt.loadNpmTasks "grunt-bower-task"
  grunt.loadNpmTasks "grunt-contrib-connect"
  grunt.loadNpmTasks "grunt-contrib-copy"
  grunt.loadNpmTasks "grunt-contrib-watch"
  grunt.loadNpmTasks "grunt-exec"
  grunt.loadNpmTasks 'grunt-contrib-less'

  grunt.initConfig
    less:
      startbootstrap:
        files:
          "vendor/css/agency.css": "vendor/less/agency.less"
    copy:
      startbootstrap:
        files: [{
          expand: true
          cwd: "bower_components/startbootstrap-agency/"
          src: ['css/**', 'font-awesome/**', 'fonts/**/*', 'img/**', 'js/**', 'less/**']
          dest: "vendor/"
        }]

    exec:
      jekyll:
        cmd: "jekyll build --trace"

    watch:
      options:
        livereload: true
      source:
        files: [
          "_drafts/**/*"
          "_includes/**/*"
          "_layouts/**/*"
          "_posts/**/*"
          "css/**/*"
          "js/**/*"
          "_config.yml"
          "*.html"
          "*.md"
        ]
        tasks: [
          "exec:jekyll"
        ]
      less:
          files: ["vendor/less/*.less"]
          tasks: ["less", "exec:jekyll"]

    connect:
      server:
        options:
          port: 4000
          base: '_site'
          livereload: true

  grunt.registerTask "import", [
    "copy"
  ]
  grunt.registerTask "build", [
    "less"
    "exec:jekyll"
  ]

  grunt.registerTask "serve", [
    "build"
    "connect:server"
    "watch"
  ]

  grunt.registerTask "default", [
    "serve"
  ]