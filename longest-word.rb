words = File.read('/usr/share/dict/words').lines

def reduce_master_dict(arr, tile_length)
  arr.select { |word| word.strip.length <= tile_length }.sort_by! { |word| -word.length }
end

def is_valid?(tile_dict, word_dict)
  return_value = true
  word_dict.each do |k, v|
    if tile_dict[k].nil? || tile_dict[k] < word_dict[k]
      return_value = false
      break
    end
  end
  return_value
end

def create_dict(string)
  return_dict = {}
  string.chars.each do |char|
    return_dict[char] ? return_dict[char] += 1 : return_dict[char] = 1
  end
  return_dict
end

def find_longest_word(words, tiles)
  current_length = tiles.length
  tile_dict = create_dict(tiles.downcase)
  valid_words = reduce_master_dict(words, current_length)
  return_word = false
  valid_words.each do |word|
    word_dict = create_dict(word.downcase.strip)
    if is_valid?(tile_dict, word_dict)
      return_word = word
      break
    end
  end
  return_word
end
