class AddImagesToListingsColumn < ActiveRecord::Migration[5.2]
  # def change
  #   add_column :listings, :images, :json
  # end

  def up
    add_column :listings, :images, :json
  end

  def down
    remove_column :listings, :images
  end
end
