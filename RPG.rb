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

<<<<<<< HEAD
	def equip_to_empty(item, item_slot, game)
		game.insert_text("Equipping #{item}.\n") if item.is_a?(String)
		game.insert_text("Equipping #{@inventory.get_item(item).name}.\n") if item.is_a?(Integer)
		self.send(item_slot, @inventory.get_item(item))
		@inventory.remove_item(item)
		update_paperdoll(game)
=======
	def equip_to_empty(item, item_slot)
		puts("Equipping #{item}.") if item.is_a?(String)
		puts("Equipping #{@inventory.get_item(item).name}.") if item.is_a?(Integer)

		self.send(item_slot, @inventory.get_item(item))
		@inventory.remove_item(@inventory.inventory.index(@inventory.get_item(item)))
>>>>>>> origin/master
	end

	def equip_and_replace(item, item_slot, game)
		temp_item = self.send(item_slot)
		game.insert_text("Unequipping #{temp_item.name}.\n")
		@inventory.add_item(temp_item)
		game.insert_text("Equipping #{item}.\n")
		self.send(item_slot, @inventory.get_item(item))
<<<<<<< HEAD
		@inventory.remove_item(item)
		update_paperdoll(game)
=======
		@inventory.remove_item(@inventory.inventory.index(@inventory.get_item(item)))
>>>>>>> origin/master
	end

	def grid_armor_helmet
		@leatherhelmet_label.grid :column => 0, :row => 1, :sticky => 'nw', :padx => 141, :pady => 27
	end

	def grid_armor_gorget
		@leathergorget_label.grid :column => 0, :row => 1, :sticky => 'nw', :padx => 201, :pady => 59
	end

	def grid_armor_tunic
		@leathertunic_label.grid :column => 0, :row => 1, :sticky => 'nw', :padx => 141, :pady => 110
	end
	
	def grid_armor_sleeves
		@leathersleeves_label.grid :column => 0, :row => 1, :sticky => 'nw', :padx => 74, :pady => 146
	end

	def grid_armor_gloves
		@leathergloves_label.grid :column => 0, :row => 1, :sticky => 'nw', :padx => 201, :pady => 146
	end

	def grid_armor_pants
		@leatherpants_label.grid :column => 0, :row => 1, :sticky => 'nw', :padx => 133, :pady => 220
	end

	def grid_armor_boots
		@leatherboots_label.grid :column => 0, :row => 1, :sticky => 'nw', :padx => 133, :pady => 296
	end

	def grid_weapon
		@longsword_label.grid :column => 0, :row => 1, :sticky => 'nw', :padx => 54, :pady => 212
	end

	def execute_player_command
		execute_player_command(self)
	end
	# you can make this method better
	def update_paperdoll(game)
		if @armor_head == nil

		else
			game.grid_armor_helmet
		end

		if @armor_neck == nil

		else
			game.grid_armor_gorget
		end

		if @armor_body == nil

		else
			game.grid_armor_tunic
		end

		if @armor_arms == nil

		else
			game.grid_armor_sleeves
		end

		if @armor_hands == nil

		else
			game.grid_armor_gloves
		end

		if @armor_legs == nil

		else
			game.grid_armor_pants
		end

		if @armor_feet == nil

		else
			game.grid_armor_boots
		end

		if @weapon == nil

		else
			game.grid_weapon
		end
	end

	# you can make this method better
	def equipment_to_s
		string = ''

		string.insert(-1, "Head:\n")
		if @armor_head == nil
			string.insert(-1, "Nothing equipped to head.\n\n")
		else
			string.insert(-1, "#{@armor_head.to_s}\n")
		end
		
		string.insert(-1, "Neck:\n")
		if @armor_neck == nil
			string.insert(-1, "Nothing equipped to neck.\n\n")
		else
			string.insert(-1, "#{@armor_neck.to_s}\n")
		end

		string.insert(-1, "Body:\n")
		if @armor_body == nil
			string.insert(-1, "Nothing equipped to body.\n\n")
		else
			string.insert(-1, "#{@armor_body.to_s}\n")
		end

		string.insert(-1, "Arms:\n")
		if @armor_arms == nil
			string.insert(-1, "Nothing equipped to arms.\n\n")
		else
			string.insert(-1, "#{@armor_arms.to_s}\n")
		end

		string.insert(-1, "Hands:\n")
		if @armor_hands == nil
			string.insert(-1, "Nothing equipped to hands.\n\n")
		else
			string.insert(-1, "#{@armor_hands.to_s}\n")
		end

		string.insert(-1, "Legs:\n")
		if @armor_legs == nil
			string.insert(-1, "Nothing equipped to legs.\n\n")
		else
			string.insert(-1, "#{@armor_legs.to_s}\n")
		end

		string.insert(-1, "Feet:\n")
		if @armor_feet == nil
			string.insert(-1, "Nothing equipped to feet.\n\n")
		else
			string.insert(-1, "#{@armor_feet.to_s}\n")
		end

		string.insert(-1, "Weapon:\n")
		if @weapon == nil
			string.insert(-1, "No weapon equipped.")
		else
			string.insert(-1, "#{@weapon.to_s}\n")
		end

		return string

	end

	# equipping by name is still ghetto...
	def equip(item, game)
		if @inventory.get_item(item) == nil
			game.insert_text("Item not found.\n")

		elsif @inventory.get_item(item).is_a?(Weapon) || @inventory.get_item(item).is_a?(Armor)
			type = @inventory.get_item(item).slot

			if self.send(type) == nil
				equip_to_empty(item, type, game)
			else
				equip_and_replace(item, type, game)
			end

		else
