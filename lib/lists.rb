require 'pg'
# require 'pry'

class List

  attr_reader :name, :id

  def initialize(name, id = nil)
    @name = name
    @id = id
  end

  def ==(another_list)
    self.name == another_list.name
  end

  def self.all
    results = DB.exec("SELECT * FROM lists;")
    lists = []
    results.each do |result|
      name = result['name']
      id = result['id']
      lists << List.new(name, id)
    end
    lists
  end

  def save
    results = DB.exec("INSERT INTO lists (name) VALUES ('#{name}') RETURNING id;")
    @id = results.first['id'].to_i
  end

  def delete(list_name, task)
    name_array = []
    List.all.each do |item|
      name_array << item.name
    end

    if name_array.include?(list_name)
      List.all.each do |item|
        if list_name == item.name

          DB.exec("DELETE FROM tasks WHERE name = '#{task}'")
          puts "Task deleted"
          Task.all.each do |item|
            puts item.name
          end
          break
        end
      end
    else
      puts "Please enter a valid choice"
    end
  end

  def add_task(list_name, task)
    name_array = []
    List.all.each do |item|
      name_array << item.name
    end

    if name_array.include?(list_name)
      List.all.each do |item|
        if list_name == item.name
          DB.exec("INSERT INTO tasks (name, list_id) VALUES ('#{task}', #{item.id});")
          break
        end
      end
    else
      puts "Please enter a valid choice"
    end
  end

  def self.display_tasks(list_name)
    chosen_list = DB.exec("SELECT * FROM lists WHERE name = '#{list_name}';")
    Task.all.each do |item|
      puts chosen_list[0]['id']
      if item.id == chosen_list[0]['id']
        item
        # results = DB.exec("SELECT * FROM tasks WHERE id = '#{chosen_list[0]['id']}';")
      end
    end
  end

end
