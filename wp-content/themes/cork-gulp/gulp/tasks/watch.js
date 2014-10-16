var gulp       = require('gulp');
var livereload = require('gulp-livereload');

gulp.task('watch', function() {
	var server = livereload();

	var reload = function(file) {
		server.changed(file.path);
	};

	gulp.watch('app/js/**/*.js', ['browserify']);
	gulp.watch('app/scss/**/*', ['compass']);
	gulp.watch('app/img/**/*', ['images']);
	gulp.watch(['dist/**/*']).on('change', reload);
	gulp.watch(['**/*.php']).on('change', reload);
	gulp.watch(['**/*.html']).on('change', reload);
});