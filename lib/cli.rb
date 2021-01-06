class CLI   
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
        puts "Hello, puzzle friend! What may I call you?"
        @name = gets.chomp
        initial_menu_selection()
    end
    def prompt
        prompt = TTY::Prompt.new()
    end
    def initial_menu_selection
        prompt()
        menu_items = ["See a list of available puzzles", "See puzzles in your posession"]
        prompt.select("What would you like to do?", menu_items)
    end
    
    def available_puzzles
        puts "The following puzzles are available:"
        prompt()
        prompt.select("Would you like to select any of the puzzles below?", ["test1", "test2"])
    end
end
