require 'pry'
class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = []


  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    #binding.pry

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end
    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)
    elsif req.path.match(/add/)
      add_item = req.params["item"]
      #binding.pry
      if @@items.include?(add_item)
        #binding.pry
        resp.write "added #{add_item}"
        @@cart << add_item
      else
        resp.write "We don't have that item"
      end
      #binding.pry
    # elsif req.path.match(/cart/)
    #   resp.write "cart is empty"
    else
      resp.write "Path Not Found"
      resp.write "Your cart is empty"
      resp.write "Apples\nOranges"
      # resp.write "added Figs"
      # resp.write "We don't have that item"
    end

    resp.finish
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end
end
