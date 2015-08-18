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

# creation fichier html **attention** au codage des char liste non complete (gsub)
myfile = File.read('indexC.html')
# extraction zone HTML : Noko::XML important pour self-close tag
doc = Nokogiri::XML(myfile, nil, "UTF-8")
prod = doc.at_css("#evtFirst_Link")
# srcJs = doc.at_css('[src~="js-btn.js"]')
docscr = Nokogiri::HTML(myfile, nil, "UTF-8")
srcJs = docscr.at_css('[src~="js-btn.js"]')
puts srcJs
File.open("index.html", "w") do |file|
  file.puts prod
  # placer le script JS en fin de document
  file.puts srcJs
end
# **attention** CODAGE a compléter (GSUB)
a = File.read("index.html").force_encoding("UTF-8")
a = a.gsub('é','&eacute;')
a = HtmlBeautifier.beautify(a, tab_stops: 2)
File.open("index.html", "w").puts a

