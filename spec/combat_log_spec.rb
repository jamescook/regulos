require "spec_helper.rb"

describe Regulos::CombatLog::File do
  context "#new" do
    context "given a valid path" do
      let(:path){ simple_combat_log_path }
      context "sent #reload" do
        before(:each) do
          @log = Regulos::CombatLog::File.new( :path => simple_combat_log_path )
          @log.reload
        end

        it "should capture all events" do
          @log.events.size.should > 0
          @log.events.any?{|e| e.is_a?(Regulos::CombatLog::Event::Unknown) }.should be_false
        end
      end
    end

    context "given a invalid path" do
      context "sent #new" do
        it "should raise FileNotFoundError" do
          lambda{ Regulos::CombatLog::File.new( :path => "/does/not/exist.txt" ) }.should raise_error(Regulos::CombatLog::FileNotFoundError)
        end
      end
    end
  end
end
