{% extends "base.tpl" %}

{% block html_head_extra %}
    <meta property="og:title" content="Paste and share images easily"/>
    <meta property="og:url" content="http://stick.im/"/>
    {% lib "css/theme-white.css" %}
{% endblock %}


{% block content %}
    <h1 id="home-head" class="heading">Paste image here</h1>
    <p id="home-expl">Copy an image to the clipboard and then press <b class="shortcut-key">Ctrl-V</b> to paste it into stick.im.</p>


    {% wire id=#submit type="submit" postback={upload} delegate=`stickim` %}
    <form id="{{ #submit }}" action="postback" method="post" >

        <div class="target-area">
            <div class="hint">Paste image</div>
        </div>

        <input type="hidden" id="imgdata" name="imgdata" value="" />
        {% validate id="imgdata" name="imgdata" type={presence} %}

        <div class="form-fields row" style="display: none">
            <hr />
            <div class="controls span3">
                <label>Title</label>
                <input type="text" name="title" id="title" maxlength="140" />
            </div>
            <div class="controls span3">
                <label>Background</label>
                <select name="theme">
                    <option value="white">White</option>
                    <option value="black">Black</option>
                    <option value="checker">Checkers</option>
                </select>
            </div>
            <div class="controls span2">
                <label>&nbsp;</label>
                {% button class="btn btn-primary pull-right" text="Share image now" %}
            </div>
        </div>
    </form>

{% endblock %}
