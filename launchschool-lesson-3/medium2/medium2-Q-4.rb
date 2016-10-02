sentences = "Humpty Dumpty sat on a wall."
puts sentences.split(/\W/).reverse().join(' ') + '.'
