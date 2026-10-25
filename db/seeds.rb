# require "date"

# random = Random.new(42)
# today = Date.current
# employee_count = 10_000
# seed_email_pattern = "seed_employee_%"

# roles_by_name = Role.all.index_by { |role| role.name.strip }

# role_distribution = {
#   "Internship" => 300,
#   "Associate Software Engineer" => 1_800,
#   "Software Engineer" => 4_000,
#   "Senior Software Engineer" => 2_500,
#   "Technical Lead" => 700,
#   "Technical Manager" => 400,
#   "HR" => 200,
#   "HR Manager" => 50,
#   "Admin" => 50
# }

# missing_roles = role_distribution.keys - roles_by_name.keys

# if missing_roles.any?
#   abort "Missing roles: #{missing_roles.join(', ')}. Create these roles before seeding."
# end

# unless role_distribution.values.sum == employee_count
#   abort "Role distribution must total #{employee_count}."
# end

# country_distribution = {
#   "IN" => 7_000,
#   "US" => 1_000,
#   "GB" => 500,
#   "CA" => 400,
#   "AU" => 300,
#   "SG" => 200,
#   "DE" => 200,
#   "AE" => 200,
#   "NL" => 100,
#   "FR" => 100
# }

# unless country_distribution.values.sum == employee_count
#   abort "Country distribution must total #{employee_count}."
# end

# country_profiles = {
#   "IN" => {
#     calling_code: "+91",
#     first_names: %w[
#       Aarav Aadhya Aanya Aarohi Abhay Aditi Advait Akash Akanksha
#       Aman Amrita Ananya Aniket Anjali Ankit Anushka Arjun Arnav
#       Bhavna Chetan Deepa Deepak Devanshi Dhruv Divya Gaurav Isha
#       Ishaan Kabir Karan Kavita Khushi Kunal Lakshmi Manish Meera
#       Mihir Neha Nikhil Nisha Pooja Pranav Priya Rahul Raj Riya
#       Rohan Sagar Sakshi Sameer Sanjana Shreya Sneha Tanvi Varun
#       Vedant Vikram Yash
#     ],
#     last_names: %w[
#       Agarwal Arora Bansal Banerjee Bhatia Chawla Desai Deshmukh
#       Ghosh Gupta Iyer Jain Joshi Kapoor Khanna Kulkarni Malhotra
#       Mehta Mishra Nair Patil Pillai Rao Reddy Shah Sharma Shinde
#       Singh Sinha Srivastava Verma Yadav
#     ],
#     cities: %w[
#       Pune Mumbai Bengaluru Hyderabad Chennai Delhi Kolkata
#       Ahmedabad Jaipur Indore
#     ]
#   },

#   "US" => {
#     calling_code: "+1",
#     first_names: %w[
#       James Olivia Liam Emma Noah Ava William Sophia Mason Isabella
#       Ethan Mia Lucas Charlotte Benjamin Amelia Henry Harper
#       Alexander Evelyn Michael Abigail Daniel Emily
#     ],
#     last_names: %w[
#       Smith Johnson Brown Taylor Anderson Thomas Jackson White Harris
#       Martin Thompson Garcia Martinez Robinson Clark Lewis Walker Hall
#       Allen Young King Wright Scott Green Baker Adams Nelson Hill
#     ],
#     cities: %w[
#       Austin Seattle Chicago Boston Denver Atlanta Dallas Portland
#       Phoenix San Diego
#     ]
#   },

#   "GB" => {
#     calling_code: "+44",
#     first_names: %w[
#       Oliver Amelia George Isla Harry Ava Jack Lily Charlie Freya
#       Oscar Grace Arthur Florence Thomas Poppy Edward Emily
#     ],
#     last_names: %w[
#       Smith Jones Taylor Brown Williams Wilson Johnson Davies
#       Robinson Wright Thompson Evans Walker White Edwards Green
#       Hall Lewis Clarke
#     ],
#     cities: %w[
#       London Manchester Bristol Birmingham Leeds Glasgow Edinburgh
#       Liverpool Oxford Cambridge Brighton
#     ]
#   },

#   "CA" => {
#     calling_code: "+1",
#     first_names: %w[
#       Liam Olivia Noah Emma Theodore Charlotte Benjamin Chloe
#       Lucas Sophie Ethan Mila Logan Zoe Jacob Alice
#     ],
#     last_names: %w[
#       Smith Brown Wilson Martin Roy Tremblay Gagnon Lee Taylor
#       Campbell Anderson MacDonald Thompson White Chen Wong Singh
#       Patel Clark
#     ],
#     cities: %w[
#       Toronto Vancouver Montreal Calgary Ottawa Edmonton Winnipeg
#       Halifax Quebec City Victoria
#     ]
#   },

