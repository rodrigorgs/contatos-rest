# Veja http://datamapper.org/getting-started.html
class Contato
    include DataMapper::Resource

    property :id, Serial
	property :nome, String
	property :telefone, String
end

# Obtém todos os contatos (ou filtra pelos parâmetros)
get '/contatos' do
    contatos = Contato.all(params)
    
    status 200 # OK
    body contatos.to_json
end

# Obtém o contato com o id fornecido
get '/contatos/:id' do
	contato = Contato.get(params[:id].to_i)
    
    if contato
        status 200 # OK
        body contato.to_json
    else
        status 404 # Not Found
	end
end

# Cria um contato
post '/contatos' do
	contato = Contato.create(@json_body)
    
    if contato
        status 201 # Created
        headers :location => uri("/contatos/#{contato.id}", true, true)
        body ({:id => contato.id}).to_json    
    else
        status 400 # Bad Request
	end
end

# Atualiza um contato
put '/contatos/:id' do
	contato = Contato.get(params[:id].to_i)
    
    if contato
        if contato.update(@json_body)
            status 201 # Created
        else
            status 500 # Internal Server Error
        end
    else
        status 404 # Not Found
    end
end

# Apaga um contato
delete '/contatos/:id' do
	contato = Contato.get(params[:id].to_i)
    
    if contato
        if contato.destroy
            status 200 # OK
        else
            status 500 # Internal Server Error
        end
    else
        status 404 # Not Found
	end
end