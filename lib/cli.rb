class CLI   
    ActiveRecord::Base.logger = nil
    def clear
        system("clear")
    end

    def start_puzzle_app
        clear()
        splash_page()
    end

    def prompt
        prompt = TTY::Prompt.new(active_color: :cyan, symbols: {marker: '🧩'})
    end

    def logo
        font = TTY::Font.new(:doom)
        puts font.write("A Bit Puzzled").colorize(:magenta)
    puts "Join our community of puzzlers through this puzzle swap app! Press ENTER".colorize(:cyan)
                                                        
    end

    def splash_page
        logo()
        gets
        welcome_user()
    end
    def welcome_user
        clear()
        @user_input_name = prompt.ask("Hello, puzzle friend! What is your name?")
       # @name = gets.chomp
        validate_user()
    end

    def validate_user
        user_validation = User.all.find do |user|
            user.name == @user_input_name
        end
        if user_validation == nil
           puts "I don't believe we've met, let's get you all set up."
           newest_user = User.create(name: @user_input_name)
           puts ""
           puts "Woohoo, you're in!"
           return_to_menu()
        end
        if user_validation != nil
        main_menu()
        end
    end

    def main_menu
        clear()
        prompt()
        menu_items = ["See a list of available puzzles", "Add a puzzle to the swap", "See puzzles in your possession"]
        selection = prompt.select("What would you like to do?", menu_items)
            if selection == "See a list of available puzzles" 
                available_puzzles()
            elsif selection == "Add a puzzle to the swap"
                add_puzzle() 
            elsif selection == "See puzzles in your possession"
                puzzles_in_possession()
            end
    end
    
    def available_puzzles
        clear()
        prompt()
        if Puzzle.where(in_progress: false).length > 0
        @selected_puzzle_title = prompt.select("The following puzzles are available. Would you like to select any of the puzzles below?", Puzzle.where(in_progress: false).pluck("title"))
        borrow_puzzle()
        else
            puts "No available puzzles at the moment! Check back soon"
            return_to_menu()
        end
        available_puzzles()
    end

    def borrow_puzzle
        selected_puzzle = Puzzle.where(title: @selected_puzzle_title) 
       Puzzle.where(title: @selected_puzzle_title).update(in_progress: true)
       existing_puzzle_id = selected_puzzle.pluck("id")
       old_puzzle_users = User.where(puzzle_id: existing_puzzle_id) 
       old_puzzle_users.destroy_all
       new_puzzle_assignment = User.create(name:@user_input_name, puzzle_id:selected_puzzle.pluck("id")[0])
    end

    def puzzles_in_possession
        clear()
        puts "These are the puzzles in your possession."
        user_puzzles = User.where(name: @user_input_name)
        puzzles_id = user_puzzles.pluck("puzzle_id")
        puts ""
        tp Puzzle.where(id: puzzles_id), :title, :in_progress
        puzzles_in_progress = Puzzle.where(id: puzzles_id, in_progress: true).pluck("title") 
        puts ""
        if puzzles_in_progress.length > 0
        @mark_as_complete_selection = prompt.select("Want to mark any of these puzzles complete? It will make the puzzle avilable for others to borrow", puzzles_in_progress) 
        completed_puzzle()  
        puzzles_in_possession()  
        else
            puts "No puzzles in progress"
        end
        return_to_menu()
    end

    def add_puzzle
        input_title = prompt.ask("Puzzle title?")
        input_design = prompt.ask("Give a description of the puzzle")
        input_number_of_pieces = prompt.ask("Pieces?")
        Puzzle.create(title: input_title, design: input_design, number_of_pieces: input_number_of_pieces, in_progress: false)
        return_to_menu()
    end

    def completed_puzzle
        Puzzle.where(title: @mark_as_complete_selection).update(in_progress: false)
    end

  

    def return_to_menu
       if prompt.keypress("Press space to got to main menu", keys: [:space])
        clear()
             main_menu()
       end
    end

end
