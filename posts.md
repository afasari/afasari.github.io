---
title: "Posts"
layout: default
---

{% raw %}
<div class="posts-grid">
  {% for post in site.posts %}
    <article class="post-card">
      <h2><a href="{{ post.url | relative_url }}">{{ post.title }}</a></h2>
      <div class="post-meta">
        <time datetime="{{ post.date | date_to_xmlschema }}">{{ post.date | date: "%B %-d, %Y" }}</time>
        {% if post.tags %}
          <div class="tags">
            {% for tag in post.tags %}
              <span class="tag">{{ tag }}</span>
            {% endfor %}
          </div>
        {% endif %}
      </div>
      <div class="post-excerpt">
        {{ post.excerpt | strip_html | truncatewords: 50 }}
      </div>
      <a href="{{ post.url | relative_url }}" class="read-more">Read More →</a>
    </article>
  {% endfor %}
</div>

<style>
  .posts-grid {
    display: grid;
    gap: 2rem;
    margin: 2rem 0;
  }

  .post-card {
    padding: 1.5rem;
    border: 1px solid var(--border);
    border-radius: 8px;
    transition: transform 0.2s ease;
  }

  .post-card:hover {
    transform: translateY(-4px);
  }

  .post-meta {
    display: flex;
    gap: 1rem;
    font-size: 0.9rem;
    color: var(--text-light);
    margin: 0.5rem 0;
  }

  .tags {
    display: flex;
    gap: 0.5rem;
  }

  .tag {
    background: var(--bg);
    padding: 0.2rem 0.5rem;
    border-radius: 4px;
    font-size: 0.8rem;
  }

  .post-excerpt {
    margin: 1rem 0;
    color: var(--text-light);
  }

  .read-more {
    display: inline-block;
    color: var(--link);
    text-decoration: none;
    font-weight: 500;
  }

  .read-more:hover {
    text-decoration: underline;
  }
</style>
{% endraw %}