#   "AU" => {
#     calling_code: "+61",
#     first_names: %w[
#       Oliver Charlotte Jack Amelia William Isla Thomas Mia
#       Henry Ava Leo Grace Charlie Ruby James Matilda
#     ],
#     last_names: %w[
#       Smith Jones Williams Brown Wilson Taylor Johnson White Martin
#       Anderson Thompson Nguyen Walker Ryan Robinson Kelly King Lee
#     ],
#     cities: %w[
#       Sydney Melbourne Brisbane Perth Adelaide Canberra Hobart
#       Darwin Newcastle Gold Coast
#     ]
#   },

#   "SG" => {
#     calling_code: "+65",
#     first_names: %w[
#       Wei Ming Jun Jia Hui Xin Li Mei Ying Kai Daniel Ethan
#       Chloe Grace Ryan Rachel Aaron
#     ],
#     last_names: %w[
#       Tan Lim Lee Ng Ong Wong Chan Koh Teo Goh Chua Yeo
#       Seah Chen
#     ],
#     cities: %w[
#       Singapore Tampines Woodlands Jurong Punggol Sengkang
#     ]
#   },

#   "DE" => {
#     calling_code: "+49",
#     first_names: %w[
#       Leon Hannah Paul Emilia Felix Mia Elias Emma Jonas Lina
#       Noah Clara Finn Sophie Lukas Marie
#     ],
#     last_names: %w[
#       Muller Schmidt Schneider Fischer Weber Meyer Wagner Becker
#       Schulz Hoffmann Koch Bauer Richter Klein Wolf Schroder
#     ],
#     cities: %w[
#       Berlin Hamburg Munich Frankfurt Cologne Stuttgart Dresden
#       Leipzig Bremen Dusseldorf
#     ]
#   },

#   "AE" => {
#     calling_code: "+971",
#     first_names: %w[
#       Mohammed Ahmed Omar Ali Zayed Khalid Fatima Aisha Mariam
#       Noor Layla Sara Hassan Abdullah Hamdan
#     ],
#     last_names: %w[
#       Almansoori Almazrouei Alnuaimi Alshamsi Alketbi Alfalasi
#       Khan Rahman Hussain Malik Ahmed Farooq Siddiqui
#     ],
#     cities: %w[
#       Dubai AbuDhabi Sharjah Ajman AlAin RasAlKhaimah
#     ]
#   },

#   "NL" => {
#     calling_code: "+31",
#     first_names: %w[
#       Daan Emma Lucas Sophie Sem Julia Levi Mila Finn Eva
#       Bram Noor Thomas Anna
#     ],
#     last_names: %w[
#       DeVries Jansen DeJong Bakker Visser Smit Meijer DeBoer
#       Mulder Peters Bos Vos Hendriks
#     ],
#     cities: %w[
#       Amsterdam Rotterdam Utrecht Eindhoven Groningen Leiden
#       Haarlem Delft Tilburg
#     ]
#   },

#   "FR" => {
#     calling_code: "+33",
#     first_names: %w[
#       Gabriel Louise Leo Emma Louis Jade Jules Alice Adam Rose
#       Hugo Ines Arthur Chloe Nathan Manon
#     ],
#     last_names: %w[
#       Martin Bernard Thomas Petit Robert Richard Durand Dubois
#       Moreau Laurent Simon Michel Lefebvre Leroy Roux
#     ],
#     cities: %w[
#       Paris Lyon Marseille Toulouse Nice Nantes Bordeaux Lille
#       Strasbourg Montpellier
#     ]
#   }
# }

# street_names = %w[
#   Oak Street Maple Avenue Park Road Lake View Road
#   Station Road Market Street Green Avenue Hill Road
#   River Street Garden Lane Main Road
# ]

# country_pool = country_distribution.flat_map do |country_code, count|
#   Array.new(count, country_code)
# end
# country_pool.shuffle!(random: random)

# role_pool = role_distribution.flat_map do |role_name, count|
#   Array.new(count, roles_by_name.fetch(role_name).id)
# end
# role_pool.shuffle!(random: random)

# User.where("email LIKE ?", "#{seed_email_pattern}%@paywise.example")
#     .delete_all