<<<<<<< HEAD
			game.insert_text("That item cannot be equipped.\n")
=======
			puts "That item cannot be equipped."
>>>>>>> origin/master
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

<<<<<<< HEAD
	def initialize(item_level, name, rarity, slot, weapon_damage, weapon_speed, skill_required, image_url)
=======
	def initialize(item_level, name, rarity, slot, weapon_damage, weapon_speed, skill_required)
>>>>>>> origin/master
		super(item_level, name, rarity, slot)
		@weapon_damage = weapon_damage
		@weapon_speed = weapon_speed
		@skill_required = skill_required
		@image_url = image_url
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

<<<<<<< HEAD
	def initialize(item_level, name, rarity, slot, armor_value, image_url)
=======
	def initialize(item_level, name, rarity, slot, armor_value)
>>>>>>> origin/master
		super(item_level, name, rarity, slot)
		@armor_value = armor_value
		@image_url = image_url
	end

	def to_s
		"Item type: Armor\n" + 
		"Item level: #{@item_level}\n" + 
		"Item name: #{@name}\n" + 
		"Rarity: #{@rarity}\n" + 
		"Equip slot: #{@slot}\n" + 
		"Armor value: #{@armor_value}\n"
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
<<<<<<< HEAD
			return @inventory.find {|item| item.name.casecmp(item_requested) == 0}
		elsif item_requested.is_a?(Integer)
			index = item_requested - 1
			return @inventory.fetch(index)
=======
			return @inventory.bsearch {|item| item.name.casecmp(item_requested)}
		elsif item_requested.is_a?(Integer)
			return @inventory.fetch(item_requested - 1)
>>>>>>> origin/master
		else
			# command not recognized
		end

	end

	def add_item(item)
		@inventory.push(item)
	end

	def remove_item(item_requested)
<<<<<<< HEAD
		if item_requested.is_a?(String)
			@inventory.delete_at(@inventory.find_index {|item| item.name.casecmp(item_requested) == 0})
		elsif item_requested.is_a?(Integer)
			index = item_requested - 1
			return @inventory.delete_at(index)
		else
			# command not recognized
		end
=======
		@inventory.delete_at(item_requested - 1)
>>>>>>> origin/master
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
		@monster = Monster.new(1, 'Goblin', 50, 50, 10, 10, 10, 10, 10, 10, 10, Inventory.new, 20)
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
				game.insert_text("You receieve #{@monster.gold} gold pieces!")
				@game.player.gold += @monster.gold
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
	:scroll, :text, :enter_button, :right_frame, :encounter, :leatherboots_label, :leathergloves_label, :leathergorget_label,
	:leatherhelmet_label, :leatherpants_label, :leathersleeves_label, :leathertunic_label, :longsword_label

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
<<<<<<< HEAD
		@x_label = Tk::Tile::Label.new(@left_frame) { background 'white'; }
		@x_image = TkPhotoImage.new(:file => "x.gif")
		@x_label['image'] = @x_image
		@human_label = Tk::Tile::Label.new(@left_frame)
		@human_image = TkPhotoImage.new(:file => "body.gif")
		@human_label['image'] = @human_image

		# item images
		@leatherboots_label = Tk::Tile::Label.new(@left_frame)
		@leatherboots_image = TkPhotoImage.new(:file => "art_assets/leatherboots.gif")
		@leatherboots_label['image'] = @leatherboots_image

		@leathergloves_label = Tk::Tile::Label.new(@left_frame)
		@leathergloves_image = TkPhotoImage.new(:file => "art_assets/leathergloves.gif")
		@leathergloves_label['image'] = @leathergloves_image

		@leathergorget_label = Tk::Tile::Label.new(@left_frame)
		@leathergorget_image = TkPhotoImage.new(:file => "art_assets/leathergorget.gif")
		@leathergorget_label['image'] = @leathergorget_image

		@leatherhelmet_label = Tk::Tile::Label.new(@left_frame)
		@leatherhelmet_image = TkPhotoImage.new(:file => "art_assets/leatherhelmet.gif")
		@leatherhelmet_label['image'] = @leatherhelmet_image

		@leatherpants_label = Tk::Tile::Label.new(@left_frame)
		@leatherpants_image = TkPhotoImage.new(:file => "art_assets/leatherpants.gif")
		@leatherpants_label['image'] = @leatherpants_image

		@leathersleeves_label = Tk::Tile::Label.new(@left_frame)
		@leathersleeves_image = TkPhotoImage.new(:file => "art_assets/leathersleeves.gif")
		@leathersleeves_label['image'] = @leathersleeves_image

		@leathertunic_label = Tk::Tile::Label.new(@left_frame)
		@leathertunic_image = TkPhotoImage.new(:file => "art_assets/leathertunic.gif")
		@leathertunic_label['image'] = @leathertunic_image

		@longsword_label = Tk::Tile::Label.new(@left_frame)
		@longsword_image = TkPhotoImage.new(:file => "art_assets/longsword.gif")
		@longsword_label['image'] = @longsword_image
