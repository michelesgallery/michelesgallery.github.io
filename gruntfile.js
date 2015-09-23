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
                        'img/featured-imgs/*.{jpg,gif,png}',
                        'img/needs-crops/*.{jpg,gif,png}',
                        'img/portfolio/**/*.{jpg,gif,png}',
                        'img/content/*.{jpg,gif,png}',
                    ],
                    cwd: '',
                    dest: 'img/crops/450x450/'
                }]
            },
            thumbs:{
                options: {
                    sizes: [{
                        width: 450,
                        height: 253,
                        aspectRatio: false,
                    }]
                },
                files: [{
                    expand: true,
                    flatten: true,
                    src: [
                        'img/featured-imgs/*.{jpg,gif,png}',
                        'img/needs-crops/*.{jpg,gif,png}',
                        'img/portfolio/**/*.{jpg,gif,png}',
                        'img/content/*.{jpg,gif,png}',
                    ],
                    cwd: '',
                    dest: 'img/crops/450x253/'
                }]
            }
        },

        imagemin: {
            gif: {
                files: [
                    {
                        expand: true,
                        cwd: '',
                        src: ['img/{,*/}{,*/}{,*/}*.gif'],
                        dest: 'media/compressed/',
                        flatten: true,
                        ext: '.gif'
                    }
                ]
            },
            png: {
                options: {
                    optimizationLevel: 5
                },
                files: [
                    {
                        expand: true,
                        cwd: '',
                        src: ['img/{,*/}{,*/}{,*/}*.png'],
                        dest: 'media/compressed/',
                        flatten: true,
                        ext: '.png'
                    }
                ]
            },
            jpg: {
                options: {
                    progressive: true
                },
                files: [
                    {
                        expand: true,
                        cwd: '',
                        src: ['img/{,*/}{,*/}{,*/}*.{jpg,jpeg}'],
                        dest: 'media/compressed/',
                        flatten: true,
                        ext: '.jpg'
                    }
                ]
            },
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
                    'js/build/main.min.js': ['js/*.js']
                }
            }
        },

        sass: {
            options: {
                outputStyle: 'compressed',
            },
            dist: {
                files: {
                    'css/main.css': 'sass/main.scss'
                }
            }
        },

        postcss: {
            options: {
                processors: [
                    require('autoprefixer-core')({browsers: '> 1%'}), // add vendor prefixes
                ]
            },
            dist: {
                files: {
                    'css/main.css': 'css/main.css'
                }
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

        copy: {
            css: {
                files: [
                    {
                        expand: true,
                        src: ['css/**'],
                        dest: 'jekyllbuild/'
                    },
                ]
            },
            js: {
                files: [
                    {
                        expand: true,
                        src: ['js/build/**'],
                        dest: 'jekyllbuild/'
                    },
                ]
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
                path: 'http://localhost:4000/',
                app: 'Firefox'
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
                tasks: ["uglify", "copy:js"]
            },
            jade: {
                files: ["{,*/}{,*/}{,*/}*.jade", "_layouts/jade/{,*/}*.html"],
                tasks: ["jade"]
            },
            css: {
                files: ["sass/{,*/}{,*/}{,*/}*.scss"],
                tasks: ["sass", "postcss", "copy:css"]
            },
            site: {
                files: ["{,*/}{,*/}{,*/}*.html", "{,*/}{,*/}{,*/}*.md", "{,*/}*.yml", "!jekyllbuild/**"],
                tasks: ["shell:jekyllBuild", "copy"]
            },
            images: {
                files: ["img/{,*/}{,*/}*.{png,jpg,gif}"],
                tasks: ["responsive_images", "newer:imagemin", "shell:jekyllBuild", "copy"]
            }
        }
    });


    require('load-grunt-tasks')(grunt);

    // Default task(s).
    grunt.registerTask("default", ["responsive_images", "newer:imagemin", "uglify", "sass", "postcss", "jade", "shell:jekyllBuild", "copy", "open", "watch"]);
    grunt.registerTask("serve", ["shell:jekyllServe"]);
    grunt.registerTask("build", ["responsive_images", "newer:imagemin", "uglify", "sass", "postcss", "jade", "shell:jekyllBuild", "copy"]);
    grunt.registerTask("deploy", ["minifyHtml", "buildcontrol:pages"]);
    grunt.registerTask("deploy-pretty", ["prettify", "buildcontrol:pages"]);
};
