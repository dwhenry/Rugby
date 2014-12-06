require 'spec_helper'

describe Pick do
  context 'Can the pick be set?' do
    let(:match) { Match.new }
    subject { Pick.new(:match => match) }

    it 'yes if it is in the future' do
      match.match_date = Date.today.advance(:days => 1)
      expect(subject).to be_can_set
    end

    it 'no if it is in the past' do
      match.match_date = Date.today.advance(:days => -1)
      expect(subject).not_to be_can_set
    end

    context 'if it i today' do
      before do
        match.match_date = Date.today
        match.kick_off = 17.0
      end

      it 'yes if it is more than 1 hour before kickoff' do
        time = Time.parse("#{Date.today} 15:59M")
        Timecop.travel(time) do
          expect(subject).to be_can_set
        end
      end

      it 'no if it is less than 1 hour before kickoff' do
        time = Time.parse("#{Date.today} 16:01M")
        Timecop.travel(time) do
          expect(subject).not_to be_can_set
        end
      end
    end

    it 'no if more than 7 days in the future' do
      match.match_date = Date.today.advance(:days => 8)
      expect(subject).not_to be_can_set
    end
  end
end
