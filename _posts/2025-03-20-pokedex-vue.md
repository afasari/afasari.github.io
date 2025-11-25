---
layout: post
title: "Building a Pokédex with Vue.js and PokéAPI - A Step-by-Step Guide"
date: 2025-03-20
tags: [vue, pokedex]
---

Hey there! 👋 Let me walk you through how I built a Pokédex using Vue.js and PokéAPI. This project is perfect for learning Vue.js basics while creating something fun!

## Prerequisites

- Node.js installed
- Basic knowledge of Vue.js
- Basic understanding of REST APIs

## Step 1: Project Setup

First, let's create a new Vue project using [Vite](https://vite.dev/guide/):

```bash
 npm create vite@latest vue-vite-pokedex -- --template vue
 cd vue-vite-pokedex
 npm install
```

## Step 2: Adding Dependencies

We'll need Bootstrap for styling:

```bash
npm install bootstrap
```

Add Bootstrap to your main.js :

```javascript
import "bootstrap/dist/css/bootstrap.min.css";
```

## Step 3: Creating the Base Structure

Let's start with our component's data structure:

```javascript
data: () => ({
  pokemonList: [],
  viewedAsDetail: false,
  pokemonDetail: "",
  search: "",
  suggestedPokemon: "",
});
```

## Step 4: Implementing API Calls

We'll create two main methods for fetching Pokémon data:

1. Fetching initial Pokémon list:

```javascript
async mounted() {
  const pokeData = await fetch('https://pokeapi.co/api/v2/pokedex/2/')
    .then(response => response.json())

  pokeData.pokemon_entries.forEach(item => {
    this.getEachPokemon(item)
  })
}
```

2. Fetching individual Pokémon details:

```javascript
async getEachPokemon(result) {
  let response = await fetch('https://pokeapi.co/api/v2/pokemon/'+result.entry_number);
  let data = await response.json();
  this.pokemonList.push(data)
  this.pokemonList.sort((a,b) => a.id - b.id)
}
```

## Step 5: Building the UI Components

1. Create the search bar:

```html
<div class="row justify-content-center mt-5 text-white">
  <div class="col-6">
    <input
      type="text"
      class="form-control"
      placeholder="search pokemon"
      v-model="search"
    />
    <!-- Suggestions will appear here -->
  </div>
</div>
```

2. Add the Pokémon grid:

```html
<div class="row px-5">
  <div class="col-12 col-md-4 col-lg-3 mb-3" v-for="pokemon in pokemonList">
    <div class="card text-center">
      <img
        :src="pokemon.sprites.other.home.front_default"
        :alt="pokemon.name"
      />
      <div class="pokemon-name">{{pokemon.name}}</div>
    </div>
  </div>
</div>
```

## Step 6: Implementing Search Functionality

Add a watch method for real-time search:

```javascript
watch: {
  search() {
    const searchTerm = this.search.toLowerCase();
    let filteredPokemon = this.pokemonList.filter(item => {
      return item.name.toLowerCase().includes(searchTerm)
    })
    this.suggestedPokemon = filteredPokemon.slice(0,3)
  }
}
```

## Step 7: Styling with Glass-morphism

Add these CSS styles for the glass effect:

```css
.card {
  background: rgba(255, 255, 255, 0.21);
  border-radius: 10px;
  box-shadow: 0 4px 30px rgba(0, 0, 0, 0.1);
  backdrop-filter: blur(9px);
  border-left: 2px solid rgba(255, 255, 255, 0.5);
  border-right: 2px solid rgba(255, 255, 255, 0.5);
}
```

## Step 8: Adding Animations

Implement hover effects and transitions:

```css
.card {
  cursor: pointer;
  transition: transform 0.2s;
}
.card:hover {
  transform: translateY(-5px);
}
```

## Testing and Debugging

1. Test the search functionality with different Pokémon names
2. Verify that all Pokémon images load correctly
3. Check responsive design on different screen sizes
4. Test the detail view for various Pokémon

## Common Issues and Solutions

1. Image Loading : Some Pokémon might not have front_default sprites. Add fallback images:

```html
<img
  :src="pokemon.sprites.other.home.front_default || 'fallback-image.png'"
  :alt="pokemon.name"
/>
```

2. API Rate Limiting : Implement delay between requests:

```javascript
await new Promise((resolve) => setTimeout(resolve, 100));
```

## Conclusion

This project demonstrates how to build a modern web application with Vue.js while working with external APIs. The glass-morphism design adds a contemporary touch, and the search functionality makes it practical to use.

## Next Steps

Consider these enhancements:

1. Add pagination for better performance
2. Implement type filtering
3. Add more Pokémon details
4. Include evolution chains
5. Add loading states

The complete code is available on [GitHub](https://github.com/afasari/vue-workspace/tree/main/vue-vite-pokedex), and you can see the live demo [here](https://afasari.github.io/vue-workspace/vue-vite-pokedex).
