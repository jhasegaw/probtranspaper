#!/usr/bin/ruby
# Create the listper figure in tikz format
File.open("listper.tex","w") do |f|
  # Start the figure
  f.puts "\\begin{center}"
  f.puts "\\begin{tikzpicture}["
  f.puts "    scale=\\mytikzscale,"
  # define node styles
  f.puts "    every node/.style={transform shape}]"
  # draw axes
  f.puts "\\draw[<->] (0,-0.5) to (0,4.5);"
  f.puts "\\draw[<->] (-0.5,0) to (10.5,0);"
  # draw scales
  1.upto(8) do |t|
    f.puts "\\draw (-0.1,#{0.5*t.to_f}) to (0.1,#{0.5*t.to_f});"
    f.puts "\\node at (-0.25,#{0.5*t.to_f}) {#{30+5*t.to_i}};"
  end
  1.upto(9) do |t|
    f.puts "\\draw (#{t},-0.1) to (#{t},0.1);"
    f.puts "\\node at (#{t},-0.25) {0.#{t}};"
  end
  # Draw axis labels and legend
  f.puts "\\node at (-1,2) {LPER};"
  f.puts "\\node at (5,-0.75) {Entropy of the PT (bits per segment)};"
  f.puts "\\node[rectangle,draw=black] at (12.5,2) {\\begin{tabular}{l}-s- = Swahili\\\\-c- = Mandarin\\\\-h- = Hungarian\\end{tabular}};"
  
  langs=['SWH', 'CMN', 'HUN']
  bits=[[0.04, 0.037, 0.03],
        [0.07, 0.084, 0.068],
        [0.12, 0.137, 0.124],
        [0.199, 0.2, 0.232],
        [0.297, 0.276, 0.377],
        [0.437, 0.443, 0.538],
        [0.521, 0.65, 0.634],
        [0.624, 0.757, 0.745],
        [0.744, 0.88, 0.87],
        [1.00, 1.02, 1.00]]

  pers=[[46.2,69.0,62.7],
        [44.8,67.0,61.6],
        [43.6,65.4,60.3],
        [41.6,63.5,57.8],
        [40.1,61.6,55.7],
        [38.1,58.4,53.9],
        [37.3,55.1,52.7],
        [36.3,53.7,51.9],
        [35.6,52.3,50.9],
        [33.9,50.8,49.9]]
        
  0.upto(bits.length-1) do |p|
    f.puts "\\node at (#{10*(bits[p][0].to_f)},#{(pers[p][0].to_f-30)/10}) {s};"
    f.puts "\\node at (#{10*(bits[p][1].to_f)},#{(pers[p][1].to_f-30)/10}) {c};"
    f.puts "\\node at (#{10*(bits[p][2].to_f)},#{(pers[p][2].to_f-30)/10}) {h};"
  end
  0.upto(2) do |q|
    1.upto(bits.length-1) do |p|
      f.puts "\\draw (#{10*(bits[p-1][q].to_f)},#{(pers[p-1][q].to_f-30)/10}) to (#{10*(bits[p][q].to_f)},#{(pers[p][q].to_f-30)/10});"
    end
  end
  f.puts "  \\end{tikzpicture}"
  f.puts "\\end{center}"
end


