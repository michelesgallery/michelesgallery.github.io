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

# take first letter of string of words
def createId(string)
    string.split.map{|w|w[0]}.join
end

def umlautify(string)
    string.encode!("UTF-8")
    string.gsub! "ä", "&auml;"
    string.gsub! "Ä", "&Auml;"
    string.gsub! "ö", "&ouml;"
    string.gsub! "Ö", "&Ouml;"
    string.gsub! "ü", "&uuml;"
    string.gsub! "Ü", "&Uuml;"
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
puts "Initating Front Matter Generator for Posts.\nPlease enter the following information as per instruction.\n".bold.green
puts ""

# Title German
puts "Enter german post title. It should not be longer than 55 characters".bold.gray
title_german = gets.chomp

if title_german.length > 55
    puts "Your title is too long, please enter a shorter title".bold.brown
    title_german = gets.chomp
    if title_german.length > 55
        abort('Program was aborted, because Title was too long. Please restart'.bold.red)
    end
end

# Title English
puts "Enter english post title. It should not be longer than 55 characters".bold.gray
title_english = gets.chomp

if title_english.length > 55
    puts "Your title is too long, please enter a shorter title".bold.brown
    title_english = gets.chomp
    if title_english.length > 55
        abort('Program was aborted, because Title was too long. Please restart'.bold.red)
    end
end

# URL Title German
puts ""
puts "Is the german title going to be equal to the URL Title?\n(yes/no)".bold.gray
url_title_german_yes_or_no = gets.chomp

case url_title_german_yes_or_no
when "yes", "y"
    file_name_german = title_german
when "no", "n"
    puts "Enter the german URL title".bold.gray
    file_name_german = gets.chomp
else
    puts "Please enter either 'yes' or 'no'".bold.brown
    url_title_german_yes_or_no = gets.chomp
    case url_title_german_yes_or_no
    when "yes", "y"
        file_name_german = title_german
    when "no", "n"
        puts "Enter the german URL title".bold.gray
        file_name_german = gets.chomp
    else
        abort("Program was aborted. Please restart and follow instructions".bold.red)
    end
end

# create URL
url_title_german = file_name_german.downcase.gsub(" ", "-").encode("UTF-8").gsub("ä", "ae").gsub("ö", "oe").gsub("ü", "ue")

# URL title English
puts ""
puts "Is the english title going to be equal to the URL Title?\n(yes/no)".bold.gray
url_title_english_yes_or_no = gets.chomp

case url_title_english_yes_or_no
when "yes", "y"
    file_name_english = title_english
when "no", "n"
    puts "Enter the english URL title".bold.gray
    file_name_english = gets.chomp
else
    puts "Please enter either 'yes' or 'no'".bold.brown
    url_title_english_yes_or_no = gets.chomp
    case url_title_english_yes_or_no
    when "yes", "y"
        file_name_english = title_english
    when "no", "n"
        puts "Enter the english URL title".bold.gray
        file_name_english = gets.chomp
    else
        abort("Program was aborted. Please restart and follow instructions".bold.red)
    end
end

# create URL
url_title_english = file_name_english.downcase.gsub(" ", "-").encode("UTF-8").gsub("ä", "ae").gsub("ö", "oe").gsub("ü", "ue")

# if there is a folder specified, add it and create a new folder, if it does not already exist
folder_german = "_posts/de"
folder_english = "_posts/en"

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
if folder_german != nil
    path_german = "#{folder_german}/#{year}-#{month}-#{day}-#{url_title_german}#{file_ending}"

    dirname_german = File.dirname(path_german)
    unless File.directory?(dirname_german)
        FileUtils.mkdir_p(dirname_german)
    end
else
    path_german = "#{year}-#{month}-#{day}-#{url_title_german}#{file_ending}"
end

# set path for file
if folder_english != nil
    path_english = "#{folder_english}/#{year}-#{month}-#{day}-#{url_title_english}#{file_ending}"

    dirname_english = File.dirname(path_english)
    unless File.directory?(dirname_english)
        FileUtils.mkdir_p(dirname_english)
    end
else
    path_english = "#{year}-#{month}-#{day}-#{url_title_english}#{file_ending}"
end

#subtitle German
puts ""
puts "Enter german subtitle\n(press enter if you don't want to add a subtitle)".bold.gray
subtitle_german = gets.chomp

#subtitle english
puts ""
puts "Enter english subtitle\n(press enter if you don't want to add a subtitle)".bold.gray
subtitle_english = gets.chomp

#tags
puts ""
puts "Enter tags, separate with commas\n(press enter if you don't want to add tags)".bold.gray
tags = gets.chomp

# Description german
puts ""
puts "Enter german post description. It shouldn't be longer than 115 characters".bold.gray
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
puts "Enter english post description. It shouldn't be longer than 115 characters".bold.gray
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

# generate ID
id = createId(title_german)

# create new file German
p_german = File.open( path_german,"w" )

sanitizeYML(title_german)
sanitizeYML(subtitle_german)
sanitizeYML(desc_german)

umlautify(title_german)
umlautify(id)
umlautify(subtitle_german)
umlautify(desc_german)

# file content
p_german.puts "---"
p_german.puts "date: #{time}"
p_german.puts "title: #{title_german}"
p_german.puts "name: #{id}"
if subtitle_german != ""
    p_german.puts "subtitle: #{subtitle_german}"
end
if tags != ""
    p_german.puts "tags: [#{tags}]"
end
p_german.puts "description: #{desc_german}"
p_german.puts "---"
p_german.close

# create new file english
p_english = File.open( path_english,"w" )

sanitizeYML(title_english)
sanitizeYML(subtitle_english)
sanitizeYML(desc_english)

# file content
p_english.puts "---"
p_english.puts "date: #{time}"
p_english.puts "title: #{title_english}"
p_english.puts "name: #{id}"
if subtitle_english != ""
    p_english.puts "subtitle: #{subtitle_english}"
end
if tags != ""
    p_english.puts "tags: [#{tags}]"
end
p_english.puts "description: #{desc_english}"
p_english.puts "category: en"
p_english.puts "---"
p_english.close

puts "file '#{path_german}' created".bold.green
puts "file '#{path_english}' created".bold.green
puts ""
puts "opening files in brackets".bold.green
value = `brackets #{path_german}`
value = `brackets #{path_english}`
