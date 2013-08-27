class CdsimportController < ApplicationController
  def import

  end
  
  def upload
    #flash[:success] = "Uploaded "+uploaded_io
    parse_cds_file(params[:filepath])
    redirect_to import_path
    #File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'w') do |file|
    #file.write(uploaded_io.read)
  end

end
