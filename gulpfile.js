var gulp = require('gulp');
var chug = require('gulp-chug');

gulp.task('default', function () {
    gulp.src(['./code/typo3conf/ext/*/gulpfile.js'])
        .pipe(chug());
});

gulp.task('deploy', function () {
    gulp.src(['./code/typo3conf/ext/*/gulpfile.js'])
        .pipe(chug({
            tasks: ['deploy']
        }));
});
