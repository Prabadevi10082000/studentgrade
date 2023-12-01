class CreateStudents < ActiveRecord::Migration[7.1]
  def change
    create_table :students do |t|
        t.string :name
        t.integer :subject1
        t.integer :subject2
        t.integer :subject3
        t.integer :subject4
  
        t.timestamps
      end
  end
end
