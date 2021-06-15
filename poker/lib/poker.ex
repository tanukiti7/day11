defmodule Poker do

  def create_deck do
    numbers = ["Ace","Two","Three","Four","Five","Six","Seven","Eight","Nine","Ten","Jack","Queen","King"]
    suits = ["Spade","Clover","Diamond","Heart",]
    for suit <-  suits, num <- numbers do
      "#{num}_of_#{suit}"
    end
  end

  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  def contains?(deck,str) do
    Enum.member?(deck,str)
  end


  def deal(deck,deal_size) do
    Enum.split(deck,deal_size)
  end

  def flash?(m1, m2, m3, m4, m5) do
    if ((m1<=13&&m2<=13&&m3<=13&&m4<=13&&m5<=13)
     || (14<=m1&&m1<=26&&14<=m2&&m2<=26&&14<=m3&&m3<=26&&14<=m4&&m4<=26&&14<=m5&&m5<=26)
     || (27<=m1&&m1<=39&&27<=m2&&m2<=39&&27<=m3&&m3<=39&&27<=m4&&m4<=39&&27<=m5&&m5<=39)
     || (m1>=40&&m2>=40&&m3>=40&&m4>=40&&m5>=40)) do
      5
     else
      0
    end
  end

  def pair?(m1, m2, m3, m4, m5) do
    list = [rem(m1, 13), rem(m2, 13), rem(m3, 13), rem(m4, 13), rem(m5, 13)]
    |> Enum.frequencies()
    |> Map.values()
    |> Enum.sort(&(&1<=&2))
    cond do
      list == [1,1,1,1,1] -> 0
      list == [1,1,1,2] -> 1
      list == [1,2,2] -> 2
      list == [1,1,3] -> 3
      list == [2,3] -> 6
      list == [1,4] -> 7
    end
  end

  def straight?(m1, m2, m3, m4, m5) do
    straight_list = [[1,2,3,4,5],[2,3,4,5,6],[3,4,5,6,7],[4,5,6,7,8],[5,6,7,8,9],[6,7,8,9,10],[7,8,9,10,11],[8,9,10,11,12],[9,10,11,12,13]]
    list = [rem(m1, 13), rem(m2, 13), rem(m3, 13), rem(m4, 13), rem(m5, 13)]
    |> Enum.sort(&(&1<=&2))
    if list = [0,10,11,12,13] do
      4.5
    end
    if list in straight_list do
      4
    else
      0
    end
  end

  def define_hand(score) do
    cond do
      score == 0 -> "high card"
      score == 1 -> "one pair"
      score == 2 -> "two pair"
      score == 3 -> "three card"
      score == 4 -> "straight"
      score == 4.5 -> "straight"
      score == 5 -> "flash"
      score == 6 -> "full house"
      score == 7 -> "four card"
      score == 9 -> "straight flash"
      score == 9.5 -> "loyal straight flash"
    end
  end

  def result(myscore, enemyscore) do
    if myscore > enemyscore do
      "YOU WIN"
    else
      if myscore < enemyscore do
         "YOU LOSE"
       else
         "DRAW"
      end
    end
  end


end
