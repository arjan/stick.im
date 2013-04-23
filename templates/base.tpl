<!DOCTYPE html>
{# Base PHONE template #}
<html lang="{{ z_language|default:"en"|escape }}">
<head>
	<meta charset="utf-8" />
	<title>{% block title %}Paste and share images easily{% endblock %} - Stick.im</title>

	<link rel="icon" href="/favicon.ico" type="image/x-icon" />
	<link rel="shortcut icon" href="/favicon.ico" type="image/x-icon" />

	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<meta name="author" content="Marc Worrell" />

    <link href='http://fonts.googleapis.com/css?family=Parisienne' rel='stylesheet' type='text/css'>

	{% all include "_html_head.tpl" %}
	{% lib 
	        "bootstrap/css/bootstrap.css" 
	        "css/jquery.loadmask.css" 
	        "css/z.growl.css" 
	        "css/z.modal.css" 
	        "css/site.css" 
	%}

    <meta property="og:site_name" content="Stick.im"/>
	{% block html_head_extra %}{% endblock %}
</head>

<body class="{% block page_class %}{% endblock %}">
<div class="container">
	{% block content_area %}
		<div class="content" {% include "_language_attrs.tpl" language=z_language %}>
		{% block content %}{% endblock %}
		</div>
	{% endblock %}
</div>

{% include "_js_include.tpl" %}
{% lib "js/jquery.paste_image_reader.js" "js/stickim.js" %}
{% script %}

{% block ua_probe %}
	{% include "_ua_probe.tpl"%}
{% endblock %}
</body>
</html>
