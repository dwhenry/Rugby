require 'rails_helper'

describe Match do
  describe '#match' do
    subject { Match.create!(name: 'match name', kick_off: 5, location: 'park', description: 'game') }

    context 'when home and away teams exist' do
      before do
        subject.sides.create!(side: 'home', team: Team.create!(short_name: 'ZZZ', name: 'ZZZ', pool: 'A'))
        subject.sides.create!(side: 'away', team: Team.create!(short_name: 'AAA', name: 'ZZZ', pool: 'A'))
        subject.reload
      end

      it 'uses the team short names' do
        expect(subject.match).to eq('ZZZ v AAA')
      end
    end

    context 'when home and away teams dont exist' do
      it 'uses the match name' do
        expect(subject.match).to eq('match name')
      end
    end
  end

  context 'points' do
    subject { Match.new(sides: [home_side, away_side]) }
    let(:away_side) { Side.new(side: 'away', score: 20) }
    let(:home_side) { Side.new(side: 'home', score: nil) }

    context 'pick a draw and its a draw' do
      xit 'points == -10 - yes you get the bonus' do
        home_side.score = 20
        expect(subject.points_for_pick(0)).to eq -10
      end
    end

    context 'diff on the home team when home team wins' do
      it 'points == error when error is positive' do
        home_side.score = 29
        expect(subject.points_for_pick(10)).to eq 1
      end

      it 'points == error when error is negative' do
        home_side.score = 31
        expect(subject.points_for_pick(10)).to eq 1
      end

      it '10 point bonus when no error' do
        home_side.score = 30
        expect(subject.points_for_pick(10)).to eq -10
      end
    end

    context 'diff on the home team when away team wins' do
      it 'points = error + 5 point penality' do
        home_side.score = 11
        expect(subject.points_for_pick(10)).to eq 24
      end
    end

    context 'diff on the away team when away team wins' do
      it 'points == error when error is negative' do
        home_side.score = 11
        expect(subject.points_for_pick(-10)).to eq 1
      end

      it 'points == error when error is positive' do
        home_side.score = 9
        expect(subject.points_for_pick(-10)).to eq 1
      end

      it '10 point bonus when no error' do
        home_side.score = 10
        expect(subject.points_for_pick(-10)).to eq -10
      end
    end

    context 'diff on the away team when home team wins' do
      it 'points = error + 5 point penality' do
        home_side.score = 29
        expect(subject.points_for_pick(-10)).to eq 24
      end
    end

    context 'when no result yet' do
      subject { Match.new }

      it 'no points' do
        expect(subject.points_for_pick(-10)).to eq 0
      end
    end

    context 'when result but tip not entered yet' do
      let(:away_side) { Side.new(side: 'away', score: 5) }
      let(:home_side) { Side.new(side: 'home', score: 15) }

      it 'points = error + 10 point penality' do
        expect(subject.points_for_pick(0)).to eq 20
      end

      context 'when it a draw' do
        let(:away_side) { Side.new(side: 'away', score: 5) }
        let(:home_side) { Side.new(side: 'home', score: 5) }

        it 'points = error + 10 point penality' do
          expect(subject.points_for_pick(0)).to eq 10
        end
      end
    end

    context 'when result is a draw' do
      let(:away_side) { Side.new(side: 'away', score: 5) }
      let(:home_side) { Side.new(side: 'home', score: 5) }

      it 'points = error' do
        expect(subject.points_for_pick(10)).to eq 10
      end
    end
  end
end
