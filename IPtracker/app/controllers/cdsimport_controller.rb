class CdsimportController < ApplicationController
  def import

  end

  def upload

    uploaded_io = params[:filepath]
    silicon = params[:silicon]

    parse_cds_file(silicon,uploaded_io)
    
    flash[:success] = "SUCESSFULLY READ FILE #{uploaded_io.original_filename}"
    
    redirect_to import_path
    
  end  
  
  def upload_old
    #flash[:success] = "Uploaded "+uploaded_io
    parse_cds_file(params[:filepath])
    redirect_to import_path
    #File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'w') do |file|
    #file.write(uploaded_io.read)
  end

end
