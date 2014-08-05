require 'pg'
require './lib/lists'
require './lib/tasks'

DB = PG.connect({:dbname => 'to_do'})

def menu
    puts "YOU HAVE ENTER THE TO DO LIST"
  loop do
  puts "1. enter a task \n
        2. create a list\n
        3. delete a task\n
        4. list out tasks\n
        x. exit"
  user_choice = gets.chomp

    if user_choice == '1'
      enter_task
    elsif user_choice == '2'
      create_list
    elsif user_choice == '3'
      delete_task
    elsif user_choice == '4'
      display_tasks
    elsif user_choice == 'x'
      puts "Goodbye"
      break
    end
  end
end

def create_list
  puts "Enter list title"
  list_title = gets.chomp
  new_list = List.new(list_title)
  new_list.save
end

def delete_task
   List.all.each do |item|
    puts item.name
    puts item.id
  end
  puts "Enter the name of the list you would like to delete a task from"
  user_choice = gets.chomp

  Task.all.each do |item|
    puts item.name
  end
  puts "What task would you like to delete?"
  user_task = gets.chomp
  List.delete(user_choice, user_task)
end

def enter_task
  List.all.each do |item|
    puts item.name
    puts item.id
  end
  puts "Enter the name of the list you would like to add a task to"
  user_choice = gets.chomp
  puts "Enter task name"
  user_task = gets.chomp
  List.add_task(user_choice, user_task)
end

def display_tasks
  puts "Enter the name of the list you would like to see the tasks of"
  user_choice = gets.chomp
  results = List.display_tasks(user_choice)

  results.each do |item|
    puts item.name
  end
end

menu
