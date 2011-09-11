require 'spec_helper'

describe Pick do
  context 'Can the pick be set?' do
    let(:match) { Match.new }
    subject { Pick.new(:match => match) }

    it 'yes if it is in the future' do
      match.match_date = Date.today.advance(:days => 1)
      subject.should be_can_set
    end

    it 'no if it is in the past' do
      match.match_date = Date.today.advance(:days => -1)
      subject.should_not be_can_set
    end

    context 'if it i today' do
      before do
        match.match_date = Date.today
        match.kick_off = 17.0
      end

      it 'yes if it is more than 1 hour before kickoff' do
        time = Time.parse("#{Date.today} 15:59M")
        Timecop.travel(time) do
          subject.should be_can_set
        end
      end

      it 'no if it is less than 1 hour before kickoff' do
        time = Time.parse("#{Date.today} 16:01M")
        Timecop.travel(time) do
          subject.should_not be_can_set
        end
      end
    end

    it 'no if more than 7 days in the future' do
      match.match_date = Date.today.advance(:days => 8)
      subject.should_not be_can_set
    end
  end
end
