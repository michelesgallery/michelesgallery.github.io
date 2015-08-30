---
date: 2015-07-07 07:40:04 +0200
title: Zwei Menus, eine responsive Off-Canvas Navigation ♦♦♦
name: ZMerON
subtitle: Zwei Menus in der Hauptansicht, die responsive zu einer Off-Canvas Navigation kombiniert werden
tags: [navigation, dropdown, responsive, sass, jade, jQuery, ♦♦♦]
description: Ein Tutorial, wie man zwei Menus schreibt, die responsive zu einem vereint werden
header-pic: Bubbly-Bloom_Pw.png
---
Dieses Menu entstand bei der Arbeit, als wir zwei klassische Menus und eine Off-Canvas Navigation unterbringen wollten, aber nur zwei Buttons zur Verfügung hatten. Die Idee war es dann, eines der beiden Menus in die Off-Canvas Navigation zu integrieren. Überraschenderweise, war das dann doch nicht so schnell gelöst, wie ich gehofft hatte, aber geschafft wurde es am Ende trotzdem. Hier findet ihr heraus, wie ich das angestellt habe.
<br>
<!-- more -->
<p data-height="266" data-theme-id="7132" data-slug-hash="oXqoJR" data-default-tab="result" data-user="mynimi" class='codepen'>See the Pen <a href='http://codepen.io/mynimi/pen/oXqoJR/'>Two Menus, One responsive Off-Canvas</a> by Myri (<a href='http://codepen.io/mynimi'>@mynimi</a>) on <a href='http://codepen.io'>CodePen</a>.</p>
<script async src="//assets.codepen.io/assets/embed/ei.js"></script>

### Markup
Wir beginnen mit dem allgemeinen Markup. Wie schon in einem anderen Tutorial erwähnt, werden meine Menus meist im Header platziert und das ist hier nicht anders. Dann haben wir einen gemeinsamen Container für beide Menus und dann jeweils einen einzelnen Container für jedes Menu, darin eine Liste. Da es sich um ein Drop-Down handelt.
Die Toggle-Links um das Off-Canvas zu öffnen, sowie die Pfeile für die Submenus, werden wir über jQuery hinzufügen.
Das Hauptmenu wollte ich rechtsbündig haben und den Toggle Button dann auf der linken Seite. Um das hinzubekommen, bekommt der Toggle-Link dann eine eigene Liste, die mit der Klasse `first` versehen wird. Das Menu bekommt demfall die Klasse `second`

Markup in Jade schaut so aus:

```slim
header
    .menu-container
        nav.off-canvas-menu 
            ul
                li
                    a(href="#") Tasum
                li
                    a(href="#") Aldpol
                    
                li.menu-item-has-children
                    a(href="#") Oughw
                    ul.sub-menu
                        li
                            a(href="#") Shyidra
                        li
                            a(href="#") Randel
                        li
                            a(href="#") Ia'usk
                    // /.sub-menu
                    
                li
                    a(href="#") Swaimim
            // /ul
        // /.off-canvas-menu
        
        nav.main-menu
            ul.second
                li
                    a(href="#") Smedgone
                li
                    a(href="#") Aotaliope
                    
                li.menu-item-has-children
                    a(href="#") Rothiope
                    ul.sub-menu
                        li
                            a(href="#") Delirious Lyric
                        li
                            a(href="#") Cleliopyte
                        li
                            a(href="#") Xioeleia
                    // /.sub-menu
                    
                li
                    a(href="#") Iorireto    
            // /ul
        // /.main-menu
    // /.menu-container
// /header
```

Und HTML für die, die es gerne wissen wollen:

