# encoding: UTF-8
require 'htmlbeautifier'
require 'slim'
require 'nokogiri'
Slim::Engine.set_options pretty: true
class Slimed
  attr_accessor :src, :out, :outprod
  def initialize(src,out,outprod)
    @src = src
    @out = out
    @outprod = outprod
  end
  def tohtml
    # ouverture src en lecture
    srcfile = File.open(src, "rb").read
    s2h = Slim::Template.new{srcfile}
    htmlrender = s2h.render
    beautiful = HtmlBeautifier.beautify(htmlrender, tab_stops: 2)
    # ecriture du fichier out = Slimed.new(src,**out**) > return beautiful
    File.open(out, "w") do |go|
      go.puts beautiful
    end
  end
end
fr = Slimed.new('indexC.slim', 'indexC.html','index.html')
fr.tohtml
# fr.htmlEncodeEnt
# system("explorer #{fr.out}")

myfile = File.read('indexC.html')
# extraction zone HTML pour prod .gsub(' ','&nbsp;')
doc = Nokogiri::HTML.parse(myfile, nil, "UTF-8")

prod = doc.at_css("#evtFirst_Link")

File.open("index.html", "w") do |file|
  file.puts prod
end

a = File.read("index.html").force_encoding("UTF-8")
puts a

File.open("index.html", "w") do |file|
  file.puts a.gsub('é','&eacute;')
end



puts "Développement".gsub('é','&eacute;')