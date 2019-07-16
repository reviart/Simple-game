class RandomWordGame
  attr_accessor :random_word, :max_attempt, :result, :point, :level

  def initialize(random_word, max_attempt, point, level)
    @result = result
    @max_attempt = max_attempt
    @random_word = random_word
    @point = point
    @level = level
  end

  def new_game
    attempt = 0

    until (@result == true) || (attempt == @max_attempt)
      attempt += 1
      print 'Jawab: '
      answer_word = gets.chomp
      @result = valid_word?(@random_word, answer_word)
      puts 'Salah, ayo coba lagi! :D' unless @result
    end

    if @result
      @point = player_point
      @level = player_level if @point == 4 || @point == 7 || @point == 11
    else
      puts 'Yahhh, kesempatan kamu habis! point tidak bertambah'
    end

    [@point, @level]
  end

  def valid_word?(random_word, answer_word)
    if random_word.length == answer_word.length
      answer_word.each_char do |word|
        random_word.delete_at(random_word.index(word))
      rescue
        return false
      end

      true
    end
  end

  def player_point
    @point += case @point
              when 0..3
                1
              when 4..6
                2
              else
                3
              end
    puts "Yey, berhasil! point kamu bertambah menjadi #{@point}"

    @point
  end

  def player_level
    @level =  case @point
              when 4
                "Medium"
              when 8
                "Hard"
              end
    puts "Selamat kamu berhasil naik menjadi level #{@level}"

    @level
  end
end

# ---------------------------------

point = 0
level = 'Beginner'

libraries = [
  ["r", "i", "g", "p", "i", "n"],
  ["i", "n", "g", "i", "p", "r"],
  ["e", "l", "g", "s", "a"],
  ["r", "u", "p", "g", "a"],
  ["k", "d", "e", "s", "o", "n"],
  ["o", "n", "k", "a", "k", "m", "g"],
  ["p", "i", "u", "a", "s"],
  ["e", "e", "k", "c", "m", "e", "l"],
  ["a", "a", "n", "w", "j"],
  ["t", "r", "s", "e", "e", "b"],
  ["e", "k", "r", "e", "c"],
  ["l", "s", "p", "u", "t", "a", "a"],
  ["o", "m", "k", "p", "r", "o"],
  ["n", "c", "e", "n", "t", "g", "o"],
  ["n", "a", "c", "i", "p"],
  ["t", "a", "e", "n", "n", "a", "l"],
  ["r", "n", "g", "s", "a", "a", "i", "n"]
]

puts 'Hallo, berikut adalah permainan tebak kata alat dapur, yaitu benda yang digunakan untuk memasak atau makan.'
print 'Berapa banyak soal yang kamu ingin coba? '
n_question = gets.chomp.to_i

n_question.times do |index|
  random_word = libraries.sample

  print "\n#{index + 1}. Berapa banyak kesempatan yang ingin kamu coba pada soal ini? "
  max_attempt = gets.chomp.to_i
  puts "Kata sifat: #{random_word.join}"

  game = RandomWordGame.new(random_word, max_attempt, point, level)
  point, level = game.new_game
end

puts "\nSelesai, point kamu #{point}, dan kamu berada pada level #{level}"
