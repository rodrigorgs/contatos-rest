class Item
    include DataMapper::Resource

    property :id, Serial
    property :name, String
	property :done, Boolean

	validates_uniqueness_of :name
end

get '/items' do
	items = Item.all
	items.to_json
end

get '/items/:id' do
	item = Item.get(params[:id].to_i)
	halt(404, 'Not Found') if item.nil?
	item.to_json
end

post '/items' do
	item = Item.create(@json_body)
    halt(400, 'Bad Request') if item.nil?
	response.status = 201
end

put '/items/:id' do
	item = Item.get(params[:id].to_i)
	halt(404, 'Not Found') if item.nil?
	item.update!(@json_body)
    response.status = 201
end

delete '/items/:id' do
	item = Item.get(params[:id].to_i)
	halt(404, 'Not Found') if item.nil?
	item.destroy!
end