#####################################################################
#
# CSCB58 Assembly Final Project
# University of Toronto, Scarborough
#
# 
#
# Bitmap Display Configuration:
# - Unit width in pixels: 4 (update this as needed)
# - Unit height in pixels: 4 (update this as needed)
# - Display width in pixels: 512 (update this as needed)
# - Display height in pixels: 512 (update this as needed)
# - Base Address for Display: 0x10008000 ($gp)
#
# Which milestones have been reached in this submission?
# (See the assignment handout for descriptions of the milestones)
# - Milestone 3 (reached all 3 milestones)
#
# Which approved features have been implemented for milestone 3?
# (See the assignment handout for the list of additional features)
# 1. Health/score (2)
# 2. Fail condition (1)
# 3. Win condition (1)
# 4. Moving platforms (2)
# 5. Different levels (2)
# 6. Jet Pack (activate a Bubble instead of a jet pack)(2)
# 7. Moving objects (worms act as both moving platforms and moving enemies, depending on where the player collides with them) (2)
#
# Link to video demonstration for final submission:
# - 
#
# Are you OK with us sharing the video with people outside course staff?
# - no
#
# Any additional information that the TA needs to know:
# - Due to the large size of the game, sometimes the registers dont clear properly results in an invalid address error or failure to generate worms. Re-assembling, resetting the game or pressing 'p' 1 or more times should fix this
# - controls:	 a - move in the left direction
#			d - move in the right direction
#			w - jump
# 			s - stop horizontal movement
#			b - activate bubble (jet pack)
#			p - reset game
#####################################################################

.eqv BASE_ADDRESS 0x10008000

# game data
.eqv GAME_ROUND_LOSE		0
.eqv GAME_ROUND_WIN		1
.eqv GAME_DATA_ROUND_NUM	0
.eqv GAME_DATA_WIN_LOSE	1
.eqv GAME_NUM_ROUNDS 	3

.eqv LEFT	-1
.eqv RIGHT 1

.eqv PLATFORM_SIZE 8
.eqv BACKGROUND_COLOUR 0x005fa2 #0x62f7ff

.eqv WORM_SIZE 5
.eqv WORM_SPEED 3

.eqv SLEEP_MS 20

.eqv JUMP_DIST_MAX 2
.eqv JUMP_DIST_LOW -25

.eqv MOVE_DIST 4

.eqv VERTICAL_DIST 512
.eqv VERTICAL_DIST_SHIFT 9
.eqv HORIZONTAL_DIST 512
.eqv HORIZONTAL_DIST_SHIFT 9

.eqv GROUND_HEIGHT 51200 #

.eqv GROUND_COLOUR 0x564d4d # gray

.eqv GROUND_MIN_POSITION 43520 # the minimum position the player needs to be at to be considered on the ground
.eqv PLAYER_START_POSITION 43520
.eqv PLAYER_START_HEALTH	10
.eqv PLAYER_COLOUR_RED 0xff0000
.eqv PLAYER_COLOUR_WHITE 0xffffff
.eqv PLAYER_COLOUR_BLACK 0x000000
.eqv PLAYER_NUM_RED 41
.eqv PLAYER_NUM_WHITE 51
.eqv PLAYER_NUM_BLACK 1

.eqv PLAYER_HEIGHT 15
.eqv PLAYER_WIDTH 12

# .data structure fields
# player struct
.eqv PLAYER_POSITION 0
.eqv PLAYER_ORIENTATION 4
.eqv PLAYER_HEALTH 5
.eqv PLAYER_NUM_BUBBLES	6

# player_movement struct
.eqv PLAYER_MOVEMENT_DIRECTION 0
.eqv PLAYER_MOVEMENT_JUMPING 4
.eqv PLAYER_MOVEMENT_JUMP_DIST 8
.eqv PLAYER_MOVEMENT_LANDED 12
.eqv PLAYER_MOVEMENT_IS_BUBBLE 16
.eqv PLAYER_MOVEMENT_BUBBLE_COUNT 20
.eqv PLAYER_MOVEMENT_BUBBLE_DIRECTION 24

# player collision
.eqv PLAYER_LANDING_RANGE_MIN 13
.eqv PLAYER_LANDING_RANGE_MAX 14

.eqv PLAYER_DAMAGE_RANGE_MIN 0
.eqv PLAYER_DAMAGE_RANGE_MAX 10

# platforms
.eqv PLATFORM_COLOUR 0x2eba26
.eqv PLATFORMS_POSITION 0
.eqv PLATFORMS_WIDTH 4
.eqv PLATFORMS_NUM 120
.eqv PLATFORMS_TOTAL_NUM 10

# worms
.eqv WORM_COLOUR 0xbda8a0
.eqv WORMS_POSITION 0
.eqv WORMS_MOVEMENT_STEP 4
.eqv WORMS_DIRECTION 6
.eqv WORMS_NUM 120
.eqv WORMS_TOTAL_NUM 15
.eqv WORMS_WAVE_INTERVAL_STEPS 10
.eqv  WORMS_WAVE_CYCLE_LENGTH 2

# snails
.eqv SNAIL_COLOUR_BODY	0xdcb570
.eqv SNAIL_COLOUR_SHELL	0xff8100
.eqv SNAIL_NUM_BODY	15
.eqv SNAIL_NUM_SHELL	13
.eqv SNAILS_POSITION	0
.eqv SNAILS_EATEN		4
.eqv SNAILS_DIRECTION		5
.eqv SNAILS_RANDOM_NUM	4 # the number of randomly position snails (will always have a snail at the topmost platform
.eqv SNAILS_NUM	80
.eqv SNAILS_PLATFORM_POSITION	-2564 # the snail's position relative to the platform it is on =  (512 * -5) - 4
.eqv SNAIL_HEIGHT		5

# hearts
.eqv HEARTS_NUM_RED	11
.eqv HEARTS_SPACING_HORIZONTAL	7
.eqv HEARTS_SPACING_VERTICAL	6
.eqv HEARTS_START_POSITION	53760  # ground position + (5 * 512)
.eqv HEARTS_COLOUR_RED 0xff0000
.eqv HEARTS_NUM_PER_ROW	15

# bubble
.eqv BUBBLE_NUM	36
.eqv BUBBLE_START_NUM	3
.eqv BUBBLE_TIMER_COUNT	200 # amount of frames before bubble disappears
.eqv BUBBLE_COLOUR	0xcadcff # whitish blue
.eqv BUBBLE_MINI_NUM	8
.eqv BUBBLE_MINI_START_POSITION 520
.eqv BUBBLE_MINI_SPACING_HORIZONTAL	6

# win and lose screens
.eqv END_SCREEN_FACE_POSITION 20736 
.eqv END_SCREEN_WORD_POSITION 25328 
.eqv WIN_FACE_NUM 11
#.eqv WIN_WORD_NUM 24
.eqv WIN_WORD_NUM 60
.eqv LOSE_FACE_NUM 11
.eqv LOSE_WORD_NUM 32

# round numbers
.eqv NUMBER_ONE_NUM 9
.eqv NUMBER_TWO_NUM 12
.eqv NUMBER_THREE_NUM 12
.eqv NUMBER_BRACKET_NUM	6
.eqv ROUND_NUMBER_START_POSITION	55184

# border box
.eqv POSITION_VERTICAL 0
.eqv POSITION_HORIZONTAL 4


# key presses
.eqv KEY_LEFT 0x61
.eqv KEY_RIGHT 0x64
.eqv KEY_JUMP 0x77
.eqv KEY_STOP 0x73
.eqv KEY_RESTART 0x70 
.eqv KEY_BUBBLE 0x62 # b

.data
padding:	.space	36000   #Empty space to prevent game data from being overwritten due to large bitmap size

# printing positions
newline:	.asciiz	"\n"

# game data: round_num: byte, game_over: byte (true/false)
game_data:	.space	2

# platforms: each platform: pos (offset) - int,  width - int, num platforms - word, 
# max 15 platforms
platforms:		.word	0:31 # num platforms

# max 15 worms
worms:		.word	0:31 # num platforms (offset-int, width - half, dir - byte)
worms_wave:	.byte		0
worms_wave_steps:		.byte 	0

# player: pos (offset) - int, orientation - byte, health - byte, numBubbles - byte
player:		.word	0:2

