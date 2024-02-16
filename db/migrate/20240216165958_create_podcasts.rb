class CreatePodcasts < ActiveRecord::Migration[7.1]
  def change
    create_table :podcasts do |t|
      t.string :title
      t.text :description
      t.string :podcast_id

      t.timestamps
    end
  end
end
