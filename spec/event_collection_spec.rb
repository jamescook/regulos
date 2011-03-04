require "spec_helper"

describe Regulos::CombatLog::EventCollection do
  let(:events){ load_yaml_fixture("samples.yml")["events"] }
  def which(row)
    Regulos::CombatLog::Event::Base.which(row)
  end

  context "#find" do
    before(:each) do
      @events = events.keys.map{|k| which(events[k]) }
      @collection = Regulos::CombatLog::EventCollection.new @events
    end

    context "sent :only => {:event => ['Heal']}" do
      it "it should only return healing events" do
        @collection.find(:event => {:only => ['Heal']}).should == [ which(events["Heal"]) ]
      end
    end

    context "sent :exclude => {:event => ['Heal']}" do
      it "it should not return healing events" do
        @collection.find(:event => {:exclude => ['Heal']}).should == @events.select{|e| e.name != "Heal" }
      end
    end

    context "sent :include => {:entity => ['Player']}" do
      it "it should not return player related events" do
        @collection.find(:entity => {:only => ['Player']}).should == @events.select{|e| (e.target && e.target.klass == "Player") || (e.origin && e.origin.klass == "Player") }
      end
    end
  end
end
