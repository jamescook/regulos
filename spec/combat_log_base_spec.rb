require "spec_helper.rb"

describe Regulos::CombatLog::Event::Base do
  context ".which" do
    def which(row)
      Regulos::CombatLog::Event::Base.which(row)
    end

    let(:events){ load_yaml_fixture("samples.yml")["events"] }

    context "for an invalid row" do
      it "should return UnknownAction" do
        which( events["Unknown"] ).should be_an_instance_of( Regulos::CombatLog::Event::Unknown )
      end
    end

    context "for a row signaling a spell is being cast" do
      it "should return BeginCast" do
        which( events["BeginCast"] ).should be_an_instance_of( Regulos::CombatLog::Event::BeginCast )
      end
    end

    context "for a row signaling a spell has been interrupted" do
      it "should return Interrupt" do
        which( events["Interrupt"] ).should be_an_instance_of( Regulos::CombatLog::Event::Interrupt )
      end
    end

    context "for a row signaling a spell landed on the target" do
      it "should return AttackHit" do
        which( events["AttackHit"] ).should be_an_instance_of( Regulos::CombatLog::Event::AttackHit )
      end
    end

    context "for a row signaling a spell did damage over time" do
      it "should return DamageOverTime" do
        which( events["DamageOverTime"] ).should be_an_instance_of( Regulos::CombatLog::Event::DamageOverTime )
      end
    end

    context "for a row signaling the target was healed" do
      it "should return Heal" do
        which( events["Heal"] ).should be_an_instance_of( Regulos::CombatLog::Event::Heal )
      end
    end

    context "for a row signaling a buff was cast" do
      it "should return BuffGain" do
        which( events["BuffGain"] ).should be_an_instance_of( Regulos::CombatLog::Event::BuffGain )
      end
    end

    context "for a row signaling a buff ended" do
      it "should return BuffFade" do
        which( events["BuffFade"] ).should be_an_instance_of( Regulos::CombatLog::Event::BuffFade )
      end
    end

    context "for a row signaling a debuff was cast" do
      it "should return Affliction" do
        which( events["Affliction"] ).should be_an_instance_of( Regulos::CombatLog::Event::Affliction )
      end
    end

    context "for a row signaling a debuff ended" do
      it "should return Dissipate" do
        which( events["Dissipate"] ).should be_an_instance_of( Regulos::CombatLog::Event::Dissipate )
      end
    end

    context "for a row signaling a spell missed" do
      it "should return AttackMiss" do
        which( events["AttackMiss"] ).should be_an_instance_of( Regulos::CombatLog::Event::AttackMiss )
      end
    end

    context "for a row signaling an entity died" do
      it "should return Death" do
        which( events["Death"] ).should be_an_instance_of( Regulos::CombatLog::Event::Death )
      end
    end

    context "for a row signaling an unknown death occurred" do
      it "should return UnknownDeath" do
        which( events["UnknownDeath"] ).should be_an_instance_of( Regulos::CombatLog::Event::UnknownDeath )
      end
    end

    context "for a row signaling fall damage" do
      it "should return FallDamage" do
        which( events["FallDamage"] ).should be_an_instance_of( Regulos::CombatLog::Event::FallDamage )
      end
    end

    context "for a row signaling a spell was dodged" do
      it "should return Dodge" do
        which( events["Dodge"] ).should be_an_instance_of( Regulos::CombatLog::Event::Dodge )
      end
    end

    context "for a row signaling a spell was parried" do
      it "should return Parry" do
        which( events["Parry"] ).should be_an_instance_of( Regulos::CombatLog::Event::Parry )
      end
    end

    context "for a row signaling a spell critically hit" do
      it "should return CriticalHit" do
        which( events["CriticalHit"] ).should be_an_instance_of( Regulos::CombatLog::Event::CriticalHit )
      end
    end

    context "for a row signaling the target was immune to a spell" do
      it "should return Immune" do
        which( events["Immune"] ).should be_an_instance_of( Regulos::CombatLog::Event::Immune )
      end
    end

    context "for a row signaling the target received mana" do
      it "should return ManaGain" do
        which( events["ManaGain"] ).should be_an_instance_of( Regulos::CombatLog::Event::ManaGain )
      end
    end

    context "for a row signaling the target was critically healed" do
      it "should return CriticalHeal" do
        which( events["CriticalHeal"] ).should be_an_instance_of( Regulos::CombatLog::Event::CriticalHeal )
      end
    end
  end
end
