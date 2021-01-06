class CLI   
    ActiveRecord::Base.logger = nil
    def clear
        system("clear")
    end
    def start_puzzle_app
        splash_page()
    end
    def splash_page
        puts "Everyday I'm puzzlin'"
        gets
        welcome_user()
    end
    def welcome_user
        clear()
        @user_input_name = prompt.ask("Hello, puzzle friend! What is your name?")
       # @name = gets.chomp
        initial_menu_selection()
    end
    def prompt
        prompt = TTY::Prompt.new()
    end
    def initial_menu_selection
        prompt()
        menu_items = ["See a list of available puzzles", "See puzzles in your possession"]
        selection = prompt.select("What would you like to do?", menu_items)
            if selection == "See a list of available puzzles" 
                available_puzzles()
            elsif selection == "See puzzles in your possession"
                puzzles_in_possession()
            end
    end
    
    def available_puzzles
        puts "The following puzzles are available:"
        prompt()
        @selected_puzzle_title = prompt.select("Would you like to select any of the puzzles below?", Puzzle.where(in_progress: false).pluck("title"))
        borrow_puzzle()
        binding.pry
    end

    def puzzles_in_possession
        clear()
        puts "These are the puzzles in your possession. If not in progress, the puzzle is available for others to borrow"
        #find User whose :name is == to @user_input_name
       puzzles = User.where(name: @user_input_name).pluck("puzzle_id")
        tp Puzzle.where(id: puzzles), :title, :in_progress
    end

    def borrow_puzzle
        #when puzzle is selected, in progress becomes true, and puzzle 'goes' to possession of person
       selected_puzzle = Puzzle.where(title: @selected_puzzle_title) 
       # selected_puzzle.in_progress = true
        #User.create(name:@user_input_name, puzzle_id:@selected_puzzle.object_id)
    end
end
