# encoding: utf-8
require 'fileutils'

# methods
#---------
# create File name for URL
def createURL(string)
    string.downcase!
    string.gsub! " ", "-"
    string.encode!("UTF-8")
    string.gsub! "ä", "ae"
    string.gsub! "ö", "oe"
    string.gsub! "ü", "ue"
end

# replace every colon within yml, so that it still can get parsed correctly
def sanitizeYML(string)
    string.gsub! ":", "&colon;"
end

# for colored output
class String
def black;          "\033[30m#{self}\033[0m" end
def red;            "\033[31m#{self}\033[0m" end
def green;          "\033[32m#{self}\033[0m" end
def brown;          "\033[33m#{self}\033[0m" end
def blue;           "\033[34m#{self}\033[0m" end
def magenta;        "\033[35m#{self}\033[0m" end
def cyan;           "\033[36m#{self}\033[0m" end
def gray;           "\033[37m#{self}\033[0m" end
def bg_black;       "\033[40m#{self}\033[0m" end
def bg_red;         "\033[41m#{self}\033[0m" end
def bg_green;       "\033[42m#{self}\033[0m" end
def bg_brown;       "\033[43m#{self}\033[0m" end
def bg_blue;        "\033[44m#{self}\033[0m" end
def bg_magenta;     "\033[45m#{self}\033[0m" end
def bg_cyan;        "\033[46m#{self}\033[0m" end
def bg_gray;        "\033[47m#{self}\033[0m" end
def bold;           "\033[1m#{self}\033[22m" end
def reverse_color;  "\033[7m#{self}\033[27m" end
end

# variables
#-----------

# date
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

# Generator
#-----------

# starting msg
puts "\n\nInitating Front Matter Generator for Themes.\nPlease enter the following information as per instruction.\n".bold.green
puts ""

# Title German
puts "Enter theme name. It should not be longer than 55 characters".bold.gray
title = gets.chomp

if title.length > 55
    puts "Your title is too long, please enter a shorter title".bold.brown
    title = gets.chomp
    if title.length > 55
        abort('Program was aborted, because Title was too long. Please restart'.bold.red)
    end
end

file_name = title

# create URL
createURL(file_name)
url_title = file_name

# if there is a folder specified, add it and create a new folder, if it does not already exist
folder = "_themes"

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
    path_german = "#{folder}/#{url_title}#{file_ending}"
    path_english = "#{folder}/en-#{url_title}#{file_ending}"

    dirname = File.dirname(path_german)
    unless File.directory?(dirname)
        FileUtils.mkdir_p(dirname)
    end
else
    path_german = "#{url_title}#{file_ending}"
    path_english = "en-#{url_title}#{file_ending}"
end

#subtitle
puts ""
puts "Enter Subtitle\n(press enter if you don't want to add a subtitle)".bold.gray
subtitle = gets.chomp

# Description German
puts ""
puts "Enter german description. It shouldn't be longer than 115 characters".bold.gray
desc_german = gets.chomp

if desc_german.length > 115
    puts "Your description is too long, please enter a shorter description".bold.brown
    desc_german = gets.chomp
    if desc_german.length > 115
        abort('Program was aborted, because description was too long. Please restart'.bold.red)
    end
elsif desc_german == ''
    puts "Please enter a description, shorter than 115 characters".bold.gray
    desc_german = gets.chomp
    if desc_german == ''
        abort("Program was aborted, because no valid description was entered. Please restart".bold.red)
        if desc_german.length > 115
            puts "Your description is too long, please enter a shorter description".bold.brown
            desc_german = gets.chomp
            if desc_german.length > 115
                abort('Program was aborted, because description was too long. Please restart'.bold.red)
            end
        end
    end
end

# Description english
puts ""
puts "Enter english description. It shouldn't be longer than 115 characters".bold.gray
desc_english = gets.chomp

if desc_english.length > 115
    puts "Your description is too long, please enter a shorter description".bold.brown
    desc_english = gets.chomp
    if desc_english.length > 115
        abort('Program was aborted, because description was too long. Please restart'.bold.red)
    end
elsif desc_english == ''
    puts "Please enter a description, shorter than 115 characters".bold.gray
    desc_english = gets.chomp
    if desc_english == ''
        abort("Program was aborted, because no valid description was entered. Please restart".bold.red)
        if desc_english.length > 115
            puts "Your description is too long, please enter a shorter description".bold.brown
            desc_english = gets.chomp
            if desc_english.length > 115
                abort('Program was aborted, because description was too long. Please restart'.bold.red)
            end
        end
    end
end

#theme-desc-head german
puts ""
puts "Enter german theme description header".bold.gray
theme_desc_head_german = gets.chomp

if theme_desc_head_german == ''
    puts "Please enter a theme description header".bold.gray
    theme_desc_head_german = gets.chomp
    if theme_desc_head_german == ''
        abort("Program was aborted, because no valid theme description header was entered. Please restart".bold.red)
    end
end

#theme-desc-head english
puts ""
puts "Enter english theme description header".bold.gray
theme_desc_head_english = gets.chomp

if theme_desc_head_english == ''
    puts "Please enter a theme description header".bold.gray
    theme_desc_head_english = gets.chomp
    if theme_desc_head_english == ''
        abort("Program was aborted, because no valid theme description header was entered. Please restart".bold.red)
    end
end

#theme-desc german
puts ""
puts "Enter german theme description".bold.gray
theme_desc_german = gets.chomp

if theme_desc_german == ''
    puts "Please enter a theme description".bold.gray
    theme_desc_german = gets.chomp
    if theme_desc_german == ''
        abort("Program was aborted, because no valid theme description was entered. Please restart".bold.red)
    end