```html
<header>
    <div class="menu-container">
        <nav class="off-canvas-menu">
            <ul>
                <li><a href="#">Tasum</a>
                </li>
                <li><a href="#">Aldpol</a>
                </li>
                <li class="menu-item-has-children"><a href="#">Oughw</a>
                    <ul class="sub-menu">
                        <li><a href="#">Shyidra</a>
                        </li>
                        <li><a href="#">Randel</a>
                        </li>
                        <li><a href="#">Ia'usk</a>
                        </li>
                    </ul>
                    <!-- /.sub-menu-->
                </li>
                <li><a href="#">Swaimim</a>
                </li>
            </ul>
            <!-- /ul-->
        </nav>
        <!-- /.off-canvas-menu-->
        <nav class="main-menu">
            <ul class="second">
                <li><a href="#">Smedgone</a>
                </li>
                <li><a href="#">Aotaliope</a>
                </li>
                <li class="menu-item-has-children"><a href="#">Rothiope</a>
                    <ul class="sub-menu">
                        <li><a href="#">Delirious Lyric</a>
                        </li>
                        <li><a href="#">Cleliopyte</a>
                        </li>
                        <li><a href="#">Xioeleia</a>
                        </li>
                    </ul>
                    <!-- /.sub-menu-->
                </li>
                <li><a href="#">Iorireto    </a>
                </li>
            </ul>
            <!-- /ul-->
        </nav>
        <!-- /.main-menu-->
    </div>
    <!-- /.menu-container-->
</header>
<!-- /header-->
```

### jQuery
Mit jQuery sorgen wir dafür, dass wir toggle links für die responsive Ansicht haben und die Sub-Menus öffnen können.
Also, integriert jQuery in eurem Projekt vor folgendem Script.

```js
$(document).ready(function() {
    
    // definiere Klassen für Toggle-Links
    var offCanvasToggle = 'toggle-link-off-canvas',
        mainToggle = 'toggle-link',
        close = 'toggle-link-close';

    /* 
     * füge Toggle Link zu Header container hinzu.
     * das wird der Toggle für das allgemeine Menu und ist erst
     * nach dem collapse sichtbar
     */
    $('header').prepend('<span class="toggle ' + mainToggle + '">Menu</span>');
    
    // schliessender toggle für das Menu in zusammengeklappter Form
    $('.menu-container').prepend('<span class="toggle ' + mainToggle + ' ' + close + '">close</span>');
    
    // schliessender und öffnender Link für das Off-Canvas Menu
    $('.off-canvas-menu').prepend('<span class="toggle ' + offCanvasToggle + ' ' + close + '">close</span>');
    $('.main-menu').prepend('<ul class="first"><li><span class="toggle ' + offCanvasToggle + '">Menu Off-Canvas</span></li></ul>');

    // Klick-Funktionen für jeden Toggle um eine "active" Klasse hinzuzufügen oder zu entfernen
    $('header .toggle-link').click(function() {
        $('.menu-container').toggleClass('active');
    });

    $('header .toggle-link-off-canvas').click(function() {
        $('.off-canvas-menu').toggleClass('active');
    });

    // Füge ein Element für den Sub-Menu Toggle-Pfeil hinzu.
    $('.menu-item-has-children > a').wrap('<span class="parent"></span>');
    $('.menu-container .parent').append('<span class="submenu-opener">open submenu</span>');

    // Klick-Funktion um das Sub-Menu zu öffnen
    $('.menu-container .submenu-opener').click(function() {
        $(this).toggleClass('sub-menu-is-open');
        $(this).parent().next('.sub-menu').slideToggle();
    });
    
});
```

Wenn das steht, können wir uns endlich an das Styling machen.

### Styling
Ich verwende wie immer Sass, um die Menus zu stylen. Für die Farben und Einstellungen, verwende ich Variabeln, ihr könnt also ganz einfach Farben ändern, wenn ihr es ausprobieren möchtet. Genauso, wie der Punkt an dem die beiden Menus eines werden.
Der Sub-Menu Toggle ist ein gleichseitiges Dreieck, das sich mit CSS machen lässt. Ich habe dafür eine Funktion und ein Mixin, weil ich immer wieder mal Dreiecke verwende.
Ausserdem verwende ich auch mal Flexbox, auch dafür gibt's ein Mixin.

Und jetzt wechsle ich einfach wieder in die Kommentare, weil's immer einfacher ist, wenn man Code und Kommentar zusammen hat, wenn ihr mich fragt.

