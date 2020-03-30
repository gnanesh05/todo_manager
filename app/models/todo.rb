require "active_record"

class Todo < ActiveRecord::Base
  def to_displayable_string
    display_status = completed ? "[X]" : "[ ]"
    display_date = due_date == Date.today ? nil : due_date
    "#{id}.#{display_status} #{todo_text} #{display_date}"
  end

  def self.to_displayable_list
    all.map { |todo| todo.to_displayable_string }
  end

  def self.add_task(task)
    task[:due_date] = Date.today + task[:due_in_days]
    new_todo = task.except (:due_in_days)
    new_todo[:completed] = false
    create!(new_todo)
  end

  def self.mark_as_complete!(todo_id)
    todo = find(todo_id)
    todo.completed = true
    todo.save
  end

  def self.due_later
    all.where("due_date > ?", Date.today)
  end

  def self.due_today
    all.where("due_date = ?", Date.today)
  end

  def self.overdue
    all.where("due_date < ?", Date.today)
  end

  def self.completed
    all.where(completed: true)
  end

  def self.show_list
    puts "My Todo-list\t"
    puts "\t"
    puts "Overdue\t"
    puts overdue.map { |todo| todo.to_displayable_string }
    puts "\t"
    puts "Due Today\t"
    puts due_today.map { |todo| todo.to_displayable_string }
    puts "\t"
    puts "Due Later"
    puts due_later.map { |todo| todo.to_displayable_string }
  end
end
