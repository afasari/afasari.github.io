---
title: "Blog Posts"
layout: page
---

<div class="posts-container">
  {% for post in site.posts %}
    <article class="post-card">
      <div class="post-content">
        <h2 class="post-title">
          <a href="{{ post.url | relative_url }}">{{ post.title }}</a>
        </h2>
        <div class="post-meta">
          <time datetime="{{ post.date | date_to_xmlschema }}">
            {{ post.date | date: "%B %-d, %Y" }}
          </time>
          {% if post.tags %}
            <div class="tags">
              {% for tag in post.tags %}
                <span class="tag">{{ tag }}</span>
              {% endfor %}
            </div>
          {% endif %}
        </div>
        <div class="post-excerpt">
          {{ post.excerpt | strip_html | truncatewords: 30 }}
        </div>
      </div>
      <div class="post-footer">
        <a href="{{ post.url | relative_url }}" class="read-more">
          Continue Reading
          <svg class="arrow" viewBox="0 0 24 24" width="16" height="16">
            <path fill="currentColor" d="M13.025 1l-2.847 2.828 6.176 6.176h-16.354v3.992h16.354l-6.176 6.176 2.847 2.828 10.975-11z"/>
          </svg>
        </a>
      </div>
    </article>
  {% endfor %}
</div>

<style>
  .posts-container {
    display: grid;
    gap: 2rem;
    margin: 2rem 0;
  }

  .post-card {
    background: var(--bg);
    border: 1px solid var(--border);
    border-radius: 12px;
    overflow: hidden;
    transition: all 0.3s ease;
  }

  .post-card:hover {
    transform: translateY(-4px);
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
  }

  .post-content {
    padding: 1.5rem;
  }

  .post-title {
    margin-bottom: 1rem;
    font-size: 1.5rem;
    font-weight: 600;
  }

  .post-title a {
    color: var(--heading);
    text-decoration: none;
  }

  .post-title a:hover {
    color: var(--link);
  }

  .post-meta {
    display: flex;
    flex-wrap: wrap;
    gap: 1rem;
    font-size: 0.9rem;
    color: var(--text-light);
    margin-bottom: 1rem;
  }

  .tags {
    display: flex;
    flex-wrap: wrap;
    gap: 0.5rem;
  }

  .tag {
    background: var(--bg);
    color: var(--text-light);
    padding: 0.2rem 0.8rem;
    border-radius: 20px;
    font-size: 0.8rem;
    border: 1px solid var(--border);
  }

  .post-excerpt {
    color: var(--text);
    line-height: 1.6;
    margin-bottom: 1rem;
  }

  .post-footer {
    padding: 1rem 1.5rem;
    border-top: 1px solid var(--border);
    background: var(--bg);
  }

  .read-more {
    display: inline-flex;
    align-items: center;
    gap: 0.5rem;
    color: var(--link);
    text-decoration: none;
    font-weight: 500;
    transition: gap 0.3s ease;
  }

  .read-more:hover {
    gap: 0.8rem;
  }

  .arrow {
    transition: transform 0.3s ease;
  }

  .read-more:hover .arrow {
    transform: translateX(2px);
  }
</style>
