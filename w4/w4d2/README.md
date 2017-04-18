# Rails View: Intro

You can only have one render or one redirect for each action because renders
do not return.

Good practice to user renders and redirects like this:
```ruby
if @book
  render :show
else
  redirect_to books_url
end
```
Below still works but is not advised
```ruby
unless @book
  redirect_to books_url
  return
end

render :show
```

Below does not work at all. You get a Double Render error because renders / redirects do not return.
```ruby
unless @book
  redirect_to books_url
end

render :show
```

# Rails View: Form

```html
<select name="book[category]">
  <option disabled>--- Select Option ---</option>
  <option value="Fiction">Fiction</option>
  <option value="Non-Fiction">Non-Fiction</option>
</select>
```

The disabled option gives you a default placeholder and doesn't allow the user to select it when using the dropdown.

Below HTML gives the user a calendar that lets them select the date.

```html
<input type="date" name="book[year]" >
```

```html
<form action="<%= books_url %>" method="post">
</form>
```

The `<%= books_url %>` helps redirect the user back to the books index.
