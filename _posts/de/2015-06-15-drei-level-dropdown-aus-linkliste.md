---
date: 2015-06-15 17:11:12 +0200
title: Responsive Blogger Menus&colon; 3-Level Dropdown aus Liste ♦♦
name: RBM3DaL
subtitle: Ein Dropdown Menu ohne Coding-Kenntnisse
tags: [dropdown, blogger, navigation, tutorial, ♦♦, javascript, jquery]
description: Wie man aus einer Linkliste ein 3-Level-Dropdown Menu in Blogger generieren kann.
---
Als ich begonnen habe, responsive Websites zu bauen, war die Navigation immer das, was mir am meisten Probleme bereitet hat. Aus diesem Grund wählte ich schlussendlich immer Bootstrap. Doch ein riesengrosses Framework zu integrieren, für ein einfaches Menu, ging mir schnell auf die Nerven und ich suchte nach Tutorials, mit denen ich selbst welche schreiben konnte.

Für all die unter euch, die am gleichen Punkt sind, wie ich damals, dann bleibt dran. Denn hier erfahrt ihr, wie ihr mit einem Linklistengadget ein responsives 3-Level Dropdown bauen könnt.

<br><!-- more -->
<p data-height="304" data-theme-id="7132" data-slug-hash="NPOKYP" data-default-tab="result" data-user="mynimi" class='codepen'>See the Pen <a href='http://codepen.io/mynimi/pen/NPOKYP/'>3-Level Dropdown from 1-Level Menu</a> by Myri (<a href='http://codepen.io/mynimi'>@mynimi</a>) on <a href='http://codepen.io'>CodePen</a>.</p>
<script async src="//assets.codepen.io/assets/embed/ei.js"></script>


In diesem Tutorial soll es nicht darum gehen, wie das Menü funktioniert, sondern, wie ihr es einbindet. (Ich plane allerdings noch ein Tutorial zum DropDown Menu selbst)

Am besten probiert ihr das immer noch in einem Testblog aus, dann seid ihr auf jeden Fall auf der sicheren Seite, auch wenn eigentlich nicht allzu viel schief gehen sollte.
Ausserdem solltet ihr hier ein Template verwenden, das responsive ist, sonst macht das nicht viel Sinn. Falls ihr's nicht selber schreiben wollt, könnt ihr gerne mal bei [meinen Templates](/themes/) vorbeischauen.

Also, bei Blogger einloggen und dann kann es losgehen.

### 1. LinkListe Erstellen

Als erstes geht ihr in den Layout Bereich eures Blogs und dann erstellt ihr dort eine neue Linkliste, platziert das Gadget wo auch immer ihr wollt, da das Menu fixiert ist, spielt es nicht wirklich eine Rolle, wo es sich befindet. Einfach logisch vom Aufbau her, wäre irgendwo oben.

Nun wie ihr eure Linkliste baut. Die Reihenfolge spielt eine Rolle.

Unterelemente für das zweite Level, beginnen mit einem `_` und Unterelemente des dritten Levels starten mit zwei Unterstrichen `__` Von der Reihenfolge her, müsst ihr einfach die Elemente untereinander platzieren

Also:

```html
Elternlink
_Kinderlink
__Enkellink
```

Und das speichert ihr dann.

![linkliste]({{ site.img_dir }}/blogger-linklist.png)

### 2. Sass und Script Personalisieren

Als nächstes personalisiert ihr euer Dropdown.

Das erste, was ihr herausfinden wollt ist, wie die Liste heisst.

Also untersucht ihr die Liste, mit dem Inspector, der in jedem guten Browser integriert ist (Rechtsklick, Element untersuchen).

Falls ihr nur eine einzige Linkliste in eurem Blog habt, könnt ihr mit der Klasse arbeiten, da aber das LinkListen Gadget ziemlich beliebt ist, ist es besser mit der ID zu arbeiten.

Ihr wollt also die ID herausfinden.

Für mich ist das `LinkList1`

![inspector ID]({{ site.img_dir }}/blogger-menu-id.jpg)