# seeded_at = Time.current
# minimum_hire_date = Date.new(2015, 1, 1)
# hire_date_range = (today - minimum_hire_date).to_i

# users = Array.new(employee_count) do |index|
#   employee_number = index + 1
#   country_code = country_pool[index]
#   profile = country_profiles.fetch(country_code)

#   first_name = profile[:first_names].sample(random: random)
#   last_name = profile[:last_names].sample(random: random)
#   city = profile[:cities].sample(random: random)
#   street = street_names.sample(random: random)
#   calling_code = profile[:calling_code]

#   hire_date = minimum_hire_date + random.rand(0..hire_date_range)

#   {
#     name: "#{first_name} #{last_name}",
#     email: format(
#       "seed_employee_%05d@paywise.example",
#       employee_number
#     ),
#     role_id: role_pool[index],
#     hire_date: hire_date,
#     country_code: country_code,
#     primary_contact_number: format(
#       "%s-0000-%06d",
#       calling_code,
#       employee_number
#     ),
#     emergency_contact_number: format(
#       "%s-9999-%06d",
#       calling_code,
#       employee_number
#     ),
#     address: "#{random.rand(1..999)} #{street}, #{city}, #{country_code}",
#     blood_group: %w[A+ A- B+ B- AB+ AB- O+ O-].sample(random: random),
#     created_at: seeded_at,
#     updated_at: seeded_at
#   }
# end

# # Insert in batches to avoid 10,000 individual database operations.
# users.each_slice(1_000) do |batch|
#   User.insert_all!(batch)
# end

# seeded_users = User.where(
#   "email LIKE ?",
#   "#{seed_email_pattern}%@paywise.example"
# )

# puts "\nSuccessfully seeded #{seeded_users.count} employees."

# puts "\nEmployees by country:"
# seeded_users.group(:country_code).count.sort.each do |country_code, count|
#   puts "#{country_code}: #{count}"
# end

# puts "\nEmployees by role:"
# seeded_users.joins(:role)
#              .group("roles.name")
#              .count
#              .sort
#              .each do |role_name, count|
#   puts "#{role_name}: #{count}"
# end






# puts "Seeding salary records..."

# SalaryRecord.delete_all

# salary_ranges = {
#   "Internship" => [15_000, 35_000],
#   "Associate Software Engineer" => [400_000, 800_000],
#   "Software Engineer" => [700_000, 1_500_000],
#   "Senior Software Engineer" => [1_400_000, 2_500_000],
#   "Technical Lead" => [2_200_000, 3_500_000],
#   "Technical Manager" => [2_500_000, 4_500_000],
#   "HR" => [400_000, 900_000],
#   "HR Manager" => [1_200_000, 2_200_000],
#   "Admin" => [350_000, 800_000]
# }.freeze

# country_currencies = {
#   "IN" => "INR",
#   "US" => "USD",
#   "GB" => "GBP",
#   "CA" => "CAD",
#   "AU" => "AUD",
#   "SG" => "SGD",
#   "DE" => "EUR",
#   "AE" => "AED",
#   "NL" => "EUR",
#   "FR" => "EUR"
# }.freeze

# international_salary_ranges = {
#   "US" => {
#     "Internship" => [25_000, 45_000],
#     "Associate Software Engineer" => [60_000, 85_000],
#     "Software Engineer" => [80_000, 130_000],
#     "Senior Software Engineer" => [120_000, 180_000],
#     "Technical Lead" => [150_000, 210_000],
#     "Technical Manager" => [160_000, 230_000],
#     "HR" => [45_000, 75_000],
#     "HR Manager" => [80_000, 130_000],
#     "Admin" => [40_000, 70_000]
#   },
#   "GB" => {
#     "Internship" => [18_000, 28_000],
#     "Associate Software Engineer" => [28_000, 40_000],
#     "Software Engineer" => [40_000, 65_000],
#     "Senior Software Engineer" => [60_000, 90_000],
#     "Technical Lead" => [75_000, 105_000],
#     "Technical Manager" => [80_000, 120_000],
#     "HR" => [25_000, 40_000],
#     "HR Manager" => [45_000, 70_000],
#     "Admin" => [24_000, 38_000]
#   }
# }.freeze

# default_salary_multipliers = {
#   "CA" => 0.80,
#   "AU" => 0.90,
#   "SG" => 0.85,
#   "DE" => 0.75,
#   "AE" => 0.80,
#   "NL" => 0.75,
#   "FR" => 0.70
# }.freeze

