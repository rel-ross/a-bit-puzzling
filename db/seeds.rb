Puzzle.destroy_all
User.destroy_all

#london = Puzzle.create(title: "London", design: "photo of London", number_of_pieces: 500, in_progress: true)
#colorado = Puzzle.create(title: "Colorado", design: "CO graphic illustration", number_of_pieces: 500, in_progress: true)
#bavaria = Puzzle.create(title: "Bavaria", design: "photo of Lichtenstein Castle", number_of_pieces: 1000, in_progress: true)
#critical_role = Puzzle.create(title: "Critical Role Vox Macina", design: "illustration of characters from Critical Role", number_of_pieces: 1000, in_progress: true)
mystic_maze = Puzzle.create(title: 'The Mystic Maze', design: "Colorful illustration by the Magic Puzzle Company", number_of_pieces: 1000, in_progress: false)


#User.create(name: "Benton", puzzle_id: london.id)
#User.create(name: "Benton", puzzle_id: critical_role.id)
#User.create(name: "Arielle", puzzle_id: colorado.id)
User.create(name: "Kyle", puzzle_id: mystic_maze.id)


