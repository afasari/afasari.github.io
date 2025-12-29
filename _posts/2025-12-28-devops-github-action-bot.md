---
layout: post
title: "Useful Github Action Bot For Software Engineer"
date: 2025-12-28
categories: [github action]
tags: [devops]
author: Batiar
mermaid: true
---

I just explore github action that increase productivity to developing system in github. I'm prefer free version first to know what github action can do. There are a lot of bot in [Github marketplace](https://github.com/marketplace) and [Probot](https://probot.github.io/), here some of them.

## **Dependency & Update Management**

### 1. **Dependabot** (`dependabot/dependabot-core`)

**Goal**: Automated dependency updates and security vulnerability alerts

```yaml
# .github/dependabot.yml
version: 2
updates:
  - package-ecosystem: "npm"
    directory: "/"
    schedule:
      interval: "weekly"
    open-pull-requests-limit: 10
```

**Key Features:**

- Automatic PR creation for dependency updates
- Security vulnerability alerts
- Version compatibility analysis
- Multi-ecosystem support (npm, Maven, pip, etc.)

### 2. **Renovate** (`renovatebot/renovate`)

**Goal**: Advanced dependency management with flexible configuration

```json
{
  "extends": ["config:base"],
  "automerge": true,
  "major": {
    "automerge": false
  }
}
```

**Why Choose Renovate over Dependabot:**

- More granular scheduling options
- Customizable merge strategies
- Support for monorepos
- Advanced grouping and scheduling

## **Release Management & Distribution**

### 3. **GoReleaser** (`goreleaser/goreleaser`)

**Goal**: Automated Go project releases with multi-platform support

```
# .goreleaser.yml
builds:
  - env:
      - CGO_ENABLED=0
    goos:
      - linux
      - windows
      - darwin
archives:
  - replacements:
      darwin: Darwin
      linux: Linux
      windows: Windows
```

**Features:**

- Cross-compilation for multiple platforms
- Homebrew/Linux packaging support
- Docker image creation
- Release notes generation

## **Code Quality & Security**

### 4. **Super-Linter** (`super-linter/super-linter`)

**Goal**: Unified linting across multiple programming languages

```yaml
name: Super-Linter
on: push
jobs:
  lint:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: github/super-linter@v4
        env:
          DEFAULT_BRANCH: main
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```

**Supported Languages:** 50+ including JavaScript, Python, Go, Java, C++, Ruby

### 5. **SonarCloud** (GitHub Marketplace)

**Goal**: Continuous code quality and security analysis

```yaml
- uses: SonarSource/sonarcloud-github-action@master
  env:
    GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
    SONAR_TOKEN: ${{ secrets.SONAR_TOKEN }}
```

**Metrics Tracked:**

- Code coverage
- Duplication percentage
- Security hotspots
- Maintainability ratings
- Bug and vulnerability detection

### 6. **CodeCov** (GitHub Marketplace)

**Goal**: Detailed code coverage reporting and visualization

```yaml
= uses: codecov/codecov-action@v2
  with:
    token: ${{ secrets.CODECOV_TOKEN }}
    files: ./coverage1.xml,./coverage2.xml
    flags: unittests
    name: codecov-umbrella
```

**Features:**

- Coverage trend graphs
- PR coverage comments
- Multi-language support
- Coverage comparisons

### 7. **CodeFactor** (GitHub Marketplace)

**Goal**: Automated code review and technical debt analysis

**Key Insights:**

- Code quality grades (A-F)
- Issue categorization
- Duplication detection
- Complexity analysis

## **Repository Organization & Maintenance**

### 8. **Issue Label Bot** (GitHub Marketplace)

**Goal**: Automatic issue and PR labeling

```yaml
name: Issue Label Bot
on:
  issues:
    types: [opened]
jobs:
  labeler:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/labeler@v4
        with:
          repo-token: "${{ secrets.GITHUB_TOKEN }}"
          configuration-path: .github/labeler.yml
```

**Common Labeling Strategies:**

- Based on issue title/content
- By affected file paths
- By issue type (bug, feature, documentation)
- Priority assessment

### 9. **Stale Bot** (Built-in)

**Goal**: Automatic cleanup of inactive issues and PRs

```yaml
# .github/stale.yml
daysUntilStale: 60
daysUntilClose: 7
exemptLabels:
  - pinned
  - security
```

### 10. **Weekly Digest** (Probot App)

**Goal**: Automated weekly repository activity summaries

**Weekly Reports Include:**

- New issues and PRs
- Closed items
- Contributor activity
- Milestone progress

## **PR & Workflow Automation**

### 11. **Automatic Rebase Action** (GitHub Marketplace)

**Goal**: Keep PRs up-to-date with target branch

```yaml
name: Automatic Rebase
on: pull_request
jobs:
  rebase:
    runs-on: ubuntu-latest
    steps:
      - uses: cirrus-actions/rebase@master
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```

**Benefits:**

- Reduces merge conflicts
- Maintains clean commit history
- Ensures PRs are tested against latest code

### 12. **Pull** (`apps/pull`) GitHub App

**Goal**: Automatic merging of PRs based on conditions

```yaml
# Configure via repository settings
# Can merge when:
# - All checks pass
# - Required reviews complete
# - No merge conflicts
```

**Merge Strategies:**

- Merge commit
- Squash and merge
- Rebase and merge

## Building a Complete Automation Stack

Sample `.github/workflows/ci-cd.yml` combining multiple tools:

```yaml
name: CI/CD Pipeline
on: [push, pull_request]

jobs:
  quality:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3

      - name: Super Linter
        uses: github/super-linter@v4

      - name: Run Tests with Coverage
        run: npm test -- --coverage

      - name: Upload to Codecov
        uses: codecov/codecov-action@v3

      - name: SonarCloud Scan
        uses: SonarSource/sonarcloud-github-action@master

      - name: Check Dependencies
        uses: actions/dependency-review-action@v3

  release:
    needs: quality
    if: startsWith(github.ref, 'refs/tags/')
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: goreleaser/goreleaser-action@v3
        with:
          version: latest
          args: release --clean
```

| **Goal**                  | **Primary Tools**          | **Best For**                     | **When to Use**                            |
| ------------------------- | -------------------------- | -------------------------------- | ------------------------------------------ |
| **Dependency Management** | Dependabot, Renovate       | Security updates, version bumps  | All projects with dependencies             |
| **Code Quality**          | Super-Linter, SonarCloud   | Multi-language teams, enterprise | Large codebases, teams > 5                 |
| **Release Automation**    | GoReleaser                 | Go projects, multi-platform      | Production applications                    |
| **Coverage Tracking**     | CodeCov                    | Open source, compliance needs    | Projects requiring test coverage metrics   |
| **Repository Hygiene**    | Issue Label Bot, Stale Bot | Active communities, OSS projects | 50+ open issues, community-driven projects |
| **PR Automation**         | Automatic Rebase, Pull App | Fast-moving teams, CI/CD focus   | Teams with high PR volume                  |
