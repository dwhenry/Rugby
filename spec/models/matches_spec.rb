require 'rails_helper'

describe Match do
  context 'points' do
    subject { Match.new(:result => result) }
    let(:result) { Result.new(away_team: 20) }

    context 'diff on the home team when home team wins' do
      it 'points == error when error is positive' do
        result.home_team = 29
        expect(subject.points_for_pick(10)).to eq 1
      end

      it 'points == error when error is negative' do
        result.home_team = 31
        expect(subject.points_for_pick(10)).to eq 1
      end

      it '10 point bonus when no error' do
        result.home_team = 30
        expect(subject.points_for_pick(10)).to eq -10
      end
    end

    context 'diff on the home team when away team wins' do
      it 'points = error + 5 point penality' do
        result.home_team = 11
        expect(subject.points_for_pick(10)).to eq 24
      end
    end

    context 'diff on the away team when away team wins' do
      it 'points == error when error is negative' do
        result.home_team = 11
        expect(subject.points_for_pick(-10)).to eq 1
      end

      it 'points == error when error is positive' do
        result.home_team = 9
        expect(subject.points_for_pick(-10)).to eq 1
      end

      it '10 point bonus when no error' do
        result.home_team = 10
        expect(subject.points_for_pick(-10)).to eq -10
      end
    end

    context 'diff on the away team when home team wins' do
      it 'points = error + 5 point penality' do
        result.home_team = 29
        expect(subject.points_for_pick(-10)).to eq 24
      end
    end

    context 'when no result yet' do
      let(:result) { Result.new }

      it 'no points' do
        expect(subject.points_for_pick(-10)).to eq 0
      end
    end

    context 'when result but tip not entered yet' do
      let(:result) { Result.new(home_team: 15, away_team: 5) }

      it 'points = error + 10 point penality' do
        expect(subject.points_for_pick(0)).to eq 20
      end

      context 'when it a draw' do
        let(:result) { Result.new(home_team: 5, away_team: 5) }

        it 'points = error + 10 point penality' do
          expect(subject.points_for_pick(0)).to eq 10
        end
      end
    end

    context 'when result is a draw' do
      let(:result) { Result.new(home_team: 5, away_team: 5) }

      it 'points = error' do
        expect(subject.points_for_pick(10)).to eq 10
      end
    end
  end
end
