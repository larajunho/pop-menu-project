# Pop Menu Project

An application to manage restaurant menus.

## Project Structure

- `backend/` → Ruby on Rails API
- `frontend/` → React frontend
- `README.md` → this file

## Prerequisites

- Ruby 3.3.9 (via Homebrew)
- Node.js and npm
- PostgreSQL

## Running the Backend

1. Go to the backend folder:

```
cd backend
```

2. Install dependencies:

```
bundle install
```

3. Set up the database:

```
rails db:create
rails db:migrate
```

4. Start the Rails server:

```
rails server
```

The API will be available at: http://localhost:3000

## API Endpoints

All endpoints are under the namespace /api/v1

### Restaurants

- GET /api/v1/restaurants

Returns a list of all restaurants with their menus and menu items.

- GET /api/v1/restaurants/:id

Returns a single restaurant with its menus and menu items.

### Menus

- GET /api/v1/restaurants/:restaurant_id/menus

Returns all menus of a restaurant.

- GET /api/v1/restaurants/:restaurant_id/menus/:id

Returns a single menu with its items.

### Menu Items

- GET /api/v1/restaurants/:restaurant_id/menus/:menu_id/menu_items

Returns all menu items in a menu.

- GET /api/v1/restaurants/:restaurant_id/menus/:menu_id/menu_items/:id

Returns a single menu item.

### Import JSON

- POST /api/v1/import_restaurants

Accepts a JSON file to import restaurants, menus, and menu items.

#### Example with curl:

```
curl -X POST -F "file=@backend/data/restaurant_data.json;type=application/json" http://localhost:3000/api/v1/import_restaurants
```

```
{
  "status": "success",
  "logs": [
    "Restaurant 'Poppo's Cafe' processed",
    " Menu 'lunch' processed for 'Poppo's Cafe'",
    "  Added item 'Burger' to menu 'lunch'",
    ...
  ]
}
```

## Running Tests

```
cd backend
rails test
```
