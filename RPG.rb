"""  ** I'm not sure if this is necessary **
module TkCore 
  RUN_EVENTLOOP_ON_MAIN_THREAD = true
end
"""

require 'tk'
require 'tkextlib/tile'

class NPC
	attr_accessor :level, :name, :health, :mana, :strength, :dexterity, :agility, :intellect, :constitution, :wisdom, 
	:charisma, :inventory, :gold

	def initialize(level=1, name="NPC", health=100, mana=100, strength=10, dexterity=10, agility=10, 
		intellect=10, constitution=10, wisdom=10, charisma=10, inventory=Inventory.new, gold=0)
		@level = level
		@name = name
		@health = health
		@mana = mana
		@strength = strength
		@dexterity = dexterity
		@agility = agility
		@intellect = intellect
		@constitution = constitution
		@wisdom = wisdom
		@charisma = charisma
		@inventory = inventory
		@gold = gold
	end
end

class Player < NPC
	attr_accessor :skills

	attr_writer :weapon, :armor_head, :armor_neck, :armor_body, :armor_arms, :armor_hands, 
	:armor_legs, :armor_feet

	def initialize(level=1, name="Player", health=100, mana=100, strength=10, dexterity=10, agility=10, 
		intellect=10, constitution=10, wisdom=10, charisma=10, inventory=Inventory.new, gold=0, skills=Skills.new)
		super(level, name, health, mana, strength, dexterity, agility, intellect, constitution, wisdom, charisma, 
			inventory, gold)
		@skills = skills
		@armor_head = nil
		@armor_neck = nil
		@armor_body = nil
		@armor_arms = nil
		@armor_hands = nil
		@armor_legs = nil
		@armor_feet = nil
		@weapon = nil
	end

	def weapon(item = nil)
		if item == nil
			return @weapon
		elsif item.is_a?(Weapon)
			@weapon = item
		end
	end

	def armor_head(item = nil)
		if item == nil
			return @armor_head
		elsif item.is_a?(Armor)
			@armor_head = item
		end
	end

	def armor_neck(item = nil)
		if item == nil
			return @armor_neck
		elsif item.is_a?(Armor)
			@armor_neck = item
		end
	end

	def armor_body(item = nil)
		if item == nil
			return @armor_body
		elsif item.is_a?(Armor)
			@armor_body = item
		end
	end

	def armor_arms(item = nil)
		if item == nil
			return @armor_arms
		elsif item.is_a?(Armor)
			@armor_arms = item
		end
	end

	def armor_hands(item = nil)
		if item == nil
			return @armor_hands
		elsif item.is_a?(Armor)
			@armor_hands = item
		end
	end

	def armor_legs(item = nil)
		if item == nil
			return @armor_legs
		elsif item.is_a?(Armor)
			@armor_legs = item
		end
	end

	def armor_feet(item = nil)
		if item == nil
			return @armor_feet
		elsif item.is_a?(Armor)
			@armor_feet = item
		end
	end

	def equip_to_empty(item, item_slot)
		puts("Equipping #{item}.") if item.is_a?(String)
		puts("Equipping #{@inventory.get_item(item).name}.") if item.is_a?(Integer)

		self.send(item_slot, @inventory.get_item(item))
		@inventory.remove_item(@inventory.inventory.index(@inventory.get_item(item)))
	end

	def equip_and_replace(item, item_slot)
		temp_item = self.send(item_slot)
		puts("Unequipping #{temp_item.name}.")
		@inventory.add_item(temp_item)
		puts("Equipping #{item}.")
		self.send(item_slot, @inventory.get_item(item))
		@inventory.remove_item(@inventory.inventory.index(@inventory.get_item(item)))
	end

	def equip(item)
		if @inventory.get_item(item) == nil
			puts("item not found")

		elsif @inventory.get_item(item).is_a?(Weapon) || @inventory.get_item(item).is_a?(Armor)
			type = @inventory.get_item(item).slot

			if self.send(type) == nil
				equip_to_empty(item, type)
			else
				equip_and_replace(item, type)
			end

		else
			puts "That item cannot be equipped."
		end
	end

	def survey
		# skill: attempt to survey current tile to reveal tile info
	end

	def harvest_metal
		# skill: attempt to harvest metal from current tile
	end

	def harvest_wood
		# skill: attempt to harvest wood from current tile
	end

	def harvest_animals
		# skill: attempt to harvest game animals from current tile
	end

	def harvest_foragables
		# skill: attempt to harvest foragables from current tile
	end

end