```scss
// EINSTELLUNGEN
//---------------

// Helfer
//--------

// Farben
$pink: #E9B4B3;
$pale-pink: #F2E4E1;
$coal: #1D2426;
$teal: #35565D;
$grass: #8AB283;

// Shortcuts
$noborder: 0 solid transparent;

// Variablen
//-----------
$menu-collapse: 610px;
$a_color: $pale-pink;
$a_color_hover: $pink;
$header_bg: $grass;
$off-canvas_bg: $teal;
$main_menu_bg: $coal;


// FUNKTIONEN
//------------

// Quadratwurzel 
@function sqrt($r) {
    $x0: 1;
    $x1: $x0;
    @for $i from 1 through 10 {
        $x1: $x0 - ($x0 * $x0 - abs($r)) / (2 * $x0);
        $x0: $x1;
    }
    @return $x1;
}

// MIXINS
//--------

// Gleichseitiges Dreieck
@mixin triangle_eqla($sl, $dir, $c) {
    width: 0;
    height: 0;
    border-style: solid;
    
    @if $dir == right {
        border-color: transparent transparent transparent $c;
    }
    @if $dir == left {
        border-color: transparent $c transparent transparent;
    }
    @if $dir == bottom or $dir == down {
        border-color: $c transparent transparent transparent;
    }
    @if $dir == top or $dir == up {
        border-color: transparent transparent $c transparent;
    }
    @if $dir == right or $dir == left {
        border-width: ($sl/2) (sqrt(3)*($sl/2));
    }
    @if $dir == top or $dir == down or $dir == bottom or $dir == up {
        border-width: (sqrt(3)*($sl/2)) ($sl/2);
    }
}

// flexbox
@mixin flexbox($direction, $wrap, $justify, $align) {
    display: flex;
    flex-direction: $direction;
    flex-wrap: $wrap;
    justify-content: $justify;
    align-items: $align;
}

// STYLING
//---------

// Grundstyles
body {
    font: {
        size: 16px;
        weight: 400;
        family: Roboto;
    }
    line-height: 1.5;
}

a {
    color: $a_color;
    text-decoration: none;
    &:hover {
        color: $a_color_hover;
        cursor: pointer;
    }
}

// Haupt style
header {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    background: $header_bg;
    line-height: 2;
    
    // das zentriert den toggle link für das responsive Menu
    @media screen and (max-width: $menu-collapse){
        @include flexbox(row, wrap, center, center);
    }
        
    // toggle link styling
    .toggle {
        @extend a;
        padding: 6px;
    }
    
    .toggle-link-close {
        position: absolute;
        top: 0;
        right: 0;
    }
    
    // hier blende ich jeweils den nicht benötigten Toggle aus.
    .toggle-link {
        @media screen and (min-width: $menu-collapse + 1) {
            display: none;
        }
    }
    
    .toggle-link-off-canvas {
        @media screen and (max-width: $menu-collapse) {
            display: none;
        }
    }
}


// Menu container, die styles sind für die responsive verssion
.menu-container {
    @media screen and (max-width: $menu-collapse) {
        z-index: 100;
        position: fixed;
        top: 0;
        left: -300px;
        height: 100%;
        overflow-y: auto;
        background: $off-canvas_bg;
        width: 300px;
        box-sizing: border-box;
        transition: .3s all ease;
        transform: translate(0, 0);

        &.active {
            transform: translate(300px, 0);
        }
    }
    
    // sub menu werden gleich gestyled wie beim off-canvas menu
    .sub-menu {
        border-top: 1px solid rgba($coal, .5);
        border-bottom: 1px solid rgba($coal, .5);
        background: lighten($off-canvas_bg, 5%);
        display: none;
        
        li {
            a {
                box-sizing: border-box;
                @media screen and (max-width: $menu-collapse) {
                    padding-left: 25px;
                }
            }
        }
    }
    
    // klickbares dreieck, um das sub menu zu öffnen
    .parent {
        @include flexbox(row, wrap, flex-start, center);
        
        .submenu-opener {
            font-size: 0;
            position: relative;
            width: 20px;
            height: 20px;
            transition: .6s all ease;

            @media screen and (max-width: $menu-collapse) {
                margin-left: 20px;
            }

            @media screen and (min-width: $menu-collapse + 1) {
                margin-left: 5px;
            }
            
            &.sub-menu-is-open {
                transform: rotate(-180deg);
            }
            
            &:after {
                content: '';
                @include triangle_eqla(10px, down, $a_color);
                position: absolute;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -20%);
                transition: .3s all ease;
            }
            
            &:hover {
                cursor: pointer;
            
                &:after {
                    border-color: $a_color_hover transparent transparent transparent;
                }
            }
        }
    }
}

// off-canvas Navigation
.off-canvas-menu {
    line-height: 2.5;
    
    @media screen and (min-width: $menu-collapse + 1) {
        z-index: 100;
        position: fixed;
        top: 0;
        left: -300px;
        height: 100%;
        overflow-y: auto;
        background: $off-canvas_bg;
        width: 300px;
        box-sizing: border-box;
        transition: .3s all ease;
        transform: translate(0, 0);

        &.active {
            transform: translate(300px, 0);
        }        
    }
    
    a {
        padding: 0 10px;
    }
}

// main menu in voller und zugeklappter version
.main-menu {
    @media screen and (max-width: $menu-collapse) {
        border-top: 1px solid darken($off-canvas_bg, 5%);
        line-height: 2.5;

        a {
            padding: 0 10px;
        }
    }
    
    @media screen and (min-width: $menu-collapse + 1) {
        position: fixed;
        width: 100%;
        left: 0;
        right: 0;
        background: $main_menu_bg;
        @include flexbox(row, wrap, space-between, center);
       
        ul {
            @include flexbox(row, wrap, flex-start, center);
        
            li {
                padding: 10px;
            }
        }

        .sub-menu {
            top: 100%;
            position: absolute;
            background: lighten($main_menu_bg, 5%);
        }
    }    
}
```

