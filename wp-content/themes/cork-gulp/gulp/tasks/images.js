var changed    = require('gulp-changed');
var gulp       = require('gulp');

gulp.task('images', function() {
	var dest = './dist/img';

	return gulp.src('./app/img/**/*')
		.pipe(changed(dest)) // Ignore unchanged files
		.pipe(gulp.dest(dest));
});