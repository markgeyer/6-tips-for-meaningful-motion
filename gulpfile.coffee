gulp = require 'gulp'
sass = require 'gulp-sass'
autoprefixer = require 'gulp-autoprefixer'
minify = require 'gulp-minify-css'
browserify = require 'gulp-browserify'
concat = require 'gulp-concat'
del = require 'del'
ghPages = require 'gulp-gh-pages'
browserSync = require 'browser-sync'
reload = browserSync.reload

paths =
  src: './src'
  output: './www'
  npm: './node_modules'
  assets: './assets'
  fonts: './assets/fonts'
  img: './assets/img'


gulp.task 'clean', (cb) ->
  del paths.output, cb


gulp.task 'deploy', ->
  gulp.src(paths.output)
    .pipe ghPages()


gulp.task 'index', ->
  gulp.src(paths.src + '/*.html')
    .pipe gulp.dest(paths.output)
    .pipe reload(stream: true)


gulp.task 'img', ->
  gulp.src(paths.img + '/**')
    .pipe gulp.dest(paths.output + '/img')
    .pipe reload(stream: true)


gulp.task 'styles', ->

  # reveal core
  gulp.src(paths.npm + '/reveal.js/css/reveal.css')
    .pipe minify(keepSpecialComments: 0)
    .pipe gulp.dest(paths.output + '/css')

  # reveal theme and misc
  gulp.src(paths.src + '/scss/*.scss')
    .pipe sass(errLogToConsole: true)
    .pipe autoprefixer()
    .pipe minify(keepSpecialComments: 0)
    .pipe gulp.dest(paths.output + '/css')
    .pipe reload(stream: true)

  # code highlighting
  gulp.src(paths.npm + '/reveal.js/lib/css/zenburn.css')
    .pipe minify(keepSpecialComments: 0)
    .pipe gulp.dest(paths.output + '/css')

  # pdf export styles
  gulp.src(paths.npm + '/reveal.js/css/print/pdf.css')
    .pipe minify(keepSpecialComments: 0)
    .pipe gulp.dest(paths.output + '/css')
  gulp.src(paths.npm + '/reveal.js/css/print/paper.css')
    .pipe minify(keepSpecialComments: 0)
    .pipe gulp.dest(paths.output + '/css')


gulp.task 'reveal', ->
  gulp.src(paths.npm + '/reveal.js/js/reveal.js')
    .pipe concat('reveal.js')
    .pipe gulp.dest(paths.output + '/js')


gulp.task 'reveal:plugins', ->

  # head
  gulp.src(paths.npm + '/reveal.js/lib/js/head.min.js')
    .pipe gulp.dest(paths.output + '/js')

  # classList
  gulp.src(paths.npm + '/reveal.js/lib/js/classList.js')
    .pipe gulp.dest(paths.output + '/js')

  # markdown
  gulp.src(paths.npm + '/reveal.js/plugin/markdown/marked.js')
    .pipe gulp.dest(paths.output + '/js')
  gulp.src(paths.npm + '/reveal.js/plugin/markdown/markdown.js')
    .pipe gulp.dest(paths.output + '/js')

  # highlight
  gulp.src(paths.npm + '/reveal.js/plugin/highlight/highlight.js')
    .pipe gulp.dest(paths.output + '/js')

  # zoom
  gulp.src(paths.npm + '/reveal.js/plugin/zoom-js/zoom.js')
    .pipe gulp.dest(paths.output + '/js')

  # notes
  gulp.src([
      paths.npm + '/reveal.js/plugin/notes/notes.js'
      paths.npm + '/reveal.js/plugin/notes/notes.html'
    ])
      .pipe gulp.dest(paths.output + '/js')

  # html5shiv
  gulp.src(paths.npm + '/reveal.js/lib/js/html5shiv.js')
    .pipe gulp.dest(paths.output + '/js')


gulp.task 'angular', ->
  gulp.src([
    paths.npm + '/angular/angular.min.js'
    paths.npm + '/angular-route/angular-route.min.js'
    paths.npm + '/angular-touch/angular-touch.min.js'
    paths.npm + '/angular-animate/angular-animate.min.js'
    paths.src + '/js/main.js'
  ])
    .pipe concat('angular.js')
    .pipe gulp.dest(paths.output + '/js')
    .pipe reload(stream: true)


gulp.task 'vendor', ->
  gulp.src([
    paths.npm + '/jquery/dist/jquery.min.js'
    paths.npm + '/fastclick/lib/fastclick.js'
  ])
    .pipe concat('vendor.js')
    .pipe gulp.dest(paths.output + '/js')


gulp.task 'browser-sync', ->
  browserSync server:
    baseDir: paths.output


gulp.task 'default', ['index', 'img', 'styles', 'reveal', 'reveal:plugins', 'angular', 'vendor', 'browser-sync'], ->
  gulp.watch paths.src + '/*.html', ['index']
  gulp.watch [paths.src + '/scss/*.scss', paths.src + '/scss/**/*.scss'], ['styles']
  gulp.watch paths.src + '/js/*.js', ['angular']
  gulp.src([
    paths.npm + '/angular-touch/angular-touch.min.js.map'
    paths.npm + '/angular-animate/angular-animate.min.js.map'
    paths.npm + '/jquery/dist/jquery.min.map'
  ])
    .pipe gulp.dest(paths.output + '/js')