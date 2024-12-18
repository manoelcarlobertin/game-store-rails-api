require 'rails_helper'

RSpec.describe Game, type: :model do
  # Validações
  it { is_expected.to validate_presence_of(:mode) }
  it { is_expected.to validate_presence_of(:release_date) }
  it { is_expected.to validate_presence_of(:developer) }

  # Associações
  it { is_expected.to belong_to :system_requirement }
  it { is_expected.to have_one :product }

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

  # Testando mensagens de erro
  describe 'mensagens de erro' do
    let(:game) { Game.new }

    it 'retorna mensagem de erro quando mode está ausente' do
      game.valid?
      expect(game.errors[:mode]).to include("can't be blank")
    end

    it 'retorna mensagem de erro quando release_date está ausente' do
      game.valid?
      expect(game.errors[:release_date]).to include("can't be blank")
    end

    it 'retorna mensagem de erro quando developer está ausente' do
      game.valid?
      expect(game.errors[:developer]).to include("can't be blank")
    end
  end
end
