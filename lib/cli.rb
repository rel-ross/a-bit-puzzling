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
       clear()
        prompt()
        if Puzzle.where(in_progress: false).length > 0
        @selected_puzzle_title = prompt.select("The following puzzles are available. Would you like to select any of the puzzles below?", Puzzle.where(in_progress: false).pluck("title"))
        else
            puts "No available puzzles at the moment! Check back soon"
            gets 
            clear()
            initial_menu_selection()
        end
        borrow_puzzle()
    end

    def puzzles_in_possession
        clear()
        puts "These are the puzzles in your possession."
        #find User whose :name is == to @user_input_name
        user_puzzles = User.where(name: @user_input_name)
        puzzles_id = user_puzzles.pluck("puzzle_id")
       # User.name = @user_input_name and in_progress == true
    #   puzzles_to_mark_complete = Puzzle.where(id: puzzles_id).pluck("title")
        puzzles_to_mark_complete = Puzzle.where(id: puzzles_id, in_progress: true).pluck("title")
        tp Puzzle.where(id: puzzles_id), :title, :in_progress
        if puzzles_to_mark_complete.length > 0
        @marked_as_complete = prompt.select("Want to mark any of these puzzles complete? It will make the puzzle avilable for others to borrow", puzzles_to_mark_complete) 
        else
            puts "No puzzles in progress"
        end
        completed_puzzle()
        binding.pry
    end

    def borrow_puzzle
        #THIS IS STILL BUGGY BECAUSE THE APP NEEDS TO DESTROY THE OLD USER THAT HAD THE PUZZLE
    #when puzzle is selected, in progress becomes true, and puzzle 'goes' to possession of person
       selected_puzzle = Puzzle.where(title: @selected_puzzle_title) 
       Puzzle.where(title: @selected_puzzle_title).update(in_progress: true)
       existing_puzzle_id = selected_puzzle.pluck("id")
       old_puzzle_users = User.where(puzzle_id: existing_puzzle_id) 
       old_puzzle_users.destroy_all
       User.create(name:@user_input_name, puzzle_id:selected_puzzle.object_id)
    end

    def completed_puzzle
        Puzzle.where(title: @marked_as_complete).update(in_progress: false)
    end
end
