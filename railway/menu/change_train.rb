# frozen_string_literal: true

# Menu methods that relate to changing the train

class Menu
  module ChangeTrain
    private

    def train_change
      puts 'Enter 1 to attach the selected wagon to the selected train'
      puts 'Enter 2 to unhook the selected wagon'
      case gets.chomp.to_i
      when 1
        @train.add_wagon(@wagon)
      when 2
        @train.delete_wagon(@wagon)
      end
    rescue StandardError => e
      puts e.message
    end

    def moving_train
      puts 'Enter 1 to move the selected train to the next station'
      puts 'Enter 2 to move the selected train to the previous station'
      case gets.chomp.to_i
      when 1
        @train.moving_forward
      when 2
        @train.moving_back
      end
    rescue StandardError => e
      puts e.message
    end
  end
end
