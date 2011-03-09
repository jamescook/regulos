require "spec_helper"

describe Regulos::CombatLog::EventCollection do
  let(:events){ load_yaml_fixture("samples.yml")["events"] }
  def which(row)
    Regulos::CombatLog::Event::Base.which(row)
  end

  context "#select" do
    before(:each) do
      @events = events.keys.map{|k| which(events[k]) }
      @collection = Regulos::CombatLog::EventCollection.new @events
    end

    context "with a block that matches a heal event by symbol" do
      it "it should only return healing events" do
        @collection.select{|e| e.is_a?(:heal) }.to_a.should == [ which(events["Heal"]) ]
      end
    end

    context "with a block that matches a heal event by Event" do
      it "it should return an EventCollection" do
        @collection.select{|e| e.is_a?(Regulos::CombatLog::Event::Heal) }.should be_an_instance_of(Regulos::CombatLog::EventCollection)
      end
      it "it should only return healing events" do
        @collection.select{|e| e.is_a?(Regulos::CombatLog::Event::Heal) }.to_a.should == [ which(events["Heal"]) ]
      end
    end
  end
end
