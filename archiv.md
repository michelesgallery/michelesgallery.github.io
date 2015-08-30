---
group: navigation-05
title: Archiv
---
{% if site.baseurl != '' or null %}
    {% assign base = site.baseurl %}
{% else %}
    {% assign base = '' %}
{% endif %}

{% assign posts = site.posts %}
Datum | Titel | Tags
---|---|---
{% for post in posts%}{% include date.md %} | [{{ post.title }}]({{ post.url | prepend: base }}) | {% for tag in post.tags %} <a href="{{ site.tag_dir | prepend: base }}/{{ tag }}" class="tag">{{ tag }}</a> {% endfor %}
{% endfor %}