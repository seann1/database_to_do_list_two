require 'pg'

class Task

  attr_reader :name, :id

  def initialize(name, id)
    @name = name
    @id = id
  end

  def self.all
    results = DB.exec("SELECT * FROM tasks;")
    tasks = []
    results.each do |result|
      name = result['name']
      id = result['list_id'].to_i
      tasks << Task.new(name, id)
    end
    tasks
  end

  def save
    DB.exec("INSERT INTO tasks (name, list_id) VALUES ('#{name}', #{id});")
  end

  def ==(another_task)
    self.name == another_task.name && self.id == another_task.id
  end

end

