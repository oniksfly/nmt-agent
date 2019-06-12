class Torrents::Client < ApplicationRecord
  self.table_name_prefix = 'torrents_'

  validates_presence_of :type, :host, :port
  validates_uniqueness_of :host, scope: [:type, :port, :path]

  def type_name
    self.class.name
  end

  def address
    "#{host}:#{port}/#{path}"
  end
end