=======
		@x_label = Tk::Tile::Label.new(@left_frame)
		@x_image = TkPhotoImage.new(:file => "x.gif")
		@x_label['image'] = @x_image
>>>>>>> origin/master

		# more configuration
		@text_two.focus
		@text.insert('end', "To start the game, type 'start'\n")
		@text.state('disabled')

		# grid GUI elements
		@content.grid :column => 0, :row => 0, :sticky => 'nsew'
		@left_frame.grid :column => 0, :row => 0, :sticky => 'nsew', :rowspan => 2
		@text.grid :column => 1, :row => 0, :sticky => 'nsew', :columnspan => 2
		@text_two.grid :column => 1, :row => 1, :sticky => 'ew'
		@enter_button.grid :column => 2, :row => 1, :sticky => 'ew'
		@scroll.grid :column => 3, :row => 0, :sticky => 'ns'
		@right_frame.grid :column => 4, :row => 0, :sticky => 'nsew', :rowspan => 2
<<<<<<< HEAD
		@map_label.grid :column => 0, :row => 0, :sticky => 'nw', :padx => 13, :pady => 5
		@x_label.grid :column => 0, :row => 0, :rowspan => 2, :sticky => 'nw', :padx => 22, :pady => 33
		@human_label.grid :column => 0, :row => 1, :sticky => 'nw', :padx => 32, :pady => 10
=======
		@map_label.grid :column => 0, :row => 0, :sticky => 'nsew', :padx => 13, :pady => 5
		@x_label.grid :column => 0, :row => 0, :sticky => 'nw', :padx => 22, :pady => 33
>>>>>>> origin/master

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
<<<<<<< HEAD
		TkGrid.columnconfigure(@left_frame, 0, :weight => 0)
		TkGrid.rowconfigure(@left_frame, 0, :weight => 0)
		TkGrid.rowconfigure(@left_frame, 1, :weight => 0)
=======
>>>>>>> origin/master

		# bindings
		@text_two.bind("KeyPress-Return") {execute_player_command}
		@text_two.bind("KeyPress-KP_Enter") {execute_player_command}

		Tk.mainloop
	end

<<<<<<< HEAD
	def grid_armor_helmet
		@leatherhelmet_label.grid :column => 0, :row => 1, :sticky => 'nw', :padx => 141, :pady => 27
	end

	def grid_armor_gorget
		@leathergorget_label.grid :column => 0, :row => 1, :sticky => 'nw', :padx => 201, :pady => 59
	end

	def grid_armor_tunic
		@leathertunic_label.grid :column => 0, :row => 1, :sticky => 'nw', :padx => 141, :pady => 110
	end
	
	def grid_armor_sleeves
		@leathersleeves_label.grid :column => 0, :row => 1, :sticky => 'nw', :padx => 74, :pady => 146
	end

	def grid_armor_gloves
		@leathergloves_label.grid :column => 0, :row => 1, :sticky => 'nw', :padx => 201, :pady => 146
	end

	def grid_armor_pants
		@leatherpants_label.grid :column => 0, :row => 1, :sticky => 'nw', :padx => 133, :pady => 220
	end

	def grid_armor_boots
		@leatherboots_label.grid :column => 0, :row => 1, :sticky => 'nw', :padx => 133, :pady => 296
	end

	def grid_weapon
		@longsword_label.grid :column => 0, :row => 1, :sticky => 'nw', :padx => 54, :pady => 212
	end

