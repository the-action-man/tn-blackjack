require_relative 'required_files'

ui = UserInterface.new
ui.show_msg_hello
ui.enter_user_name

game = Game.new(ui)
game.start
