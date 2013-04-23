{% extends "base.tpl" %}

{% block title %}Error {{ error_code }} - {% inherit %}{% endblock %}

{% block html_head_extra %}
    {% lib "css/theme-white.css" %}
{% endblock %}

{% block content %}
<h1 class="heading">Error {{ error_code }}</h1>

<hr />
<p id="home-expl">Sorry... <a href="/">Return to home page &raquo;</a></p>

{% endblock %}