# player 15 pixels tall, 11 pixels wide. Top to bottom 2 words per line - 15 x 12 = 
player_box_red:	.word	0, 5, 0, 6, 0, 7, 1, 4, 1, 5, 1, 6, 2, 4, 2, 5, 2, 6, 3, 5, 3, 6, 3, 7, 3, 8, 4, 2, 4, 3, 4, 6, 4, 7, 5, 2, 5, 4, 5, 5, 6, 1, 6, 2, 6, 4, 6, 5, 6, 6, 7, 1, 7, 2, 7, 3, 7, 4, 7, 8, 8, 2, 8, 3, 8, 5,  10, 4, 11, 3, 11, 4, 11, 5, 12, 4, 12, 5, 12, 6, 12, 7
player_box_white:	.word 	0, 8, 1, 7, 1, 8, 1, 9, 2, 3, 2, 8, 2, 9, 2, 10, 3, 2, 3, 3, 3, 4, 3, 9, 3, 10, 4, 4, 4, 5, 4, 8, 4, 9, 5, 1, 5, 3, 5, 6, 5, 7, 5, 8, 6, 0, 6, 3, 6, 7, 7, 0, 7, 5, 7, 6, 8, 0, 8, 4, 8, 8, 9, 2, 9, 3, 9, 4, 9, 5, 10, 3, 10, 5, 12, 8, 12, 9, 12, 10, 12, 11, 13, 5, 13, 6, 13, 7, 13, 8, 13, 9, 13, 10, 14, 6, 14, 7, 14, 8
player_box_black:	.word 	2, 7
player_box_border:	.word	5, 8, 4, 9, 3, 10, 2, 10, 2, 9, 1, 8, 0, 7, 0, 8, 8, 8, 2, 6, 3, 6, 3, 6, 4, 11, 5, 10, 6, 9

# movement: direction - word, isJumping - bit, jumpDistance - word?, onPlatform - bit, inBubble - int, bubbleCount - word, bubbleDirection - word
player_movement:	.word 0, 0, 0, 0, 0, 0, 0
jumping_distance:	.word	-5, 

# snails
# snail:	position: int, eaten: byte, direction: byte (total = 8)
snails:	.space	84 # max 10 snails	
snail_box_body:	.word	0, 0, 0, 2, 1, 1, 1, 2, 2, 1, 2, 2, 3, 2, 3, 2, 4, 2, 4, 3, 4, 4, 4, 5, 4, 6, 4, 7, 4, 8
snail_box_shell:	.word	1, 4, 1, 5, 1, 6, 2, 3, 2, 4, 2, 5, 2, 6, 2, 7, 3, 3, 3, 4, 3, 5, 3, 6, 3, 7
snail_box_border:	.word	0, 2, 1, 6, 1, 7, 2, 7, 2, 8

# hearts
hearts_box_red:		.word 	0, 1, 0, 3, 1, 0, 1, 1, 1, 2, 1, 3, 1, 4, 2, 1, 2, 2, 2, 3, 3, 2
hearts_is_updated:		.byte 	1 

#  bubble
bubble_box:	.word	0, 3, 0, 4, 0, 5, 0, 6, 0, 7, 0, 8, 0, 9, 1, 2, 1, 10, 2, 1, 2, 11, 3, 0, 3, 12, 4, 0, 4, 12, 5, 0, 5, 12, 6, 0, 6, 12, 7, 0, 7, 12, 8, 0, 8, 12, 9, 0, 9, 12, 10, 1, 10, 11, 11, 2, 11, 10, 12, 3, 12, 4, 12, 5, 12, 6, 12, 7, 12, 8, 12, 9
bubble_mini_box:	.word	0, 1, 0, 2, 1, 0, 1, 3, 2, 0, 2, 3, 3, 1, 3, 2

# smiley_face
win_face_box:		.word	0, 1, 0, 5, 2, 0, 2, 6, 3, 0, 3, 1, 3, 2, 3, 3, 3, 4, 3, 5, 3, 6
win_word_box:		.word 	0,0,1,0, 2, 0, 3, 0, 4, 0, 0, 1, 2, 1, 0, 2, 2, 2, 3, 2, 0, 3, 1, 3, 2, 3, 4, 3, 1, 5, 2, 5, 3, 5, 4, 5, 0, 6,  2, 6, 0, 7, 2, 7, 1, 8, 2, 8, 3, 8, 4, 8, 0, 10, 1, 10, 2, 10, 3, 10, 4, 11, 3, 12, 4, 13, 0, 14, 1, 14, 2, 14, 3, 14, 1, 16, 2, 16, 3, 16, 4, 16, 0, 17, 2, 17, 0, 18, 2, 18, 1, 19, 2, 19, 3, 19, 4, 19, 0, 21, 1, 21, 3, 21, 4, 21, 0, 22, 4, 22, 0, 23, 4, 23, 1, 24, 2, 24, 3, 24
 # frown face 
lose_face_box:		.word	0, 1, 0, 5, 2, 0, 2, 1, 2, 2, 2, 3, 2, 4, 2, 5, 2, 6, 3, 0, 3, 6, 
lose_word_box:		.word	0, 0, 0, 5, 0, 6, 0, 9, 0, 10, 0, 11, 0, 13, 0, 14, 0, 15, 1, 0, 1, 4, 1, 7, 1, 9, 1, 13, 2, 0, 2, 4, 2, 7, 2, 10, 2, 11, 2, 13, 2, 14, 3, 0, 3, 1, 3, 2, 3, 5, 3, 6, 3, 9, 3, 10, 3, 11, 3, 13, 3, 14, 3, 15
# round numbers
number_one_box:	.word 	0, 0, 0, 1, 1, 1, 2, 1, 3, 1, 4, 1, 5, 0, 5, 1, 5, 2
number_two_box:	.word 	0, 0, 0, 1, 0, 2, 1, 2, 2, 0, 2, 1, 2, 2, 3, 0, 4, 0, 5, 0, 5, 1, 5, 2
number_three_box:		.word 	0, 0, 0, 1, 0, 2, 1, 2, 2, 0, 2, 1, 2, 2, 3, 2, 4, 2, 5, 0, 5, 1, 5, 2
number_bracket_box:	.word 	0, 2, 1, 2, 2, 1, 3, 1, 4, 0, 5, 0

round_numbers:	.word	0:6

.text
new_game:
	li $t1, 1
	
	# set game data
	la $t0, game_data
	sb $t1, GAME_DATA_ROUND_NUM($t0)
	sb $zero, GAME_DATA_WIN_LOSE($t0) # default set to lose if game over happens
	
	# set health
	la $t0, hearts_is_updated
	sb $t1, 0($t0) # update health display
	
	# load number of bubbles
	la $t0, player
	li $t1, BUBBLE_START_NUM
	sb $t1, PLAYER_NUM_BUBBLES($t0)
	
	# load number data
	la $t0, round_numbers
	la $t1, number_one_box
	sw $t1, 0($t0)
	li $t1, NUMBER_ONE_NUM
	sw $t1, 4($t0)
	la $t1, number_two_box
	sw $t1, 8($t0)	
	li $t1, NUMBER_TWO_NUM
	sw $t1, 12($t0)
	la $t1, number_three_box
	sw $t1, 16($t0)
	li $t1, NUMBER_THREE_NUM
	sw $t1, 20($t0)
	
new_round:
	la $t7, player_movement
	li $t8, 0
	sw $t8, PLAYER_MOVEMENT_DIRECTION($t7) # set initial direction to 0
	sw $t8, PLAYER_MOVEMENT_JUMPING($t7) # set initial isJumping to 0

	addi $a1, $zero, GROUND_HEIGHT
	subi $a1, $a1, 1500 # padding off the ground
	addi $a0, $zero, 3000 # padding off the top of the display
	addi $sp, $sp, -8
	sw $a0, 4($sp)
	sw $a1, 0($sp)
	
	jal generate_platforms
	
	la $t7, player
	li $t8, PLAYER_START_POSITION
	sw $t8, PLAYER_POSITION($t7) # set initial offset 
	li $t8, PLAYER_START_HEALTH
	sb $t8, PLAYER_HEALTH($t7) # set initial health 
	
	jal draw_background
	jal draw_round_numbers
	
	li $t1, 1 
	la $t0, hearts_is_updated # always redraw hearts since background is also being redrawn
	sb $t1, 0($t0)
	
	
draw: 


check_for_damage:
	jal snail_damage_check_collision
	jal worm_damage_check_collision
	beqz $v0, check_for_damage_end # if collision = false, move on to the movement
execute_damage:
	la $t0, player
	li $t1, PLAYER_START_POSITION # player received damage, teleport player to the starting position
	sw $t1, PLAYER_POSITION($t0)	
	lb $t1, PLAYER_HEALTH($t0) # get the player's health
	subi $t1, $t1, 1
	sb $t1, PLAYER_HEALTH($t0) # decrease player health
	la $t2, hearts_is_updated # we need to update hearts display
	li $t1, 1
	sb $t1, 0($t2) # set hearts is updated to true
	la $t0, player_movement
	sb $zero, PLAYER_MOVEMENT_IS_BUBBLE($t0)  # remove bubble
stop_player_movement:
	la $t0, player_movement
	sw $zero, PLAYER_MOVEMENT_JUMPING($t0)
	sw $zero, PLAYER_MOVEMENT_DIRECTION($t0)
	jal draw_background
	jal draw_round_numbers

check_for_damage_end:

draw_erase_moving_objects:
	
