require 'nokogiri'
require 'open-uri'


def crazy_scrapper
  #on déclare les tableaux
  hash = []
  names_array = []
  prices_array = []
  #on récupère les noms des cryptos
  doc = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))
  doc.xpath('//html/body/div/div/div[2]/div[1]/div[2]/div/div[2]/div[3]/div/table/tbody/tr/td[2]/div').each do |names|
    names_array << names.content #on insère le contenu récupéré dans un tableau
  end
  #on récupère les prices des cryptos
  doc.xpath('//html/body/div/div/div[2]/div[1]/div[2]/div/div[2]/div[3]/div/table/tbody/tr/td[5]/a').each do |prices|
    prices_array << prices.content.delete('$').to_f #on insère le contenu récupéré dans un tableau en supprimant les $ et en transformant en float
  end

  #on fusionne les deux tableaux
  names_array.zip(prices_array).each do |merge| 
    hash << {merge[0] => merge[1]}
  end
  return hash
end

puts "#{crazy_scrapper}" #affiche le hash final