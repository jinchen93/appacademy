# Rails - Week 4 Day 1

## What is an API?
`GET /cats` returns data whether it be in `JSON` or `HTML`

Useful for:
- Mobile Apps
- Server <-> Server communication
- Single Page Apps (client side rendering of data)

## HTTP Request and Response

#### Clients send requests and Servers send responses
#### A request has:
  - Methods
    - GET, PUT, POST, DELETE
  - Path
    - ex: `/users/4`
  - Query
    - ex: `?name=cat`
  - Body
    - additional data, ex:
      - email address
      - passwords

#### A response has:
  - Status codes
    - ex: `404 NOT FOUND`, `200 OK`
  - Body
    - Data that goes back to the client (`JSON` and etc..)

## Rails Routing

The router checks the path and the method

### Controllers
Controllers process the requests from the router.
Controllers have actions (which are just methods)
  - `index`, `create`, `edit`, etc...

#### Say for example we have a `UsersController`
Router receives a `GET /users`

Router creates a new instance of the `UsersController`

`UsersController` then calls `UsersController#index` action

## Routes DEMO

#### RESTful routes:
```ruby
get     'superheroes'     to: 'superheroes#index'
get     'superheroes/:id' to: 'superheroes#show'
post    'superheroes'     to: 'superheroes#create'
patch   'superheroes/:id' to: 'superheroes#update'
put     'superheroes/:id' to: 'superheroes#update'
delete  'superheroes/:id' to: 'superheroes#destroy'
```

Need `patch` and `put` both because of historical reasons
#### The above block can all be created with:

```ruby
resources :superheroes, only: [:index, :show, :create, :update, :destroy]
```

Extra routes:

**Member routes** like `GET /superheroes/2/abilities` would be created like this:

```ruby
resources :superheroes do
  resources :abilities, only: [:index]
end
```

OR

```ruby
resources :abilities, only: [:show, :update, :create, :destroy]
```

## Controller DEMO

All controllers inherit from `ApplicationController`

```ruby
# app/controllers/silly_controller.rb

class SillyController < ApplicationController
end
```

Can specify params

```ruby
# app/controllers/silly_controller.rb

class SillyController < ApplicationController
  def fun
    render json: params
  end
end
```

params can come from
  - Query string
  - Request body
  - URL params/route params

params will be a hash

A `GET /silly` returns:
```json
{
  "message": "hi",
  "controller": "silly"
}
```

A `GET /silly?message=hi` returns:
```json
{
  "message": "hi",
  "controller": "silly",
  "action": "fun"
}
```

A `GET /silly?message=hi&fun=100` returns:
```json
{
  "message": "hi",
  "fun": "100",
  "controller": "silly",
  "action": "fun"
}
```

You can treat it like a params like a normal hash like this:
```ruby
# app/controllers/silly_controller.rb

class SillyController < ApplicationController
  def fun
    render text: params[:message]
  end
end
```

which will just render the text `hi`

## RESTful Controller Demo

### PATCH:
```ruby
# app/controllers/superheroes_controller.rb

def update
  superhero = Superhero.find_by(id: params[:id])

  if superhero.update(superhero_params)
    render json: superhero
  else
    render json: superhero.errors.full_messages, status: :unprocessable_entity
  end
end

private

def superhero_params
  params.require(:superhero).permit(:name, :secret_identity, :power)
end
```

We need to whitelist params!

### POST:
```ruby
# app/controllers/superheroes_controller.rb

def create
  superhero = Superhero.new(superhero_params)

  if superhero.save
    render json: superhero
  else
    render json: superhero.errors.full_messages, status: :unprocessable_entity
  end
end

private

def superhero_params
  params.require(:superhero).permit(:name, :secret_identity, :power)
end
```
