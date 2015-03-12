var gulp = require('gulp');
var chug = require('gulp-chug');

gulp.task('default', function () {
    gulp.src(['./htdocs/typo3conf/ext/*/gulpfile.js'])
        .pipe(chug());
});

gulp.task('deploy', function () {
    gulp.src(['./htdocs/typo3conf/ext/*/gulpfile.js'])
        .pipe(chug({
            tasks: ['deploy']
        }));
});