Als nächstes öffnet ihr meinen [CodePen](http://codepen.io/mynimi/pen/NPOKYP)

Im JavaScript müsst ihr eigentlich nichts anpassen, wenn ihr meine CSS verwenden wollt und mit den Klassen zufrieden seid, abgesehen von zwei Variablen.

Sucht nach

```js
// SETTINGS
//------------------------------------------------------    
var one_level_list_element = $('ul'), // mandatory!
    menu_name = 'Menu', // this will be used next to the hamburger icon for the toggle Button
```

Das erste `$('ul)` solltet ihr ersetzen durch die richtige Ansprache für eure Liste. Das zweite ist der Name, der neben dem Hamburger Icon in der responsiven Ansicht angezeigt wird. Ich möchte, dass das in meinem Fall "Navigation" ist.

Nach der Änderung sieht das also so aus:

```js
// SETTINGS
//------------------------------------------------------    
var one_level_list_element = $('#LinkList1 ul'), // mandatory!
    menu_name = 'Navigation', // this will be used next to the hamburger icon for the toggle Button
```

Da die Styles in Sass geschrieben sind, könnt ihr hier nach Herzenslust ändern. Die Variablen sind alle angeschrieben:

```scss
// Punkt an dem das responsive Menu verwendet wird
$toggle: 700px;

// Haupthintergrund Farbe
$menu_bg: #4F0719;

// Link Farbe und Hover
$menu_color: white;
$item_hover_color: lighten($menu_bg, 75%);

// Drop Down Links (kleine Pfeile)
$arrow_toggle_line: 1px solid rgba(white, .1);
$arrow_toggle_hover_bg: rgba(white, .1);
$arrow_toggle_color: white;

// Level Zwei Hintergrund und Hintergrund bei Hover
$level-two_bg: $menu_bg;
$level-two_hover_bg: rgba(white, .1);

// Level Drei Hintergrund und Hintergrund bei Hover
$level-three_bg: $menu_bg;
$level-three_hover_bg: rgba(white, .1);

// Menu Text-Ausrichtugn verwendet hier "left", "center" oder "right"
$text_align: left; 

// Responsive Toggle Link
$responsive_width: 100%;
$responsive_toggle_text_align: left;
$navtoggle_bg: #291018;
$navtoggle_color: white;
$navtoggle_hover_color: lighten(#291018, 80%);
```

Wenn ihr eure Farben angepasst habt, seit ihr ready um euer HTML Gadget zusammenzustellen.

### 3. HTML Widget einfügen

Okay, was kommt alles ins Gadget?

Das Menu ist abhängig von Icons, also kommt Font-Awesome rein und da das Script in jQuery geschrieben ist, solltet ihr das auch integriert haben (womöglich habt ihr das schon, also bitte nicht mehrmals einfügen, das Ding ist relativ gross)

Ich packe alles in ein einzelnes Gadget, wenn ihr aber keine Angst vor eurem Code habt, dann platziert doch den Font-Awesome link im `<head>`Bereich eures Blogs, die CSS dort wo die CSS ist und jQuery und Script kurz vor dem schliessenden body tag (`</body>`)

Ihr wollt das komplette Javascript aus dem Codepen kopieren.

Für die CSS klickt ihr oben im CSS-Balken auf _view compiled_, sodass ihr die generierte CSS seht.

Und dann sucht ihr den Kommentar:

```css
/* Copy Everything Below This Line */
```

Und alles was unter diesem Kommentar folgt, kopiert ihr an die entsprechende Stelle.

Wenn ihr mit dem Gadget arbeitet, kommt das alles rein.

```html
<!-- Font Awesome -->
<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">
<style>
    /* Hier CSS einfügen */
</style>

<!--jQuery-->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script>
    // hier javascript einfügen
</script>
```

### 4. Troubleshoot

Zum Teil ist Blogger etwas mühsam.

Falls euer Menu nicht funktioniert, kann das daran liegen, dass die CSS des Widgets im Weg ist.

In diesem Fall nehmt ihr nochmal eure ID der Linkliste und fügt eine Zeile am Ende eures Scripts ein (LinkList1 dann durch eure ID ersetzen)

```js
    // add this height as a margin to the body, so that the menu won't cover everything up.
    $('body').css('margin-top', menuheight + 10)

    // die Zeile hier unten ist neu:
    $('#LinkList2').toggleClass('widget', '');
});
```

Und dann sollte es funktionieren. Die Klasse zu entfernen geht um einiges schneller, als alles mit CSS zu überschreiben. :)

![resultat]({{ site.img_dir }}/responsive-3-level-menu.gif)