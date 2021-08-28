class Member < ApplicationRecord
  before_save :set_defaults

  def set_defaults
    self.games_played ||= 0
    self.rank ||= Member.all.size + 1 if self.games_played == 0
  end

  def full_name
    "#{self.name} #{self.surname}"
  end

  def rank_and_name
    "#{self.rank}. #{self.full_name}"
  end

  def rank_up
    return if self.rank == 1
    member = Member.find_by_rank(self.rank - 1)
    self.rank -= 1
    member.rank += 1
    self.save
    member.save
  end

  def rank_down
    return if self.rank == Member.all.count
    member = Member.find_by_rank(self.rank + 1)
    self.rank += 1
    member.rank -= 1
    self.save
    member.save
  end
end