draw_erase_prev_player:

	la $t7, player
	lw $s0, PLAYER_POSITION($t7) # get offset

	# red
	li $t3, PLAYER_NUM_RED
	la $t4, player_box_red
	li $t5, BACKGROUND_COLOUR # MATCH BACKGROUND COLOUR
	subi $sp, $sp, 16 # create space in the stack
	sw $s0, 12($sp) # object offset
	sw $t3, 8($sp) # num to draw
	sw $t4, 4($sp) # positions
	sw $t5, 0($sp) # colour to draw		
	jal draw_object_positions_list
	
	# white
	li $t3, PLAYER_NUM_WHITE
	la $t4, player_box_white
	li $t5, BACKGROUND_COLOUR # MATCH BACKGROUND COLOUR
	subi $sp, $sp, 16 # create space in the stack
	sw $s0, 12($sp) # object offset
	sw $t3, 8($sp) # num to draw
	sw $t4, 4($sp) # positions
	sw $t5, 0($sp) # colour to draw		
	jal draw_object_positions_list
	
	# black
	li $t3, PLAYER_NUM_BLACK
	la $t4, player_box_black
	li $t5, BACKGROUND_COLOUR # MATCH BACKGROUND COLOUR
	subi $sp, $sp, 16 # create space in the stack
	sw $s0, 12($sp) # object offset
	sw $t3, 8($sp) # num to draw
	sw $t4, 4($sp) # positions
	sw $t5, 0($sp) # colour to draw		
	jal draw_object_positions_list

draw_erase_bubble:

	la $t0, player_movement
	lb $t1, PLAYER_MOVEMENT_IS_BUBBLE($t0) # get whether bubble is activated
	beqz $t1, draw_erase_bubble_end # bubble not activated, dont draw bubble
	
	# draw bubble at the same position as the player
	la $s0, player
	lw $s0, PLAYER_POSITION($s0)
	li $t3, BUBBLE_NUM
	la $t4, bubble_box
	li $t5,  BACKGROUND_COLOUR
	subi $sp, $sp, 16 # create space in the stack
	sw $s0, 12($sp) # object offset
	sw $t3, 8($sp) # num to draw
	sw $t4, 4($sp) # positions
	sw $t5, 0($sp) # colour to draw	
	jal draw_object_positions_list	
draw_erase_bubble_end:
		
draw_erase_worms:
	li $s0, BASE_ADDRESS
	la $t0, worms

	lw $t1,  WORMS_NUM($t0) # get num worms

	li $t2, 0 # counter
	li $t6, WORMS_WAVE_CYCLE_LENGTH 
	la $t5, worms_wave
	lb $t5, 0($t5) # get current worm wave position
	la $s6, worms_wave_steps
	lb $s6, 0($s6) # get current worm wave step
draw_erase_worms_loop:
	lw $t3, WORMS_POSITION($t0) # get the position of worm
	bge $t3, GROUND_HEIGHT, draw_erase_worms_loop_next # the worm is below the ground, no need to draw
draw_erase_worms_is_changed:
	add $s1, $s0, $t3 # add offset to address
	li $t8, BACKGROUND_COLOUR # MATCH BACKGROUND COLOUR
	li $t4, WORM_SIZE 

draw_erase_worms_loop_length:
	div $t4, $t6
	mfhi $t7 # $t7 = counter % 2
	beq $t7, $t5, draw_erase_worms_loop_lowered # this unit of the worm is lowered
	sw $t8, 0($s1) # draw the colour
	j draw_erase_worms_loop_length_next
draw_erase_worms_loop_lowered:
	addi $s2, $s1, VERTICAL_DIST
	sw $t8, 0($s2) # draw the worm unit
draw_erase_worms_loop_length_next:
	subi $t4, $t4, 1 # count down
	addi $s1, $s1, 4 # next word
	bgtz $t4, draw_erase_worms_loop_length
draw_erase_worms_loop_next:
	addi $t0, $t0, 8 # iterate to the next indices
	addi $t2, $t2, 1 # count up
	bne $t2, $t1, draw_erase_worms_loop	
				
execute_movement:
	jal movement_worms
	jal movement_player
													
draw_ground:
	li $t0, BASE_ADDRESS
	li $t1, GROUND_HEIGHT
	add $t0, $t0, $t1 # go to beginning of ground pos
	li $t2, VERTICAL_DIST # width of ground
	li $t3, VERTICAL_DIST  # counter
	li $t4, GROUND_COLOUR
draw_ground_loop:
	sw $t4 0($t0) # draw it green
	addi $t0, $t0, 4 # move to the next word
	subi $t3, $t3, 4 # count up
	bnez $t3, draw_ground_loop

draw_snails:

	la $s0, snails # get snails array
	lw $s7, SNAILS_NUM($s0) # get total number of snails, also act as counter
	
	# load snail data
	li $s1, SNAIL_NUM_BODY
	la $s2, snail_box_body
	li $s3, SNAIL_COLOUR_BODY
	li $s4, SNAIL_NUM_SHELL
	la $s5, snail_box_shell
	li $s6, SNAIL_COLOUR_SHELL
	
draw_snails_loop:
	lh $t0, SNAILS_EATEN($s0) # get whether snail is already eatern
	bnez $t0, draw_snails_loop_erased # snail is already eatern, draw background colour instead
	# draw the snail's body
	subi $sp, $sp, 16 # create space in the stack
	lw $t1, SNAILS_POSITION($s0) # get the snail's offset
	sw $t1, 12($sp) # object offset
	sw $s1, 8($sp) # num to draw
	sw $s2, 4($sp) # positions
	sw $s3, 0($sp) # colour to draw
	jal draw_object_positions_list

	# draw the smail's shell
	subi $sp, $sp, 16 # create space in the stack
	lw $t1, SNAILS_POSITION($s0) # get the snail's offset
	sw $t1, 12($sp) # object offset
	sw $s4, 8($sp) # num to draw
	sw $s5, 4($sp) # positions
	sw $s6, 0($sp) # colour to draw	
	
	jal draw_object_positions_list
	
	j draw_snails_next
	
draw_snails_loop_erased:
	
	# draw the snail's body
	subi $sp, $sp, 16 # create space in the stack
	lw $t1, SNAILS_POSITION($s0) # get the snail's offset
	sw $t1, 12($sp) # object offset
	sw $s1, 8($sp) # num to draw
	sw $s2, 4($sp) # positions
	li $t1, BACKGROUND_COLOUR # we draw the background colour instead
	sw $t1, 0($sp) # colour to draw
	jal draw_object_positions_list

	# draw the smail's shell
	subi $sp, $sp, 16 # create space in the stack
	lw $t1, SNAILS_POSITION($s0) # get the snail's offset
	sw $t1, 12($sp) # object offset
	sw $s4, 8($sp) # num to draw
	sw $s5, 4($sp) # positions
	li $t1, BACKGROUND_COLOUR # we draw the background colour instead
	sw $t1, 0($sp) # colour to draw
	
	jal draw_object_positions_list
	
draw_snails_next:	
	addi $s0, $s0, 8 # iterate to next snail in snails array
	subi $s7, $s7, 1 # count down
	bnez $s7, draw_snails_loop
	
draw_platforms:
	move $s7, $ra
	li $s0, BASE_ADDRESS
	la $t0, platforms
	
	lw $t1,  PLATFORMS_NUM($t0) # get num platforms
	
	li $t2, 0 # counter
draw_platforms_loop:
	addi $t2, $t2, 1
	lw $t3, PLATFORMS_POSITION($t0) # get the position of platform
	add $s1, $s0, $t3 # add offset to address
	li $t8, PLATFORM_COLOUR # $t8 stores the green colour code
	li $t4, PLATFORM_SIZE # counter 
draw_platforms_loop_length:
	sw $t8, 0($s1) # draw the green
	subi $t4, $t4, 1 # count down
	addi $s1, $s1, 4 # next word
	bgtz $t4, draw_platforms_loop_length
	addi $t0, $t0, 8 # iterate to the next indices, 
	bne $t2, $t1, draw_platforms_loop
	move $ra, $s7
		
draw_player:		
	la $s0, player
	lw $s0, PLAYER_POSITION($s0) # get player offset
draw_player_red:
	
	li $t3, PLAYER_NUM_RED
	la $t4, player_box_red
	li $t5, PLAYER_COLOUR_RED
	subi $sp, $sp, 16 # create space in the stack
	sw $s0, 12($sp) # object offset
	sw $t3, 8($sp) # num to draw
	sw $t4, 4($sp) # positions
	sw $t5, 0($sp) # colour to draw	
	
	jal draw_object_positions_list

draw_player_white:	
	# white
	li $t3, PLAYER_NUM_WHITE
	la $t4, player_box_white
	li $t5, PLAYER_COLOUR_WHITE 
	subi $sp, $sp, 16 # create space in the stack
	sw $s0, 12($sp) # object offset
	sw $t3, 8($sp) # num to draw
	sw $t4, 4($sp) # positions
	sw $t5, 0($sp) # colour to draw		
	jal draw_object_positions_list
	
