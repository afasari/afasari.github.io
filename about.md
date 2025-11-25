---
title: Links
layout: page
---

<div class="linktree-container">
  <div class="profile-section">
    <img src="/assets/images/profile.jpg" alt="Batiar Afas" class="profile-image">
    <h1>Batiar Afas</h1>
    <p>Software Engineer | Backend Specialist</p>
  </div>

  <div class="links-section">
    <a href="https://github.com/afasari" class="link-card github">
      <i class="fa fa-github"></i>
      GitHub
    </a>
  
    <a href="https://linkedin.com/in/batiar-afas" class="link-card linkedin">
      <i class="fa fa-linkedin"></i>
      LinkedIn
    </a>

    <a href="mailto:batiar.rahmamulia@gmail.com" class="link-card email">
      <i class="fa fa-envelope"></i>
      Email Me
    </a>

    <a href="/projects" class="link-card projects">
      <i class="fa fa-code"></i>
      My Projects
    </a>

    <a href="/posts" class="link-card blog">
      <i class="fa fa-pen"></i>
      Read My Blog
    </a>

  </div>
</div>

<style>
  .linktree-container {
    max-width: 680px;
    margin: 0 auto;
    padding: 2rem 1rem;
    text-align: center;
  }

  .profile-section {
    margin-bottom: 2rem;
  }

  .profile-image {
    width: 128px;
    height: 128px;
    border-radius: 50%;
    margin-bottom: 1rem;
    border: 3px solid var(--link);
    object-fit: cover;
  }

  .profile-section h1 {
    margin: 0;
    font-size: 1.8rem;
    color: var(--heading);
  }

  .profile-section p {
    color: var(--text-light);
    margin: 0.5rem 0;
  }

  .links-section {
    display: flex;
    flex-direction: column;
    gap: 1rem;
  }

  .link-card {
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 0.75rem;
    padding: 1rem;
    background: var(--bg);
    border: 2px solid var(--border);
    border-radius: 8px;
    text-decoration: none;
    color: var(--text);
    font-weight: 500;
    transition: all 0.3s ease;
  }

  .link-card:hover {
    transform: translateY(-2px);
    border-color: var(--link);
    background: var(--bg);
  }

  .link-card i {
    font-size: 1.2rem;
  }

  .github:hover { border-color: #6e5494; }
  .linkedin:hover { border-color: #0077b5; }
  .email:hover { border-color: #ea4335; }
  .projects:hover { border-color: #60a5fa; }
  .blog:hover { border-color: #10b981; }
</style>

