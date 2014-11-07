Given(/^there is an admin user with email "(.*?)" and password "(.*?)"$/) do |email, password|
  Admin.create(email: email, password: password)
end

Given(/^there is a request for teaching assistant with professor "(.*?)" and course "(.*?)" and requested_number "(.*?)" and priority "(.*?)" and student_assistance "(.*?)" and work_correction "(.*?)" and test_oversight "(.*?)"$/) do |professor_name, course_code, requested_number, priority, student_assistance, work_correction, test_oversight|
  RequestForTeachingAssistant.create(
    professor_id: Professor.where(name: professor_name).take.id,
    course_id: Course.find_by({:course_code => course_code}).id,
    requested_number: requested_number,
    priority: priority,
    student_assistance: student_assistance,
    work_correction: work_correction,
    test_oversight: test_oversight,
    semester_id: Semester.first.id )
end

When(/^there is a request for teaching assistant by professor "(.*?)" for the course "(.*?)"$/) do |professor_name, course_code|
  RequestForTeachingAssistant.create(
    professor_id: Professor.where(name: professor_name).take.id,
    course_id: Course.find_by({:course_code => course_code}).id,
    requested_number: 1,
    priority: 1,
    student_assistance: false,
    work_correction: false,
    test_oversight: false,
    semester_id: Semester.first.id )
end

def create_professor(name, password, nusp, department, email, professor_rank)
  d = Department.find_by("code" => department)
  if not d
    d = Department.create! {{"code" => department}}
  end
  Professor.create(name: name , password: password, nusp: nusp, department_id: d.id, email: email,
    professor_rank: professor_rank,
    confirmation_token:nil, confirmed_at: Time.now)
end

Given(/^there is a professor with name "(.*?)" and password "(.*?)" nusp "(.*?)" department "(.*?)" and email "(.*?)"$/) do |name, password, nusp, department, email|
  create_professor(name, password, nusp, department, email, 0)
end

When(/^there is a professor with name "(.*?)" and nusp "(.*?)" and department "(.*?)" and email "(.*?)"$/) do |name, nusp, department, email|
  create_professor(name, "password", nusp, department, email, 0)
end

Given(/^there is a super_professor with name "(.*?)" and password "(.*?)" nusp "(.*?)" department "(.*?)" and email "(.*?)"$/) do |name, password, nusp, department, email|
  create_professor(name, password, nusp, department, email, 1)
end

Given(/^there is a super_professor with name "(.*?)" nusp "(.*?)" department "(.*?)" and email "(.*?)"$/) do |name, nusp, department, email|
  create_professor(name, "password", nusp, department, email, 1)
end

Given(/^there is a hiper_professor with name "(.*?)" and password "(.*?)" nusp "(.*?)" department "(.*?)" and email "(.*?)"$/) do |name, password, nusp, department, email|
  create_professor(name, password, nusp, department, email, 2)
end

When(/^there is a secretary with name "(.*?)" and password "(.*?)" nusp "(.*?)" and email "(.*?)"$/) do |name, password, nusp, email|
  s = Secretary.create(name: name, nusp: nusp, email: email, password: password,
    confirmation_token:nil, confirmed_at: Time.now)
end

When(/^there is a student with name "(.*?)" and password "(.*?)" and nusp "(.*?)" and gender "(.*?)" and rg "(.*?)" and cpf "(.*?)" and address "(.*?)" and district "(.*?)" and zipcode "(.*?)" and city "(.*?)" and state "(.*?)" and tel "(.*?)" and cel "(.*?)" and email "(.*?)" and has_bank_account "(.*?)"$/) do |name, password, nusp, gender, rg, cpf, address, district, zipcode, city, state, tel, cel, email, has_bank_account|
  Student.create(name: name, password: password, email: email,
    nusp: nusp, gender: gender, rg: rg, cpf: cpf,
    address: address, city: city, district: district, zipcode: zipcode, state: state,
    tel: tel, cel: cel,
    has_bank_account: has_bank_account,
    confirmation_token:nil, confirmed_at: Time.now)
end

Given(/^there is a student with name "(.*?)" with nusp "(.*?)" and email "(.*?)"$/) do |name, nusp, email|
  Student.create(name: name, password: "changeme!", email: email,
    nusp: nusp, institute: "Instituto de Matemática e Estatística", gender: "1", rg: "1", cpf: "1",
    address: "IME", city: "São Paulo", district: "Butantã", zipcode: "0", state: "SP",
    tel: "1145454545", cel: "11985858585",
    has_bank_account: "true",
    confirmation_token:nil, confirmed_at: Time.now)
end

Given(/^there is a department with code "(.*?)"$/) do |code|
  Department.create(code: code)
end

Given(/^there is an candidature with student "(.*?)" and first option "(.*?)" and second option "(.*?)" and third option "(.*?)" and availability for daytime "(.*?)" and availability for night time "(.*?)" and period preference "(.*?)"$/) do |student, course1, course2, course3, av_daytime, av_nighttime, period|
  Candidature.create(
    student_id: Student.where(name: student).take.id,
    course1_id: Course.where(name: course1).take.id,
    course2_id: Course.where(name: course2).take.id,
    semester_id: Semester.first.id,
    daytime_availability: av_daytime,
    nighttime_availability: av_nighttime,
    time_period_preference: period)
end

When(/^there is a candidature by student "(.*?)" for course "(.*?)"$/) do |student_name, course_code|
  course_id = Course.where(course_code: course_code).take.id
  student_id = Student.where(name: student_name).take.id
  Candidature.create(
    student_id: student_id,
    course1_id: course_id,
    semester_id: Semester.first.id,
    daytime_availability: true,
    nighttime_availability: true,
    time_period_preference: 0)
end

When(/^there is a course with name "(.*?)" and code "(.*?)" and department "(.*?)"$/) do |name, code, department|
  Course.create(name: name, course_code: code, department_id: Department.find_by({:code => department}).id)
end

When(/^there is a closed semester "(.*?)" "(.*?)"$/) do |year, parity|
  Semester.create(year: year, parity: parity, open: false)
end

When(/^there is an open semester "(.*?)" "(.*?)"$/) do |year, parity|
  Semester.create(year: year, parity: parity, open: true)
end

When(/^there is an assistant role for student "(.*?)" with professor "(.*?)" at course "(.*?)"$/) do |student_name, professor_name, course_code|
  professor_id = Professor.where(name: professor_name).take.id
  course_id = Course.where(course_code: course_code).take.id
  request_id = RequestForTeachingAssistant.where(professor_id: professor_id, course_id: course_id).take.id
  AssistantRole.create(student_id: Student.where(name: student_name).take.id, request_for_teaching_assistant_id: request_id)
end

