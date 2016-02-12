module.exports = function(grunt) {

    // Project configuration.
    grunt.initConfig({
        pkg: grunt.file.readJSON('package.json'),

        responsive_images: {
            square:{
                options: {
                    sizes: [{
                        width: 450,
                        height: 450,
                        aspectRatio: false,
                    }]
                },
                files: [{
                    expand: true,
                    flatten: true,
                    src: [
                        'media/compressed/needs-crops/*.{jpg,gif,png}'
                    ],
                    cwd: '',
                    dest: 'media/compressed/'
                }]
            },
            thumbs:{
                options: {
                    sizes: [{
                        width: 450
                    }]
                },
                files: [{
                    expand: true,
                    flatten: true,
                    src: [
                        'media/compressed/needs-crops/*.{jpg,gif,png}'
                    ],
                    cwd: '',
                    dest: 'media/compressed/'
                }]
            }
        },

        buildcontrol: {
            options: {
                dir: 'jekyllbuild',
                commit: true,
                push: true,
                message: 'Built site from commit %sourceCommit% on branch %sourceBranch%'
            },
            pages: {
                options: {
                    remote: 'git@github.com:michelesgallery/michelesgallery.github.io.git',
                    branch: 'master'
                }
            }
        },

        uglify: {
            options: {
                preserveComments: false,
            },
            dist: {
                files:{
                    'jekyllbuild/js/build/main.min.js': ['js/*.js']
                }
            }
        },

        sass: {
            options: {
                outputStyle: 'compressed',
            },
            main: {
                files: [{
                    expand: true,
                    cwd: 'sass',
                    src: ['*.scss'],
                    dest: 'jekyllbuild/css',
                    ext: '.css'
                }]
            }
        },

        postcss: {
            options: {
                processors: [
                    require('autoprefixer-core')({browsers: '> 1%'}), // add vendor prefixes
                ]
            },
            dist: {
                files: [{
                    expand: true,
                    cwd: '',
                    src: ['{,*/}{,*/}{,*/}{,*/}*.css'],
                    dest: '',
                    ext: '.css'
                }]
            }
        },

        jade: {
            compile: {
                options: {
                    pretty: true
                },
                files: [{
                    expand: true,
                    cwd: '',
                    src: [ '_layouts/jade/*.jade' ],
                    dest: '_layouts',
                    flatten: true,
                    ext: '.html'
                }]
            }
        },

        shell: {
            jekyllServe: {
                command: "jekyll serve --no-watch"
            },
            jekyllBuild: {
                command: "jekyll build"
            }
        },

        open : {
            build: {
                path: 'http://localhost:4000/'
            }
        },

        minifyHtml: {
            options: {
                cdata: true,
                removeComments: true,
            },
            dist: {
                files: [{
                    expand: true,
                    cwd: '',
                    src: ['jekyllbuild/{,*/}{,*/}{,*/}*.html'],
                    dest: '',
                    ext: '.html'
                }]
            }
        },

        prettify: {
            options: {
                indent: 4,
                brace_style: 'end-expand',
                unformatted: ['code', 'pre']
            },
            html: {
                files: [{
                    expand: true,
                    cwd: '',
                    src: ['jekyllbuild/{,*/}{,*/}{,*/}{,*/}*.html'],
                    dest: '',
                    ext: '.html'
                }]
            }
        },

        watch: {
            options: {
                livereload: true
            },
            scripts: {
                files: ['js/{,*/}*.js'],
                tasks: ["uglify"]
            },
            jade: {
                files: ["{,*/}{,*/}{,*/}*.jade", "_layouts/jade/{,*/}*.html", "demo/{,*/}*.jade", "!jekyllbuild/**"],
                tasks: ["jade"]
            },
            css: {
                files: ["sass/{,*/}{,*/}{,*/}*.scss"],
                tasks: ["sass", "postcss"]
            },
            img: {
                files: ["media/compressed/needs-crops/*.{jpg,gif,png}"],
                tasks: ["responsive_images", "shell:jekyllBuild"]
            },
            site: {
                files: ["{,*/}{,*/}{,*/}*.html", "{,*/}{,*/}{,*/}*.md", "{,*/}*.yml", "!jekyllbuild/**"],
                tasks: ["shell:jekyllBuild"]
            },
        }
    });


    require('load-grunt-tasks')(grunt);

    // Default task(s).
    grunt.registerTask("default", ["responsive_images", "uglify", "sass", "postcss", "jade", "shell:jekyllBuild", "open", "watch"]);
    grunt.registerTask("serve", ["shell:jekyllServe"]);
    grunt.registerTask("build", ["responsive_images", "uglify", "sass", "postcss", "jade", "shell:jekyllBuild"]);
    grunt.registerTask("post", ["responsive_images", "shell:jekyllBuild", "open", "watch"]);
    grunt.registerTask("deploy", ["minifyHtml", "buildcontrol:pages"]);
    grunt.registerTask("deploy-pretty", ["prettify", "buildcontrol:pages"]);
};
