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

	def equip_to_empty(item, item_slot, game)
		game.insert_text("Equipping #{item}.\n") if item.is_a?(String)
		game.insert_text("Equipping #{@inventory.get_item(item).name}.\n") if item.is_a?(Integer)
		self.send(item_slot, @inventory.get_item(item))
		@inventory.remove_item(item)
		game.send("grid_#{item_slot}")
	end

	def equip_and_replace(item, item_slot, game)
		temp_item = self.send(item_slot)
		game.insert_text("Unequipping #{temp_item.name}.\n")
		@inventory.add_item(temp_item)
		game.insert_text("Equipping #{item}.\n")
		self.send(item_slot, @inventory.get_item(item))
		@inventory.remove_item(item)
		game.send("grid_#{item_slot}")
	end

	# this is currently not used, but could be useful if a player loaded a fresh character, and the game
	# had to draw all equipment labels at once
	def update_paperdoll(game)
		array = %w[armor_head armor_neck armor_body armor_arms armor_hands armor_legs armor_feet weapon]
		array.each do |slot|
			if instance_variable_get("@#{slot}") != nil
				game.send("grid_#{slot}")
			else
				# do nothing
			end
		end
	end

	def equipment_to_s
		string = ''
		array = %w[armor_head armor_neck armor_body armor_arms armor_hands armor_legs armor_feet]

		array.each do |slot|
			string.insert(-1, "#{slot.gsub('armor_', '').capitalize}:\n")
			if instance_variable_get("@#{slot}") == nil
				string.insert(-1, "Nothing equipped to #{slot.gsub('armor_', '')}.\n\n")
			else
				string.insert(-1, "#{instance_variable_get("@#{slot}").to_s}\n")
			end
		end

		if @weapon == nil
			string.insert(-1, "No weapon equipped.")
		else
			string.insert(-1, @weapon.to_s)
		end
		return string
	end

	def unequip(item, game)
		item_slot = ''
		array = %w[armor_head armor_neck armor_body armor_arms armor_hands armor_legs armor_feet weapon]
		array.each do |slot|
			if instance_variable_get("@#{slot}") == nil
				# do nothing
			else
				if instance_variable_get("@#{slot}").name.casecmp(item) == 0
					item_slot = slot
				else
					# do nothing
				end
			end
		end
		temp_item = instance_variable_get("@#{item_slot}")
		instance_variable_set("@#{item_slot}", nil)
		game.insert_text("Unequipping #{temp_item.name}.\n")
		@inventory.add_item(temp_item)
		game.destroy_label(item_slot)
	end

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
			game.insert_text("That item cannot be equipped.\n")
		end
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
	attr_accessor :weapon_damage, :weapon_speed, :skill_required, :image_url

	def initialize(item_level, name, rarity, slot, weapon_damage, weapon_speed, skill_required, image_url)
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
end

class Armor < Item
	attr_accessor :armor_value, :image_url

	def initialize(item_level, name, rarity, slot, armor_value, image_url)
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
			return @inventory.find {|item| item.name.casecmp(item_requested) == 0}
		elsif item_requested.is_a?(Integer)
			index = item_requested - 1
			return @inventory.fetch(index)
		else
			# command not recognized
		end

	end

	def add_item(item)
		@inventory.push(item)
	end

	def remove_item(item_requested)
		if item_requested.is_a?(String)
			@inventory.delete_at(@inventory.find_index {|item| item.name.casecmp(item_requested) == 0})
		elsif item_requested.is_a?(Integer)
			index = item_requested - 1
			return @inventory.delete_at(index)
		else
			# command not recognized
		end
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

		def calculate_resources(wood, metal, animals, foraging)
			@wood = rand(wood)
			@metal = rand(metal)
			@animals = rand(animals)
			@foraging = rand(foraging)
		end

		if type == :prairie
			calculate_resources(0, 10, 30, 30)

		elsif type == :swamp
			calculate_resources(20, 10, 15, 15)

		elsif type == :desert
			calculate_resources(0, 20, 5, 5)

		elsif type == :mountain
			calculate_resources(10, 30, 10, 10)

		elsif type == :forest
			calculate_resources(30, 5, 15, 15)

		else
			calculate_resources(20, 10, 20, 25)

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
	:scroll, :text, :enter_button, :right_frame, :encounter, :feet_label, :hands_label, :neck_label,
	:head_label, :legs_label, :arms_label, :body_label, :weapon_label

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
		@text = TkText.new(@content) {see 1.0; wrap 'word'; padx 10; pady 10; width 80; height 40; 
			background '#2E2E2E'; foreground '#ffffff'}
		@scroll = Tk::Tile::Scrollbar.new(@content) {orient 'vertical'}
		@text_two = Tk::Tile::Entry.new(@content) {width 80; textvariable @enter_button_var}
		@enter_button = Tk::Tile::Button.new(@content) {text 'Enter'; command 'execute_player_command'}
		@right_frame = Tk::Tile::Frame.new(@content) {relief "sunken"; width 300; height 700}
		@map_label = Tk::Tile::Label.new(@left_frame) { text 'Game Map'; compound 'bottom' }
		@map_image = TkPhotoImage.new(:file => "map270.gif")
		@map_label['image'] = @map_image
		@x_label = Tk::Tile::Label.new(@left_frame) { background 'white'; }
		@x_image = TkPhotoImage.new(:file => "x.gif")
		@x_label['image'] = @x_image
		@human_label = Tk::Tile::Label.new(@left_frame)
		@human_image = TkPhotoImage.new(:file => "body.gif")
		@human_label['image'] = @human_image
		@text['yscrollcommand'] = proc{|*args| @scroll.set(*args);}
		@scroll['command'] = proc{|*args| @text.yview(*args)}

		# right frame widgets
		@name_label = Tk::Tile::Label.new(@right_frame) {text "Character Name: "}
		@strength_label = Tk::Tile::Label.new(@right_frame) {text "Strength: "}
		@strength_value_label = Tk::Tile::Label.new(@right_frame) {text "0"}
		@dexterity_label = Tk::Tile::Label.new(@right_frame) {text "Dexterity: "}
		@dexterity_value_label = Tk::Tile::Label.new(@right_frame) {text "0"}
		@agility_label = Tk::Tile::Label.new(@right_frame) {text "Agility: "}
		@agility_value_label = Tk::Tile::Label.new(@right_frame) {text "0"}
		@intellect_label = Tk::Tile::Label.new(@right_frame) {text "Intellect: "}
		@intellect_value_label = Tk::Tile::Label.new(@right_frame) {text "0"}
		@constitution_label = Tk::Tile::Label.new(@right_frame) {text "Constitution: "}
		@constitution_value_label = Tk::Tile::Label.new(@right_frame) {text "0"}
		@wisdom_label = Tk::Tile::Label.new(@right_frame) {text "Wisdom: "}
		@wisdom_value_label = Tk::Tile::Label.new(@right_frame) {text "0"}
		@charisma_label = Tk::Tile::Label.new(@right_frame) {text "Charisma: "}
		@charisma_value_label = Tk::Tile::Label.new(@right_frame) {text "0"}
		@damage_label = Tk::Tile::Label.new(@right_frame) {text "Damage: "}
		@damage_value_label = Tk::Tile::Label.new(@right_frame) {text "0"}
		@armor_label = Tk::Tile::Label.new(@right_frame) {text "Armor: "}
		@armor_value_label = Tk::Tile::Label.new(@right_frame) {text "0"}
		@gold_label = Tk::Tile::Label.new(@right_frame) {text "Gold: "}
		@gold_value_label = Tk::Tile::Label.new(@right_frame) {text "0"}

		# create item container labels for paperdoll
		array = %w[feet hands neck head legs arms body weapon]
		array.each {|string| instance_variable_set("@#{string}_label", Tk::Tile::Label.new(@left_frame))}
		array.each {|string| instance_variable_set("@#{string}_image", TkPhotoImage.new)}

		# more configuration
		@text_two.focus
		@text.insert('end', "To start the game, type 'start'\n")
		@text.state('disabled')

		# bindings
		@text_two.bind("KeyPress-Return") {execute_player_command}
		@text_two.bind("KeyPress-KP_Enter") {execute_player_command}

		# more bindings - gets item info on left click
		@head_label.bind("1") {get_item_info(@player.armor_head)}
		@neck_label.bind("1") {get_item_info(@player.armor_neck)}
		@body_label.bind("1") {get_item_info(@player.armor_body)}
		@arms_label.bind("1") {get_item_info(@player.armor_arms)}
		@hands_label.bind("1") {get_item_info(@player.armor_hands)}
		@legs_label.bind("1") {get_item_info(@player.armor_legs)}
		@feet_label.bind("1") {get_item_info(@player.armor_feet)}
		@weapon_label.bind("1") {get_item_info(@player.weapon)}

		# more bindings - unequip item on right click
		@head_label.bind("3") {@player.unequip(@player.armor_head.name, self)}
		@neck_label.bind("3") {@player.unequip(@player.armor_neck.name, self)}
		@body_label.bind("3") {@player.unequip(@player.armor_body.name, self)}
		@arms_label.bind("3") {@player.unequip(@player.armor_arms.name, self)}
		@hands_label.bind("3") {@player.unequip(@player.armor_hands.name, self)}
		@legs_label.bind("3") {@player.unequip(@player.armor_legs.name, self)}
		@feet_label.bind("3") {@player.unequip(@player.armor_feet.name, self)}
		@weapon_label.bind("3") {@player.unequip(@player.weapon.name, self)}

		# grid GUI elements
		@content.grid :column => 0, :row => 0, :sticky => 'nsew'
		@left_frame.grid :column => 0, :row => 0, :sticky => 'nsew', :rowspan => 2
		@text.grid :column => 1, :row => 0, :sticky => 'nsew', :columnspan => 2
		@text_two.grid :column => 1, :row => 1, :sticky => 'ew'
		@enter_button.grid :column => 2, :row => 1, :sticky => 'ew'
		@scroll.grid :column => 3, :row => 0, :sticky => 'ns'
		@right_frame.grid :column => 4, :row => 0, :sticky => 'nsew', :rowspan => 2
		@map_label.grid :column => 0, :row => 0, :sticky => 'nw', :padx => 13, :pady => 5
		@x_label.grid :column => 0, :row => 0, :rowspan => 2, :sticky => 'nw', :padx => 22, :pady => 33
		@human_label.grid :column => 0, :row => 1, :sticky => 'nw', :padx => 32, :pady => 10

		# grid right frame widgets
		@name_label.grid :column => 0, :row => 0, :columnspan => 4, :sticky => 'nw', :padx => 20, :pady => 10
		@strength_label.grid :column => 0, :row => 1, :sticky => 'e', :padx => 27
		@strength_value_label.grid :column => 1, :row => 1, :sticky => 'w'
		@dexterity_label.grid :column => 2, :row => 1, :sticky => 'e', :padx => 27
		@dexterity_value_label.grid :column => 3, :row => 1, :sticky => 'w'
		@agility_label.grid :column => 0, :row => 2, :sticky => 'e', :padx => 27
		@agility_value_label.grid :column => 1, :row => 2, :sticky => 'w'
		@intellect_label.grid :column => 2, :row => 2, :sticky => 'e', :padx => 27
		@intellect_value_label.grid :column => 3, :row => 2, :sticky => 'w'
		@constitution_label.grid :column => 0, :row => 3, :sticky => 'e', :padx => 27
		@constitution_value_label.grid :column => 1, :row => 3, :sticky => 'w'
		@wisdom_label.grid :column => 2, :row => 3, :sticky => 'e', :padx => 27
		@wisdom_value_label.grid :column => 3, :row => 3, :sticky => 'w'
		@charisma_label.grid :column => 0, :row => 4, :sticky => 'e', :padx => 27
		@charisma_value_label.grid :column => 1, :row => 4, :sticky => 'w'
		@damage_label.grid :column => 0, :row => 5, :sticky => 'e', :padx => 27, :pady => 10
		@damage_value_label.grid :column => 1, :row => 5, :sticky => 'w', :pady => 10
		@armor_label.grid :column => 2, :row => 5, :sticky => 'e', :padx => 27
		@armor_value_label.grid :column => 3, :row => 5, :sticky => 'w'
		@gold_label.grid :column => 0, :row => 6, :sticky => 'e', :padx => 27
		@gold_value_label.grid :column => 1, :row => 6, :sticky => 'w'

		# configure resizing behavior
		TkGrid.propagate(@left_frame, false)
		TkGrid.propagate(@right_frame, false)
		TkGrid.columnconfigure(@root, 0, :weight => 1)
		TkGrid.rowconfigure(@root, 0, :weight => 1)
		TkGrid.columnconfigure(@content, 0, :weight => 0)
		TkGrid.columnconfigure(@content, 1, :weight => 1)
		TkGrid.columnconfigure(@content, 2, :weight => 0)
		TkGrid.columnconfigure(@content, 3, :weight => 0)
		TkGrid.rowconfigure(@content, 0, :weight => 1)
		TkGrid.rowconfigure(@content, 1, :weight => 0)
		TkGrid.columnconfigure(@left_frame, 0, :weight => 0)
		TkGrid.rowconfigure(@left_frame, 0, :weight => 0)
		TkGrid.rowconfigure(@left_frame, 1, :weight => 0)

		# start main GUI loop
		Tk.mainloop
	end

	# hides the specified item label from the paperdoll when item is unequipped
	def destroy_label(slot)
		TkGrid.remove(instance_variable_get("@#{slot.gsub('armor_', '')}_label"))
	end

	# shows the item art when an item is equipped.  item art url is specified in the item object.
	def grid_armor_head
		@head_image['file'] = @player.armor_head.image_url
		@head_label['image'] = @head_image
		@head_label.grid :column => 0, :row => 1, :sticky => 'nw', :padx => 141, :pady => 27
	end

	# shows the item art when an item is equipped.  item art url is specified in the item object.
	def grid_armor_neck
		@neck_image['file'] = @player.armor_neck.image_url
		@neck_label['image'] = @neck_image
		@neck_label.grid :column => 0, :row => 1, :sticky => 'nw', :padx => 201, :pady => 59
	end

	# shows the item art when an item is equipped.  item art url is specified in the item object.
	def grid_armor_body
		@body_image['file'] = @player.armor_body.image_url
		@body_label['image'] = @body_image
		@body_label.grid :column => 0, :row => 1, :sticky => 'nw', :padx => 141, :pady => 110
	end
	
	# shows the item art when an item is equipped.  item art url is specified in the item object.
	def grid_armor_arms
		@arms_image['file'] = @player.armor_arms.image_url
		@arms_label['image'] = @arms_image
		@arms_label.grid :column => 0, :row => 1, :sticky => 'nw', :padx => 74, :pady => 146
	end

	# shows the item art when an item is equipped.  item art url is specified in the item object.
	def grid_armor_hands
		@hands_image['file'] = @player.armor_hands.image_url
		@hands_label['image'] = @hands_image
		@hands_label.grid :column => 0, :row => 1, :sticky => 'nw', :padx => 201, :pady => 146
	end

	# shows the item art when an item is equipped.  item art url is specified in the item object.
	def grid_armor_legs
		@legs_image['file'] = @player.armor_legs.image_url
		@legs_label['image'] = @legs_image
		@legs_label.grid :column => 0, :row => 1, :sticky => 'nw', :padx => 133, :pady => 220
	end

	# shows the item art when an item is equipped.  item art url is specified in the item object.
	def grid_armor_feet
		@feet_image['file'] = @player.armor_feet.image_url
		@feet_label['image'] = @feet_image
		@feet_label.grid :column => 0, :row => 1, :sticky => 'nw', :padx => 133, :pady => 296
	end

	# shows the item art when an item is equipped.  item art url is specified in the item object.
	def grid_weapon
		@weapon_image['file'] = @player.weapon.image_url
		@weapon_label['image'] = @weapon_image
		@weapon_label.grid :column => 0, :row => 1, :sticky => 'nw', :padx => 54, :pady => 212
	end

	# reads weapons.txt to generate all game weapons
	def init_weapons
		@weapons = []
		weapons_array = IO.readlines("weapons.txt")
		weapons_array.each do |item|
			newitem = item.split(', ')
			@weapons.push(Weapon.new(newitem[0], newitem[1], newitem[2], newitem[3], newitem[4], newitem[5], 
				newitem[6], newitem[7].chomp))
		end
	end

	# reads armor.txt to generate all game armor
	def init_armor
		@armor = []
		armor_array = IO.readlines("armor.txt")
		armor_array.each do |item|
			newitem = item.split(', ')
			@armor.push(Armor.new(newitem[0], newitem[1], newitem[2], newitem[3], newitem[4], newitem[5].chomp))
		end
	end

	# repaints the "x" on the map when the player moves
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

	# this method checks the command the player entered and decides which command to execute
	def execute_player_command
		if state == 'pregame'
			if text_two.get.casecmp('start') == 0
				start
			else
				insert_text("To start the game, type 'start'")
			end

		elsif state == 'normal'
			if text_two.get.casecmp('fight') == 0
				fight
			elsif /\Aequip ([a-zA-Z])+(\s|[a-zA-Z])*$/ === text_two.get
				array = text_two.get.split(' ')
				array.shift
				string = array.join(' ')
				@player.equip(string, self)
			elsif /\Aequip (\d)+$/ === text_two.get
				array = text_two.get.split(' ')
				array.shift
				integer = array.join(' ').to_i
				@player.equip(integer, self)
			elsif (text_two.get.casecmp('move e') == 0) || 
				(text_two.get.casecmp('move w') == 0)||
				(text_two.get.casecmp('move s') == 0) ||
				(text_two.get.casecmp('move n') == 0)
				array = text_two.get.split(' ')
				array.shift
				direction = array.join(' ')
				move(direction)
			elsif text_two.get.casecmp('equipment') == 0
				insert_text(@player.equipment_to_s)
			elsif text_two.get.casecmp('survey') == 0
				insert_text(@game_map.get_tile_info)
			elsif text_two.get.casecmp('gold') == 0
				insert_text("You have #{@player.gold} gold pieces.")
			elsif text_two.get.casecmp('show equippables') == 0
				show_equippables
			elsif /\Aunequip ([a-zA-Z])+(\s|[a-zA-Z])*$/ === text_two.get
				array = text_two.get.split(' ')
				array.shift
				string = array.join(' ')
				@player.unequip(string, self)
			elsif text_two.get.casecmp('show inventory') == 0
				show_inventory
			elsif text_two.get.casecmp('equip') == 0
				insert_text("You must specify the item you want to equip. and the item must be in your inventory.")
				insert_text("You can either use the name of the item, or the slot in your inventory where item is stored.")
				insert_text("For example, you could type 'equip Longsword'.")
				insert_text("Or, if the item is in inventory slot 1, you could type 'equip 1'.")
				insert_text("To see all equippable items you currently posess, type 'show equippables'.\n")	
			elsif text_two.get.casecmp('start') == 0
				insert_text("Game already started.")
			elsif (text_two.get == '') || (/\s/ === text_two.get)
				# do nothing
			elsif text_two.get.casecmp('test') == 0
				test
			elsif text_two.get.casecmp('help') == 0
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

	def fight
		@encounter = MonsterEncounter.new(self)
		insert_text("You are attacked by a Goblin!  Prepare to defend yourself!")
		@state = 'combat'
	end

	# retrieves all equippable items in the player's inventory
	def show_equippables
		insert_text("The following items in your inventory are equippable:\n")
		@player.inventory.inventory.each_with_index do |item, i|
			if item.is_a?(Weapon) || item.is_a?(Armor)
				insert_text("Inventory slot #{i + 1}")
				insert_text(item)		
			end
		end
	end

	# retrieves all items in the player's inventory
	def show_inventory
		insert_text("Your inventory contains the following items:\n")
		@player.inventory.inventory.each_with_index do |item, i|
			insert_text("Inventory slot #{i + 1}")
			insert_text(item.to_s)
		end
	end

	# print all available player commands.  need to add this.
	def help

	end

	# test method, Tk.sleep is working
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

	# move the player around the game map
	def move(direction)
		if direction.casecmp('n') == 0 && game_map.is_valid_move("n") == true
			game_map.player_row -= 1
			adjust_map(game_map.player_col, game_map.player_row)

		elsif direction.casecmp('s') == 0 && game_map.is_valid_move("s") == true
			game_map.player_row += 1
			adjust_map(game_map.player_col, game_map.player_row)

		elsif direction.casecmp('e') == 0 && game_map.is_valid_move("e") == true
			game_map.player_col += 1
			adjust_map(game_map.player_col, game_map.player_row)

		elsif direction.casecmp('w') == 0 && game_map.is_valid_move("w") == true
			game_map.player_col -= 1
			adjust_map(game_map.player_col, game_map.player_row)

		else
			insert_text("That is not a valid move.\n")
		end
	end

	def get_item_info(item)
		item_info = TkToplevel.new {title "Item Info"}
		item_info.geometry = '+400+360'

		item_label = Tk::Tile::Label.new(item_info)
		item_image = TkPhotoImage.new(:file => item.image_url)
		item_label['image'] = item_image
		item_label.grid :column => 0, :row => 0, :sticky => 'nw', :padx => 10, :pady => 5

		item_name = item.name
		item_name_label = Tk::Tile::Label.new(item_info) {text item_name}
		item_name_label.grid :column => 1, :row => 0, :sticky => 'nw', :pady => 27

		item_stats = item.to_s
		item_stats_label = Tk::Tile::Label.new(item_info) {text item_stats}
		item_stats_label.grid :column => 0, :row => 1, :columnspan => 2, :sticky => 'nw', :padx => 10

		ok_button = Tk::Tile::Button.new(item_info) {text "Continue"; command {item_info.destroy}}
		ok_button.grid :column => 0, :row => 2, :columnspan => 2, :sticky => 'nw', :padx => 30, :pady => '0 15'
		ok_button.focus
		ok_button.bind("KeyPress-Return") {item_info.destroy}
		ok_button.bind("KeyPress-KP_Enter") {item_info.destroy}
		ok_button.bind("KeyPress-Escape") {item_info.destroy}
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

			# i have no idea why i can't use the command option to bind this button to the create_player method?
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
		@name_label.text = "Character Name:  #{@player.name.to_s}"
		@strength_value_label.text = @player.strength
		@dexterity_value_label.text = @player.dexterity
		@agility_value_label.text = @player.agility
		@intellect_value_label.text = @player.intellect
		@constitution_value_label.text = @player.constitution
		@wisdom_value_label.text = @player.wisdom
		@charisma_value_label.text = @player.charisma
		@gold_value_label.text = @player.gold
		@create_character.destroy
		insert_text("Welcome to Bloog's Quest, #{name}!")
		insert_text("To see a list of commands, type 'help'.\n")
		player.inventory.add_item(@armor[0])
		player.inventory.add_item(@armor[1])
		player.inventory.add_item(@armor[2])
		player.inventory.add_item(@armor[3])
		player.inventory.add_item(@armor[4])
		player.inventory.add_item(@armor[5])
		player.inventory.add_item(@armor[6])
		player.inventory.add_item(@weapons[0])
	end
end

my_game = Game.new