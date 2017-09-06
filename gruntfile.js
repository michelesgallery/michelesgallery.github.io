module.exports = function(grunt) {

    // Project configuration.
    grunt.initConfig({
        pkg: grunt.file.readJSON('package.json'),

        responsive_images: {
            thumbs: {
                options: {
                    sizes: [{
                        width: 450,
                    }]
                },
                files: [{
                    expand: true,
                    src: ['**/*.{jpg,gif,png}'],
                    cwd: 'media/compressed/',
                    custom_dest: 'media/compressed/crops/'
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
                outputStyle: 'compressed'
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
                    require('autoprefixer')({browsers: '> 1%'})
                ]
            },
            dist: {
                src: 'jekyllbuild/css/*.css'
            }
        },

        pug: {
            compile: {
                options: {
                    pretty: true
                },
                files: [{
                    expand: true,
                    cwd: '',
                    src: [ '_layouts/pug/*.pug' ],
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
            pug: {
                files: ["{,*/}{,*/}{,*/}*.pug", "_layouts/pug/{,*/}*.html", "demo/{,*/}*.pug", "!jekyllbuild/**"],
                tasks: ["pug"]
            },
            css: {
                files: ["sass/{,*/}{,*/}{,*/}*.scss"],
                tasks: ["sass", "postcss"]
            },
            img: {
                files: ["media/compressed/{,*/}*.{jpg,gif,png}"],
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
    grunt.registerTask("default", ["responsive_images", "uglify", "sass", "postcss", "pug", "shell:jekyllBuild", "open", "watch"]);
    grunt.registerTask("serve", ["shell:jekyllServe"]);
    grunt.registerTask("build", ["uglify", "sass", "postcss", "pug", "shell:jekyllBuild"]);
    grunt.registerTask("post", ["responsive_images", "shell:jekyllBuild", "open", "watch"]);
    grunt.registerTask("deploy", ["minifyHtml", "buildcontrol:pages"]);
    grunt.registerTask("deploy-pretty", ["prettify", "buildcontrol:pages"]);
};
