# app/controllers/grades_controller.rb

class GradesController < ApplicationController
    before_action :initialize_students
    helper_method :calculate_grade
  
    def index
      @students = Student.all
      @grade_report = generate_grade_report
      @student = Student.new
    end
  
    def create
      student_data = params.require(:student).permit(:id, :name, :subject1, :subject2, :subject3, :subject4)
      Student.create(student_data)
      redirect_to action: :index
    end
  
    private
  
    def initialize_students
      @students = Student.all
    end
  
    def calculate_grade(student)
      total_score = student.subject1.to_i + student.subject2.to_i + student.subject3.to_i + student.subject4.to_i
  
      case total_score
      when 340..Float::INFINITY then 'A'
      when 300..339 then 'B'
      else 'C'
      end
    end

    def generate_grade_report
        grade_report = { 'A' => 0, 'B' => 0, 'C' => 0, 'Above Average' => 0, 'Below Average' => 0 }
    
        total_students = @students.length
        total_score_all = @students.sum { |student| student.subject1 + student.subject2 + student.subject3 + student.subject4 }
        overall_average_score = total_score_all / (total_students * 4).to_f
    
        @students.each do |student|
          grade = calculate_grade(student)
          total_score = student.subject1 + student.subject2 + student.subject3 + student.subject4
          grade_report[grade] += 1
    
          if total_score > overall_average_score
            grade_report['Above Average'] += 1
          else
            grade_report['Below Average'] += 1
          end
        end
    
        grade_report
    end
    
end
  