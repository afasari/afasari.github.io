---
layout: post
title: "Building a Modern Todo App with HTMX and Go"
date: 2024-01-09
categories: [go, htmx, webdev]
tags: [project]
author: Batiar
---

In this article, I'll share my experience building a modern Todo application using HTMX and Go. If you're looking for a simpler approach to building interactive web applications without heavy JavaScript frameworks, this project might interest you.

## Why HTMX and Go?

The web development landscape is often dominated by complex JavaScript frameworks. However, for many applications, we might be overcomplicating things. HTMX allows us to build dynamic applications using simple HTML attributes, while Go provides a robust and efficient backend.

## Project Overview

I built a Todo application with these key features:

- Real-time updates without page refreshes
- Modern dark theme UI
- PostgreSQL for data persistence
- Minimal JavaScript
- Fast and lightweight

## The Tech Stack

### Backend

- **Go**: For its simplicity and performance
- **Gorilla Mux**: For routing
- **PostgreSQL**: For data storage

### Frontend

- **HTMX**: For dynamic interactions
- **TailwindCSS**: For styling
- **DaisyUI**: For UI components

## Code Highlights

### HTMX Simplicity

Here's how we handle a todo creation:

```html
<form class="flex gap-2 mb-6">
  <input
    class="flex-1 input input-bordered input-sm bg-slate-700"
    type="text"
    name="todo"
    placeholder="Add new task..."
  />
  <button hx-post="/todo" hx-target="#todos" hx-swap="innerHTML">
    Add Task
  </button>
</form>
```

Just three HTMX attributes handle:

- POST request
- DOM targeting
- Content swapping

### Go Backend

The Go code is equally clean:

```go
func createTodo(w http.ResponseWriter, r *http.Request) {
    err := r.ParseForm()
    if err != nil {
        log.Printf("Error parsing form: %v", err)
        return
    }

    model.CreateTodo(r.FormValue("todo"))
    sendTodos(w)
}
```

## Project Structure

```plaintext
todo-htmx/
├── templates/
│   └── index.html    # Main UI template
├── model/
│   └── todo.go       # Database operations
├── routes/
│   └── routes.go     # HTTP handlers
└── main.go           # Application entry
```

## Key Benefits

1. Minimal JavaScript : HTMX handles all dynamic interactions
2. Fast Development : Less code, fewer bugs
3. Great Performance : Server-side rendering
4. Modern UI : Dark theme with TailwindCSS
5. Real-time Updates : Without WebSocket complexity

## Lessons Learned

1. Not every project needs a JavaScript framework
2. Server-side rendering is still powerful
3. HTMX + Go is a great combination for CRUD apps
4. TailwindCSS makes styling maintainable

## Getting Started

Want to try it yourself? Check out the project repository .

## Future Improvements

I'm planning to add:

- Authentication
- Task categories
- Due dates
- Mobile responsiveness
- Offline support

## Conclusion

This project demonstrates that we can build modern, interactive web applications without the complexity of traditional JavaScript frameworks. HTMX and Go provide a refreshing, simplified approach to web development.

Have you tried HTMX? What's your take on minimalist web development? Let me know in the comments!
