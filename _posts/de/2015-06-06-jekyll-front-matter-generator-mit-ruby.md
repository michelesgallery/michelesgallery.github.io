---
date: 2015-06-06 10:01:07 +0200
title: Ein Front Matter Generator mit Ruby ♦♦
name: EFMGmR
subtitle: Warum ich mir nie wieder front matter Variablen merken werde
tags: [jekyll, ruby, front matter, generator, ♦♦]
description: Wie ich einen Front Matter Generator f&uuml;r Jekyll mit ruby schrieb.
---
Nachdem ich vor einigen Jahren in Informatik eine Einführung in Java erhielt, hatte ich beschlossen, die Programmiersprachen auf ewig hinter mir zu lassen. Hätten wir damals eine Sprache wie Ruby gelernt, hätte ich das wohl ganz anders gesehen.
Ich hatte einen Tag ruby gelernt, als ich die erste Version dieses Generators schrieb. Nach einem Jahr Java konnte ich nicht einmal so viel programmieren, wie ich es mit ein bisschen Javascript und CSS heute kann.
Und das was ich mit ruby geschrieben habe, ist eindeutig brauchbarer. Denn es bedeutet, dass ich nie wieder meine Front Matter Deklarationen einer jekyll-Page selbst schreiben werde.
<br>
<!-- more -->
<div class="video">
    <iframe src="https://www.youtube.com/embed/oVUMEKLBLw0" frameborder="0" allowfullscreen></iframe>
</div>

Vor einer Weile hab ich schon über einen Front Matter Generator geschrieben. Dort eine Webbasierte Version mit Javascript und jQuery[^1], die zwar gut funktionierte, doch sie erforderte mir persönlich noch zu viele Schritte. Ich wollte die Datei nicht speichern und verschieben müssen. Ich wollte einfach nur meine Daten eingeben und die Datei dann am liebsten gleich in meinem liebsten Editor geöffnet haben. Das war doch nicht zu viel verlangt?

