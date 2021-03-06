require 'rails_helper'

# User Story 2 of 4
# As a visitor,
# When I visit '/professors/:id'
# I see a list of the names of the students the professors have.
# (e.g. "Neville Longbottom"
#      "Hermione Granger"
#      "Luna Lovegood")

describe 'As a vistor' do
  describe "When I visit '/professors/:id" do
    before(:each) do
      @snape = Professor.create(name: "Severus Snape", age: 45, specialty: "Potions")
      @lupin = Professor.create(name: "Remus Lupin", age: 49 , specialty: "Defense Against The Dark Arts")
      @harry = Student.create(name: "Harry Potter" , age: 11 , house: "Gryffindor" )
      @malfoy = Student.create(name: "Draco Malfoy" , age: 12 , house: "Slytherin" )
      @longbottom = Student.create(name: "Neville Longbottom" , age: 11 , house: "Gryffindor" )

      ProfessorStudent.create(student_id: @harry.id, professor_id: @lupin.id)
      ProfessorStudent.create(student_id: @malfoy.id, professor_id: @lupin.id)
      ProfessorStudent.create(student_id: @longbottom.id, professor_id: @lupin.id)

    end
    it 'I see a list of the professors students' do
      visit "/professors/#{@lupin.id}"
      @lupin.students.each do |student|
        within("#student-#{student.id}") do
          expect(page).to have_content(student.name)
        end
    
      end
    end
    it 'If prof has no students, there is no prof students section' do
      visit "/professors/#{@snape.id}"
      expect(page).to_not have_selector('#student-dtls')
    end
    it 'I see the average age of all students for that professor' do
      visit "/professors/#{@lupin.id}"
      within('#students') do
        expect(page).to have_content(@lupin.avg_student_age)
      end
    end
  end
end
