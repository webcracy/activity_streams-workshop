class RenameBodyToSummaryInActivity < ActiveRecord::Migration
  def self.up
    rename_column :activities, :body, :summary
  end

  def self.down
    rename_column :activities, :summary, :body
  end
end
