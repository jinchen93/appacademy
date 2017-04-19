# Authentication

### HTTP is STATELESS!

### Cookies Stores State

You might have

`username = John20`

`password = hunter12`

`cart_id = 1293812093819208301928309`

You can store cookies.

But people can **spoof cookies**.

We don't want raw username and raw password being sent in packets.

Solution: Store the sessions token in cookies

`session_token: 74927402710`

In the backend you would generate a new session token everytime the user logins.

Users:
`username`, `password`, `session_token`

### Hashing

Use hashing functions to solve the problem.

**Hash collision:** When two different strings hash to the same value

We want to use crytographic hashing functions.
  - Have extremely low collisions

---

**Types of cryptographic hashing functions:**

SHA-1 (deprecated)

MD5 (deprecated)

SHA-2

Scrypt

BCrypt (Blowfish)

---

SO! We will be storing:

`username` and `password_digest` (from the hashing function)

# Salting

### Rainbow tables:
Tables with the most commonly used passwords and their respective hash digests.

**Salting** is the answer to rainbow tables.

Takes a randomly generated string and appends it to the password... and then
hashes the password with the salt appended.

Each user will have their own unique salt in the DB.

To de-incentivize cracking passwords by appending the salt to random passwords,
we will run the hashing function **MULTIPLE** times so that hackers will
have to run the hashing function multiple times too (VERY COMPUTATIONAlLY EXPENSIVE!).

# BCrypt

```ruby
require 'bcrypt'
pass = BCrypt::Password.create('asd')
> "$2a$10$b59fLwuafvndPtq9yYRTUOYRGu9nFdmyaeD4CqBBRDT/7nbFUok.K"
```

BCrypt will give you a different output each time with metadata about how
many times it ran the hashing function and what the salt is.

BCrypt returns a `BCrypt::Password` class.

```ruby
pass.salt
> "$2a$10$b59fLwuafvndPtq9yYRTUO"

# checksum is the digest
pass.checksum
> "YRGu9nFdmyaeD4CqBBRDT/7nbFUok.K"

# this is the full digest
pass.salt + pass.checksum
```

Three functions we care about:

```ruby
pass = BCrypt::Password.create('hunter12')
pass2 = BCrypt::Password.new(pass.to_s)
pass2.is_password?('hunter12')
```

# Session and flash

Sessions are cookies.

Flashes are cookies that live for one request. (Mainly used for validation errors).

```ruby
flash[:user_error] = "Username can't be blank"
```

```html
<div class="error">
  <%= flash[:user_error] %>
</div>
```

```ruby
flash.now[:user_error]
```
Is not a cookie, it is not persisted, it lives for one request.


# Auth Patterns

```ruby
#User Model
validates :password, length: { minimum: 6, allow_nil: true }
```

Makes it so that the user has to supply a password in the beginning.
The allow nil makes it so that we can pull it out of the database
without breaking the validation. (Since we won't store passwords)


User methods for authentication:
```ruby
# /models/user.rb
def password(password_input)
  @password_digest = BCrypt::Password.create(password_input)
end

def generate_session_token
  # make session token
end

def ensure_session_token
  # if session token, good. else, make it.
end

def reset_session_token
  # reset the session token
end

def find_by_credentials(username, password)
  user = User.find_by(username: username)
  password_digest = BCrypt::Password.create(password)
  user.password_digest.is_password?(password_digest)
end
```

UsersController will have **#new** (register page) and **#create** (new user & log in)

SessionsController will have **#new** (log in page), **#create** (logs in), and **#destroy** (log out)

ApplicationController will have **#current_user** (important to store as instance variable so we don't keep doing queries)
```ruby
def current_user
  @current_user ||= User.find_by(session_token: session[:session_token])
end

def login!(user)
end

def redirect_unless_logged_in
end
```
