require_relative '../config/environment'



class Application

    @@items = [Item.new("Figs",3.42)]

    def call(env)
        resp = Rack::Response.new
        req = Rack::Request.new(env)

        if req.path.match(/items\/.+/)
            request_item = req.path.split("/items/").last
            flag = false
            @@items.each do |i|
                if i.name == request_item
                    resp.status = 200
                    resp.write "#{i.price}"
                    flag = true
                end
            end
            if flag == false
                resp.status = 400
                resp.write "Item not found"
            end
        else
            resp.status = 404
            resp.write "Route not found"
        end
        resp.finish
    end
end
