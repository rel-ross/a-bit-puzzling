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
    end

    def available_puzzles
        puts "The following puzzles are available:"
    end
end