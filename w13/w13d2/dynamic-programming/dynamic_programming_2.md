# Dynamic Programming: Part 1

It's time to practice what we've learned. This project will be part reading, part programming. As we build up your knowledge, you'll take a more active role in *designing* as well as implementing these algorithms. Let's get started!

### Setup

Dynamic programming problems often involve maintaining some sort of a cache (usually using a hash or an array) for storing solutions to smaller subproblems that have already been seen. Each run of the function must refer to the same cache object -- otherwise, there's danger that two calls with the same input give a different output.

There are several ways to deal with this rather annoying problem. We could use globally scoped variables (depending on our language of choice). We could also pass a pointer to the cache from call to call -- this is called *passing by reference*, and it's an important concept in software development. Once again, whether passing a reference will work or not depends upon the language. In Javascript, for example, all non-primitive types are passed by reference, so we could pass a hash or an array in this way. In Ruby, everything, including something like a hash or an array, is *passed by value*, meaning that when a parameter is passed into a function, that function makes a copy of of the parameter and then refers to and mutates that copy.

The solutions outlined above both work, but to keep our code readable and our work organized, we'll use a class in Ruby. Within that class, we'll create instance variables to use as our caches -- one for each of the dynamic programming problems we attack. Go ahead and start by doing that:

```ruby
class DynamicProgramming
  def initialize
  end
end
```
We should note as well that we'll only use this technique for *top-down* implementations. For bottom-up implementations, a helper function will build out and return the cache, so that we don't have to worry about updating it while we're performing recursive calls.

Side note: if you were going to use dynamic programming in a real-world context, you probably wouldn't want to do it this way. However, it's very likely that you'd be working within a class, functional scope, or other context that would allow you to create and maintain your cache in some reasonable way.

**NB**: if you're whiteboarding a dynamic programming question, you probably don't need to bother creating a class. Just initialize a cache object outside the function and refer to it. However, make sure the interviewer knows what you're doing! Explain to them that you're assuming that the cache is globally scoped, and even clue them into how you would approach the actual implementation of it.

### Warmup

Now that we've dealt with the annoying cache problem, let's start with a problem similar to Fibonacci. We'll define the *Blair numbers* as follows:

- The first Blair number, <i>b<sub>1</sub></i>, is 1,
- The second Blair number, <i>b<sub>2</sub></i>, is 2,
- The <i>k</i>th Blair number is the sum of the previous two Blair numbers plus the *k* - 1st odd number. For example, <i>b<sub>3</sub></i> = <i>b<sub>2</sub></i> + <i>b<sub>1</sub></i> + 2nd odd = 1 + 2 + 3 = 6.

Your job in this warmup is to write `blair_nums(n)`, which should return the *nth* Blair number. First, write this function recursively. Here's an outline of the code to get you started:

```ruby
class DynamicProgramming
  ...

  def blair_nums(n)
    # Base case(s): which inputs n should return early?
    # Recursive case: what's the recursive relationship?
    # *NB*: you'll need to figure out how to express the nth odd number in terms of n.
  end

  ...
end
```
Try running `blair_nums(100)`. Assuming you haven't yet done any optimization, it's probably pretty slow. Is it done yet? Probably not. How about now? Not yet! Let's introduce a cache as we did with the Fibonacci numbers to optimize the runtime. Start by adding an instance variable to our `initialize` function.

```ruby
def initialize
  @blair_cache = {}
end
```
But wait! We have some information about the Blair numbers that we didn't include in the cache: those two base cases, <i>b<sub>1</sub></i> and <i>b<sub>2</sub></i>. Add those to the cache as well.

Now it's time to optimize `blair_nums`. Remember, we want to *check the cache first* and return early if we find our answer is already stored. We also want to add any new answers that we find to `@blair_cache` before returning.

```ruby
def blair_nums(n)
  # Check the cache for a stored answer
  # If not found, 1) perform the recursion, 2) store the answer, 3) return the answer.  
end
```

Now try running `blair_nums(100)` again. If you've done it right, it should finish running by the time you finish reading this sentence! What was the time complexity of the original, unoptimized `blair_nums`? What's the time complexity of the optimized function?

You've just written `blair_nums` using top-down dynamic programming. Can you write `blair_nums` using bottom-up dynamic programming? Remember, *bottom-up* means that you're going to create the *entire* cache first, then return the appropriate (usually the last) entry. Use the bottom-up implementation of `fibonacci(n)` as a guide.

### Frogs Hopping

A frog is sitting at the bottom of a staircase with *n* stairs. Tiny little frog can only jump so many steps at once. In particular, it can only hop 1, 2, or 3 steps at a time.

<img src="dp_images/frog_diagram.png" />

Given this information, write a function to return the number of ways the frog can get to the top of the stairs. For example, if there are two stairs in the staircase, there are two ways for the frog to get to the top: hop 2 steps, or hop 1 step and then hop 1 step again. For *n* = 3, there are 4 ways: [1, 1, 1], [1, 2], [2, 1], and [3].

