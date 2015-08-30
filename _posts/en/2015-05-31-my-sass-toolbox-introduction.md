---
title: My Sass Toolbox ♦
subtitle: Introduction and main.scss
description: An introduction into my sass toolbox and file structure
tags: [tutorial, sass toolbox, sass, ♦]
name: sass-toolbox-1
category: en
---
Sass. Who doesn't use a preprocessor nowadays has yet to realize how much more fun CSS can be.
Before I had a real look at Sass, I thought that preprocessors were hard and annoying and took a lot of steps to get to the actual final CSS. Also I did not want to learn a new syntax.
Well it wasn't a new syntax. Also as soon as you had Sass installed it was super easy to get my Sass into CSS.
In this little series I want to talk about the Setup I use for my Sass to get to the CSS I use.
<!-- more -->

## How my Sass becomes CSS
To start with, what makes my CSS? I have two different ways that I tend to use. The first is grunt, the other is prepros.

### Grunt
Grunt is a Taskrunner. Sass is very simple to integrate. I use the [grunt-sass](https://github.com/sindresorhus/grunt-sass) task, because it uses libSass. libSass is much faster at compiling and that's always a plus. And of course I combine Sass with Autoprefixer([grunt-autoprefixer](https://github.com/nDmitry/grunt-autoprefixer)) because Autoprefixer is life. I'm not a fan of using mixins for prefixes and definitely not a fan of writing them myself, so Autoprefixer takes care of them and makes sure that my CSS is always up to date.
A gruntfile that takes care of my CSS might look something like this (also using watch here, because why wouldn't you)

```js
module.exports = function(grunt) {

    // Project configuration.
    grunt.initConfig({
        pkg: grunt.file.readJSON('package.json'),

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

        autoprefixer: {
            global: {
                src: 'css/main.css',
                dest: 'css/main.css'
            }
        },
        watch: {
            css: {
                files: ["sass/{,*/}{,*/}{,*/}*.scss"],
                tasks: ["sass", "autoprefixer"]
            },
        }
    });


    require('load-grunt-tasks')(grunt);
 
    // Default task(s).
    grunt.registerTask("default", ["sass", "autoprefixer", "watch"]);
};
```
I'm always using compressed as my prefered output because minification makes a site faster.
The grunt-version is what I use whenever I have a jekyll project or some other project that requires grunt. For things like WordPress, blogger or simple static sites, I will almost always use Prepros.

### Prepros
[Prepros](https://prepros.io/) is an app (not free, but with unlimited trial time so you can test extensively, before buying anything) which can compile a lot of different languages (less and stylus, if you use one of these as well as jade or coffeescript) I use it on my jade and to concatenate my javascript files as well as my Sass, of course. Also Prepros makes it extremely easy to have live preview and you can test on other devices within your network as well.

My settings on Prepros are the same as within grunt.

![prepros einstellungen]({{ site.img_dir }}/prepros-settings.png)

I don't use SourceMaps mostly because I am able to find my settings and there is a little problem with Prepros to have libSass and SourceMaps together. And I prefer libSass to Sourcemaps, so I will go without them.

## Directory Structure
Let's talk about my sass folder structure. I have read different posts on how structuring your sass project the best way and have gathered a lot of experience on what works and what does not for me within the last year, since I've used it probably every single day. So this is what I have come up with.

```
│sass/
├── assets/
│   └── all Sass files, that I did not write myself (e.g. fontawesome)
├── base/
│   ├── _reset.scss 
│   ├── _typography.scss
│   ├── _settings.scss
│   └── _base-style.scss
├── partials/
│   └── all project partials
├── toolbox/
│   ├── _all.scss
│   ├── _colors.scss
│   ├── _functions.scss
│   └── _mixins.scss
└── main.scss
```

I don't want to talk too much about my assets and partials folders, since they change for every project and are not that interesting. 

## main.scss
That's the main file - obviously. This is where I do all of the imports so it's basically a table of contents for the stylesheet. 

I have my whole Sass-Toolbox uploaded on my gitHub together with my jade starter. So if you want to have a look at it, check out the link: [start-off](https://github.com/mynimi/start-off).

Also taken from there the example main file to finish this post

```scss
@import "toolbox/all";
@import "base/settings";
@import "base/typography";

@import "assets/font-awesome";

@import "base/reset";
@import "base/base-style";

@import "partials/general";

@import "partials/tobetakencareof";
```