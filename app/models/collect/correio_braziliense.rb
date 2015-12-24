require 'nokogiri'  
require 'open-uri'

module Collect
  class CorreioBraziliense 
    include ActiveModel::Model
    
    URL = 'http://www.classificadoscb.com.br/anuncio/empregos-e-formacao-profissional/subcategoria,Oferta%20de%20Emprego/ordenar-por,insercao-desc/apartir-de'  


    def self.sync!


      page = Nokogiri::HTML(open(URL)) 

      #ListJob.destroy_all
      max_page = page.css('.pagination__area span')[1].text.split('de ')[1].to_i

      index = -1
      
      max_page.times do 
        index += 1

        page = Nokogiri::HTML(open("#{URL},#{index * 20}")) 
        
        item = page.css('.product__area__bx')

        item.each do |i|
          
          link_job = i.css('.product__bx').map { |link| link['href']}
          inside_page = Nokogiri::HTML(open(link_job[0])) rescue nil 

          if inside_page.present?
            inside_title = inside_page.css('.header__result .no-arrow').text
            inside_date  = inside_page.css('.header__result .post-time').text
            inside_description  = inside_page.css('.description__bx p').text
            
            list = ListJob.new({
              title: inside_title,
              description: inside_description,
              link: link_job[0],
              date: Date.parse(inside_date)
            })

            list.save
          end
        end

      end
    end

  end
end