=======
>>>>>>> origin/master
	def execute_player_command
		execute_player_command(self)
	end

	def init_weapons
		@weapons = []
<<<<<<< HEAD
		@weapons.push(Weapon.new(1, "Longsword", 'normal', 'weapon', 10, 30, "Slashing", "art_assets/longsword.gif"))
		@weapons.push(Weapon.new(1, "Broadsword", 'normal', 'weapon', 12, 20, "Slashing", "art_assets/longsword.gif"))
		@weapons.push(Weapon.new(1, "Dagger", 'normal', 'weapon', 6, 60, "Piercing", "art_assets/longsword.gif"))
		@weapons.push(Weapon.new(1, "Mace", 'normal', 'weapon', 14, 15, "Mace Fighting", "art_assets/longsword.gif"))
		@weapons.push(Weapon.new(1, "Axe", 'normal', 'weapon', 16, 12, "Slashing", "art_assets/longsword.gif"))
=======
		@weapons.push(Weapon.new(1, "Longsword", 'normal', 'weapon', 10, 30, "Slashing"))
		@weapons.push(Weapon.new(1, "Broadsword", 'normal', 'weapon', 12, 20, "Slashing"))
		@weapons.push(Weapon.new(1, "Dagger", 'normal', 'weapon', 6, 60, "Piercing"))
		@weapons.push(Weapon.new(1, "Mace", 'normal', 'weapon', 14, 15, "Mace Fighting"))
		@weapons.push(Weapon.new(1, "Axe", 'normal', 'weapon', 16, 12, "Slashing"))
>>>>>>> origin/master
	end

	def init_armor
		@armor = []
		@armor.push(Armor.new(1, "Leather Cap", "normal", "armor_head", 2, "art_assets/leatherhelmet.gif"))
		@armor.push(Armor.new(1, "Leather Gorget", "normal", "armor_neck", 2, "art_assets/leathergorget.gif"))
		@armor.push(Armor.new(1, "Leather Tunic", "normal", "armor_body", 4, "art_assets/leathertunic.gif"))
		@armor.push(Armor.new(1, "Leather Sleeves", "normal", "armor_arms", 2, "art_assets/leathersleeves.gif"))
		@armor.push(Armor.new(1, "Leather Gloves", "normal", "armor_hands", 2, "art_assets/leathergloves.gif"))
		@armor.push(Armor.new(1, "Leather Leggings", "normal", "armor_legs", 4, "art_assets/leatherpants.gif"))
		@armor.push(Armor.new(1, "Leather Boots", "normal", "armor_feet", 2, "art_assets/leatherboots.gif"))	
	end

	def adjust_map(next_col, next_row)
		x_loc = 22 + (next_col * 27)
		y_loc = 33 + (next_row * 27)
		@x_label.grid :column => 0, :row => 0, :sticky => 'nw', :padx => x_loc, :pady => y_loc
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
<<<<<<< HEAD
				@player.equip(string, self)
=======
				@player.equip(string)
>>>>>>> origin/master
			elsif /equip (\d)+$/ === text_two.get
				array = text_two.get.split(' ')
				array.shift
				integer = array.join(' ').to_i
<<<<<<< HEAD
				@player.equip(integer, self)
=======
				@player.equip(integer)
>>>>>>> origin/master
			elsif text_two.get == 'move e' || 
				text_two.get == 'move w' ||
				text_two.get == 'move s' ||
				text_two.get == 'move n'

				array = text_two.get.split(' ')
				array.shift
				direction = array.join(' ')
				move(direction)
<<<<<<< HEAD
			elsif text_two.get == 'equipment'
				insert_text(@player.equipment_to_s)
			elsif text_two.get == 'survey'
				insert_text(@game_map.get_tile_info)
			elsif text_two.get == 'gold'
				insert_text("You have #{@player.gold} gold pieces.")
=======
			elsif text_two.get == 'survey'
				survey
>>>>>>> origin/master
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
<<<<<<< HEAD
		player.inventory.add_item(@armor[0])
		player.inventory.add_item(@armor[1])
		player.inventory.add_item(@armor[2])
		player.inventory.add_item(@armor[3])
		player.inventory.add_item(@armor[4])
		player.inventory.add_item(@armor[5])
		player.inventory.add_item(@armor[6])
		player.inventory.add_item(@weapons[0])
=======
		dagger = Weapon.new(1, 'Dagger', 'normal', 'weapon', 10, 4, 'Piercing')
		player.inventory.add_item(dagger)
>>>>>>> origin/master
	end
end

my_game = Game.new