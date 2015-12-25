class CreateListJobs < ActiveRecord::Migration
  def change
    create_table :list_jobs do |t|
      t.string :title
      t.string :description
      t.string :link
      t.date :date
      t.date :collect_date
      t.string :ref

      t.timestamps null: false
    end
  end
end
