class CreateProxies < ActiveRecord::Migration[5.2]
  def change
    create_table :proxies do |t|
      t.integer :kind
      t.string :server_host
      t.integer :server_port
      t.string :username
      t.string :password

      t.timestamps
    end
  end
end
