require File.expand_path(File.dirname(__FILE__) + '/neo')

# Greed is a dice game where you roll up to five dice to accumulate
# points.  The following "score" function will be used to calculate the
# score of a single roll of the dice.
#
# A greed roll is scored as follows:
#
# * A set of three ones is 1000 points
#
# * A set of three numbers (other than ones) is worth 100 times the
#   number. (e.g. three fives is 500 points).
#
# * A one (that is not part of a set of three) is worth 100 points.
#
# * A five (that is not part of a set of three) is worth 50 points.
#
# * Everything else is worth 0 points.
#
#
# Examples:
#
# score([1,1,1,5,1]) => 1150 points
# score([2,3,4,6,2]) => 0 points
# score([3,4,5,3,3]) => 350 points
# score([1,5,1,2,4]) => 250 points
#
# More scoring examples are given in the tests below:
#
# Your goal is to write the score method.

def score(dice)
  # This verbose version worked for up to 3; then started going out of hand
  # dice.sort!
  # score = 0
  # # Case: Empty Array
  # if dice.length == 0
  #   score

  # # Case: Array <= 3 
  # elsif dice.length <= 3
  #   repeat = dice.count(dice[0])
  #   if repeat == 3
  #     if dice[0] == 1
  #       score += 1000
  #     else
  #       score += dice[0]*100
  #     end
  #   else
  #     if dice[0] == 1
  #       score += repeat*100
  #     elsif dice[0] == 5
  #       score += repeat*50
  #     end
  #   end

  # # Case: 4 or 5 Array 
  # else
  #   length = dice.length
  #   repeat = dice.count(dice[0])
  #   if repeat == 5
  #     if dice[0] == 1
  #       score += 1000 + 2 * 100
  #     elsif dice[0] == 5
  #       score += (5 * 100) + (2 * 50)
  #     else
  #       score += dice[0]*100
  #     end
  #   elsif repeat == 4
  #     if dice[0] == 1
  #       score += 1000 + 100
  #     elsif dice[0] = 5
  #       score += (5 * 100) + 50
  #     else
  #       score += dice[0]*100

  # Another paused approach
  # counts = Hash.new(0)
  # dice.each {|i| counts[i] += 1}    
  # dice.uniq!
  # score = 0
  # dice.each do |elem|
  #   if counts[elem] == 5
  #     if elem == 1
  #       score += 1200
  #     elsif elem == 5  
  #       score += 600  
  #     else
  #       score += elem * 100
  #   elsif counts[elem] == 4
  #     if elem == 1
  #       score += 1100
  #     elsif elem == 5 
  #       score += 550
  #     else
  #       score += elem * 100
  #     end  
  #   elsif counts[elem] == 3
  
  # end         
  
  # end  


  counts = Hash.new(0)
  dice.each {|i| counts[i] += 1}    
  dice.uniq!
  score = 0
  dice.each do |elem|
    if elem == 1
      case counts[elem]
      when 5 then score += 1200
      when 4 then score += 1100
      when 3 then score += 1000
      when 2 then score += 200
      when 1 then score += 100
      end
    elsif elem == 5
      case counts[elem]
      when 5 then score += 600
      when 4 then score += 550
      when 3 then score += 500
      when 2 then score += 100
      when 1 then score += 50
      end  
    else
      if counts[elem] >= 3
        score += 100 * elem  
      end  
    end
  end
  score    
end

class AboutScoringProject < Neo::Koan
  def test_score_of_an_empty_list_is_zero
    assert_equal 0, score([])
  end

  def test_score_of_a_single_roll_of_5_is_50
    assert_equal 50, score([5])
  end

  def test_score_of_a_single_roll_of_1_is_100
    assert_equal 100, score([1])
  end

  def test_score_of_multiple_1s_and_5s_is_the_sum_of_individual_scores
    assert_equal 300, score([1,5,5,1])
  end

  def test_score_of_single_2s_3s_4s_and_6s_are_zero
    assert_equal 0, score([2,3,4,6])
  end

  def test_score_of_a_triple_1_is_1000
    assert_equal 1000, score([1,1,1])
  end

  def test_score_of_other_triples_is_100x
    assert_equal 200, score([2,2,2])
    assert_equal 300, score([3,3,3])
    assert_equal 400, score([4,4,4])
    assert_equal 500, score([5,5,5])
    assert_equal 600, score([6,6,6])
  end

  def test_score_of_mixed_is_sum
    assert_equal 250, score([2,5,2,2,3])
    assert_equal 550, score([5,5,5,5])
    assert_equal 1100, score([1,1,1,1])
    assert_equal 1200, score([1,1,1,1,1])
    assert_equal 1150, score([1,1,1,5,1])
  end

end