class Monster < NPC
	def initialize(level=1, name="Monster", health=100, mana=100, strength=10, dexterity=10, agility=10, 
			intellect=10, constitution=10, wisdom=10, charisma=10, inventory=Inventory.new, gold=0)
		super(level, name, health, mana, strength, dexterity, agility, intellect, constitution, wisdom, charisma, 
			inventory, gold)
	end
end

class Item
	attr_accessor :item_level, :name, :rarity, :slot

	def initialize(item_level, name, rarity, slot)
		@item_level = item_level
		@name = name
		@rarity = rarity
		@slot = slot
	end

	def to_s
		"Item level: #{@item_level}\n" + 
		"Item name: #{@name}\n" + 
		"Rarity: #{@rarity}\n" + 
		"Equip slot: not equippable\n"
	end
end

class Weapon < Item
	attr_accessor :weapon_damage, :weapon_speed, :skill_required

	def initialize(item_level, name, rarity, slot, weapon_damage, weapon_speed, skill_required)
		super(item_level, name, rarity, slot)
		@weapon_damage = weapon_damage
		@weapon_speed = weapon_speed
		@skill_required = skill_required
	end

	def to_s
		"Item type: Weapon\n" + 
		"Item level: #{@item_level}\n" + 
		"Item name: #{@name}\n" + 
		"Rarity: #{@rarity}\n" + 
		"Equip slot: weapon\n" + 
		"Damage: #{@weapon_damage}\n" + 
		"Speed: #{@weapon_speed}\n" + 
		"Skill required: #{@skill_required}\n"
	end
end

class Armor < Item
	attr_accessor :armor_value

	def initialize(item_level, name, rarity, slot, armor_value)
		super(item_level, name, rarity, slot)
		@armor_value = armor_value
	end

	def to_s
		"Item type: Armor\n" + 
		"Item level: #{@item_level}\n" + 
		"Item name: #{@name}\n" + 
		"Rarity: #{@rarity}\n" + 
		"Equip slot: #{@slot}\n" + 
		"Armor value: #{@armor_value}\n"
	end
end

# using a hash is causing problems when adding multiple instances of the same item into the player's inventory.
# the most recently added item will overwrite the current item if they have the same name
class Inventory
	attr_accessor :inventory

	def initialize
		@inventory = []
	end

	def get_item(item_requested)
		if item_requested.is_a?(String)
			return @inventory.bsearch {|item| item.name.casecmp(item_requested)}
		elsif item_requested.is_a?(Integer)
			return @inventory.fetch(item_requested - 1)
		else
			# command not recognized
		end

	end

	def add_item(item)
		@inventory.push(item)
	end

	def remove_item(item_requested)
		@inventory.delete_at(item_requested - 1)
	end

	def to_s
		@inventory.inspect
	end
end

class Tile
	attr_accessor :type, :danger_level, :wood, :metal, :animals, :foraging

	def initialize(type)
		@type = type
		@danger_level = rand(100)

		if type == :prairie
			@wood = 0
			@metal = rand(10)
			@animals = rand(30)
			@foraging = rand(30)

		elsif type == :swamp
			@wood = rand(20)
			@metal = rand(10)
			@animals = rand(15)
			@foraging = rand(15)

		elsif type == :desert
			@wood = 0
			@metal = rand(20)
			@animals = rand(5)
			@foraging = rand(5)

		elsif type == :mountain
			@wood = rand(10)
			@metal = rand(30)
			@animals = rand(10)
			@foraging = rand(10)

		elsif type == :forest
			@wood = rand(30)
			@metal = rand(5)
			@animals = rand(15)
			@foraging = rand(15)

		else
			@wood = rand(20)
			@metal = rand(10)
			@animals = rand(20)
			@foraging = rand(25)
		end
	end	

	def to_s
		"Environment type: #{type}\n" + 
		"Danger level: #{danger_level}\n" + 
		"Wood available: #{wood}\n" + 
		"Metal available: #{metal}\n" + 
		"Animals available: #{animals}\n" + 
		"Foraging available: #{foraging}\n"
	end
end

class GameMap
	attr_accessor :game_map, :tile_set, :player_col, :player_row

	def initialize
		@game_map = Array.new(10) { Array.new(10, 0) }	
		@tile_set = [:Prairie, :Swamp, :Desert, :Mountain, :Forest, :Jungle]
		@player_row = 0
		@player_col = 0
	end

	def fill_game_map
		(0..9).each do |i|
			(0..9).each do |j|
				@game_map[i][j] = Tile.new(@tile_set[rand(5)])
			end
		end
	end

	def get_tile_info
		return @game_map.at(player_col).at(player_row).to_s
	end

	def is_valid_move(direction)
	  (direction == "n" && @player_row > 0) ||
	  (direction == "s" && @player_row < (@game_map.size - 1)) ||
	  (direction == "e" && @player_col < (@game_map.size - 1)) ||
	  (direction == "w" && @player_col > 0)
	end	
