json.array!(@cdslibs) do |cdslib|
  json.extract! cdslib, :name
  json.url cdslib_url(cdslib, format: :json)
end