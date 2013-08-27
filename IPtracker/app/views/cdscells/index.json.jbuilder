json.array!(@cdscells) do |cdscell|
  json.extract! cdscell, :name, :cdslib_id
  json.url cdscell_url(cdscell, format: :json)
end