Instead of approaching this with top-down DP, let's practice our bottom-up skills. Let <i>s</i><sub>n</sub> be the number of ways the frog can hop to the top of *n* stairs. The first step is to define the recursive relationship between the answer we want, <i>s</i><sub>n</sub>, and previous answers for smaller staircases. The key observation here is that the frog has 3 choices for its first hop: it can hop 1 stair, 2 stairs, or 3 stairs. This means that:

<i>s</i><sub>n</sub> = <i>s</i><sub>n - 1</sub> + <i>s</i><sub>n - 2</sub> + <i>s</i><sub>n - 3</sub>

Careful, though! This relationship only holds true if *n* is large enough. What happens when *n* is below a certain threshold? What is that threshold?

The equation above tells us something important: we can build the *ith* solution using only the *i* - 1st, *i* - 2nd, and *i* - 3rd solutions. This is what we will do, until we have built enough previous solutions to get the *n*-th solution. Start by defining two functions in your `DynamicProgramming` class:

```ruby
def frog_hops(n)
end

def frog_cache_builder(n)
end
```
Remember that when we use a bottom-up approach, we don't need to define an instance variable in `initialize`. You will do this for the top-down approach, however.

Let's build out `frog_cache_builder`. Start from the bottom: create a cache (a hash or an array will work here). Add the solutions for the three base cases to this cache. Make sure to add a check to see if *n* falls into one of these cases before building out the rest of the function.

```ruby
def frog_cache_builder(n)
  # Make a hash or array for storing previous solutions
  # Add the base cases to the cache
end
```
Next, build up the solutions in the cache. Start with 4 and go all the way up to *n*, using the recursive relationship we found previously. Finally, return the cache.

```ruby
def frog_cache_builder(n)
  # Make a hash or array for storing previous solutions
  # Add the base cases to the cache  
  # Build solutions 4..n into the cache
  # Return the cache
end
```
Now, it's time to build `frog_hops`. This one is easy: build the cache that you need using `frog_cache_builder`, and return the correct entry from that cache. What's the time complexity of `frog_hops(n)`?

Next, build a top-down implementation of the same function. As we did with the Blair numbers, write it recursively first, then introduce a cache that gets checked and updated upon finding new solutions.

### Super-Charged Frogs

Let's generalize the frog problem. This time, frogs have different jumping capacities. Some frogs can hop up to 10, 20, or 100 times at once, some only 3 or 4 times. The maximum number of jumps a frog can do will be passed in as a parameter, `max_stairs`, to the function you'll write.

Write a function, `super_frog_hops(num_stairs, max_stairs)` that takes in the number of stairs and the maximum number of stairs that can be hopped at once, and returns the number of ways this frog can make its journey.

First, we need to figure out the recursive relationships within this problem. This time, you'll have a heavier hand in designing the algorithm. Here's a list of questions that you should ask yourself as a guide.

1. What are the base case(s)? (Hint: you may be tempted to include *more* base cases than before, but it might make more sense to go *smaller* -- reduce the number of base cases used in `frog_hops`.)
2. What previous solutions do you need in order to find `super_frog_hops(num_stairs, max_stairs)`?
3. What happens when `max_stairs > num_stairs`? It might make sense to separate this case from the case where `max_stairs <= num_stairs`.

If you find yourself getting stuck, try looking at some reasonably-sized examples. Try `max_stairs = 4` at first.

Once you've defined the recursive relationships here, decide how to optimize. Choose either top-down or bottom-up implementation. What should you store in the cache? What answer should be returned? Create the necessary helper function or instance variable to suit your needs.

### Maze Solver

You're given a maze and asked to find a path from its starting location to the finish. The maze is 2-dimensional, and will be represented by an array of characters. Empty squares are represented with `" "`, blocked spaces with `"X"`, your location with `"L"`, and the finish with `"F"`.  Here's an example:

<img src="dp_images/maze_1.png" />

Write a function that takes in the maze array, starting position, and ending position, and returns an array of moves from start to finish. One possible return value for the example above is [[0, 0], [1, 0], [1, 1], [1, 2], [2, 2], [3, 2], [3, 3], [3, 4]]. There are a few other valid paths as well -- any one of them is a satisfactory return value.

This may not seem as straightforward an application of recursion as the previous examples. True! But there is a recursive structure here. Take note of a couple things:

1. Whatever position we find ourselves at in the maze, we have up to 4 choices for our next move: up, down, left, or right. Some of these may be blocked or out of bounds, however.
2. There's a base case here. What is it? Hint: for which position(s) in the maze do we already know the shortest possible path?

This gives us a pretty clear outline for our recursive algorithm. We'll check for our base case and return early if we find it. Otherwise, we'll run our algorithm on all the legal next moves and choose the one that returns the shortest path.

