require 'rails_helper'

RSpec.describe Game, type: :model do
  # Validações
  it { is_expected.to validate_presence_of(:mode) }
  it { is_expected.to validate_presence_of(:release_date) }
  it { is_expected.to validate_presence_of(:developer) }

  # Associações
  it { is_expected.to belong_to :system_requirement }
  it { is_expected.to have_one :product }

  # it_has_behavior_of "like searchable concern", :game, :developer

  # Testando a enumeração
  describe 'enums' do
    it 'define os modos corretamente' do
      expect(Game.modes.keys).to contain_exactly('pvp', 'pve', 'both')
    end

    it 'mapeia os modos para os valores corretos' do
      expect(Game.modes['pvp']).to eq(1)
      expect(Game.modes['pve']).to eq(2)
      expect(Game.modes['both']).to eq(3)
    end
  end
end
