Puzzle.destroy_all
User.destroy_all

london = Puzzle.create(title: "London", design: "photo of London", number_of_pieces: 500, makes_back_sore: false)
colorado = Puzzle.create(title: "Colorado", design: "CO graphic illustration", number_of_pieces: 500, makes_back_sore: false)
bavaria = Puzzle.create(title: "Bavaria", design: "photo of Lichtenstein Castle", number_of_pieces: 1000, makes_back_sore: true)
critical_role = Puzzle.create(title: "Critical Role Vox Macina", design: "illustration of characters from Critical Role", number_of_pieces: 1000, makes_back_sore: true)





User.create(name: "Benton", puzzle_id: london.id, puzzle_complete: false)
User.create(name: "Arielle", puzzle_id: colorado.id, puzzle_complete: false)
User.create(name: "Kyle", puzzle_id: bavaria.id, puzzle_complete: false)


