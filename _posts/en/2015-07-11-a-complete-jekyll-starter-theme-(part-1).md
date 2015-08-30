---
date: 2015-07-11 01:57:00
title: A complete jekyll starter theme (part 1) ♦♦♦♦♦
name: Ekjst(1
subtitle: Intro, Prepping and Folder structure
tags: [jekyll, jekyll starter series, starter theme, sass, jade, tutorial, ♦♦♦♦♦ ]
description: in this series I document the creation of a jekyll starter theme.
category: en
---
I think I mentioned, that I am a big jekyll fan. I do like jekyll that much, because it offers so many opportunities to build stuff. But a lot of the things that can be done, are not obvious at first sight. Especially not if you start off with the `jekyll new` command.
In this series I want to write a jekyll starter theme. So basically a starting point that offers a lot of functionality and minimal style. I have been wanting to do this for a while now, because it will be easier to create themes with a starting point. So I thought, why not document it?

<!-- more -->

### 1. The Beginning

#### 1.1 Installation
Of course, before starting, you will need jekyll. I also use grunt on my pages because I can automate stuff with it, like optimizing images, javascript minification or deployment of the site (with plugins) on GitHub pages with just one command. And because I will be using jade on my templates, I also install node.

Oh and I'm on a Windows and jekyll runs perfectly. Version 3.0.0 of jekyll is at the time of writing in beta. I will use this version, but if you don't feel comfortable, you can also use the last stable version. It might be though, that some of the code will not work then, because there is a newer liquid version with 3.0.0.

So install: [jekyll](http://jekyllrb.com/docs/installation/), [grunt](http://gruntjs.com/getting-started) and [node](https://nodejs.org/).

#### 1.2 Git
I don't know about other people but I'm a big fan of free hosting. If you don't have a problem with your site being open source, I'd definitely recommend GitHub as hoster. GitHub Pages has an installation of jekyll, so you wouldn't need to compile yourself, but because I want the things I compile locally to look just the same live, so I will not use this version. Also I live to use some plugins. So what I do is push the source to a source branch and the generated site folder to either `master` or `gh-pages` branch.

If you don't have Git installed yet, you absolutely should get started with it ([click here to install](https://git-scm.com/)). GitHub offers some program for managing ([Win](https://windows.github.com/) &bull; [Mac](https://mac.github.com/)) and the [Brackets editor](http://brackets.io) offers a nice [Extension](https://github.com/zaggino/brackets-git), which is in use on my computer. But some things are just faster when done in the terminal (and that from me, I who declared war to the terminal a while back, but kinda surrendered a little bit to the commands).

#### 1.3 URL Situation
Before starting you should know your URL situation. If you are putting the site in a subfolder, you will need to use a variable from jekyll so that the links work. I will do that for this example, but if you set up a custom domain, you can just forget about it.

### 2 Set Up

#### 2.1 Git Initiation
After all of that is installed and you are ready, we can start. I start by creating a Git-Repo so that I can save all of my steps in the history.
Just create a new repo and get the URL. Default will be HTTPS, I use SSH because it just works better, especially with large commits. It does take a little more steps to configure though, but GitHub has some [nette Anleitung](https://help.github.com/articles/generating-ssh-keys/#platform-all) about how to get it up and running.

Okay, after you have that, create a new folder where you create the theme. Open the terminal and navigate into that folder. I just will write the terminal commands, because it's easier to write down, than having to use a ton of screenshots.

My folder is in a directory called GitLab (yes, my current playground for that project is on GitLab, because I can keep it private over there) 

So in the terminal I write the following:

```bash
cd documents/gitlab/jekyll-starter
git init
git remote add origin git@gitlab.com:myri/jekyll-starter.git
```

after origin you want to add your own clone URL and also use your folder structure to navigate

After that's done, you can start creating files.

#### 2.2 folder structure
jekyll has some folders and files that are required. I will follow that and add some screenshots, so you see all of the files I created for now.

!({{ site.img_dir}}/folder_structure_1.png)
![folder structure]({{ site.img_dir}}/folder_structure_2.png)
![folder structure]({{ site.img_dir}}/folder_structure_3.png)
![folder structure]({{ site.img_dir}}/folder_structure_4.png)
![folder structure]({{ site.img_dir}}/folder_structure_5.png)
![folder structure]({{ site.img_dir}}/folder_structure_6.png)
![folder structure]({{ site.img_dir}}/folder_structure_7.png)
![folder structure]({{ site.img_dir}}/folder_structure_8.png)

And with that I would like to finish up part one. In the next part, we will tackle the grunt file and fill up the first few files with content.

And whoever is a little bit paranoid, feel free to make a first commit to the Git repo.

```bash
git add -A
git commit -m "Ordnerstruktur erstellt!"
git push -u origin master
```