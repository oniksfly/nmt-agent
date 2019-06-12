class CreateTorrentsClients < ActiveRecord::Migration[5.2]
  def change
    create_table :torrents_clients do |t|
      t.string :type
      t.string :host
      t.integer :port
      t.string :path
      t.string :username
      t.string :password
      t.string :sessions

      t.timestamps
    end
  end
end