end

class MonsterEncounter
	attr_accessor :monster, :game

	def initialize(game)
		@game = game
		@monster = Monster.new(1, 'Goblin', 100, 100, 10, 10, 10, 10, 10, 10, 10)
	end

	def attack_monster
		# players turn
		if rand(100) >= 50
			game.insert_text("You swing your weapon at the #{@monster.name} and score a hit!")
			@monster.health -= 10
			if @game.player.weapon == nil
				@game.player.skills.skill_up("Hand-to-Hand", @game.player.skills.skills["Hand-to-Hand"], @game)
			else
				@game.player.skills.skill_up(@game.player.weapon.skill_required, @game.player.skills.skills["Hand-to-Hand"], @game)
			end
			
			if @monster.health <= 0
				game.insert_text("You have defeated the #{@monster.name}!")
				game.state = 'normal'
				return
			else
				# do nothing
			end

		else
			game.insert_text("You swing your weapon at the #{@monster.name}, but miss!")
		end

		# monster's turn
		if rand(100) >= 50
			game.insert_text("The #{@monster.name} attacks you and scores a hit!")
			game.player.health -= 5
			if game.player.health <= 0
				game.insert_text("You have been defeated by the #{@monster.name}.  Game over!")
				game.state = 'normal'
				return
			else
				# do nothing
			end

		else
			game.insert_text("The #{@monster.name} attacks you, but misses!")
		end
		game.insert_text("Player health remaining: #{game.player.health}")
		game.insert_text("Monster health remaining: #{@monster.health}")
	end
end

class Skills
	attr_accessor :skills

	def initialize
		@skills = {"Piercing" => 0.0, "Slashing" => 0.0, "Mace Fighting" => 0.0, "Hand-to-Hand" => 0.0, "Mining" => 0.0,
		 "Lumberjacking" => 0.0, "Hunting" => 0.0, "Foraging" => 0.0}
	end

	# all skills have a (100.0 - current skill value)% chance of increasing each time they're used
	def skill_up(skill, value, game)
		if rand(100.0) >= value
			@skills[skill] += 0.1
			game.insert_text("Your #{skill} skill has increased to #{@skills[skill]}!")
		else
			# no increase
		end
	end
end

