require "roda"
require "json"

class App < Roda
  route do |r|
    # GET / request
    r.root do
      r.redirect "/pets"
    end

    # /pets branch
    r.on "pets" do
      @pets = [
        {id: 1, name: "Doggy", tag: "dog"},
        {id: 2, name: "Kitty", tag: "cat"},
        {id: 3, name: "Zebra", tag: "other"}
      ]

      r.is do
        # GET /pets request
        r.get do
          @pets.to_json
        end

        # POST /pets request
        r.post do
          # hardcoded response
          {id: 5, name: "Test", tag: "Teszt"}.to_json
        end
      end

      # GET /pets/:id
      r.is Integer do |id|
        @pets.find { |h| h[:id] == id }.to_json
      end
    end
  end
end
