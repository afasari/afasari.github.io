---
title: "Projects"
layout: page
---

## Projects

## Todo App with HTMX and Go

A lightweight, fast Todo application built with Go and HTMX, featuring a clean dark theme UI and real-time updates.

- **Tech Stack**: Go, HTMX, PostgreSQL, TailwindCSS
- **[View Project](https://github.com/afasari/go-workspace/tree/main/Projects/todo-htmx)**

## Pokedex Vue

A Pokédex application built with Vue 3 and Vite, featuring modern UI and real-time Pokémon data.

- **Tech Stack**: Vue 3, Vite, TailwindCSS, PokeAPI
- **[View Project](https://github.com/afasari/vue-workspace/tree/main/vue-vite-pokedex)**
- **[View Demo](https://afasari.github.io/vue-workspace/vue-vite-pokedex)**

## Pokedex React

A React-based Pokédex application with TypeScript support and modern features.

- **Tech Stack**: React, TypeScript, TailwindCSS, PokeAPI
- **[View Project](https://github.com/afasari/react-workspace/tree/main/pokedex)**

## Todo App with Rust

A command-line Todo application built with Rust, demonstrating systems programming concepts.

- **Tech Stack**: Rust, SQLite
- **[View Project](https://github.com/afasari/rust-workspace/tree/main/todo)**

## Personal Website

My personal website built with Jekyll and GitHub Pages.

- **Tech Stack**: Jekyll, GitHub Pages, Markdown
- **[View Project](https://github.com/afasari/afasari.github.io)**

{% raw %}
<div id="github-projects">
  <script>
    fetch('https://api.github.com/users/afasari/repos?sort=updated')
      .then(response => response.json())
      .then(data => {
        const projectsDiv = document.getElementById('github-projects');
        projectsDiv.innerHTML = '<h2>All GitHub Projects</h2>';
        data.forEach(repo => {
          if (!repo.fork) {
            const repoDiv = document.createElement('div');
            repoDiv.className = 'project-item';
            repoDiv.innerHTML = `
              <h3><a href="${repo.html_url}">${repo.name}</a></h3>
              <p>${repo.description || ''}</p>
              <p><small>Last updated: ${new Date(repo.updated_at).toLocaleDateString()}</small></p>
            `;
            projectsDiv.appendChild(repoDiv);
          }
        });
      });
  </script>
  <noscript>Please enable JavaScript to view my GitHub projects.</noscript>
</div>

<style>
  .project-item {
    margin-bottom: 2em;
    padding: 1em;
    border-bottom: 1px solid #eee;
  }
  .project-item h3 {
    margin-bottom: 0.5em;
  }
  .project-item p {
    margin: 0.5em 0;
  }
</style>
{% endraw %}