Und CSS davon würde so aussehen

```css
body {
  font-size: 16px;
  font-weight: 400;
  font-family: Roboto;
  line-height: 1.5;
}

a, header .toggle {
  color: #F2E4E1;
  text-decoration: none;
}
a:hover, header .toggle:hover {
  color: #E9B4B3;
  cursor: pointer;
}

header {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  background: #8AB283;
  line-height: 2;
}
@media screen and (max-width: 610px) {
  header {
    display: -webkit-box;
    display: -webkit-flex;
    display: -ms-flexbox;
    display: flex;
    -webkit-box-orient: horizontal;
    -webkit-box-direction: normal;
    -webkit-flex-direction: row;
        -ms-flex-direction: row;
            flex-direction: row;
    -webkit-flex-wrap: wrap;
        -ms-flex-wrap: wrap;
            flex-wrap: wrap;
    -webkit-box-pack: center;
    -webkit-justify-content: center;
        -ms-flex-pack: center;
            justify-content: center;
    -webkit-box-align: center;
    -webkit-align-items: center;
        -ms-flex-align: center;
            align-items: center;
  }
}
header .toggle {
  padding: 6px;
}
header .toggle-link-close {
  position: absolute;
  top: 0;
  right: 0;
}
@media screen and (min-width: 611px) {
  header .toggle-link {
    display: none;
  }
}
@media screen and (max-width: 610px) {
  header .toggle-link-off-canvas {
    display: none;
  }
}

@media screen and (max-width: 610px) {
  .menu-container {
    z-index: 100;
    position: fixed;
    top: 0;
    left: -300px;
    height: 100%;
    overflow-y: auto;
    background: #35565D;
    width: 300px;
    box-sizing: border-box;
    -webkit-transition: .3s all ease;
            transition: .3s all ease;
    -webkit-transform: translate(0, 0);
        -ms-transform: translate(0, 0);
            transform: translate(0, 0);
  }
  .menu-container.active {
    -webkit-transform: translate(300px, 0);
        -ms-transform: translate(300px, 0);
            transform: translate(300px, 0);
  }
}
.menu-container .sub-menu {
  border-top: 1px solid rgba(29, 36, 38, 0.5);
  border-bottom: 1px solid rgba(29, 36, 38, 0.5);
  background: #3e656d;
  display: none;
}
.menu-container .sub-menu li a, .menu-container .sub-menu li header .toggle, header .menu-container .sub-menu li .toggle {
  box-sizing: border-box;
}
@media screen and (max-width: 610px) {
  .menu-container .sub-menu li a, .menu-container .sub-menu li header .toggle, header .menu-container .sub-menu li .toggle {
    padding-left: 25px;
  }
}
.menu-container .parent {
  display: -webkit-box;
  display: -webkit-flex;
  display: -ms-flexbox;
  display: flex;
  -webkit-box-orient: horizontal;
  -webkit-box-direction: normal;
  -webkit-flex-direction: row;
      -ms-flex-direction: row;
          flex-direction: row;
  -webkit-flex-wrap: wrap;
      -ms-flex-wrap: wrap;
          flex-wrap: wrap;
  -webkit-box-pack: start;
  -webkit-justify-content: flex-start;
      -ms-flex-pack: start;
          justify-content: flex-start;
  -webkit-box-align: center;
  -webkit-align-items: center;
      -ms-flex-align: center;
          align-items: center;
}
.menu-container .parent .submenu-opener {
  font-size: 0;
  position: relative;
  width: 20px;
  height: 20px;
  -webkit-transition: .6s all ease;
          transition: .6s all ease;
}
@media screen and (max-width: 610px) {
  .menu-container .parent .submenu-opener {
    margin-left: 20px;
  }
}
@media screen and (min-width: 611px) {
  .menu-container .parent .submenu-opener {
    margin-left: 5px;
  }
}
.menu-container .parent .submenu-opener.sub-menu-is-open {
  -webkit-transform: rotate(-180deg);
      -ms-transform: rotate(-180deg);
          transform: rotate(-180deg);
}
.menu-container .parent .submenu-opener:after {
  content: '';
  width: 0;
  height: 0;
  border-style: solid;
  border-color: #F2E4E1 transparent transparent transparent;
  border-width: 8.66025px 5px;
  position: absolute;
  top: 50%;
  left: 50%;
  -webkit-transform: translate(-50%, -20%);
      -ms-transform: translate(-50%, -20%);
          transform: translate(-50%, -20%);
  -webkit-transition: .3s all ease;
          transition: .3s all ease;
}
.menu-container .parent .submenu-opener:hover {
  cursor: pointer;
}
.menu-container .parent .submenu-opener:hover:after {
  border-color: #E9B4B3 transparent transparent transparent;
}

.off-canvas-menu {
  line-height: 2.5;
}
@media screen and (min-width: 611px) {
  .off-canvas-menu {
    z-index: 100;
    position: fixed;
    top: 0;
    left: -300px;
    height: 100%;
    overflow-y: auto;
    background: #35565D;
    width: 300px;
    box-sizing: border-box;
    -webkit-transition: .3s all ease;
            transition: .3s all ease;
    -webkit-transform: translate(0, 0);
        -ms-transform: translate(0, 0);
            transform: translate(0, 0);
  }
  .off-canvas-menu.active {
    -webkit-transform: translate(300px, 0);
        -ms-transform: translate(300px, 0);
            transform: translate(300px, 0);
  }
}
.off-canvas-menu a, .off-canvas-menu header .toggle, header .off-canvas-menu .toggle {
  padding: 0 10px;
}

@media screen and (max-width: 610px) {
  .main-menu {
    border-top: 1px solid #2c474d;
    line-height: 2.5;
  }
  .main-menu a, .main-menu header .toggle, header .main-menu .toggle {
    padding: 0 10px;
  }
}
@media screen and (min-width: 611px) {
  .main-menu {
    position: fixed;
    width: 100%;
    left: 0;
    right: 0;
    background: #1D2426;
    display: -webkit-box;
    display: -webkit-flex;
    display: -ms-flexbox;
    display: flex;
    -webkit-box-orient: horizontal;
    -webkit-box-direction: normal;
    -webkit-flex-direction: row;
        -ms-flex-direction: row;
            flex-direction: row;
    -webkit-flex-wrap: wrap;
        -ms-flex-wrap: wrap;
            flex-wrap: wrap;
    -webkit-box-pack: justify;
    -webkit-justify-content: space-between;
        -ms-flex-pack: justify;
            justify-content: space-between;
    -webkit-box-align: center;
    -webkit-align-items: center;
        -ms-flex-align: center;
            align-items: center;
  }
  .main-menu ul {
    display: -webkit-box;
    display: -webkit-flex;
    display: -ms-flexbox;
    display: flex;
    -webkit-box-orient: horizontal;
    -webkit-box-direction: normal;
    -webkit-flex-direction: row;
        -ms-flex-direction: row;
            flex-direction: row;
    -webkit-flex-wrap: wrap;
        -ms-flex-wrap: wrap;
            flex-wrap: wrap;
    -webkit-box-pack: start;
    -webkit-justify-content: flex-start;
        -ms-flex-pack: start;
            justify-content: flex-start;
    -webkit-box-align: center;
    -webkit-align-items: center;
        -ms-flex-align: center;
            align-items: center;
  }
  .main-menu ul li {
    padding: 10px;
  }
  .main-menu .sub-menu {
    top: 100%;
    position: absolute;
    background: #283234;
  }
}
```

Und das ist es dann auch schon.