class Category < ActiveRecord::Base
  
  belongs_to :user

  has_many :cell_categories, foreign_key: "category_id", dependent: :destroy
  has_many :cdscells, through: :cell_categories, source: :cdscell
  has_many :cdslibs, through: :cdscells, source: :cdslib

  #has_many :silicons, through: :cdscells

  
  validates :user_id, presence: true
  validates :name,  presence: true, 
                    length: { maximum: 140 },
                    format: { with: /\A\w+\Z/i, #Alphanumeric only
                              message: "can only contain letters and numbers." }                 
                    
  def self.create_from_list(user,category_list)
    
    category_names = category_list.split(/, */)
    
    return_list = []
    
    category_names.each do |name|
      #Create the category if it does not already exist
      found_category = user.categories.find_by(name: name)

      if !found_category
        new_category = user.categories.build(name: name)
        new_category.save!
        return_list << new_category
      else
        return_list << found_category
      end      
    end
    
    return return_list
    
  end
  def self.cleanup!(user)
    
    user.categories.each do |category|
      empty_category = category.cdscells.empty?
      if empty_category
        category.destroy!
      end
    end
  end
  
end
