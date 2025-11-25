#!/bin/bash

# jekyll-post-generator.sh

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Default values
DEFAULT_TITLE="My New Post"
DEFAULT_CATEGORY="blog"
DEFAULT_LAYOUT="post"
DEFAULT_AUTHOR="Batiar"
POSTS_DIR="_posts"

# Function to show usage
show_usage() {
  echo -e "${GREEN}Jekyll Post Generator${NC}"
  echo "Usage: $0 [OPTIONS]"
  echo ""
  echo "OPTIONS:"
  echo "  -t, --title TITLE      Post title (default: '$DEFAULT_TITLE')"
  echo "  -c, --category CAT     Post category (default: '$DEFAULT_CATEGORY')"
  echo "  -l, --layout LAYOUT    Post layout (default: '$DEFAULT_LAYOUT')"
  echo "  -a, --author AUTHOR    Post author (default: '$DEFAULT_AUTHOR')"
  echo "  -d, --date DATE        Post date in YYYY-MM-DD format (default: today)"
  echo "  -T, --tags \"TAG1,TAG2\" Comma-separated tags"
  echo "  -i, --interactive      Interactive mode"
  echo "  -h, --help             Show this help message"
  echo ""
  echo "EXAMPLES:"
  echo "  $0 -t \"My Amazing Post\" -c tutorial -T \"jekyll,github,pages\""
  echo "  $0 --interactive"
  echo "  $0 --title \"Quick Note\" --date 2024-01-15"
}

# Function to validate date
validate_date() {
  if ! date -d "$1" >/dev/null 2>&1; then
    echo -e "${RED}Error: Invalid date format. Use YYYY-MM-DD${NC}"
    exit 1
  fi
}

# Function to generate filename
generate_filename() {
  local title="$1"
  local date="$2"
  # Convert title to lowercase, replace spaces with hyphens, remove special chars
  local clean_title=$(echo "$title" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9]/-/g' | sed 's/--*/-/g' | sed 's/^-//' | sed 's/-$//')
  echo "${date}-${clean_title}.md"
}

# Function to create posts directory if it doesn't exist
ensure_posts_dir() {
  if [ ! -d "$POSTS_DIR" ]; then
    echo -e "${YELLOW}Creating posts directory: $POSTS_DIR${NC}"
    mkdir -p "$POSTS_DIR"
  fi
}

# Function to generate front matter
generate_front_matter() {
  local title="$1"
  local layout="$2"
  local date="$3"
  local category="$4"
  local author="$5"
  local tags="$6"

  cat <<EOF
---
layout: $layout
title: "$title"
date: $date
categories: [$category]
author: $author
EOF

  if [ -n "$tags" ]; then
    echo "tags: [$tags]"
  fi

  echo "---"
  echo ""
  echo "<!-- Start writing your content here -->"
  echo ""
  echo "# Introduction"
  echo ""
  echo "Your post content goes here..."
}

# Interactive mode
interactive_mode() {
  echo -e "${BLUE}Jekyll Post Generator (Interactive Mode)${NC}"
  echo ""

  read -p "Post title [$DEFAULT_TITLE]: " title
  title=${title:-$DEFAULT_TITLE}

  read -p "Category [$DEFAULT_CATEGORY]: " category
  category=${category:-$DEFAULT_CATEGORY}

  read -p "Layout [$DEFAULT_LAYOUT]: " layout
  layout=${layout:-$DEFAULT_LAYOUT}

  read -p "Author [$DEFAULT_AUTHOR]: " author
  author=${author:-$DEFAULT_AUTHOR}

  read -p "Date (YYYY-MM-DD) [$(date +%Y-%m-%d)]: " date_input
  date_input=${date_input:-$(date +%Y-%m-%d)}
  validate_date "$date_input"
  date="$date_input"

  read -p "Tags (comma-separated, optional): " tags_input
  tags="$tags_input"

  create_post "$title" "$layout" "$date" "$category" "$author" "$tags"
}

# Main function to create post
create_post() {
  local title="$1"
  local layout="$2"
  local date="$3"
  local category="$4"
  local author="$5"
  local tags="$6"

  local filename=$(generate_filename "$title" "$date")
  local filepath="$POSTS_DIR/$filename"

  # Check if file already exists
  if [ -f "$filepath" ]; then
    echo -e "${YELLOW}Warning: File $filepath already exists.${NC}"
    read -p "Overwrite? (y/N): " overwrite
    if [[ ! $overwrite =~ ^[Yy]$ ]]; then
      echo -e "${RED}Post creation cancelled.${NC}"
      exit 1
    fi
  fi

  # Generate the post
  ensure_posts_dir
  generate_front_matter "$title" "$layout" "$date" "$category" "$author" "$tags" >"$filepath"

  echo -e "${GREEN}✓ Post created successfully: $filepath${NC}"
  echo ""
  echo -e "${BLUE}Preview:${NC}"
  echo "================================"
  cat "$filepath"
  echo "================================"
}

# Parse command line arguments
TITLE=""
CATEGORY=""
LAYOUT=""
AUTHOR=""
DATE=""
TAGS=""
INTERACTIVE=false

while [[ $# -gt 0 ]]; do
  case $1 in
  -t | --title)
    TITLE="$2"
    shift 2
    ;;
  -c | --category)
    CATEGORY="$2"
    shift 2
    ;;
  -l | --layout)
    LAYOUT="$2"
    shift 2
    ;;
  -a | --author)
    AUTHOR="$2"
    shift 2
    ;;
  -d | --date)
    validate_date "$2"
    DATE="$2"
    shift 2
    ;;
  -T | --tags)
    TAGS="$2"
    shift 2
    ;;
  -i | --interactive)
    INTERACTIVE=true
    shift
    ;;
  -h | --help)
    show_usage
    exit 0
    ;;
  *)
    echo -e "${RED}Unknown option: $1${NC}"
    show_usage
    exit 1
    ;;
  esac
done

# Main execution
if [ "$INTERACTIVE" = true ]; then
  interactive_mode
else
  # Set default values for any missing parameters
  TITLE=${TITLE:-$DEFAULT_TITLE}
  CATEGORY=${CATEGORY:-$DEFAULT_CATEGORY}
  LAYOUT=${LAYOUT:-$DEFAULT_LAYOUT}
  AUTHOR=${AUTHOR:-$DEFAULT_AUTHOR}
  DATE=${DATE:-$(date +%Y-%m-%d)}

  # Validate that we have a title
  if [ -z "$TITLE" ]; then
    echo -e "${RED}Error: Title is required${NC}"
    show_usage
    exit 1
  fi

  create_post "$TITLE" "$LAYOUT" "$DATE" "$CATEGORY" "$AUTHOR" "$TAGS"
fi
