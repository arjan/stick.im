{% extends "base.tpl" %}

{% block title %}{{ s.title }}{% endblock %}

{% block html_head_extra %}
    <meta property="og:image" content="{% url stickimg star=s.path use_absolute_url %}"/>
    <meta property="og:title" content="{{ s.title }}"/>
    <meta property="og:url" content="{% url stickim id=s.id use_absolute_url %}"/>

    {% if s.theme == "black" %}
        {% lib "css/theme-black.css" %}
    {% elseif s.theme == "white" %}
        {% lib "css/theme-white.css" %}
    {% elseif s.theme == "checker" %}
        {% lib "css/theme-checker.css" %}
    {% endif %}
{% endblock %}

{% block content %}

{% if s.title %}<h1 class="heading">{{ s.title }}</h1>{% endif %}

<div class="stickim">
    <a href="{% url stickimg star=s.path %}"><img src="{% url stickimg star=s.path %}"/></a>
</div>

<div class="social">
    <div class="pull-right meta">
        <a href="/">stick.im home</a>
    </div>

    <iframe src="//www.facebook.com/plugins/like.php?href=http%3A%2F%2Ffoo.nl%2F&amp;send=false&amp;layout=button_count&amp;width=450&amp;show_faces=false&amp;font=verdana&amp;colorscheme=light&amp;action=like&amp;height=21" scrolling="no" frameborder="0" style="border:none; overflow:hidden; width:450px; height:21px;" allowTransparency="true"></iframe></div>{# &amp;appId=130307173826193 #}
</div>

{% endblock %}
