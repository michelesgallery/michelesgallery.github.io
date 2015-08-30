---
permalink: /archiv/
group: "navigation-04"
title: Archiv
lang: de
id: archive
description: Alle Posts von ½ a px. Posts über blogger, jekyll, HTML und Sass.
---
{% if site.baseurl != '' or null %}
    {% assign base = site.baseurl %}
{% else %}
    {% assign base = '' %}
{% endif %}

{% assign posts = site.posts | where:"lang", page.lang %}
Datum | Titel | Tags
---|---|---
{% for post in posts%}{% include date.md %} | [{{ post.title }}]({{ post.url | prepend: base }}) | {% for tag in post.tags %} <a href="{{ site.tag_dir | prepend: base }}/{{ tag }}" class="tag">{{ tag }}</a> {% endfor %}
{% endfor %}