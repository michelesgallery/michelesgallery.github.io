---
date: 2015-06-06 10:01:07 +0200
title: A front Matter generator with ruby ♦♦
name: EFMGmR
subtitle: Why I will no longer remember my front matter variables
tags: [jekyll, ruby, front matter, generator, ♦♦]
description: How I wrote a jekyll front matter generator with ruby.
category: en
---
After an Introduction to Java a few years ago in school I decided to leave the programming languages behind me. I think if we'd have gotten an introduction to Ruby, my opinion would have been different.
I had studied ruby for one day, when I wrote the first version of this generator. After a year of Java I was not even able to program as much functionality as I can with just a few lines of JavaScript and CSS today.
And the thing I wrote in ruby is definitely more useful. Because It means that I will never again write front matter declarations in a jekyll page.

<br><!-- more -->
<div class="video">
    <iframe src="https://www.youtube.com/embed/oVUMEKLBLw0" frameborder="0" allowfullscreen></iframe>
</div>


I have written another front matter generator a while ago[^1], it worked pretty good, but for me too many steps were involved until the file was at the right place. I just wanted to enter my data and then - preferably - have the file opened in my favourite editor so I could just go on write the content.

I got inspired, when I had a look at some jekyll plugins, that did generate new files. So I thought Ruby is the way to go. I started the course at [Codecademy](http://www.codecademy.com/en/tracks/ruby) and 60% into it, decided to give this generator a go and it basically wrote itself.
How I wrote it, is what I want to show you today.

### Collecting Variables
Okay, first step is pretty obvious. Before you can write a front matter generator, you need all of the relevant variables, to be included. In this tutorial I want to present a shorter generator than my personal one. Mine generates two files since I'm posting in two languages and certain variables share values.

The variables I use for this generator are as follows:

Variable | Description | Some more to note
---|---|---
title | the title | should not be longer than 55 characters
url-title | This is not a front matter variable, but important for the file name | this should not include empty spaces or special characters
subtitle | the subtitle | optional
description | Meta tag description | not longer than 115 characters
tags | tags | are in an array, and optional

I just want the subtitle and tags to be optional. All of the others are needed, especially for SEO purposes. 

### File
Okay, the file will be placed within a ruby folder. And since most jekyll sites use git, you will most probably have your terminal open at the root. So it is easy to navigate to the Posts folder. My script is within the ruby folder, so I can call it using `ruby _ruby/createpost.rb`

Okay, open your favourite editor. Mine is [Brackets](http://brackets.io/) and then we can get started.

Since we need to create a new file, we will need a require. And then we start with the methods.

Since I like my output to be colorful, I googled and found the classes to create some color.

```ruby
# encoding: utf-8
require 'fileutils'

# for colored output
class String
def red;            "\033[31m#{self}\033[0m" end
def green;          "\033[32m#{self}\033[0m" end
def brown;          "\033[33m#{self}\033[0m" end
def gray;           "\033[37m#{self}\033[0m" end
def bold;           "\033[1m#{self}\033[22m" end
end
```

We need different methods so that the generator works a bit faster.

First we have createURl, which replaces all of the german umlaut characters with an equivalent representation and all of the spaces with a hyphen. It looks like this:

```ruby
# create File name for URL
def createURL(string)
    string.downcase!
    string.gsub! " ", "-"
    string.encode!("UTF-8")
    string.gsub! "ä", "ae"
    string.gsub! "ö", "oe"
    string.gsub! "ü", "ue"
end
```

To remove the umlauts, we also create a method

```ruby
# replace all ä,ö,ü with Unicode
def umlautify(string)
    string.encode!("UTF-8")
    string.gsub! "ä", "&auml;"
    string.gsub! "Ä", "&Auml;"
    string.gsub! "ö", "&ouml;"
    string.gsub! "Ö", "&Ouml;"
    string.gsub! "ü", "&uuml;"
    string.gsub! "Ü", "&Uuml;"
end
```

And since any colon in yaml within the content can cause problems, we replace them with the unicode representation. 

```ruby
# replace every colon within yml, so that it still can get parsed correctly
def sanitizeYML(string)
    string.gsub! ":", "&colon;"
end
```

Since this is going to generate posts we need to work on the date. So first we'll save some variables. First the time which exactly spits out what we need for the date variable and then we'll get the year, day and month for the file name. And we'll also make sure that the numbers below 10 will be prepended with a zero.

```ruby
# date
#------
time = Time.new
year = time.year.to_s

#if day and month are below 10, add a 0 in front of it
if time.day <= 9
    day = "0#{time.day}"
else
    day = time.day.to_s
end

if time.month <= 9
    month = "0#{time.month}"
else
    month = time.month.to_s
end
```

### Generator
As soon as that's done, we can start the generator.

We start by inserting a initiation message `\n` tells it, to start a new line. And we'll do that in bold and green

```ruby
# Generator
#-----------

# starting msg
puts "Initating Front Matter Generator for Posts.\nPlease enter the following information as per instruction.\n".bold.green
puts ""
```

Then we'll ask for the title and save the input in a variable. We then check the value. If it's above 55 characters or empty, we will ask once again. If it is not inserted correctly a second time, we'll abort the program and ask for a restart.

```ruby
# Title
puts "Enter post title. It should not be longer than 55 characters".bold.gray
title = gets.chomp

if title.length > 55
    puts "Your title is too long, please enter a shorter title".bold.brown
    title = gets.chomp
    if title == ''
        abort("Program was aborted, because no valid title was entered. Please restart".bold.red)
    elsif title.length > 55
        abort('Program was aborted, because title was too long. Please restart'.bold.red)
    end
elsif title == ''
    puts "Please enter a title, shorter than 55 characters".bold.gray
    title = gets.chomp
    if title == ''
        abort("Program was aborted, because no valid title was entered. Please restart".bold.red)
    elsif title.length > 55
        abort('Program was aborted, because title was too long. Please restart'.bold.red)
    end
end
```

Then we ask if the title is equal to the URL part, so the file name. If it is, we'll set the file name variable to title, else we ask for input. And also if somethings wrong we abort the program.

```ruby
# URL Title
puts ""
puts "Is the title going to be equal to the URL Title?\n(yes/no)".bold.gray
url_title_yes_or_no = gets.chomp

case url_title_yes_or_no
when "yes", "y"
    file_name = title
when "no", "n"
    puts "Enter the URL title".bold.gray
    file_name = gets.chomp
    if file_name == ''
        puts "Please enter a valid file name".bold.brown
        file_name = gets.chomp
        if file_name == ''
            abort("Program was aborted. Please restart and follow instructions".bold.red)
        end
    end
else
    puts "Please enter either 'yes' or 'no'".bold.brown
    url_title_yes_or_no = gets.chomp
    case url_title_yes_or_no
    when "yes", "y"
        file_name = title
    when "no", "n"
        puts "Enter the URL title".bold.gray
        file_name = gets.chomp
        if file_name == ''
            puts "Please enter a valid file name".bold.brown
            file_name = gets.chomp
            if file_name == ''
                abort("Program was aborted. Please restart and follow instructions".bold.red)
            end
        end
    else
        abort("Program was aborted. Please restart and follow instructions".bold.red)
    end
end
```

Now that we have the URL title, we'll transform it into the URL format. For that we use the method we defined before. And then we'll set the file path. We define the folder and if it does not already exist, we'll create it. 

```ruby
# create URL
createURL(file_name)

# if there is a folder specified, add it and create a new folder, if it does not already exist
folder = "_posts/"

file_format = "markdown"
case file_format
when "md", "markdown"
    file_ending = ".md"
when "html", "HTML"
    file_ending = ".html"
when "txt", "textile"
    file_ending = ".txt"
else
    file_ending = ""
end

# set path for file
if folder != nil
    path = "#{folder}/#{year}-#{month}-#{day}-#{file_name}#{file_ending}"

    dirname = File.dirname(path)
    unless File.directory?(dirname)
        FileUtils.mkdir_p(dirname)
    end
else
    path = "#{year}-#{month}-#{day}-#{file_name}#{file_ending}"
end
```

Subtitle and tags are both optional, so we just ask if there is any input, otherwise nothing happens.

```ruby
#subtitle
puts ""
puts "Enter subtitle\n(press enter if you don't want to add a subtitle)".bold.gray
subtitle = gets.chomp

#tags
puts ""
puts "Enter tags, separate with commas\n(press enter if you don't want to add tags)".bold.gray
tags = gets.chomp
```

For the description we do the same we did for the title

```ruby
# Description
puts ""
puts "Enter post description. It shouldn't be longer than 115 characters".bold.gray
desc = gets.chomp

if desc.length > 115
    puts "Your description is too long, please enter a shorter description".bold.brown
    desc = gets.chomp
    if desc == ''
        abort("Program was aborted, because no valid description was entered. Please restart".bold.red)
    elsif desc.length > 115
        abort('Program was aborted, because description was too long. Please restart'.bold.red)
    end
elsif desc == ''
    puts "Please enter a description, shorter than 55 characters".bold.gray
    desc = gets.chomp
    if desc == ''
        abort("Program was aborted, because no valid desription was entered. Please restart".bold.red)
    elsif desc.length > 115
        abort('Program was aborted, because description was too long. Please restart'.bold.red)
    end
end
```

And then we're ready to create the file.
We'll execute the methods to clean up the content and then we'll add it into the file content.

```ruby
# create new file
p = File.open( path,"w" )

sanitizeYML(title)
sanitizeYML(subtitle)
sanitizeYML(desc)

umlautify(title)
umlautify(subtitle)
umlautify(tags)
umlautify(desc)

# file content
p.puts "---"
p.puts "date: #{time}"
p.puts "title: #{title}"
if subtitle != ""
    p.puts "subtitle: #{subtitle}"
end
if tags != ""
    p.puts "tags: [#{tags}]"
end
p.puts "description: #{desc}"
p.puts "---"
p.close
```

At the end we'll put out the created path and open the file in brackets, executing the command `brackets <path>`.

And then the program is done.

```ruby
# add notification that file was created
puts "file '#{path}' created".bold.green
puts ""
puts "opening file in brackets".bold.green

# add command to open file in brackets
value = `brackets #{path}`
```

And you can see the whole thing [here](https://gist.github.com/mynimi/7592bb381cbdf0d66644#file-createpost-rb).


[^1]: it was based on javascript and built for the web. Post is German only: [jekyll für Nicht-Hacker](http://digitalmind.ch/ein-front-matter-generator-fuer-jekyll/)