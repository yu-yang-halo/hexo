{% extends '_layout.swig' %}
{% import '_macro/sidebar.swig' as sidebar_template %}

{% block title %}
  {% set page_title_suffix = ' // ' + config.title %}

  {% if page.type === "categories" %}
    {{ __('title.category') + page_title_suffix }}
  {% elif page.type === "tags" %}
    {{ __('title.tag') + page_title_suffix }}
  {% else %}
    {{ page.title + page_title_suffix }}
  {% endif %}
{% endblock %}

{% block content %}

  <div id="posts" class="posts-expand">
    {# tagcloud page support #}
    {% if page.type === "tags" %}
      <div class="tag-cloud">
        <div class="tag-cloud-title">
            {{ _p('counter.tag_cloud', site.tags.length) }}
        </div>
        <div class="tag-cloud-tags">
          {{ tagcloud({min_font: 12, max_font: 30, amount: 200, color: true, start_color: '#ccc', end_color: '#111'}) }}
        </div>
      </div>
    {% elif page.type === 'categories' %}
      <div class="category-all-page">
        <div class="category-all-title">
            {{ _p('counter.categories', site.categories.length) }}
        </div>
        <div class="category-all">
          {{ list_categories() }}
        </div>
      </div>
    {% else %}
      {{ page.content }}
      {% if post.comments %}
        {% if (config.duoshuo and config.duoshuo.shortname) or config.duoshuo_shortname %}
          <span class="post-comments-count">
          &nbsp; | &nbsp;
          <a href="{{ url_for(post.path) }}#comments" >
            <span class="post-comments-count ds-thread-count" data-thread-key="{{ post.path }}"></span>
          </a>
        </span>
        {% elseif config.disqus_shortname %}
          <span class="post-comments-count">
          &nbsp; | &nbsp;
          <a href="{{ url_for(post.path) }}#comments" >
            <span class="post-comments-count disqus-comment-count" data-disqus-identifier="{{ post.path }}"></span>
          </a>
        </span>
        {% endif %}
      {% endif %}
    {% endif %}
  </div>

{% endblock %}

{% block sidebar %}
  {{ sidebar_template.render(false) }}
{% endblock %}
