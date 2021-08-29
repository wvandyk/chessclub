class Match < ApplicationRecord
  belongs_to :winner, class_name: "Member", foreign_key: "winner_id"
  belongs_to :loser, class_name: "Member", foreign_key: "loser_id"
  validate :player_cannot_play_themselves
  after_save :rerank

  def player_cannot_play_themselves
    if self.winner == self.loser
      errors.add(:winner_id, "cannot play themselves")
    end
  end

  def rerank
    if self.draw == true
      high_rank, low_rank = [self.loser, self.winner].sort_by(&:rank)
      return if low_rank.rank == (high_rank.rank + 1)
      low_rank.rank_up
    end

    if self.draw == false && (self.winner_previous_rank > self.loser_previous_rank)
      self.loser.rank_down
      ((self.winner_previous_rank - self.loser_previous_rank) / 2).times { self.winner.rank_up }
    end
    return true
  end
end
