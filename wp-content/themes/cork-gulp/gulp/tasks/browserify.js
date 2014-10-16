var browserify = require('gulp-browserify');
var gulp         = require('gulp');
var handleErrors = require('../util/handleErrors');

gulp.task('browserify', ['browserify-header', 'browserify-global']);

gulp.task('browserify-header', function(){

	return gulp.src(['app/js/header.js'])
        .pipe(browserify())
        .on('error', handleErrors)
        .pipe(gulp.dest('./dist/js'))
});

gulp.task('browserify-global', function(){

	return gulp.src(['app/js/global.js'])
        .pipe(browserify())
        .on('error', handleErrors)
        .pipe(gulp.dest('./dist/js'))
});