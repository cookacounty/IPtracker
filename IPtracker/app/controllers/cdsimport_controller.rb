class CdsimportController < ApplicationController
  attr_accessor :form_errors
  
  def import
    @form_errors = []
    if !signed_in?
      redirect_to signin_url, notice: "Please sign in."
    end
  end

  def upload
    @form_errors = []
    uploaded_io = params[:filepath]

    #Create a new model to check if the name is valid
    silicon = Silicon.new(name: params[:silicon])
    
    valid_upload = validate_file(uploaded_io)
    valid_silicon = silicon.valid?
    
    valid_upload = t
        
    #Validate the form
    if !valid_upload || !valid_silicon
      
      @form_errors << "Invalid File Name. File must be named #{Settings.iptracker.tar_file}" if !valid_upload
      @form_errors << silicon.errors.full_messages if !valid_silicon

      @form_errors.flatten!
      
      render action: "import"
    else
      silicon = silicon.name
      parse_cds_file(silicon,uploaded_io)
      
      flash[:success] = "SUCESSFULLY READ FILE #{uploaded_io.original_filename}"
      
      #Create a micropost that shows silicon was uploaded
      if signed_in?
        build_micropost(silicon)
      end
      
      redirect_to import_path(:upload_success=>"t")
    end
    

    
  end  
  
  def upload_old
    #flash[:success] = "Uploaded "+uploaded_io
    parse_cds_file(params[:filepath])
    redirect_to import_path
    #File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'w') do |file|
    #file.write(uploaded_io.read)
  end
  
  

end