Conceptually, this makes sense. How do we implement it? Let's outline a purely recursive function before introducing any optimizations. Start with the base case. If you're at "F", you should return an array with just the coordinates of the "F" square.

```ruby
def maze_solver(maze)
  # Implement the base case here
end
```
Next, write the recursive case. Check all valid moves and choose the one that gives you the shortest path to the finish. Remember to add your current position's coordinates to the path!  

Try your function out on the example maze we gave above. Do you get the expected output? If so, you're ready to optimize!

What's the time complexity of `maze_solver`? Think about a relatively simple case: an `n x n` maze with no obstacles (i.e., all " " characters). About how many choices will we have for each move that we make? Make a rough sketch of a decision tree to help you visualize how many calls are being made. Come up with at least a good lower bound on the time complexity.

Now let's improve that time complexity by using dynamic programming. Let's think about what information we need to cache. Throughout the course of our recursion, we'll encounter the same square over and over again. For example, look at our example maze and two paths that we'll end up trying:

<img src="dp_images/maze_overlaps.png" />

One approach would be to store the entire shortest path from each position to the end point in a hash. However, this would take up an enormous amount of space. Instead, for each position in the maze, let's only store the *next move* in its optimized path.

Take a top-down approach for this one. Create the instance variable that you need, `@maze_cache`, initializing it to an empty array or hash. An 2-dimensional array the same size as the maze is a straightforward choice in this case -- you'll be able to refer more easily to a given coordinate in the maze. Now, since you won't get the actual maze until the `maze_solver` function is run, you won't be able to populate any base cases to your `@maze_cache` on initialization of the `DynamicProgramming` object. That's okay, though. Set it up with this work-around:

```ruby
class DynamicProgramming
  def initialize
    @maze_cache = []
  end

  def maze_solver(maze, start_pos, finish_pos)
    # Call populate_maze_cache to set up the maze cache
    # Call and return or parse the result of solve_maze
  end

  private
  def populate_maze_cache(maze)
    # Create a maze_cache of the correct size
    # Record base case(s) in the cache
  end

  def solve_maze(maze, start_pos, finish_pos)
    # Do the actual work of solving the maze
  end
end
```
This is all the setup you need! Now, put your dynamic programming skills to work -- check the cache and record new results in the cache as you go. Try running your new code on the example maze. Does it still work? Also try running your code on the big example we gave. It should return in a few seconds this time!

How would you approach this problem using a bottom-up implementation? Hint: you may want to record *previous* steps to a solution instead of *next* steps.

### Making the Best Change

In the DP reading, we saw one example of the all too popular `make_change` question. This is a classic interview question, so it's good to know the approach well. This time, we'll return to the question as it's usually stated: write a function that takes in a set of coins and an amount, and returns the set of coins that make change for the amount using the fewest number of coins. Return `nil` if it's not possible for the amount using the given set of coins.

As an example, suppose `coins = [2, 5, 10]`. Then `amt = 14` should return `[2, 2, 10]`, `amt = 3` should return `nil`, and `amt = 15` should return `[5, 10]`.

The recursive approach should be review from earlier in the course, but let's discuss it anyhow. First, find the base case(s). These will be similar to the base cases outlined in the reading.

Next, let's tackle the recursion. It's tempting to use this **flawed** approach:

#### Flawed Approach
1. Choose one of the coins to be the "first" coin in your set of change. Subtract that coin from your amount and make a recursive call with *amount - first_coin* and the original set of coins.   
2. Take the best of the answers you get from these recursive calls and return it.

This "solution" has a big flaw, though: the tricky part about this problem is that the order of the coins does *not* matter. So, the solution [2, 2, 5] is the same as the solution [5, 2, 2], and we should count it as such. The algorithm above would make a distinction between these two. What *is* unique about this solution is the number of each coin that is included in the set of change: there are two 2's and one 5. So, we approach our recursion from that perspective.

#### Correct Approach
1. Find the smallest coin. Include increasing numbers of copies of that coin until you exceed the given amount. E.g., use 0, 1, 2, ... *k* copies of that coin until *k* x *coin* > *amount*. Make a recursive call for each of these. (What should the `coins` array be for these calls?)
2. Return the optimal solution resulting from Step 1.

If you need the review, implement the purely recursive version of `make_change`. Then, optimize it using a cache and a top-down approach.

Now, go for the bottom-up approach. Build the cache that you ended up with in the top-down implementation, but do so starting with the smallest cases and building up to the biggest case you'll need.

## Bonus

Make a visual interface for `maze_solver` using Javascript. Having a visualization for a technically complex problem is a great way to appeal to folks like recruiters, who might not have a good sense for the coding side of things. Plus, it's fun and pretty!

## Next Steps

Tomorrow, we'll do some more advanced Dynamic Programming problems for part 2!