class Game
	attr_accessor :player, :text_two, :game_map, :weapons, :armor, :state, :root, :enter_button_var, :content, :left_frame, 
	:scroll, :text, :enter_button, :right_frame, :encounter

	def initialize
		@game_map = GameMap.new
		@game_map.fill_game_map
		@state = 'pregame'
		init_weapons
		init_armor

		# create and configure root GUI window
		@root = TkRoot.new
		@root['geometry'] = '+5+5'

		# TkVariable declarations
		@enter_button_var = TkVariable.new

		# create and configure GUI widgets
		@content = Tk::Tile::Frame.new(@root) {padding "3 3 3 3"}
		@left_frame = Tk::Tile::Frame.new(@content) {relief "sunken"; width 300; height 700}
		@scroll = Tk::Tile::Scrollbar.new(@content) {orient 'vertical'}
		@text = TkText.new(@content) {see 1.0; wrap 'word'; padx 10; pady 10; width 80; height 40; 
			background '#2E2E2E'; foreground '#ffffff'}
		@text_two = Tk::Tile::Entry.new(@content) {width 80; textvariable @enter_button_var}
		@enter_button = Tk::Tile::Button.new(@content) {text 'Enter'; command 'execute_player_command'}
		@right_frame = Tk::Tile::Frame.new(@content) {relief "sunken"; width 300; height 700}
		@map_label = Tk::Tile::Label.new(@left_frame) { text 'Game Map'; compound 'bottom' }
		@map_image = TkPhotoImage.new(:file => "map270.gif")
		@map_label['image'] = @map_image
		@x_label = Tk::Tile::Label.new(@left_frame)
		@x_image = TkPhotoImage.new(:file => "x.gif")
		@x_label['image'] = @x_image

		# more configuration
		@text_two.focus
		@text.insert('end', "To start the game, type 'start'\n")
		@text.state('disabled')

		# grid GUI widgets
		@content.grid :column => 0, :row => 0, :sticky => 'nsew'
		@left_frame.grid :column => 0, :row => 0, :sticky => 'nsew', :rowspan => 2
		@text.grid :column => 1, :row => 0, :sticky => 'nsew', :columnspan => 2
		@text_two.grid :column => 1, :row => 1, :sticky => 'ew'
		@enter_button.grid :column => 2, :row => 1, :sticky => 'ew'
		@scroll.grid :column => 3, :row => 0, :sticky => 'ns'
		@right_frame.grid :column => 4, :row => 0, :sticky => 'nsew', :rowspan => 2
		@map_label.grid :column => 0, :row => 0, :sticky => 'nsew', :padx => 13, :pady => 5
		@x_label.grid :column => 0, :row => 0, :sticky => 'nw', :padx => 22, :pady => 33

		# configure resizing behavior
		TkGrid.propagate(@left_frame, false)
		TkGrid.columnconfigure(@root, 0, :weight => 1)
		TkGrid.rowconfigure(@root, 0, :weight => 1)
		TkGrid.columnconfigure(@content, 0, :weight => 0)
		TkGrid.columnconfigure(@content, 1, :weight => 1)
		TkGrid.columnconfigure(@content, 2, :weight => 0)
		TkGrid.columnconfigure(@content, 3, :weight => 0)
		TkGrid.rowconfigure(@content, 0, :weight => 1)
		TkGrid.rowconfigure(@content, 1, :weight => 0)

		# bindings
		@text_two.bind("KeyPress-Return") {execute_player_command}
		@text_two.bind("KeyPress-KP_Enter") {execute_player_command}

		Tk.mainloop
	end

	def execute_player_command
		execute_player_command(self)
	end

	def init_weapons
		@weapons = []
		@weapons.push(Weapon.new(1, "Longsword", 'normal', 'weapon', 10, 30, "Slashing"))
		@weapons.push(Weapon.new(1, "Broadsword", 'normal', 'weapon', 12, 20, "Slashing"))
		@weapons.push(Weapon.new(1, "Dagger", 'normal', 'weapon', 6, 60, "Piercing"))
		@weapons.push(Weapon.new(1, "Mace", 'normal', 'weapon', 14, 15, "Mace Fighting"))
		@weapons.push(Weapon.new(1, "Axe", 'normal', 'weapon', 16, 12, "Slashing"))
	end

	def init_armor
		@armor = []
		@armor.push(Armor.new(1, "Leather Cap", "normal", 2, "armor_head"))
		@armor.push(Armor.new(1, "Leather Gorget", "normal", 2, "armor_neck"))
		@armor.push(Armor.new(1, "Leather Tunic", "normal", 4, "armor_body"))
		@armor.push(Armor.new(1, "Leather Sleeves", "normal", 2, "armor_arms"))
		@armor.push(Armor.new(1, "Leather Gloves", "normal", 2, "armor_hands"))
		@armor.push(Armor.new(1, "Leather Leggings", "normal", 4, "armor_legs"))
		@armor.push(Armor.new(1, "Leather Boots", "normal", 2, "armor_feet"))	
	end

	def adjust_map(next_col, next_row)
		x_loc = 22 + (next_col * 27)
		y_loc = 33 + (next_row * 27)
		@x_label.grid :column => 0, :row => 0, :sticky => 'nw', :padx => x_loc, :pady => y_loc
	end

	# 1) enables the text widget to be edited
	# 2) inserts string
	# 3) ensures bottom of text widget is showing
	# 4) disables text widget
	def insert_text(string)
		text.state('normal')
		text.insert('end', "#{string}\n")
		text.see('end')
	 	text.state('disabled')
	end

	def execute_player_command
		if state == 'pregame'
			if text_two.get == 'start'
				start
			else
				insert_text("To start the game, type 'start'")
			end

		elsif state == 'normal'
			if text_two.get == 'fight'
				fight
			elsif /equip ([a-zA-Z])+(\s|[a-zA-Z])*$/ === text_two.get
				array = text_two.get.split(' ')
				array.shift
				string = array.join(' ')
				@player.equip(string)
			elsif /equip (\d)+$/ === text_two.get
				array = text_two.get.split(' ')
				array.shift
				integer = array.join(' ').to_i
				@player.equip(integer)
			elsif text_two.get == 'move e' || 
				text_two.get == 'move w' ||
				text_two.get == 'move s' ||
				text_two.get == 'move n'

				array = text_two.get.split(' ')
				array.shift
				direction = array.join(' ')
				move(direction)
			elsif text_two.get == 'survey'
				survey
			elsif text_two.get == 'map'
				print_map
			elsif text_two.get == 'show equippables'
				show_equippables
			elsif text_two.get == 'show inventory'
				show_inventory
			elsif text_two.get == 'equip'
				insert_text("You must specify the item you want to equip. and the item must be in your inventory.")
				insert_text("You can either use the name of the item, or the slot in your inventory where item is stored.")
				insert_text("For example, you could type 'equip Longsword'.")
				insert_text("Or, if the item is in inventory slot 1, you could type 'equip 1'.")
				insert_text("To see all equippable items you currently posess, type 'show equippables'.")	
			elsif text_two.get == 'start'
				insert_text("Game already started.")
			elsif text_two.get == ''
				# do nothing
			elsif /\s/ === text_two.get
				# do nothing
			elsif text_two.get == 'test'
				test
			elsif text_two.get == 'help'
				help
			else
				insert_text("Unknown command.\n")
			end

		elsif state == 'combat'
			if text_two.get == 'attack'
				@encounter.attack_monster
			elsif text_two.get == 'status'
				# print player status		
			else
				# do stuff
			end
		else
			# do stuff
		end

	  text_two.delete(0, 'end')
	end

	def survey
		insert_text(@game_map.get_tile_info)
	end

	def fight
		@encounter = MonsterEncounter.new(self)
		insert_text("You are attacked by a Goblin!  Prepare to defend yourself!")
		@state = 'combat'
	end

	def show_equippables
		insert_text("The following items in your inventory are equippable:\n")

		@player.inventory.inventory.each_with_index do |item, i|
			if item.is_a?(Weapon) || item.is_a?(Armor)
				insert_text("Inventory slot #{i + 1}")
				insert_text(item)		
			end
		end
	end

	def show_inventory
		insert_text("Your inventory contains the following items:\n")

		@player.inventory.inventory.each_with_index do |item, i|
			insert_text("Inventory slot #{i + 1}")
			insert_text(item.to_s)
		end
	end

	def help

	end

	# test method
	def test
		i = 0
		num = 100

		until i > num do
			text.state('normal')
			text.insert('end', "Testing...\n")
			text.see('end')
		  	text.state('disabled')
	 		i += 1
	  		Tk.sleep(50)
		end
	end

	def move(direction)
		if direction == "n"
			if game_map.is_valid_move("n") == true
				game_map.player_row -= 1
				adjust_map(game_map.player_col, game_map.player_row)
			else
				puts "That is not a valid move"
			end

		elsif direction == "s"
			if game_map.is_valid_move("s") == true
				game_map.player_row += 1
				adjust_map(game_map.player_col, game_map.player_row)
			else
				puts "That is not a valid move"
			end

		elsif direction == "e"
			if game_map.is_valid_move("e") == true
				game_map.player_col += 1
				adjust_map(game_map.player_col, game_map.player_row)
			else
				puts "That is not a valid move"
			end

		elsif direction == "w"
			if game_map.is_valid_move("w") == true
				game_map.player_col -= 1
				adjust_map(game_map.player_col, game_map.player_row)
			else
				puts "That is not a valid move"
			end

		else
			# do nothing
		end
	end

	def print_map
		(0..9).each do |i|
			(0..9).each do |j|
				if i == game_map.player_row && j == game_map.player_col
					print "x"
				else
					print game_map.game_map[i][j]
				end
			end
			print "\n"
		end
	end

	def start
		if player == nil
			char_name_var = TkVariable.new

			@create_character = TkToplevel.new {title "Character Creation"}
			@create_character.geometry = '+400+120'

			char_name_label = Tk::Tile::Label.new(@create_character) {text 'Character Name'}
			char_name_label.grid :column => 0, :row => 0, :pady => '10 10'

			char_name = Tk::Tile::Entry.new(@create_character) {textvariable char_name_var}
			char_name.focus
			char_name.bind("KeyPress-Return") {create_player(char_name_var)}
			char_name.bind("KeyPress-KP_Enter") {create_player(char_name_var)}
			char_name.grid :column => 0, :row => 1, :padx => 50, :pady => '0 20'

			create_character_button = Tk::Tile::Button.new(@create_character) {text 'Start Game'}
			create_character_button.grid :column => 0, :row => 2, :pady => 15

			TkGrid.columnconfigure(@create_character, 0, :weight => 0)
			TkGrid.rowconfigure(@create_character, 0, :weight => 0)

			@state = 'normal'
		else	
			insert_text("Game already started.")
		end
	end

	def create_player(name)
		@player = Player.new(1, name, 100, 100, 10, 10, 10, 10, 10, 10, 10)
		@create_character.destroy
		insert_text("Welcome to Bloog's Quest, #{name}!")
		insert_text("To see a list of commands, type 'help'.\n")
		dagger = Weapon.new(1, 'Dagger', 'normal', 'weapon', 10, 4, 'Piercing')
		player.inventory.add_item(dagger)
	end
end

my_game = Game.new