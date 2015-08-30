---
date: 2015-06-29 22:02:53 +0200
title: Basic responsive menu (off-canvas with flexbox) ♦
name: BRM(mf
subtitle: pretty much the easiest 1-Level-Menu ever
tags: [tutorial, navigation,  sass, css, html, flexbox, ♦]
description: How to write a simple one level menu with flexbox
category: en
---
Menus. The first Menu I wrote was a list that was made looking like a navigation with CSS. I still use a lisst for a drop down menu. But since we are finally ready to use Flexbox, I have given up on lists and turned to a simpler markip. 
This navigation is written with flexbos and becomes off-canvas once it collapses.
<br>
<!-- more -->
<p data-height="266" data-theme-id="7132" data-slug-hash="dPNyMz" data-default-tab="result" data-user="mynimi" class='codepen'>See the Pen <a href='http://codepen.io/mynimi/pen/dPNyMz/'>responsive 1-Level Menu</a> by Myri (<a href='http://codepen.io/mynimi'>@mynimi</a>) on <a href='http://codepen.io'>CodePen</a>.</p>
<script async src="//assets.codepen.io/assets/embed/ei.js"></script>

I use [Font-Awesome](http://fontawesome.io/) and [jQuery](https://jquery.com/) here because I always have those in my projectrs. But you can create a menu like that, with CSS only. If you are interested in a tutorial, let me know.

### Markup
Since I use my menus in the header area that's what I did here as well, because I did not want my toggle link floating arount in the emptyness. There are two. One within the `nav` element, that I use to wrap the items and one within. They will toggle the off-canvas. So only used for that version.

And so that markup is written a little faster, I will use jade

```slim
header
    a.toggle-link(href='#menu')
        | <i class="fa fa-navicon"></i> Menu
    nav.main-menu#menu
        a.toggle-link(href='#menu')
            i.fa.fa-close
        each val in [1, 2, 3, 4, 5]
            a(href='index'+val+'.html')= 'Item ' + val
```

This will result in the following HTML

```html
<header>
    <a href="#menu" class="toggle-link">
        <i class="fa fa-navicon"></i> Menu
    </a>
    <nav id="menu" class="main-menu">
        <a href="#menu" class="toggle-link">
            <i class="fa fa-close"></i>
        </a>
        <a href="index1.html">Item 1</a>
        <a href="index2.html">Item 2</a>
        <a href="index3.html">Item 3</a>
        <a href="index4.html">Item 4</a>
        <a href="index5.html">Item 5</a>
  </nav>
</header>
```

### Styling
Styling is done with Flexbox. And Sass, because I will never write plain CSS again. Comments will explain a bit further.

```scss
// point at which menu turns to off-canvas
$menu_collapse: 500px;

// basic styling
body {
    font: {
        size: 22px;
        weight: 300;
        family: Roboto;
    }
    line-height: 1.8;
    color: #333;
}

header{
    width: 100%;
    position: relative;
    left: 0;
    top: 0;
    background: darken(white, 15%);
}
a {
    text-decoration: none;
    color: black;
    transition: .3s;
    &:hover {
        color: lighten(black, 50%);
    }
}

// menu style
.main-menu {
    display: flex;
    flex-wrap: wrap;
    align-items: center;
    
    // change the way links appear with flex-direction
    
    // on a horizontal line in non-collapsed way
    @media screen and (min-width: $menu_collapse) {
        flex-direction: row;
        justify-content: space-between;
        max-width: 800px;
        
        .toggle-link {
            display: none;
        }
    }
    
    // off-canvas look
    @media screen and (max-width: $menu_collapse) {
        // make links appear underneath each other
        flex-direction: column;
        justify-content: flex-start;
        
        // off-canvas style, closed
        background: darken(white, 10%);
        z-index: 100;
        width: 320px;
        min-height: 100%;
        position: fixed;
        top: 0;
        left: 0;
        transition: .3s all linear;
        box-sizing: border-box;
        padding: 10px;
        transform: translateX(-320px);
        
        // off-canvas, open
        &.active {
            transform: translateX(0px);
        }
        
        // position "x" in the upper right-hand corner
        .toggle-link {
            align-self: flex-end;
        }
    }
}

// make toggle links visible if off-canvas menu is to be displayed
header {
    .toggle-link {
        @media screen and (min-width: $menu_collapse) {
            display: none;
        }
    }
}
```

and that's what the styles look like after sass and autoprefixer did their work

``` css
.main-menu {
  display: -webkit-box;
  display: -webkit-flex;
  display: -ms-flexbox;
  display: flex;
  -webkit-flex-wrap: wrap;
      -ms-flex-wrap: wrap;
          flex-wrap: wrap;
  -webkit-box-align: center;
  -webkit-align-items: center;
      -ms-flex-align: center;
          align-items: center;
}
@media screen and (min-width: 500px) {
  .main-menu {
    -webkit-box-orient: horizontal;
    -webkit-box-direction: normal;
    -webkit-flex-direction: row;
        -ms-flex-direction: row;
            flex-direction: row;
    -webkit-box-pack: justify;
    -webkit-justify-content: space-between;
        -ms-flex-pack: justify;
            justify-content: space-between;
    max-width: 800px;
  }
  .main-menu .toggle-link {
    display: none;
  }
}
@media screen and (max-width: 500px) {
  .main-menu {
    -webkit-box-orient: vertical;
    -webkit-box-direction: normal;
    -webkit-flex-direction: column;
        -ms-flex-direction: column;
            flex-direction: column;
    -webkit-box-pack: start;
    -webkit-justify-content: flex-start;
        -ms-flex-pack: start;
            justify-content: flex-start;
    background: #e6e6e6;
    z-index: 100;
    width: 320px;
    min-height: 100%;
    position: fixed;
    top: 0;
    left: 0;
    -webkit-transition: .3s all linear;
            transition: .3s all linear;
    box-sizing: border-box;
    padding: 10px;
    -webkit-transform: translateX(-320px);
        -ms-transform: translateX(-320px);
            transform: translateX(-320px);
  }
  .main-menu.active {
    -webkit-transform: translateX(0px);
        -ms-transform: translateX(0px);
            transform: translateX(0px);
  }
  .main-menu .toggle-link {
    -webkit-align-self: flex-end;
        -ms-flex-item-align: end;
            align-self: flex-end;
  }
}

@media screen and (min-width: 500px) {
  header .toggle-link {
    display: none;
  }
}
```


### and a pinch of jQuery
For the off-canvas to function, we will write a click event, that triggers an active class to display the menu or hide it.

```js
$(document).ready(function () {
    $(".toggle-link").click(function () {
        $("#menu").toggleClass("active");
    });
});
```

and that's it. Super simple, really easy to customize.
