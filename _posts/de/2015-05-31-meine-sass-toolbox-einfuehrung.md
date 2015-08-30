---
title: Meine Sass Toolbox ♦
subtitle: Einführung und main.scss
description: Eine Einführung in meine Sass Toolbox
tags: [tutorial, sass toolbox, sass, ♦]
name: sass-toolbox-1
---
Sass. Wer heute keinen Preprocessor benutzt, der hat noch nicht erkannt, dass CSS so viel mehr Spass machen kann.
Bevor ich Sass ansah, hatte ich das Gefühl, dass Sass absolut doof ist und viel zu viele Schritte erfordert, um aufzusetzen. Ausserdem wollte ich keine neue Syntax lernen.
Nun, eine neue Syntax war es nicht. Überhaupt, einmal installiert und dann konnte ich Sass schreiben und CSS folgte.
In dieser kleinen Serie möchte ich meine Toolbox vorstellen. Wie ich meine Sass Projekte strukturiere und ein paar kleine Code-Snippets, die mein Leben erleichtern.

<!-- more -->

## Wie aus meinem Sass CSS wird
Zu Beginn, wie wird aus meinem Sass CSS? Grundsätzlich habe ich zwei Wege, die ich verwende. Zum einen verwende ich Grunt zum anderen Prepros.

### Grunt
Grund ist ein Taskrunner. Sass lässt sich hier super integrieren. Ich verwende [grunt-sass](https://github.com/sindresorhus/grunt-sass) als task, weil dieser Task libSass verwendet. libSass ist viel schneller im compiling und darum natürlich erstrebenswerter. Ausserdem verwende ich auch den Autoprefixer task ([grunt-autoprefixer](https://github.com/nDmitry/grunt-autoprefixer)), den ich dann über's CSS laufen lasse, weil ich kein Fan von Mixins für Browser-Prefixe bin und keine Lust habe, selbst welche zu schreiben. Autoprefixer sorgt dafür, dass die Prefixe immer aktuell sind und ich muss mich nicht mehr darum kümmern.
Ein Gruntfile, das sich nur um meine CSS kümmert, würde dann so ausschauen (hier noch mit einem watch-task, damit die CSS immer up to date ist )

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
Ich bin auch immer für compressed beim Output, weil minifaction die Seiten schneller macht.
Die Grunt-Varsion meines Compilings verwende ich allerdings meist nur bei jekyll-Projekten, wenn ich mit WordPress oder Blogger oder kleinen statischen Seiten arbeite, dann verwende ich Prepros.

### Prepros
[Prepros](https://prepros.io/) ist ein App (nicht kostenlos, aber eine unlimitierte Trial-Zeit, ihr könnt euch also wirklich zuerst überzeugen, bevor ihr das Geld ausgebt), das einiges an Code compilen kann. Ich verwende Prepros auch für jade und die Zusammenstellung von javascript-files. Ausserdem kann man mit Prepros super einfach live preview haben und bei Geräten im gleichen Netzwerk auch mal auf dem Handy testen, was natürlich unglaublich praktisch ist.

Meine Einstellugnen bei Prepros unterscheiden sich kaum von denen mit Grunt:

![prepros einstellungen]({{ site.img_dir }}/prepros-settings.png)

Ich verwende keine SourceMaps, weil ich meist weiss, wie ich meine Einstellungen wiederfinde, ansonsten gibt es Ordner-weite Suchfunktionen. Bei Prepros gibt es im Moment allerdings ein kleines Problem mit ihnen, was bedeutet, dass man SourceMaps nicht in Kombination mit libSass verwenden kann und das heisst, dass es länger dauert. Also habe ich für mich entschieden, dass ich sie nicht verwenden will.


## Ordnerstruktur
Kommen wir zu meiner Ordnerstruktur. Ich habe verschiedene Posts gelesen, wie man Sass-Ordner strukturieren sollte und habe verschiedenes probiert und bin dann schlussendlich bei dem hier gelandet was eine Kombination aus verschiedenen Posts und Erfahrungen ist, die ich einem Jahr täglichen Sass-Gebrauch gesammelt habe.

```
│sass/
├── assets/
│   └── alle sass files, die ich nicht selbst geschrieben habe (z.B. fontawesome)
├── base/
│   ├── _reset.scss 
│   ├── _typography.scss
│   ├── _settings.scss
│   └── _base-style.scss
├── partials/
│   └── alle projekt partials
├── toolbox/
│   ├── _all.scss
│   ├── _colors.scss
│   ├── _functions.scss
│   └── _mixins.scss
└── main.scss
```

Den Assets-Ordner möchte ich in dieser Serie nicht besprechen und auch über partials möchte ich nicht gross sprechen, denn in diesem sind grundsätzlich bloss partials drin, die ich in mein main-file einbinde und drin passiert abgesehen von der Projektspezifischen Gestaltung nicht viel.

## main.scss
Das ist das Hauptfile. Hier binde ich alle partials ein, grundsätzlich ist dieses File so etwas wie ein Inhaltsverzeichnis für das komplette Stylesheet.

Meine Sass-Toolbox habe ich zusammen mit meinem jade-Starter in ein GitHub-Projekt gepackt. Wer sich also schon einen Blick darüber verschaffen will, kann es sich schon einmal beim [start-off](https://github.com/mynimi/start-off) ansehen.

Von dort zum Schluss nun auch noch mein main-File:

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