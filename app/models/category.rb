class Category < ApplicationRecord
    # For initialzing ancestry attribute to nil 
    before_validation :init_ancestry
    # Orphan_strategy method identifies what to do with children of a node that is destroyed.
    # Destroy  option is telling that  all children are destroyed as well (default).
    has_ancestry orphan_strategy: :destroy
    has_many :products, dependent: :destroy

    # Validation of title attribute
    validates :title, presence: { message: "The title should not be empty" }
    validates :title, length: { maximum: 30,
      too_long: "%{count} characters is the maximum allowed" }
    # Validation of weight attribute
    validates_numericality_of :weight, greater_than_or_equal_to: 0,
    message: "Weight of product has to over 0"
    validates_numericality_of :weight, less_than_or_equal_to: 100,
    message: "Weight of product has to within 0 to 100"
    validates_numericality_of :weight, only_integer: true,
    message: "Weight of product has to be an integer"
    
    
  

    # Because my app's searching features is runing base on the Categories and sub-category of all items, a handy method is
  # defined here to access all the category tree node with the help of ancestry gem method 'roots' and 'children'.
  def self.grouped_data
    # Arrange all the category dates in an array, while the self.roots returns an array of first class categories and the array inject method will 
    # produces accumulating funtion base on the categories array. The empty array argument is the initial value which the 'result' represents,
    # While the 'parent' presents every element in self.roots array which is first class category.
    # In the inject block, I declear a empty array to contain all the categories and then add all the sub categories array indisde the array and
    # after combine the initial empty row array it finally returns an array contains specific first class category in index 0 
    # and corresponing sub categories array as the second element in index 2. And the this array goes in the initial result empty array box, and
    # accumulate other array of category and its own sub categories.
    # The reslut will look like this: [[C1,[c11,c12,c13...]],[C2,[c21,c22,c23...]],[C3,[c31,c32,c33...]]...]
    # And the, I can invoke this handy method in what ever controllers action to get the main and sub categories record and loop through the result
    # and send the result back to view.
      self.roots.order("weight desc").inject([]) do |result, parent|
        row = []
        row << parent
        row << parent.children.order("weight desc")
        result << row
      end
    end

    private
  def init_ancestry
    self.ancestry = nil if self.ancestry.blank?
  end

end