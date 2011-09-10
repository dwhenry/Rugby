require 'spec_helper'

describe Match do
  context 'points' do
    subject { Match.new(:result => result) }

    context 'diff on the home team when home team wins' do
      let(:result) { mock_model(Result) }

      it 'points == error when error is positive' do
        result.stub(:diff => 9)
        subject.points_for_pick(10).should == 1
      end

      it 'points == error when error is negative' do
        result.stub(:diff => 11)
        subject.points_for_pick(10).should == 1
      end

      it '10 point bonus when no error' do
        result.stub(:diff => 10)
        subject.points_for_pick(10).should == -10
      end
    end

    context 'diff on the home team when away team wins' do
      let(:result) { mock_model(Result) }

      it 'points = error + 5 point penality' do
        result.stub(:diff => -9)
        subject.points_for_pick(10).should == 24
      end
    end

    context 'diff on the away team when away team wins' do
      let(:result) { mock_model(Result) }

      it 'points == error when error is negative' do
        result.stub(:diff => -9)
        subject.points_for_pick(-10).should == 1
      end

      it 'points == error when error is positive' do
        result.stub(:diff => -11)
        subject.points_for_pick(-10).should == 1
      end

      it '10 point bonus when no error' do
        result.stub(:diff => -10)
        subject.points_for_pick(-10).should == -10
      end
    end

    context 'diff on the away team when home team wins' do
      let(:result) { mock_model(Result) }

      it 'points = error + 5 point penality' do
        result.stub(:diff => 9)
        subject.points_for_pick(-10).should == 24
      end
    end

    context 'when no result yet' do
      let(:result) { mock_model(Result, :diff => nil) }

      it 'no points' do
        subject.points_for_pick(-10).should == 0
      end
    end

    context 'when result but tip not entered yet' do
      let(:result) { mock_model(Result, :diff => 10) }

      it 'points = error + 10 point penality' do
        subject.points_for_pick(0).should == 20
      end

      context 'when it a draw' do
        let(:result) { mock_model(Result, :diff => 0) }

        it 'points = error + 10 point penality' do
          subject.points_for_pick(0).should == 10
        end
      end
    end

    context 'when result is a draw' do
      let(:result) { mock_model(Result, :diff => 0) }

      it 'points = error' do
        subject.points_for_pick(10).should == 10
      end
    end
  end
end