Inspiration kam, als ich die Plugins für Jekyll ansah. Es gab welche, die neue Seiten generierten. Ruby war also wohl die Lösung. Gedacht, getan. Den Kurs auf [Codecademy](http://www.codecademy.com/en/tracks/ruby) begonnen und nach 60% des Kurses, schrieb sich der Generator praktisch von selbst.
Wie ich ihn geschrieben habe, möchte ich euch heute zeigen.

### Variablen Sammeln
Okay, der erste Schritt ist ganz klar. Ehe man einen Front Matter Generator schreiben kann, braucht man alle Variablen, die vorkommen.
In diesem Tutorial, möchte ich einen etwas kürzeren Generator vorstellen, als meinen eigenen. Meiner generiert mir jeweils direkt zwei Files, weil ich zweisprachig poste und gewisse Variablen den gleichen Wert haben.

Die Variablen, die ich für diesen Generator verwende, sind folgende:

Variable | Beschreibung | Zu beachten
---|---|---
title | Titel | darf nicht länger als 55 Zeichen sein
url-title | Das ist keine Front Matter Variable, aber für den file-name entscheidend | darf keine Leerzeichen und Sonderzeichen enthalten
subtitle | Untertitel | keine Einschränkungen
description | Meta-Beschreibung | nicht länger als 115 Zeichen
tags | tags | sind in einem Array drin

Von diesen Variablen, möchte ich bloss den Untertitel und die Tags optional hinzufügen. Doch da Titel und Beschreibung für SEO nötig sind, muss hier auf jeden Fall etwas eingegeben werden.

### File
Okay. Nun müssen wir uns überlegen, wo wir das File am besten platzieren. Wenn man eine Jekyll-Seite hat, ist es sehr wahrscheinlich, dass man auch git verwendet. Das Terminal ist also im Root-Ordner geöffnet. Wir müssen ausserdem auf den Posts-Ordner einfach zugreifen können, und das Script sollte nicht allzu weit entfernt sein.
Ich habe also entschlossen, einen Ordner zu machen, den ich `_ruby`genannt habe und darin mein Ruby-Script zu speichern.
Ausführen kann ich es also mit `ruby _ruby/erstellepost.rb` Wenn ihr aber für euch kein Problem damit habt, einfach ein ruby-file im Root zu haben, könnt ihr es auch dort speichern. Die Datei würde ich aber auf jeden Fall beschreibend benennen.

Okay öffnet euren liebsten Editor. Meiner ist [Brackets](http://brackets.io/) und dann können wir anfangen.

Da wir eine neue Datei erstellen müssen, brauchen wir ein require für diese Funktionalität.
Und dann fangen wir mit den Methoden an, die wir für den Generator verwenden.

Da ich meinen Output im Terminal noch farbig gestalten will, füge ich noch die Klassen dafür ein (die sind nicht von mir, sondern wurden durch eine kurze Internetsuche gefunden)

```ruby
# encoding: utf-8
require 'fileutils'

# für farbigen Output
class String
def red;            "\033[31m#{self}\033[0m" end
def green;          "\033[32m#{self}\033[0m" end
def brown;          "\033[33m#{self}\033[0m" end
def gray;           "\033[37m#{self}\033[0m" end
def bold;           "\033[1m#{self}\033[22m" end
end
```

Okay, wir brauchen verschiedene Methoden, damit das mit dem Generator etwas schneller geht.

Zum einen habe ich hier eine Methode createURL, die aus einem String die Leerzeichen durch `-`, alles klein schreibt und die Umlaute ä, ö, ü durch ae, oe und ue ersetzt.

Das schaut dann so aus:

```ruby
# Erstelle URL Format aus String
def createURL(string)
    string.downcase!
    string.gsub! " ", "-"
    string.encode!("UTF-8")
    string.gsub! "ä", "ae"
    string.gsub! "ö", "oe"
    string.gsub! "ü", "ue"
end
```

Wo wir schon bei Umlauten sind, die sollten alle durch Unicode ersetzt werden für die Variablen im Text

```ruby
# Ersetze alle Umlaute mit Unicode
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

Und dann bleibt nur noch eines. Wenn in yaml Doppelpunkte verwendet werden, kann das zu einem parsing-error führen. Da wir das verhindern wollen, ersetzen wir noch jeden Doppelpunkt durch den Unicode-Character.

```ruby
# Ersetze jeden Doppelpunkt mit Unicode
def sanitizeYML(string)
    string.gsub! ":", "&colon;"
end
```

Da es sich um einen Post-Generator handelt, müssen wir noch einiges mit dem Datum machen. Als erstes speichern wir mal ein paar Variablen. ab. Einmal time, was genau das ausgibt, was wir für die `date`-Variable im Content brauchen, doch für den Dateinamen, brauchen wir das Jahr, den Tag und den Monat. Und Monat und Tag sollten noch mit einem vorne ausgestattet werden, falls wir einen einstelligen Wert haben.

```ruby
# Datum
#------
time = Time.new
year = time.year.to_s

# Wenn Tag und Monat unter 10 sind, füge 0 vorne hinzu
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
Okay, haben wir das getan, können wir nun mit dem Generator beginnen.

Wir beginnen damit, dass wir eine Info ausgeben, die sagt, dass wir den Generator gestartet haben. `\n` sagt hier, dass eine neue Zeile begonnen werden soll. Und das machen wir in fett und grün.

```ruby
# Generator
#-----------

# Start Nachricht
puts "Initiiere Front Matter Generator für Posts.\nGib folgende Informationen wie instruiert ein.\n".bold.green
puts ""
```

Und dann kommen wir zum Titel. Wir bitten um Eingabe des Titels und speichern den Input in einer Variable.
Dann checken wir, ob der Titel länger als unsere Zeichenbegrenzung ist. Falls ja, geben wir eine Warnung aus und fragen erneut nach einem Titel. Gleiches tun wir, falls gar kein Titel eingegeben wurde. Dann fragen wir jeweils noch einmal nach. Falls dann erneut ein zu langer oder gar kein Titel eingegeben werden, brechen wir das Programm ab und bitten um einen Neustart.

```ruby
# Title
puts "Post Titel. Sollte nicht länger als 55 Zeichen sein".bold.gray
title = gets.chomp

if title.length > 55
    puts "Dein Titel ist zu lang, gib einen kürzeren ein".bold.brown
    title = gets.chomp
    if title == ''
        abort("Programm abgebrochen, weil kein gültiger Titel eingegeben wurde. Bitte starte erneut".bold.red)
    elsif title.length > 55
        abort('Programm abgebrochen, weil der Titel zu lang war. Bitte starte erneut'.bold.red)
    end
elsif title == ''
    puts "Bitte gib einen Titel ein, der weniger als 55 Zeichen lang ist".bold.gray
    title = gets.chomp
    if title == ''
        abort("Programm abgebrochen, weil kein gültiger Titel eingegeben wurde. Bitte starte erneut".bold.red)
    elsif title.length > 55
        abort('Programm abgebrochen, weil der Titel zu lang war. Bitte starte erneut'.bold.red)
    end
end
```

Als nächstes fragen wir nach, ob der Titel der URL entspricht oder nicht. Falls die Antwort ja ist, speichern wir die `file_name` Variable mit dem Titel als Wert ab, falls nicht, fragen wir nach dem Filetitel. Falls dieser nicht eingegeben wird, bitten wir erneut darum. Und falls dann wieder ein ungültiger Dateiname eingegeben wird, brechen wir das Programm ab. Gleiches tun wir auch, wenn zwei Mal weder ja noch nein als Antwort auf die Frage eingetippt wird.

```ruby
# URL Title
puts ""
puts "Ist der Titel gleich wie die URL?\n(ja/nein)".bold.gray
url_title_yes_or_no = gets.chomp

case url_title_yes_or_no
when "ja", "j"
    file_name = title
when "nein", "n"
    puts "Gib die URL ein".bold.gray
    file_name = gets.chomp
    if file_name == ''
        puts "Bitte gib einen gültigen Dateinamen ein".bold.brown
        file_name = gets.chomp
        if file_name == ''
            abort("Programm abgebrochen. Bitte starte erneut und befolge die Anweisungen".bold.red)
        end
    end
else
    puts "Bitte gib entweder 'ja' oder 'nein' ein.".bold.brown
    url_title_yes_or_no = gets.chomp
    case url_title_yes_or_no
    when "ja", "j"
        file_name = title
    when "nein", "n"
        puts "Gib die URL ein".bold.gray
        file_name = gets.chomp
        if file_name == ''
            puts "Bitte gib einen gültigen Dateinamen ein".bold.brown
            file_name = gets.chomp
            if file_name == ''
                abort("programm abgebrochen. Bitte starte erneut und befolge die Anweisungen".bold.red)
            end
        end
    else
        abort("programm abgebrochen. Bitte starte erneut und befolge die Anweisungen".bold.red)
    end
end
```

Nun, da wir den URL titel haben, müssen wir ihn noch ins URL-Format umwandeln, dazu verwenden wir die Methode von vorhin. UNd dann geben wir den Dateipfad bekannt. Wir definieren den Ordner und das Format der Datei und dann erstellen wir, falls der Ordner noch nicht existiert einen Ordner mit dem Namen und die Datei darin, oder wir erstellen nur die Datei.

```ruby
# erstelle URL
createURL(file_name)

# falls der Ordner noch nicht existiert, erstelle ihn.
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

# setze dateipfad
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

Untertitel und Tags sind jeweils beide optional, also fragen wir bloss nach Input und tun nichts, falls einmal Enter gedrückt wird, anstelle eine Eingabe

```ruby
# Untertitel
puts ""
puts "Untertitel.\n(drücke Enter, falls du keinen Untertitel einfügen willst)".bold.gray
subtitle = gets.chomp

#tags
puts ""
puts "Tags, trenne Schlagworte durch Kommas\n(drücke Enter, falls du keinen Untertitel einfügen willst)".bold.gray
tags = gets.chomp
```

Für die Beschreibung tun wir genau das gleiche wie beim Titel

```ruby
# Beschreibung
puts ""
puts "Gib die Meta Beschreibung ein. Sie sollte nicht länger als 115 Zeichen sein".bold.gray
desc = gets.chomp

if desc.length > 115
    puts "Deine Beschreibung ist zu lang. Gib eine kürzere ein.".bold.brown
    desc = gets.chomp
    if desc == ''
        abort("Programm abgebrochen, weil keine gültige Beschreibung eingegeben wurde. Bitte starte erneut.".bold.red)
    elsif desc.length > 115
        abort('Programm abgebrochen, weil Beschreibung zu lang war. Bitte starte erneut.'.bold.red)
    end
elsif desc == ''
    puts "Bitte gib eine Beschreibung ein, die kürzer als 115 Zeichen ist".bold.gray
    desc = gets.chomp
    if desc == ''
        abort("Programm abgebrochen, weil keine gültige Beschreibung eingegeben wurde. Bitte starte erneut.".bold.red)
    elsif desc.length > 115
        abort('Programm abgebrochen, weil Beschreibung zu lang war. Bitte starte erneut.'.bold.red)
    end
end
```

Und dann sind wir bereit, eine neue Datei zu erstellen.

Wir führen unsere Methoden bei den Variablen aus und geben sie dann im Content ein.

```ruby
# Erstelle neue Datei
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

Zum Schluss geben wir den erstellten Pfad aus. Und ich öffne meine Dateien am Ende auch gerne, also füge ich noch den Befehl `brackets <pfad>` aus.

Und dann ist das Programm zu Ende.

```ruby
# Notifikation, dass Datei erstellt wurde
puts "Datei '#{path}' erstellt".bold.green
puts ""
puts "Öffne Datei in brackets".bold.green

# füge befehl für Öffnen in Brackets ein
value = `brackets #{path}`
```

Und das ganze Ding findet ihr [hier](https://gist.github.com/mynimi/7592bb381cbdf0d66644#file-erstellepost-rb).

[^1]: [jekyll für Nicht-Hacker](http://digitalmind.ch/ein-front-matter-generator-fuer-jekyll/)