draw_player_black:	
	# white
	li $t3, PLAYER_NUM_BLACK
	la $t4, player_box_black
	li $t5, PLAYER_COLOUR_BLACK 
	subi $sp, $sp, 16 # create space in the stack
	sw $s0, 12($sp) # object offset
	sw $t3, 8($sp) # num to draw
	sw $t4, 4($sp) # positions
	sw $t5, 0($sp) # colour to draw		
	jal draw_object_positions_list	
	
draw_player_bubble:

	la $t0, player_movement
	lb $t1, PLAYER_MOVEMENT_IS_BUBBLE($t0) # get whether bubble is activated
	beqz $t1, draw_player_bubble_end # bubble not activated, dont draw bubble
	
	# draw bubble at the same position as the player
	la $s0, player
	lw $s0, PLAYER_POSITION($s0)
	li $t3, BUBBLE_NUM
	la $t4, bubble_box
	li $t5, BUBBLE_COLOUR
	subi $sp, $sp, 16 # create space in the stack
	sw $s0, 12($sp) # object offset
	sw $t3, 8($sp) # num to draw
	sw $t4, 4($sp) # positions
	sw $t5, 0($sp) # colour to draw	
	jal draw_object_positions_list	
	
	
draw_player_bubble_end:
	
draw_worms:
	move $s7, $ra
	li $s0, BASE_ADDRESS
	addi $s4, $s0, 65536 # maximum possible offset
	la $t0, worms

	lw $t1,  WORMS_NUM($t0) # get num worms
	bgt $t1, PLATFORMS_TOTAL_NUM, draw_worms_end
	beqz $t1, draw_worms_end # no worms to draw
	li $t2, 0 # counter
	li $t6, WORMS_WAVE_CYCLE_LENGTH # the length of the worm's wave arc
draw_worms_loop:
	lw $t3, WORMS_POSITION($t0) # get the position of worm
	bge $t3, GROUND_HEIGHT, draw_worms_end # the worm is below the ground, no need to draw
	add $s1, $s0, $t3 # add offset to address
	li $t8, WORM_COLOUR # $t8 stores the worm colour code
	li $t4, WORM_SIZE 
	la $t5, worms_wave
	lb $t5, 0($t5) # get current worm wave position
draw_worms_loop_length:
	div $t4, $t6
	mfhi $t7 # $t7 = counter % 2
	beq $t7, $t5, draw_worms_loop_lowered # this unit of the worm is lowered
	bgt $t4, $s4, draw_worms_loop_next # going outside of display, so skip 
	sw $t8, 0($s1) # draw the green
	j draw_worms_loop_next
draw_worms_loop_lowered:
	addi $s2, $s1, VERTICAL_DIST
	sw $t8, 0($s2) # draw the worm unit
draw_worms_loop_next:
	bgt $t4, PLATFORMS_TOTAL_NUM, draw_worms_end
	bgt $t2, PLATFORMS_TOTAL_NUM, draw_worms_end
	subi $t4, $t4, 1 # count down
	addi $s1, $s1, 4 # next word
	bnez $t4, draw_worms_loop_length
	addi $t0, $t0, 8 # iterate to the next indices, 
	addi $t2, $t2, 1 # count up
	bne $t2, $t1, draw_worms_loop
draw_worms_end:

draw_hearts:

	# number of hearts doesnt change as often, so only need to redraw if its updated
	la $t0, hearts_is_updated 
	lb $t0, 0($t0) # get whether health was updated or not
	beqz $t0, draw_hearts_end # health was not updated, so move on
	
	la $s0, hearts_box_red
	li $s1, HEARTS_COLOUR_RED
	li $s2, HEARTS_START_POSITION # also as current pointer
	la $s3, player 
	lb $s4, PLAYER_HEALTH($s3) # get the player's health
	beqz $s4, draw_hearts_end # no hearts to draw
	li $s5, HEARTS_NUM_RED # number of red units to draw
	li $s6, HEARTS_SPACING_HORIZONTAL # the spacing between hearts
	sll $s6, $s6, 2 # multiply spacing by 4 for word length
	li $s7, HEARTS_START_POSITION # act as row pointer
	li $s3, HEARTS_NUM_PER_ROW # num of hearts per row, also act as counter
draw_hearts_loop:
	
	# draw the heart
	subi $sp, $sp, 16 # create space in the stack
	sw $s2, 12($sp) # object offset
	sw $s5, 8($sp) # num to draw
	sw $s0, 4($sp) # positions
	sw $s1, 0($sp) # colour to draw		
	jal draw_object_positions_list	
	
	add $s2, $s2, $s6 # shift current position by spacing between hearts, do this here so if new row, starting point isnt affected
	
	bnez $s3, draw_hearts_next # if current row count != hearts per row, move to the next heart
	
	li $t0, HEARTS_SPACING_VERTICAL # the spacing between rows of hearts

	sll $t0, $t0, VERTICAL_DIST_SHIFT # shift down HEARTS_SPACING_VERTICAL number of rows
	
	add $s7, $s7, $t0 # add the dist to the current row start position, set as the new current pointer
	
	move $s2, $s7  # add the dist to the current row start position, set as the new current pointer

	li $s3, HEARTS_NUM_PER_ROW # reset row heart counter


draw_hearts_next:

	subi $s4, $s4, 1 # count down

	subi $s3, $s3, 1 # dount down
	
	bnez $s4, draw_hearts_loop
	
	# reset hearts-updated to false
	la $t0, hearts_is_updated 
	sb $zero, 0($t0) # dont need to update health display anymore
	
draw_hearts_end:	
	
draw_mini_bubbles:
	
	la $s0, bubble_mini_box
	li $s1, BUBBLE_COLOUR
	li $s2, BUBBLE_MINI_START_POSITION # also as current pointer
	la $s3, player 
	lb $s4, PLAYER_NUM_BUBBLES($s3) # get the player's num bubbles
	beqz $s4, draw_mini_bubbles_end # no hearts to draw
	li $s5, BUBBLE_MINI_NUM # number of red units to draw
	li $s6, BUBBLE_MINI_SPACING_HORIZONTAL # the spacing between hearts
	sll $s6, $s6, 2 # multiply spacing by 4 for word length
	li $s7, BUBBLE_MINI_START_POSITION # act as row pointer

draw_mini_bubbles_loop:
	
	# draw the heart
	subi $sp, $sp, 16 # create space in the stack
	sw $s2, 12($sp) # object offset
	sw $s5, 8($sp) # num to draw
	sw $s0, 4($sp) # positions
	sw $s1, 0($sp) # colour to draw		
	jal draw_object_positions_list	
	
	add $s2, $s2, $s6 # shift current position by spacing between bubbles

draw_mini_bubbles_next:

	subi $s4, $s4, 1 # count down

	subi $s3, $s3, 1 # dount down
	
	bnez $s4, draw_mini_bubbles_loop
	
	# reset hearts-updated to false
	la $t0, hearts_is_updated 
	sb $zero, 0($t0) # dont need to update health display anymore
	
draw_mini_bubbles_end:	

game_loop:

	li $t9, 0xffff0000
	lw $t8, 0($t9)
	beq $t8, 1, key # if a key is pressed
	j return_from_key
key:	
	lw $s0, 4($t9)
	la $t0, player_movement
	lw $s2, PLAYER_MOVEMENT_DIRECTION($t0)
	beq $s0, KEY_LEFT, left 
	beq $s0, KEY_RIGHT, right
	
	lw $t1, PLAYER_MOVEMENT_IS_BUBBLE($t0) # if the player is currently inbubble
	bnez $t1, key_bubble
	
	beq $s0, KEY_JUMP, up
	beq $s0,  KEY_STOP, down
	j key_game_state
key_bubble:
	beq $s0, KEY_JUMP, bubble_up
	beq $s0,  KEY_STOP, bubble_down
key_game_state:
	beq $s0,  KEY_RESTART, new_game
	beq $s0, KEY_BUBBLE, key_new_bubble
return_from_key_direction:	
	# return
	j return_from_key
return_from_key:
	
	# sleep 
	li $a0, SLEEP_MS
	li $v0, 32
	syscall
update_game:
	jal check_round_status
	
	j draw
	
up:	
	lw $t1, PLAYER_MOVEMENT_JUMPING($t0) # get isJumping
	bnez $t1,  return_from_key_direction # if already jumping, dont jump again
	
	lw $t3, PLAYER_MOVEMENT_LANDED($t0) # get is landed
	beqz $t3,  return_from_key_direction # if not in a landed position, dont jump
	
	li $t1, 1 # isJumping 
	sw $t1, PLAYER_MOVEMENT_JUMPING($t0) # set is Jumping to true
	li $t2, JUMP_DIST_LOW
	sw $t2, PLAYER_MOVEMENT_JUMP_DIST($t0) # set jump count distance
	j return_from_key_direction
down:	
	li $t1, 0 # isJumping 
	sw $t1, PLAYER_MOVEMENT_DIRECTION($t0)
	j return_from_key_direction
left:	li $t1, -1 # direction = -1
	sw $t1, PLAYER_MOVEMENT_DIRECTION($t0)
	j return_from_key_direction
