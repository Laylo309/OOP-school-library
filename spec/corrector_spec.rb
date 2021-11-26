require_relative '../library/corrector'
require_relative '../library/student'

describe Corrector do
  context 'When testing the Corrector class' do
    it 'Should capitalize first letters in the name' do
      new_corrector = Corrector.new
      expect(new_corrector.correct_name('laylo')).to eq 'Laylo'
    end
    it 'Should limit the amout of the letters in the name to 10 characters' do
      new_corrector = Corrector.new
      expect(new_corrector.correct_name('laylokhodjaeva')).to eq 'Laylokhodj'
    end
  end
end
