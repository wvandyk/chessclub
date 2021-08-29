require 'rails_helper'

# I am following the four-phase model as per https://thoughtbot.com/blog/four-phase-test

describe Match do
  context "Reranking" do
    def create_members
      @t1 = Member.create(name: "Test1")
      @t2 = Member.create(name: "Test2")
      @t3 = Member.create(name: "Test3")
      @t4 = Member.create(name: "Test4")
      @t5 = Member.create(name: "Test5")
    end

    def teardown
      Member.delete_all
      Match.delete_all
    end

    it "should rank the loser down by one and the winner up by half the difference in their ranks" do
      create_members
      match = Match.new(winner: @t5, winner_previous_rank: @t5.rank, loser: @t1, loser_previous_rank: @t1.rank, draw: false)
   
      match.save

      expect(@t1.rank).to eql 2
      expect(@t5.rank).to eql 3

      teardown
    end

    it "should rank the lower ranked player up by one when there is a draw" do
      create_members
      match = Match.new(winner: @t1, winner_previous_rank: @t1.rank, loser: @t3, loser_previous_rank: @t3.rank, draw: true)
   
      match.save

      expect(@t1.rank).to eql 1
      expect(@t3.rank).to eql 2

      teardown
    end

    it "should not rank the lower ranked player up if the next rank up is the other player" do
      create_members
      match = Match.new(winner: @t1, winner_previous_rank: @t1.rank, loser: @t2, loser_previous_rank: @t2.rank, draw: true)
   
      match.save

      expect(@t1.rank).to eql 1
      expect(@t2.rank).to eql 2

      teardown
    end

    it "should not change the ranks of either player if the higher ranked player wins" do
      create_members
      match = Match.new(winner: @t1, winner_previous_rank: @t1.rank, loser: @t3, loser_previous_rank: @t3.rank, draw: false)
   
      match.save

      expect(@t1.rank).to eql 1
      expect(@t3.rank).to eql 3

      teardown
    end
  end
end