end

#theme-desc english
puts ""
puts "Enter theme description".bold.gray
theme_desc_english = gets.chomp

if theme_desc_english == ''
    puts "Please enter a theme description".bold.gray
    theme_desc_english = gets.chomp
    if theme_desc_english == ''
        abort("Program was aborted, because no valid theme description was entered. Please restart".bold.red)
    end
end

# theme-demo
puts ""
puts "Enter theme demo URL".bold.gray
theme_demo = gets.chomp

if theme_demo == ''
    puts "Please enter theme demo URL".bold.gray
    theme_demo = gets.chomp
    if theme_demo == ''
        abort("Program was aborted, because no valid theme demo URL was entered. Please restart".bold.red)
    end
end

# theme-source
puts ""
puts "Enter theme source URL".bold.gray
theme_source = gets.chomp

if theme_source == ''
    puts "Please enter theme source URL".bold.gray
    theme_source = gets.chomp
    if theme_source == ''
        abort("Program was aborted, because no valid theme source URL was entered. Please restart".bold.red)
    end
end

# theme-docs
puts ""
puts "Enter theme docs URL".bold.gray
theme_docs = gets.chomp

if theme_docs == ''
    puts "Please enter theme docs URL".bold.gray
    theme_docs = gets.chomp
    if theme_docs == ''
        abort("Program was aborted, because no valid theme docs URL was entered. Please restart".bold.red)
    end
end

# theme-img
puts ""
puts "Enter the image to be used on the theme page".bold.gray
theme_img = gets.chomp

if theme_img == ''
    puts "Please enter image name".bold.gray
    theme_img = gets.chomp
    if theme_img == ''
        abort("Program was aborted, because no valid image name was entered. Please restart".bold.red)
    end
end

puts ""
puts "Is the same image going to be used on the theme's page?(yes/no)".bold.gray
is_img_the_same = gets.chomp

case is_img_the_same
when "yes", "y"
    theme_preview = theme_img
when "no", "n"
    # theme-preview
    puts "Enter the image to be used on the theme preview page".bold.gray
    theme_preview = gets.chomp

    if theme_preview == ''
        puts "Please enter image name".bold.gray
        theme_preview = gets.chomp
        if theme_preview == ''
            abort("Program was aborted, because no valid image name was entered. Please restart".bold.red)
        end
    end
else
    puts "Please enter either 'yes' or 'no'".bold.brown
    is_img_the_same = gets.chomp
    case is_img_the_same
    when "yes", "y"
        theme_preview = theme_img
    when "no", "n"
        # theme-preview
        puts ""
        puts "Enter the image to be used on the theme preview page".bold.gray
        theme_preview = gets.chomp

        if theme_preview == ''
            puts "Please enter image name".bold.gray
            theme_preview = gets.chomp
            if theme_preview == ''
                abort("Program was aborted, because no valid image name was entered. Please restart".bold.red)
            end
        end
    else
        abort("Program was aborted. Please restart and follow instructions".bold.red)
    end
end


# category
puts ""
puts "Enter category".bold.gray
category = gets.chomp

if category == ''
    puts "Please enter category".bold.gray
    category = gets.chomp
    if category == ''
        abort("Program was aborted, because no valid category was entered. Please restart".bold.red)
    end
end

#tags
puts ""
puts "Enter tags, separate with commas\n(press enter if you don't want to add tags)".bold.gray
tags = gets.chomp

sanitizeYML(title)
sanitizeYML(subtitle)

# create new file german
p_german = File.open( path_german,"w" )

sanitizeYML(desc_german)

# file content
p_german.puts "---"
p_german.puts "date: #{time}"
p_german.puts "title: #{title}"
if subtitle != ""
    p_german.puts "subtitle: #{subtitle}"
end
if tags != ""
    p_german.puts "tags: [#{tags}]"
end
p_german.puts "description: #{desc_german}"
p_german.puts "theme-desc-head: #{theme_desc_head_german}"
p_german.puts "theme-desc: #{theme_desc_german}"
p_german.puts "theme-demo: #{theme_demo}"
p_german.puts "theme-source: #{theme_source}"
p_german.puts "theme-docs: #{theme_docs}"
p_german.puts "theme-img: #{theme_img}"
p_german.puts "theme-preview: #{theme_preview}"
p_german.puts "category: #{category}"
p_german.puts "lang: de"
p_german.puts "id: #{title}"
p_german.puts "---"
p_german.close

# create new file
p_english = File.open( path_english,"w" )

# file content
p_english.puts "---"
p_english.puts "date: #{time}"
p_english.puts "title: #{title}"
if subtitle != ""
    p_english.puts "subtitle: #{subtitle}"
end
if tags != ""
    p_english.puts "tags: [#{tags}]"
end
p_english.puts "description: #{desc_english}"
p_english.puts "theme-desc-head: #{theme_desc_head_english}"
p_english.puts "theme-desc: #{theme_desc_english}"
p_english.puts "theme-demo: #{theme_demo}"
p_english.puts "theme-source: #{theme_source}"
p_english.puts "theme-docs: #{theme_docs}"
p_english.puts "theme-img: #{theme_img}"
p_english.puts "theme-preview: #{theme_preview}"
p_english.puts "category: #{category}"
p_english.puts "lang: en"
p_english.puts "id: #{title}"
p_english.puts "permalink: /en/themes/#{url_title}/"
p_english.puts "---"
p_english.close

puts "file '#{path_german}' created".bold.green
puts "file '#{path_english}' created".bold.green
puts ""
puts "opening file in brackets".bold.green
value = `brackets #{path_german}`
value = `brackets #{path_english}`
