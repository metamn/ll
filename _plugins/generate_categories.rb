module Jekyll
  
  
  # The CategoryIndex class creates a single category page for the specified category.
  class CategoryIndex < Page
    
    # Initializes a new CategoryIndex.
    #
    #  +base+         is the String path to the <source>.
    #  +category_dir+ is the String path between <source> and the category folder.
    #  +category+     is the category currently being processed.
    def initialize(site, base, category_dir, category)
      @site = site
      @base = base
      @dir  = category
      @name = 'index.html'
      self.process(@name)
      # Read the YAML data from the layout page.
      self.read_yaml(File.join(base, '_layouts'), 'category.html')
      self.data['category']    = category
      # Set the title for this page.
      title_prefix             = site.config['category_title_prefix'] || ''
      self.data['title']       = "#{title_prefix.capitalize}#{category}"
      # Set the meta-description for this page.
      meta_description_prefix  = site.config['category_meta_description_prefix'] || 'Category: '
      self.data['description'] = "#{meta_description_prefix}#{category}"
    end
    
  end
  
  
  # The Site class is a built-in Jekyll class with access to global site config information.
  class Site
    
    # Creates an instance of CategoryIndex for each category page, renders it, and 
    # writes the output to a file.
    #
    #  +category_dir+ is the String path to the category folder.
    #  +category+     is the category currently being processed.
    def write_category_index(category_dir, category)
      index = CategoryIndex.new(self, self.source, category, category)
      index.render(self.layouts, site_payload)
      index.write(self.dest)
      # Record the fact that this page has been added, otherwise Site::cleanup will remove it.
      self.pages << index
    end
    
    # Loops through the list of category pages and processes each one.
    def write_category_indexes
      if self.layouts.key? 'category'
        dir = self.config['category_dir'] || 'categories'
        self.categories.keys.each do |category|
          self.write_category_index(File.join(dir, category), category)
        end
        
      # Throw an exception if the layout couldn't be found.
      else
        throw "No 'category' layout found."
      end
    end
    
  end
  
  
  # Jekyll hook - the generate method is called by jekyll, and generates all of the category pages.
  class GenerateCategories < Generator
    safe true
    priority :low

    def generate(site)
      site.write_category_indexes
    end

  end
  
  
  # Adds some extra filters used during the category creation process.
  module Filters
    
    # Outputs a list of categories as comma-separated <a> links. This is used
    # to output the category list for each post on a category page.
    #
    #  +categories+ is the list of categories to format.
    #
    # Returns string
    def category_links(categories)
      categories = categories.sort!.map do |item|
        '<a href="/'+item+'/">'+item+'</a>'
      end
      
      connector = "and"
      case categories.length
      when 0
        ""
      when 1
        categories[0].to_s
      when 2
        "#{categories[0]} #{connector} #{categories[1]}"
      else
        "#{categories[0...-1].join(', ')}, #{connector} #{categories[-1]}"
      end
    end
    
    # Outputs the post.date as formatted html, with hooks for CSS styling.
    #
    #  +date+ is the date object to format as HTML.
    #
    # Returns string
    def date_to_html_string(date)
      result = '<span class="month">' + date.strftime('%b').upcase + '</span> '
      result += date.strftime('<span class="day">%d</span> ')
      result += date.strftime('<span class="year">%Y</span> ')
      result
    end
    
  end
  
end