right:	
	la $t0, player_movement
	li $t1, 1 # direction = 1
	sw $t1, PLAYER_MOVEMENT_DIRECTION($t0)
	j return_from_key_direction
	
bubble_up:
	li $t1, -1
	sw $t1, PLAYER_MOVEMENT_BUBBLE_DIRECTION($t0)
	j return_from_key_direction
bubble_down:
	li $t1, 1
	sw $t1, PLAYER_MOVEMENT_BUBBLE_DIRECTION($t0)
	j return_from_key_direction
	
movement_player:
	# save return address in stack
	subi $sp, $sp, 4
	sw $ra, 0($sp)
	
	la $s6, player_movement # get player movement
	lw $t3, PLAYER_MOVEMENT_JUMPING($s6) # get isJumping
	bnez $t3, movement_direction
	lw $t3, PLAYER_MOVEMENT_IS_BUBBLE($s6) # get is bubble
	bnez $t3, movement_direction
movement_not_jumping: # if not jumping, or in a bubble, player is susceptible to gravity
	jal gravity	
movement_direction:
	la $s6, player_movement
	lw $t2, PLAYER_MOVEMENT_DIRECTION($s6) # get direction (-1, 0, 1)
	la $t3, player
	lw $t4, PLAYER_POSITION($t3) # get current offset for player position	
	li $t5, 4
	mult $t2, $t5 # mult direction * movement width / display unit
	mflo $t2 
	add $s3, $t2, $t4 # add offset for new horizontal position

	move $a0, $t4 

	subi $sp, $sp, 4 # create space in stack
	sw $s3, 0($sp) # add potential position to stack
	jal wall_check_collision
	lw $t1, 0($sp) # pop result from stack
	addi $sp, $sp, 4 # remove space in stack
	bnez $t1, movement_done_horizontal # if collides with wall, dont update position movement
	
	add $a0, $zero, $s3 # store new position
	
movement_done_horizontal:
	la $s6, player_movement # get player movement
	lw $t3, PLAYER_MOVEMENT_IS_BUBBLE($s6) # get is bubble
	beqz $t3, movement_check_jumping # not bubble so check for jumping instead
movement_check_bubble:
	jal bubble_movement
	bltz $v0, movement_return # if the player is hitting the ceiling, dont update height
	la $t9, player
	sw $v0, PLAYER_POSITION($t9) # store new offset
	j movement_return
movement_check_jumping:
	jal jumping
	bltz $v0, movement_return # if the player is hitting the ceiling, dont update height
	la $t9, player
	sw $v0, PLAYER_POSITION($t9) # store new offset
movement_return:
	lw $ra, 0($sp) # pop return address from stack
	addi $sp, $sp, 4
	jr $ra
	
gravity:
	subi $sp, $sp, 4 # create space in stack to save return address
	sw $ra, 0($sp)
	jal platform_check_collision
	bnez $v0, gravity_return # if current pos is on a platform, no freefall
	jal ground_check_collision
	bnez $v0, gravity_return # if current pos is on the ground, no freefall
	la $t1, player
	lw $t2, PLAYER_POSITION($t1) # get player offset
	addi $t3, $t2, VERTICAL_DIST	# falling down
	sw $t3, PLAYER_POSITION($t1) # store new pos
gravity_return:	
	lw $ra, 0($sp) # get return address from stack
	addi $sp, $sp, 4 # pop space
	jr $ra
jumping:
	subi $sp, $sp, 4 # create space in stack for return addr
	sw $ra, 0($sp)  # save return address
	la $a1, player_movement
	lw $t8, PLAYER_MOVEMENT_JUMPING($a1) # load isJumping
	beqz $t8, jumping_return
	# current y pos = jumpingDistance ^ 2
	li $t5, JUMP_DIST_MAX
	lw $s2, PLAYER_MOVEMENT_JUMP_DIST($a1) # get jumpingDistance (-total <= 0 <= total)
	bge $t5, $s2, calc_offset # not ending of jump
end_jump:
	li $t8, 0 # isJumping = false
	sw $t8, PLAYER_MOVEMENT_JUMPING($a1) # stop jumping after this
	j jumping_return
calc_offset:
	beqz $s2, new_height # no movement since hitting peak of jump
	bgtz $s2, falling
upward:
	addi $t8, $zero, -1
	j new_height
falling:
	# check if falling and has collision
	bltz $s2, jumping_increment_counter # only check for collision when falling
	jal platform_check_collision
	bnez $v0, end_jump # if has collision, end the jump
	
	addi $t8, $zero, 1
new_height:
	# mult $t9, $t9 # jumpingdistance ^ 2
	# mflo $t7
	li $t7, 1
	mult $t7, $t8 # multiply by vertical direction
	mflo $t7

	sll $t7, $t7, VERTICAL_DIST_SHIFT # multiply by row offset width

	move $s6, $a0
	add $a0, $s6, $t7 # add the new position offset
	
	# increment jumpingDistance
jumping_increment_counter:
	addi $s2, $s2, 1
	sw $s2, PLAYER_MOVEMENT_JUMP_DIST($a1)
jumping_return:
	move $v0, $a0
	lw $ra, 0($sp) # get return addr from stack
	addi $sp, $sp, 4
	jr $ra	

bubble_movement:
	subi $sp, $sp, 4 # create space in stack for return address
	sw $ra, 0($sp)
	
	jal ground_check_collision # hitting ground true/false is in $v0

	la $t0, player_movement
	lw $t1, PLAYER_MOVEMENT_IS_BUBBLE($t0) 
	
	beqz $t1, bubble_movement_end	# if player not in bubble, dont care about movement
	lw $t1, PLAYER_MOVEMENT_BUBBLE_DIRECTION($t0) # get the current bubble vertical direction
	beq $v0, $t1, bubble_movement_counter # if ground collision = 1 and player direction = 1, dont update position
	
	sll $t1, $t1, VERTICAL_DIST_SHIFT # get vertical offset
	add $a0, $a0, $t1 # add new position to current position
	
bubble_movement_counter:
	lw $t1, PLAYER_MOVEMENT_BUBBLE_COUNT($t0)
	subi $t1, $t1, 1 #  - 1 on bubble count
	sw $t1, PLAYER_MOVEMENT_BUBBLE_COUNT($t0) # store new bubble count
	bnez $t1, bubble_movement_end
bubble_movement_end_of_bubble:
	sw $zero, PLAYER_MOVEMENT_IS_BUBBLE($t0) # set is bubble to false
	sw $zero, PLAYER_MOVEMENT_BUBBLE_DIRECTION($t0) # set bubble direction to 0
bubble_movement_end:
	move $v0, $a0
	lw $ra, 0($sp)
	addi $sp, $sp, 4 # pop return address from stack
	jr $ra

movement_worms:
	la $t0, worms
	lw $t1, WORMS_NUM($t0) # get total number of worms
	li $t3, VERTICAL_DIST # get width of the display
	li $t9, WORM_SIZE # find the worm's offset for hitting the right wall
	li $t2, 4 
	mult $t9, $t2
	mflo $t9 # store this 4 * worm size in t9
movement_worms_loop:
	lh $t8, WORMS_MOVEMENT_STEP($t0) # get the worm's animation step
	bne $t8, WORM_SPEED, movement_worms_loop_next_iteration # if current step != speed, the worm does not move
	li $t8, 0 # otherwise, reset the animation step to 0
	lh $t2, WORMS_DIRECTION($t0) # get direction
	lw $t4, WORMS_POSITION($t0) # get worm's offset
	div $t4, $t3
	mfhi $t5 # get the worm's relative x-axis position
	beq $t2, RIGHT, movement_worms_loop_right
movement_worms_loop_left:
	beqz $t5, movement_worms_loop_set_right 
	# worm is moving left so -4 on offset
	subi $t4, $t4, 4
	j movement_worms_loop_update_position
movement_worms_loop_set_right:
	li $t6, RIGHT
	sh $t6, WORMS_DIRECTION($t0)
movement_worms_loop_right:
	sub $t6, $t3, $t9 # the remainder to look for when moving right
	beq $t6, $t5, movement_worms_loop_set_left # if hitting right wall, begin to move left
	# worm is moving right so +4 on offset
	addi $t4, $t4, 4
	j movement_worms_loop_update_position
movement_worms_loop_set_left:
	li $t6, LEFT
	sh $t6, WORMS_DIRECTION($t0)
	j movement_worms_loop_left
movement_worms_loop_update_position:
	sh $t4, WORMS_POSITION($t0) # set the worm's new offset
movement_worms_loop_next_iteration:
	addi $t8, $t8, 1 # count up the worm's movement step
	sh $t8, WORMS_MOVEMENT_STEP($t0) # store the worm's new animation step
	addi $t0, $t0, 8
	subi $t1, $t1, 1 # count down
	bnez $t1, movement_worms_loop
	