# salary_records = []
# timestamp = Time.current

# User.includes(:role).find_each do |user|
#   role_name = user.role&.name&.strip
#   country_code = user.country_code

#   next unless salary_ranges.key?(role_name)

#   currency = country_currencies[country_code]
#   next unless currency

#   if country_code == "IN"
#     minimum_salary, maximum_salary = salary_ranges.fetch(role_name)
#   elsif international_salary_ranges.dig(country_code, role_name)
#     minimum_salary, maximum_salary =
#       international_salary_ranges.fetch(country_code).fetch(role_name)
#   else
#     multiplier = default_salary_multipliers.fetch(country_code, 1.0)
#     base_minimum, base_maximum = salary_ranges.fetch(role_name)

#     minimum_salary = (base_minimum * multiplier).round
#     maximum_salary = (base_maximum * multiplier).round
#   end

#   salary_records << {
#     user_id: user.id,
#     role_id: user.role_id,
#     compensation: rand(minimum_salary..maximum_salary),
#     currency: currency,
#     effective_from: user.hire_date || Date.current,
#     created_at: timestamp,
#     updated_at: timestamp
#   }
# end

# salary_records.each_slice(1_000) do |batch|
#   SalaryRecord.insert_all!(batch)
# end

# puts "Created #{salary_records.size} salary records."



puts "Seeding employment histories..."

employees = User.order(:id).limit(2)

if employees.count < 2
  raise "At least 2 employees must exist before seeding employment histories."
end

EmploymentHistory.where(user_id: employees.pluck(:id)).delete_all

employment_history_data = [
  [
    {
      company_name: "TechNova Solutions",
      designation: "Junior Software Engineer",
      salary: 450_000,
      currency: "INR",
      started_on: Date.new(2018, 6, 1),
      ended_on: Date.new(2019, 12, 31)
    },
    {
      company_name: "CloudPeak Technologies",
      designation: "Software Engineer",
      salary: 650_000,
      currency: "INR",
      started_on: Date.new(2020, 1, 1),
      ended_on: Date.new(2021, 6, 30)
    },
    {
      company_name: "Innovate Labs",
      designation: "Software Engineer",
      salary: 850_000,
      currency: "INR",
      started_on: Date.new(2021, 7, 1),
      ended_on: Date.new(2022, 12, 31)
    },
    {
      company_name: "NexGen Systems",
      designation: "Senior Software Engineer",
      salary: 1_200_000,
      currency: "INR",
      started_on: Date.new(2023, 1, 1),
      ended_on: Date.new(2024, 6, 30)
    },
    {
      company_name: "CurrentTech",
      designation: "Senior Software Engineer",
      salary: 1_600_000,
      currency: "INR",
      started_on: Date.new(2024, 7, 1),
      ended_on: nil
    }
  ],
  [
    {
      company_name: "BrightPath Systems",
      designation: "Associate Software Engineer",
      salary: 550_000,
      currency: "INR",
      started_on: Date.new(2019, 4, 1),
      ended_on: Date.new(2020, 9, 30)
    },
    {
      company_name: "Vertex Digital",
      designation: "Software Engineer",
      salary: 750_000,
      currency: "INR",
      started_on: Date.new(2020, 10, 1),
      ended_on: Date.new(2022, 3, 31)
    },
    {
      company_name: "BlueOrbit Technologies",
      designation: "Software Engineer",
      salary: 950_000,
      currency: "INR",
      started_on: Date.new(2022, 4, 1),
      ended_on: Date.new(2023, 6, 30)
    },
    {
      company_name: "Apex Innovations",
      designation: "Senior Software Engineer",
      salary: 1_350_000,
      currency: "INR",
      started_on: Date.new(2023, 7, 1),
      ended_on: Date.new(2025, 1, 31)
    },
    {
      company_name: "FutureStack",
      designation: "Technical Lead",
      salary: 1_900_000,
      currency: "INR",
      started_on: Date.new(2025, 2, 1),
      ended_on: nil
    }
  ]
]

timestamp = Time.current
employment_histories = []

employees.each_with_index do |employee, employee_index|
  employment_history_data[employee_index].each do |history|
    employment_histories << history.merge(
      user_id: employee.id,
      created_at: timestamp,
      updated_at: timestamp
    )
  end
end

employment_histories.each_slice(1_000) do |batch|
  EmploymentHistory.insert_all!(batch)
end

puts "Created #{employment_histories.size} employment history records for #{employees.count} employees."
