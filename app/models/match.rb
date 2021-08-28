class Match < ApplicationRecord
  belongs_to :winner, class_name: "Member", foreign_key: "winner_id"
  belongs_to :loser, class_name: "Member", foreign_key: "loser_id"

  def rerank
    if self.winner_previous_rank > self.loser_previous_rank
      self.loser.rank_down
      ((self.winner_previous_rank - self.loser_previous_rank) / 2).times { self.winner.rank_up }
    end
  end
end
