def interactive_menu
    @students = []
    loop do 
        print_menu
        process(gets.chomp)
    end
end

def process(selection)
    case selection 
    when "1"
        input_students
    when "2"
        show_students
    when "3"
        save_students
    when "4"
        load_students
    when "9"
        exit
    else
        puts "I don't know what you meant, try again"
    end
end

def save_students
    file = File.open("students.csv", "w")
    @students.each do |student|
        arr = [student["name"], student["cohort"]]
        csv_line = arr.join(",")
        file.puts csv_line
    end
    file.close
end

def load_students
    file = File.open("students.csv", "r")
    file.readlines.each do |line|
    name, cohort = line.chomp.split(',')
        @students << {"name" => name, "cohort" => cohort.to_sym}
    end
    file.close
end

def show_students
    print_header
    print(@students)
    print_footer(@students)
end

def print_menu
    puts "1. Input the students"
    puts "2. Show the students"
    puts "3. Save the list to students.csv"
    puts "4. Load the list from students.csv"
    puts "9. Exit"
end

def input_students
    puts "Please enter the names of the students"
    puts "To finish, just hit return twice"

    @students = [] 

    name = gets.chomp
    cohorts = ["november", "december", "january"]

    while !name.empty? do
        while true
            puts "enter cohort"
            cohort = gets.chomp
            if cohort.empty?
                cohort = "november"
                break
            elsif cohorts.include? cohort
                break
            else
                puts "this doesnt exist, try again"
            end
        end
        puts "please provide the age"
        age = gets.chomp
        @students << {"name" => name, "cohort" => cohort.to_sym, "age" => age}
        puts "now we have #{@students.count} students"
        name = gets.chomp
    end

    @students
end

def print_header
    puts "The students of Villains Academy"
    puts "-------------"
end

def print(students)
    cohorts = ["november", "december", "january"]
    cohorts.each do |co|
        puts "cohort: #{co}"
        students.each do |student|
            if co == student["cohort"].to_s
                puts student["name"]
            end
        end
    end
    #st_no = 0
    #until st_no == students.count
    #    profile = "#{st_no + 1}. #{students[st_no][:name]} (#{students[st_no][:cohort]} cohort, age: #{students[st_no][:age]})"
    #    a = profile.center(profile.size + (50 - profile.size),"-")
    #    puts a 
    #    st_no += 1
    #end
end

def print_footer(names)
# finally, we print the total number of students
    if names.count > 1
        puts "Overall, we have #{names.count} great students" 
    else
        puts "Overall, we have 1 great student" 
    end
end


interactive_menu
print_header
print(@students)
print_footer(@students)