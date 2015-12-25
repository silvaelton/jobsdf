require 'nokogiri'  
require 'open-uri'

module Collect
  class BlogEmprego
    
    include ActiveModel::Model 

    URL = 'http://www.empregodf.com.br/search'

    def self.sync!
      page = Nokogiri::HTML(open("#{URL}?max-results=100&updated-max=#{Date.today.strftime('%Y-%m-%d')}"))
      item = page.css('.post-title')

      item.each do |i|
        link    = i.css('a').map { |link| link['href']}
        inside  = Nokogiri::HTML(open(link[0]))

        title = inside.css('.post-title').text
        date  = inside.css('.published').map {|text| text['title']} 
        text  = inside.css('.post-body')[1]

        post = ListJob.new({
          title: title, 
          date: date[0],
          link: link[0],
          description: text,
          ref: 'blog do emprego',
          collect_date: Date.today
        })

        post.save
      end
      
    end


  end
end