movement_worms_loop_end:
	
	# wave movement check
	la $t3, worms_wave_steps
	lb $t4, 0($t3) # get the current wave step
	li $t2, WORMS_WAVE_INTERVAL_STEPS
	bne $t2, $t4, movement_worms_end
	# update worms wave position
	li $t4, 0 # reset step count to 0
	la $t0, worms_wave
	lb $t5, 0($t0)
	beqz $t5, next_worms_position_is_one
	
next_worms_position_is_zero:

	sb $zero, 0($t0)

	j movement_worms_end
next_worms_position_is_one:

	li $t1, 1
	
	sb $t1, 0($t0)

movement_worms_end:
	# update worms wave position
	addi $t4, $t4, 1 # add 1 to the wave step
	sb $t4, 0($t3) # store the new wave step
	jr $ra
	
generate_platforms:
	move $s7, $ra
	lw $t2, 0($sp) # get lowest possible platgorm
	lw $t1, 4($sp) # get highest possible platform

	sub $t3, $t2, $t1 # get total height coverage

	li $t8, PLATFORMS_TOTAL_NUM # number of platforms. 
	
	div $t3, $t8 # height / num platforms
	mflo $t0
	
	la $t9, platforms
	sw $t8, PLATFORMS_NUM($t9) 
	
	la $s5, worms 
	sw $t8, WORMS_NUM($s5) # num of worms = num of platforms

	li $s3, SNAILS_RANDOM_NUM # get the number of randomly generated  snails
	la $s4, snails # get snails array
	addi $s6, $s3, 1 # total num of snails = random num + 1 (at the top)
	sw $s6, SNAILS_NUM($s4) # store total number of snails
		
	li $t5, PLATFORM_SIZE
	
	sll $t5, $t5, 2 # multiply platform size * 4
	
	li $t4, HORIZONTAL_DIST 

	sub $t4, $t4, $t5 # save max platform position remainder

generate_platforms_loop:
	subi $t8, $t8, 1 # count down
randomize_platform:
	mult $t8, $t0 # get section of display top, current level's top boundary 
	mflo $t5 
	lw $t1, 4($sp) # get highest possible platform
	add $t5, $t5, $t1 # add highest possible platform
	# move $a0, $t5
	move $a1, $t0 # upper bound for random number
	move $s0, $ra
	jal generate_number
	li $s1, HORIZONTAL_DIST
	
	add $v0, $v0, $t5 # add current level's bottom boundary to the relative height
	
	li $t5, 4

	div $v0, $t5 # the new pos needs to fit word algined
	mfhi $t5
	sub $v0, $v0, $t5
	
	div $v0, $s1
	mfhi $s2
	
	bge $s2, $t4, randomize_platform # of platform x is too large, re-randomize platform
	
	subi $t5, $v0, SNAILS_PLATFORM_POSITION 
	blez $t5, randomize_platform # the platform is too high, re-randomize
	bge $s2, $t4, randomize_platform # of platform x is too large, re-randomize platform
	
	
	sw $v0, PLATFORMS_POSITION($t9) # store the platform pos in platforms struct
generate_platform_worm:	
	# the worm will be in between each platform in the middle
	srl $t1, $t0, 1 # the midpoint between platforms
	add $t1, $v0, $t1 # the platform worm's relative position
	
	li $t5, 4

	div $t1, $t5 # the new pos needs to fit word algined
	mfhi $t5
	sub $t1, $t1, $t5
	
	sw $t1, WORMS_POSITION($s5) # store the worm  pos in worms struct
	li $s2, WORM_SIZE
	sh $zero, WORMS_MOVEMENT_STEP($s5)
	li $s2, LEFT # set default direction to left
	sh $s2, WORMS_DIRECTION($s5)

generate_platform_snail_random:	
	move $t1, $v0 # save the platform's position
	beqz $t8,  generate_platform_snail # if this is the topmost platform, generate a snail
	beqz $s3, randomize_platform_next # no more snails left to generate
	subi $t5, $t8, 1 # since the topmost snail takes up a guaranteed spot, we dont want topmost and random to overlap
	ble $t5, $s3, generate_platform_random_snail # if  num of platforms left + 1 <= num snails needed, force the generation of snails
	li $a1, 2 # upper bound for the random number. Will use 0 for false, 1 for true
	jal generate_number # generate 0 or 1 in v0
	bnez $v0, randomize_platform_next # if random num is 0 = false, dont generate a snail and move on
generate_platform_random_snail:
	subi $s3, $s3, 1 # count down number of snails
generate_platform_snail:
	addi $t1, $t1, SNAILS_PLATFORM_POSITION # get the snail's position relative to the platform
	sw $t1, SNAILS_POSITION($s4) # store the snail's position in snail array
	sb $zero, SNAILS_DIRECTION($s4) 
	sb $zero, SNAILS_EATEN($s4) # all snails are alive and well at the beginning
	addi $s4, $s4, 8 # move on to the next indices in snail array
	
randomize_platform_next:	
	move $a0, $v0
	jal print_int
	la $a0, newline
	jal print_str
	move $a0, $t1
	jal print_int
	la $a0, newline
	jal print_str
	li $s2, PLATFORM_SIZE
	sw $s2, PLATFORMS_WIDTH($t9)
	

	addi $t9, $t9, 8 # move to the next indices
	addi $s5, $s5, 8
	bnez $t8, generate_platforms_loop
	move $ra, $s7
	jr $ra
	
wall_check_collision:	
	la $t1, HORIZONTAL_DIST
	la $t2, player_movement
	lw $t3, 0($sp) # get position from stack
	lw $t4, PLAYER_MOVEMENT_DIRECTION($t2) # get player direction
	
	div $t3, $t1 # get horizontal axis position
	mfhi $t6
	
	beqz $t4, wall_no_collision
	bgtz $t4, wall_check_right_collision
	j wall_check_left_collision
wall_check_left_collision:
	subi $t5, $t1, 4 # get right boundary
	beq $t6, $t5 wall_has_collision
	j wall_no_collision	
wall_check_right_collision:
	li $t7, PLAYER_WIDTH # get the player's width
	sll $t7, $t7, 2 # shift left twice to multiply by 4	
	add $t6, $t6, $t7 # add player pos + player width in word length
	blt $t1, $t6, wall_has_collision # if screen width < add player pos + player width in word length
	j wall_no_collision
wall_has_collision:
	li $t1, 1
	sw $t1, 0($sp)
	jr $ra
wall_no_collision:
	sw $zero, 0($sp)
	jr $ra

platform_check_collision:	# check landing collision for platforms and worms
	subi $sp, $sp, 4 # create space in stack for return address
	sw $ra, 0($sp)
	la $s0, platforms
	lw $s1, PLATFORMS_NUM($s0) # get num of platforms
	la $s5, worms
platform_collision_check_loop:
	lw $s2, PLATFORMS_POSITION($s0) # get platform pos
	li $s4, PLATFORM_SIZE 
	lw $s6, WORMS_POSITION($s5) # get worm pos
	li $s7, WORM_SIZE # all worms have fixed width
platform_collision_unit_check_loop:
	subi $sp, $sp, 8 # create space in stack
	li $t1, 1 # true
	sw $t1, 0($sp) # checking for landing collision only, since we are letting the player jump through platforms
	sw $s2, 4($sp) # push platform pos in stack
	
	jal player_unit_check_collision # check collision with single platform unit
	
	lw $t2, 0($sp) # get result from stack
	addi $sp, $sp, 4

	bnez $t2, platform_has_collision # if result != false, there is a collision

	addi $s2, $s2, 4 #: 4 is a constant
	subi $s4, $s4, 1 # count down
	bnez $s4, platform_collision_unit_check_loop
worm_collision_unit_check_loop:
	subi $sp, $sp, 8 # create space in stack
	li $t1, 1 # constant for true
	sw $t1, 0($sp) # checking for landing collision only, since we are letting the player jump through platforms
	sw $s6, 4($sp) # push platform pos in stack
	
	jal player_unit_check_collision # check collision with single platform unit
	
	lw $t2, 0($sp) # get result from stack
	addi $sp, $sp, 4

	bnez $t2, platform_has_collision # if result != false, there is a collision

	addi $s6, $s6, 4 # : 4 is a constant
	subi $s7, $s7, 1 # count down
	bnez $s7, worm_collision_unit_check_loop
platform_no_collision:
	addi $s0, $s0, 8 # iterate to next platform	
	addi $s5, $s5, 8 # iterate to next worm
	subi $s1, $s1, 1
	bnez $s1, platform_collision_check_loop
	# end of loop
	li $v0, 0 # contant
	la $t0, player_movement 
	sw $v0, PLAYER_MOVEMENT_LANDED($t0) # set player is landed to false
	lw $ra, 0($sp) # get return address
	addi $sp, $sp, 4
	jr $ra
platform_has_collision:
	li $v0, 1 #  constant
	la $t0, player_movement 
	sw $v0, PLAYER_MOVEMENT_LANDED($t0) # set player is landed to true
	lw $ra, 0($sp) # get return address
	addi $sp, $sp, 4
	jr $ra

