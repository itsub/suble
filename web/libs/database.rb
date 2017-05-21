#!/usr/bin/ruby


class DatabaseManager
  def initialize
    dbc = YAML.load_file('../config/database.yml')
    @db = Sequel.connect(adapter: dbc['adapter'], host: dbc['host'], database: dbc['database'], user: dbc['user'], password: dbc['password'])
  end

  def get_connection
    @db
  end
end

@dbm = DatabaseManager.new

require './models/keywords'