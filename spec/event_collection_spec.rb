require "spec_helper"

describe Regulos::CombatLog::EventCollection do
  let(:events){ load_yaml_fixture("samples.yml")["events"] }
  def which(row)
    Regulos::CombatLog::Event::Base.which(row)
  end

  context "#filter" do
    before(:each) do
      @events = events.keys.map{|k| which(events[k]) }
      @collection = Regulos::CombatLog::EventCollection.new @events
    end

    context "sent :only => {:event => ['Heal']}" do
      it "it should only return healing events" do
        @collection.filter(:only => {:event => ["Heal"]}).should == [ which(events["Heal"]) ]
      end
    end

    context "sent :exclude => {:event => ['Heal']}" do
      it "it should not return healing events" do
        @collection.filter(:exclude => {:event => ["Heal"]}).should == @events.select{|e| e.name != "Heal" }
      end
    end
  end
end
