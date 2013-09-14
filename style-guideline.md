# Style guideline

Here is a short guideline for the style to use in the project.

## General

* Indent with two spaces
* Leave a blank line at the end of file

## Ruby

Generally speaking, just follow Ruby (and Rails) coding style convention.

* Class names in `PascalCase`
* Variable names in `snake_case`
* Use brackets only for single line block:

    ```ruby
    foo.map { |e| e + 1 }
    ```

* Use `do` and `end` for multiple line blocks:

    ```ruby
    foo.each do |e|
      array << e
      puts e
    end
    ```

* Use `then` only in single line `if`:

    ```ruby
    a = if condition then 1 else 3
    ```

  in other cases just use `if`:

    ```ruby
    if foo
      bar
    else
      baz
    end
    ```

## CoffeeScript

* Class names in `PascalCase`
* Variable names in `camelCase`