ground_check_collision:
	subi $sp, $sp, 4
	sw $ra, 0($sp) # save return address in stack
	# li $s3, GROUND_HEIGHT # beginning of ground offset
	# li $s4, 0 # counter
	la $t0, player # load the player data
	lw $t1, PLAYER_POSITION($t0) # get the player's position
	subi $t2, $t1, GROUND_MIN_POSITION # player's pos - ground min position
	# subi $t3, $s3, GROUND_MIN_POSITION # gound height - ground min position
	bgez $t2, ground_has_collision # the player is on the ground
ground_no_collision:
	li $v0, 0
	lw $ra, 0($sp)
	addi $sp, $sp, 4 # pop return address from stack
	jr $ra	
ground_has_collision:
	li $v0, 1	
	la $t0, player_movement 
	sw $v0, PLAYER_MOVEMENT_LANDED($t0) # set player is landed to true
	lw $ra, 0($sp)
	addi $sp, $sp, 4 # pop return address from stack
	jr $ra	
	
worm_damage_check_collision:
	# using damage range min and max rows, check if the address stored at the location
	# overlapping with the fish contains the worm colour
	la $t0, player
	
	lw $t0, PLAYER_POSITION($t0) # get the player's position
	beq $t0, PLAYER_START_POSITION, worm_damage_dont_check # if player is at start position, don't check for worm damage!
	li $t8, PLAYER_DAMAGE_RANGE_MIN # begin at the top of the damage area, also serving as counter
	li $t9, PLAYER_DAMAGE_RANGE_MAX # begin at the top of the damage area
	li $t2, VERTICAL_DIST
	la $t3, player_box_border # the player's border for collisions
	li $t5, WORM_COLOUR # colour to check at the display addresses
worm_damage_check_collision_row_loop:
	mult $t8, $t2 # get the dist from the player's position
	mflo $t6 # store it in t6
	sll $t7, $t8, 3 #  the amount of space for each row in player_box_border, multiply by 8
	add $t7, $t3, $t7 # jump to the current row's data in player_box_border
	lw $t1, 0($t7) # get the min of the row, also acting as a counter
	lw $t7, 4($t7) # get the max of the row
	sll $t4, $t1, 2 # the offset to begin at, mult min of row by 4
	add $t6, $t6, $t4, # the relative player address to begin at on x-axis
	add $t6, $t6, $t0, # where to begin from the player's offset
	addi $t6, $t6, BASE_ADDRESS # get the exact address of the player's unit
worm_damage_check_collision_unit_loop:
	lw $t4, 0($t6) # get what's stored 
	# since worms are layered on top of the player, if the player collides with the worm, the worm's colour should be stored
	beq $t4, $t5, worm_damage_has_collision
	addi $t1, $t1, 1 # count up
	addi $t6, $t6, 4 # move to the next unit
	ble $t1, $t7, worm_damage_check_collision_unit_loop # not the end of the row range
worm_damage_no_collision:	
	addi $t8, $t8, 1 # count up
	ble $t8, $t9, worm_damage_check_collision_row_loop # if current row <= max row, continue with the loop
	li $v0, 0 # otherwise, end of the function and there is no collision
	jr $ra 
worm_damage_has_collision:	
	li $v0, 1
	jr $ra
worm_damage_dont_check:
	li $v0, 0
	jr $ra
	

snail_damage_check_collision:	# check landing collision for platforms and worms
	subi $sp, $sp, 4 # create space in stack for return address
	sw $ra, 0($sp)
	la $s0, snails
	lw $s1, SNAILS_NUM($s0) # get num of snails

snail_damage_collision_check_loop:
	lh $t0, SNAILS_EATEN($s0) # get whether the snail is already eaten
	bnez $t0, snail_damage_next # snail is already eaten, so move on to the next snail
	lw $s2, SNAILS_POSITION($s0) # get platform pos
	li $s4, SNAIL_HEIGHT
	la $s5, snail_box_border # get the snail's relative border
snail_damage_collision_unit_check_loop:
	subi $sp, $sp, 8 # create space in stack

	sw $zero, 0($sp) # checking for full body collision, any part of the player's character can collide with snail
	sw $s2, 4($sp) # push snail pos in stack
	
	jal player_unit_check_collision # check collision with single platform unit
	
	lw $t2, 0($sp) # get result from stack
	addi $sp, $sp, 4

	bnez $t2, snail_damage_has_collision # if result != false, there is a collision
	
snail_damage_no_unit_collision:
	addi $s2, $s2, 4 #  4 is a constant
	subi $s4, $s4, 1 # count down
	bnez $s4, snail_damage_collision_unit_check_loop
	j snail_damage_next # move on to the next snail
snail_damage_has_collision: 	# has collision, meaning the snail is being eaten
	li $t1, 1 #  constant
	sh $t1, SNAILS_EATEN($s0) # set snail to eaten
	
	# eating a snail increases the player's health
	la $t3, player
	lb $t4, PLAYER_HEALTH($t3) # get player current health
	addi $t4, $t4, 1 # + 1 on player health
	sb $t4, PLAYER_HEALTH($t3) # store new health value
	# this health will need to be updated
	la $t0, hearts_is_updated 
	li $t1, 1 # true
	sb $t1, 0($t0) # update health display
	
snail_damage_next:
	addi $s0, $s0, 8 # iterate to next snail	

	subi $s1, $s1, 1 # count down num of snails
	bnez $s1, snail_damage_collision_check_loop
	
	# end of loop
	lw $ra, 0($sp) # get return address
	addi $sp, $sp, 4
	jr $ra


generate_number:
	move $t7, $ra

	li $v0, 42
	syscall
	
	move $v0, $a0

	move $ra, $t7
	jr $ra
	
draw_object_positions_list:

	li $t0, BASE_ADDRESS
	
	lw $t1, 12($sp) # get offset of object
	
	add $t0, $t0, $t1 # add object's current offset to base address
	
	lw $t1, 8($sp) # num to draw
	lw $t2, 4($sp) # positions
	lw $t3, 0($sp) # colour to draw
	
	addi $sp, $sp, 16 # pop off the stack
	
draw_object_positions_list_loop:	
	
	lw $t5, POSITION_HORIZONTAL($t2) # get horizontal offset
	lw $t6, POSITION_VERTICAL($t2) # get vertical offset
	
	sll $t5, $t5, 2 # horizontal offset in word, mult by 4
	
	sll $t6, $t6, VERTICAL_DIST_SHIFT # get vertical offset on y axis

	
	add $t7, $t0, $t6 # add vertical dist to base address
	add $t7, $t7, $t5 # add horizontal dist to base address
	
	sw $t3, 0($t7) # draw the colour at the address
	
	subi $t1, $t1, 1 # count down
	addi $t2, $t2, 8 # iterate to the next 2-tuple in the list
	
	bnez $t1, draw_object_positions_list_loop
	
	jr $ra	
	

player_unit_check_collision:
	lw $t0, 4($sp) # pop unit from stack
	lw $t9, 0($sp) # pop landing collision
	addi $sp, $sp, 4 # we leave a spot in the stack for the return
	la $t1, player_box_border # get the player's border
	li $t2, PLAYER_HEIGHT # get the height of player (# of 2-tuples in player border)

	li $t3, 0 # counter
	
	# get player's current offset position
	la $t4, player
	lw $t4, PLAYER_POSITION($t4)
	
	li $t8, 4 # word width
	
player_unit_check_collision_loop:
	beqz $t9, player_unit_check_full_collision # if landing is false 
	# is only checking for landing
	blt $t3, PLAYER_LANDING_RANGE_MIN, player_unit_end_loop_iteration	# if counter < landing min row
	bgt $t3, PLAYER_LANDING_RANGE_MAX, player_unit_end_loop_iteration	# if counter > landing min row
player_unit_check_full_collision: # not landing only

	sll $t7, $t3, VERTICAL_DIST_SHIFT # convert to y axis row widths based on counter
	
	add $t7, $t4, $t7 # the row relative to the player's current offset
	
	lw $t5, 0($t1) # get left border
	
	sll $t5, $t5, 2 # convert to axis word lengths

	
	add $t5, $t7, $t5 # relative to the player's current pos
	
	lw $t6, 4($t1) # get right border
	sll $t6, $t6, 2 # convert to axis word lengths
	add $t6, $t7, $t6  # relative to the player's current pos
	
	bge $t5, $t0, player_unit_end_loop_iteration # if left border > unit, end iteration
	ble $t6, $t0, player_unit_end_loop_iteration # if right border < unit, end iteration
	
	j player_unit_has_collision # otherwise there is a collision
		
player_unit_end_loop_iteration:
	addi $t3, $t3, 1 # count up
	addi $t1, $t1, 8 # iterate to next tuple in array. 
	bne $t3, $t2, player_unit_check_collision_loop	
player_unit_check_collision_end:
	sw $zero, 0($sp)
	jr $ra
player_unit_has_collision:	
	li $t0, 1 #  set true/false constants
	sw $t0, 0($sp)
	jr $ra
	
	
