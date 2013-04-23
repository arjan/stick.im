{% extends "base.tpl" %}

{% block title %}Your browser is not supported…{% endblock %}

{% block html_head_extra %}
    {% lib "css/theme-white.css" %}
{% endblock %}

{% block content %}
<h1 class="heading">We are sorry…</h1>

<hr />
<p class="expl">Unfortunately, your browser does not seem to support the image copy-paste functionality that makes <b>stick.im</b> work.</a></p>
<p class="expl"><a href="https://www.google.com/intl/en/chrome/browser/"><img src="/lib/images/chrome.png"/></a></p>
<p class="expl">Download the <a href="https://www.google.com/intl/en/chrome/browser/">Google Chrome</a> browser to use <b>stick.im</b>.</p>

{% endblock %}
