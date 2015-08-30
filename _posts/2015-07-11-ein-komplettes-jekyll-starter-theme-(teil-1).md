---
date: 2015-07-11 01:57:00
title: Ein komplettes jekyll starter theme (Teil 1) ♦♦♦♦♦
subtitle: Intro, Vorbereitungen und Ordnerstruktur
tags: [jekyll, jekyll starter series, starter theme, sass, jade, tutorial, ♦♦♦♦♦ ]
description: In dieser Serie erkl&auml;re ich, wie ein komplettes jekyll starter theme entsteht.
header-pic: Bubbly-Bloom_Pw.png
site-title-display: false
---
Dass ich ein Fan von jekyll bin, habe ich wohl schon einige Male erwähnt. Ich bin ein Fan von jekyll, weil es so viele Möglichkeiten gibt. Doch viele erkennt man auf den ersten Blick gar nicht. Schon gar nicht, wenn man den Blog mit dem `jekyll new` command started.
In dieser Serie möchte ich ein Jekyll Starter Theme schreiben. Also ein Anfang, der Funktionalität und minimales Styling bietet. Ich wollte schon vor einer Weile einen Jekyll Starter für mich schreiben, damit ich Themes schneller beisammen habe. Und da dachte ich: Warum nicht dokumentieren?

<!-- more -->

## 1. Der Anfang

### 1.1 Installation
Bevor wir wirklich loslegen können, brauchen wir natürlich jekyll. Ich verwende für meine jekyll Seiten Grunt, weil ich damit noch einiges automatisieren kann. Zum Beispiel Bilder verkleinern, javascript minification oder liveSchaltung der Seite (mit Plugins) auf GitHub Pages mit nur einem Command. Da ich auch jade für meine Templates verwende, installiere ich ebenfalls nodejs.

Oh und ich bin auf einem Windows unterwegs und jekyll läuft. Version 3.0.0 von jekyll ist im Moment des Schreibens noch in der Beta, ich verwende diese Version, ihr könnt aber auch die aktuell stabile Version verwenden, womöglich funktioniert dann einiges vom Code nicht ganz identisch, weil 3.0.0 mit der neueren liquid-Version _geshipt_ wird.

Also installiert [jekyll](http://jekyllrb.com/docs/installation/), [grunt](http://gruntjs.com/getting-started) und [node](https://nodejs.org/). Dann könnt ihr loslegen.

### 1.2 Git
Ich weiss ja nicht, wie es mit anderen steht, aber ich bin immer ein grosser Fan von kostenlosem Hosting. Wenn ihr kein Problem damit habt, eure Seite Open Source zu haben, dann würde ich GitHub als Hoster verwenden. GitHub Pages hat jekyll installiert. Da ich allerdings immer das live haben will, was ich lokal sehen kann (also nicht auf eine alte Version zurückgehen will, oder mit einem syntax highlighter, den ich nicht mag, arbeiten möchte, oder auf Plugins verzichten will) pushe ich meinen Code auf einen `source` branch und verwende grunt um den generierten Ordner mit der statischen Seite, auf den `master` oder `gh-pages` branch zu pushen. Das läuft sehr gut.

Falls Git noch nicht installiert ist, solltet ihr das natürlich dann auch noch nachholen ([bitte hier klicken, zum installieren](https://git-scm.com/)). Wie ihr das managen wollt, ist euch überlassen. GitHub stellt Programme zu Verfügung ([Win](https://windows.github.com/) &bull; [Mac](https://mac.github.com/)), die das Terminal nicht verwenden und der [Brackets Editor](http://brackets.io), hat eine nette [Extension](https://github.com/zaggino/brackets-git), die ich auch verwende, aber gewisse Dinge, laufen über das Terminal einfach schneller (und das von mir, deklarierte Erzfeindin des Terminals, die in gewisser Weise aufgegeben hat zu kämpfen und sich den Commands gefügt hat).

### 1.3 URL Situation
Bevor ihr überhaupt mit der Seite anfangt, solltet ihr euch über die URL im Klaren sein, die die Seite am Ende haben wird, wenn sie live ist. Falls ihr in einem Sub-Folder arbeiten werdet, müsst ihr nämlich jeweils mit der `baseurl` Variable von jekyll arbeiten, bei eigenen Domains könnt ihr das lassen.
Für dieses Beispiel werde ich mit Base-URL arbeiten, da es einfacher ist.

## 2 Set Up

### 2.1 Git Initiation
Nachdem alles installiert ist, kann es losgehen. Ich starte meist gleich mit einem Git-Repo, weil ich dann alle Schritte mal zwischenspeichern kann.
Dafür erstellt ihr ein neues Repo auf GitHub und kopiert die URL. Default ist hier HTTPS, ich verwende SSH, weil das erfahrungsgemäss einfach besser läuft, vor allem wenn man relativ grosse Commits hochladen will, man braucht allerdings etwas mehr Config, also SSH key generieren und hinterlegen (dafür hat GitHub eine [nette Anleitung](https://help.github.com/articles/generating-ssh-keys/#platform-all))

Okay, nachdem ihr die URL habt, erstellt ihr einen neuen Ordner wo das Theme reinkommt und öffnet das Terminal an dieser Stelle. Ich werd jetzt einfach jeweils Terminal-Commands angeben. Für die ganzen anderen Tools gibt es sicher auch Anleitungen, aber das ist vor allem schneller erklärt und notiert, weil wir dann mit weniger Screenshots auskommen.

Mein Ordner ist in einem Ordner den ich GitLab nenne (mein Arbeitsrepo für das Starter-Theme liegt dort, weil ich es dort privat machen kann und rumspinnen so viel ich will, ehe ich mich auf etwas festlege) und darin dann jekyll-starter. So habe ich auch das Repo genannt.

Im Terminal (auf Windows wäre das dann Git Bash) gebe ich also folgendes ein:

```bash
cd documents/gitlab/jekyll-starter
git init
git remote add origin git@gitlab.com:myri/jekyll-starter.git
```

nach origin folgt die clone URL.

Wenn das steht, ist mein Repo bereit und es kann mit der Ordner-Struktur begonnen werden.

### 2.2 Ordnerstruktur
Jekyll hat eine festgelegte Ordnerstruktur, die ich im Grunde befolgen werde.

Hier ein paar Screenshots, wie diese nach dem ersten Schritt aussieht.

![ordner struktur]({{ site.img_dir}}/folder_structure_1.png)
![ordner struktur]({{ site.img_dir}}/folder_structure_2.png)
![ordner struktur]({{ site.img_dir}}/folder_structure_3.png)
![ordner struktur]({{ site.img_dir}}/folder_structure_4.png)
![ordner struktur]({{ site.img_dir}}/folder_structure_5.png)
![ordner struktur]({{ site.img_dir}}/folder_structure_6.png)
![ordner struktur]({{ site.img_dir}}/folder_structure_7.png)
![ordner struktur]({{ site.img_dir}}/folder_structure_8.png)

Und damit ist Teil 1 komplett. Im nächsten Teil machen wir uns an die Vorbereitung des Grunt-Files und an die Füllung dieser bisher leeren Dateien, die wir erstellt haben.

Und wer paranoid ist, darf gerne auch schon den ersten commit machen.

```bash
git add -A
git commit -m "Ordnerstruktur erstellt!"
git push -u origin master
```