key_new_bubble:

	la $t0, player_movement
	lw $t1, PLAYER_MOVEMENT_IS_BUBBLE($t0) # if player is currently activating a bubble
	bnez $t1, return_from_key_direction # dont create new bubble
	la $t2, player
	lb $t1, PLAYER_NUM_BUBBLES($t2)
	beqz $t1, return_from_key_direction # player has no more bubbles
	
	# create new bubble
	li $t3, BUBBLE_TIMER_COUNT # start the counter from the top
	sw $t3, PLAYER_MOVEMENT_BUBBLE_COUNT($t0)
	li $31, 1 
	sw $t3, PLAYER_MOVEMENT_IS_BUBBLE($t0) # set is bubble to true
	
	subi $t1, $t1, 1 # count down num of bubbles left
	sb $t1, PLAYER_NUM_BUBBLES($t2)  # store new num of bubbles
	
	# erase the mini bubble
	la $s0, bubble_mini_box
	li $s1, BACKGROUND_COLOUR
	li $s2, BUBBLE_MINI_START_POSITION # also as current pointer
	
	la $s3, player 

	li $s6, BUBBLE_MINI_SPACING_HORIZONTAL # the spacing between hearts
	sll $s6, $s6, 2 # multiply spacing by 4 for word length
	
	mult $t1, $s6 # mult num bubbles  by num spacing
	mflo $t3 # the position to erase
	add $t3, $s2, $t3 # add relative position to erase to bubble start position

	# draw the erase
	subi $sp, $sp, 16 # create space in the stack
	sw $t3, 12($sp) # object offset
	sw $s5, 8($sp) # num to draw
	sw $s0, 4($sp) # positions
	sw $s1, 0($sp) # colour to draw		
	
	jal draw_object_positions_list	
	
		
	j return_from_key_direction

check_round_status:

	#  check player health
	la $t0, player
	lb $t1, PLAYER_HEALTH($t0)
	beqz $t1, game_over # player has no more health so game over

	# check the number of snails still not eaten
	la $t0, snails
	lw $t1, SNAILS_NUM($t0) # get total number of snails, also counter
	
check_round_status_snails:
	lb $t2, SNAILS_EATEN($t0) # get whether or not the snail was eaten
	beqz $t2, check_round_status_not_done
	subi $t1, $t1, 1 # count down
	addi $t0, $t0, 8 # iterate to the next snail
	
	bnez $t1, check_round_status_snails # if not all snails checked, keep going
	
	
	j next_round # otherwise, all snails have been eaten which means move to the next round
	
check_round_status_not_done:
	jr $ra
	
	
# set up for the next round
next_round:
	la $t0, player_movement
	sb $zero, PLAYER_MOVEMENT_IS_BUBBLE($t0)  # remove bubble
	la $t0, game_data # get game data
	lb $t1, GAME_DATA_ROUND_NUM($t0) # get the current round number
	bne $t1, GAME_NUM_ROUNDS, update_round# not end of rounds, increment tothe next
next_round_is_game_over: # reached max num rounds, which means the game is won
	li $t2, 1
	sb $t2, GAME_DATA_WIN_LOSE($t0) # set game to won!
	j game_over
update_round:
	addi $t1, $t1, 1 # add + 1 for the next round
	sb $t1, GAME_DATA_ROUND_NUM($t0) # get the current round number
	j new_round
	
	
game_over:
	jal draw_background # cover the screen
	la $t0, game_data
	lb $t0, GAME_DATA_WIN_LOSE($t0) # get whether the game is won or lost
	beqz $t0, 	draw_game_over_lose_screen # game is lost, draw lose screen
	# otherwise, draw win screen
draw_game_over_win_screen:
	# draw the face
	li $t0, END_SCREEN_FACE_POSITION 
	li $t3, WIN_FACE_NUM
	la $t4, win_face_box
	li $t5, PLAYER_COLOUR_WHITE 
	subi $sp, $sp, 16 # create space in the stack
	sw $t0, 12($sp) # object offset
	sw $t3, 8($sp) # num to draw
	sw $t4, 4($sp) # positions
	sw $t5, 0($sp) # colour to draw	
	
	jal draw_object_positions_list
	
	# draw the word
	li $t0, END_SCREEN_WORD_POSITION 
	li $t3, WIN_WORD_NUM
	la $t4, win_word_box
	li $t5, PLAYER_COLOUR_WHITE 
	subi $sp, $sp, 16 # create space in the stack
	sw $t0, 12($sp) # object offset
	sw $t3, 8($sp) # num to draw
	sw $t4, 4($sp) # positions
	sw $t5, 0($sp) # colour to draw	
	
	jal draw_object_positions_list
	
	j end
	
draw_game_over_lose_screen:
	# draw the face
	li $t0, END_SCREEN_FACE_POSITION 
	li $t3, LOSE_FACE_NUM
	la $t4, lose_face_box
	li $t5, PLAYER_COLOUR_WHITE
	subi $sp, $sp, 16 # create space in the stack
	sw $t0, 12($sp) # object offset
	sw $t3, 8($sp) # num to draw
	sw $t4, 4($sp) # positions
	sw $t5, 0($sp) # colour to draw	
	
	jal draw_object_positions_list
	
	# draw the word
	li $t0, END_SCREEN_WORD_POSITION 
	li $t3, LOSE_WORD_NUM
	la $t4, lose_word_box
	li $t5, PLAYER_COLOUR_WHITE 
	subi $sp, $sp, 16 # create space in the stack
	sw $t0, 12($sp) # object offset
	sw $t3, 8($sp) # num to draw
	sw $t4, 4($sp) # positions
	sw $t5, 0($sp) # colour to draw	
	
	jal draw_object_positions_list
	j end
		
draw_background:
	li $t0, 65536 # draw up until 512 * 128
	li $t1, BASE_ADDRESS # begin drawing at base address
	add $t0, $t1, $t0 # ground height offset + base address
	li $t2, BACKGROUND_COLOUR 
	
draw_background_loop:
	sw $t2, 0($t1) # colour the unit
	addi $t1, $t1, 4 # move to the next unit
	blt $t1, $t0, draw_background_loop
	jr $ra
	
draw_round_numbers:
	subi $sp, $sp, 4
	sw $ra, 0($sp) # store return address
	
	
	li $t0, ROUND_NUMBER_START_POSITION
	
	la $t1, game_data
	lb $t1,  GAME_DATA_ROUND_NUM($t1) # get current round number
	subi $t1, $t1, 1 # subtract 1 since we are adding offset to address
	
	la $s2,  round_numbers
	li $t3, 8 # get the position of current num
	mult $t3, $t1
	mflo $t3
	
	add $t4, $s2, $t3 # find the number info stored
	
	lw $t5, 0($t4) # get box of number
	lw $t6, 4($t4) # get num
		
	# draw the numerator
	li $t7, PLAYER_COLOUR_WHITE
	subi $sp, $sp, 16 # create space in the stack
	sw $t0, 12($sp) # object offset
	sw $t6, 8($sp) # num to draw
	sw $t5, 4($sp) # positions
	sw $t7, 0($sp) # colour to draw		
	jal draw_object_positions_list
	
	li $t0, ROUND_NUMBER_START_POSITION
	addi $t0, $t0, 20 # shift drawing position horiztonally
	addi $t0, $t0, VERTICAL_DIST # shift drawing position vertically
	
	# draw the bracket 
	li $t6, NUMBER_BRACKET_NUM
	la $t5, number_bracket_box
	li $t7, PLAYER_COLOUR_WHITE
	subi $sp, $sp, 16 # create space in the stack
	sw $t0, 12($sp) # object offset
	sw $t6, 8($sp) # num to draw
	sw $t5, 4($sp) # positions
	sw $t7, 0($sp) # colour to draw		
	jal draw_object_positions_list
	
	
	li $t0, ROUND_NUMBER_START_POSITION
	addi $t0, $t0, 40 # shift drawing position horiztonally
	addi $t0, $t0, VERTICAL_DIST # shift drawing position vertically
	addi $t0, $t0, VERTICAL_DIST # shift drawing position vertically
	
	# draw the denominator 
	li $t6, NUMBER_THREE_NUM
	la $t5, number_three_box
	li $t7, PLAYER_COLOUR_WHITE
	subi $sp, $sp, 16 # create space in the stack
	sw $t0, 12($sp) # object offset
	sw $t6, 8($sp) # num to draw
	sw $t5, 4($sp) # positions
	sw $t7, 0($sp) # colour to draw		
	jal draw_object_positions_list	
	
	lw $ra, 0($sp) # pop return address
	addi $sp, $sp, 4
	jr $ra
		
print_str:
	addi $v0, $zero, 4
	syscall
	jr $ra	
print_int:
	addi $v0, $zero, 1
	syscall
	jr $ra	
print_float:
	addi $v0, $zero, 2
	syscall
	jr $ra
end:	
li $v0, 10 # terminate the program gracefully
syscall
