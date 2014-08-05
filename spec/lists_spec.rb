require 'spec_helper'
require 'pry'
describe :Lists do

  describe :initalize do
    it "should initialize with a name" do
      list = List.new("Free Time")
      list.should be_an_instance_of List
    end

    it "tells you its name" do
      list = List.new("Work Time")
      list.name.should eq "Work Time"
    end

    it "is the same list if it has the same name" do
      list1 = List.new('Epicodus stuff')
      list2 = List.new('Epicodus stuff')
      list1.should eq list2
    end
  end

  describe :all do
    it "starts off with no lists" do
      List.all.should eq []
    end
  end

  describe :save do
    it "lists all of the lists created" do
      list1 = List.new("Eat")
      list2 = List.new("Sleep")
      list1.save
      list2.save
      List.all.should eq ([list1, list2])
    end
  end

  describe :display_tasks do
    it "displays tasks for only the specified list" do
      list1 = List.new("eat")
      list2 = List.new("play")
      list1.save
      list2.save
      task1 = Task.new("food", list1.id)
      task2 = Task.new("drink", list1.id)
      task3 = Task.new("happy", list2.id)
      task3.save
      task1.save
      task2.save
      List.display_tasks("play").should eq ([task3])

    end
  end

end
