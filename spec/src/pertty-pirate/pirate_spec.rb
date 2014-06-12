require 'spec_helper'

describe PrettyPirate::Pirate do

  describe '.profane?' do

    context 'a blacklist word' do

      before do
        PrettyPirate::Pirate.configure do |config|
          config.blacklist = ['php']
          config.whitelist = []
          config.replacement = :none
        end
      end

      it 'returns true when that curse word is in my text' do
        expect(PrettyPirate::Pirate.profane?('I wrote an app in php!')).to be_truthy
      end

      it 'returns true when that curse word is in my text and capitalized' do
        expect(PrettyPirate::Pirate.profane?('I wrote an app in PHP!')).to be_truthy
      end

      it 'returns false when that curse word is in my text' do
        expect(PrettyPirate::Pirate.profane?('I wrote a ruby gem!')).to be_falsey
      end

    end

    context 'a blacklist and a whitelist' do

      before do
        PrettyPirate::Pirate.configure do |config|
          config.blacklist = ['php']
          config.whitelist = ['not using php']
          config.replacement = :none
        end
      end

      it 'does not filter when I am using the whitelist version' do
        expect(PrettyPirate::Pirate.profane?('I am not using php!')).to be_falsey
      end

    end

  end

  describe '.sanitize' do

    context 'a blacklist word and replacement style' do

      before do
        PrettyPirate::Pirate.configure do |config|
          config.blacklist = ['php']
          config.whitelist = []
          config.replacement = :star
        end
      end

      it 'replaces the blacklisted word with stars' do
        expect(PrettyPirate::Pirate.sanitize('I wrote an app in php!')).to eq('I wrote an app in ***!')
      end

      it 'replaces none of the good words' do
        expect(PrettyPirate::Pirate.sanitize('I wrote a ruby gem!')).to eq('I wrote a ruby gem!')
      end

    end

    context 'a blacklist and a whitelist' do

      before do
        PrettyPirate::Pirate.configure do |config|
          config.blacklist = ['php']
          config.whitelist = ['not using php']
          config.replacement = :star
        end
      end

      it 'does not filter when I am using the whitelist version' do
        expect(PrettyPirate::Pirate.sanitize('I am not using php!')).to eq('I am not using php!')
      end

    end

  end

end
