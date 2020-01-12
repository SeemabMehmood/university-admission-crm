class ApplicationPdf < Prawn::Document
  def initialize(application)
    super(top_margin: 70)
    @application = application
    applicant
  end

  def applicant
    text "Reference No\: #{@application.reference_no}", size: 30, style: :bold
    move_down 10
    text "\t\tCourse Name:\t#{@application.major_course} #{@application.intake}", size: 12
    text "Country: #{@application.representing_country.name}\t\t\tInstitution: #{@application.representing_institutions.pluck(:name).join(" & ")}", size: 12
    move_down 10
    text "Accommodation: #{@application.accommodation ? "Yes" : "No"}\t\tMedical: #{@application.medical ? "Yes" : "No"}\t\tInterview Date: #{@application.interview_date}", size: 12
    move_down 10
    text "Applicant Data", size: 15, style: :bold
    move_down 10
    personal_info_items
    move_down 10
    text "Education Details", size: 15, style: :bold
    education_items
    move_down 10
    text "Language Details", size: 15, style: :bold
    language_items
    move_down 10
    text "Work Experience Details", size: 15, style: :bold
    work_experience_items
    move_down 10
    text "Reference Details", size: 15, style: :bold
    reference_items
    move_down 10
    text "Statement of Purpose:", size: 15, style: :bold
    text "#{@application.statement_of_purpose}", size: 12
  end

  def personal_info_items
    table personal_info_rows do
      row(0).font_style = :bold
      columns(1..3).align = :right
      self.row_colors = ['DDDDDD', 'FFFFFF']
      self.header = true
    end
  end

  def personal_info_rows
    [["Name", "Gender", "Title", "Marital Status", "DOB",
      "Nationality", "Passport", "Email", "Skype", "Phone"]] +
    [[@application.applicant.name, @application.applicant.gender, @application.applicant.title, @application.applicant.marital_status,
      @application.applicant.dob, @application.applicant.nationality, @application.applicant.passport_no,
      @application.applicant.email, @application.applicant.skypeid, @application.applicant.phone_number]]
  end

  def education_items
    move_down 20
    table education_rows do
      row(0).font_style = :bold
      columns(1..3).align = :right
      self.row_colors = ['DDDDDD', 'FFFFFF']
      self.header = true
    end
  end

  def education_rows
    [["Majore Degree", "Institution", "Year", "Grade"]] +
    @application.applicant.educations.map do |education|
      [education.qualification, education.institute,
      "#{education.starting_year} to #{education.year_passing}", education.grade]
    end
  end

  def language_items
    move_down 20
    table language_rows do
      row(0).font_style = :bold
      columns(1..3).align = :right
      self.row_colors = ['DDDDDD', 'FFFFFF']
      self.header = true
    end
  end

  def language_rows
    [["Test", "Listening", "Speaking", "Reading", "Writing", "Overall"]] +
    @application.applicant.languages.map do |language|
      [language.test_type, language.listening, language.speaking,
        language.reading, language.writing, language.overall]
    end
  end

  def work_experience_items
    move_down 20
    table work_experience_rows do
      row(0).font_style = :bold
      columns(1..3).align = :right
      self.row_colors = ['DDDDDD', 'FFFFFF']
      self.header = true
    end
  end

  def work_experience_rows
    [["Employer", "Position", "Period", "Responsibilities"]] +
    @application.applicant.work_experiences.map do |work_experience|
      [work_experience.employer, work_experience.position, work_experience.period,
        work_experience.responsibilities]
    end
  end

  def reference_items
    move_down 20
    table reference_rows do
      row(0).font_style = :bold
      columns(1..3).align = :right
      self.row_colors = ['DDDDDD', 'FFFFFF']
      self.header = true
    end
  end

  def reference_rows
    [["Name", "Designation", "Institution", "Phone", "Email"]] +
    @application.applicant.references.map do |reference|
      [reference.name, reference.designation, reference.institution,
        reference.phone, reference.email]
    end
  end
end
