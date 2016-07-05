//V3.

module aligator (CLOCK_50, KEY,
VGA_CLK,   						//	VGA Clock
		VGA_HS,							//	VGA H_SYNC
		VGA_VS,							//	VGA V_SYNC
		VGA_BLANK_N,						//	VGA BLANK
		VGA_SYNC_N,						//	VGA SYNC
		VGA_R,   						//	VGA Red[9:0]
		VGA_G,	 						//	VGA Green[9:0]
		VGA_B, SW, HEX0, HEX1, HEX2,HEX3,  HEX4, HEX5, LEDR);

input CLOCK_50;
input [3:0] KEY;
input [9:0] SW;
output [6:0] HEX0, HEX1, HEX2,HEX3,  HEX4, HEX5;
output [9:0] LEDR;

output [9:0] VGA_R;
	output [9:0] VGA_G;
	output [9:0] VGA_B;
	output VGA_HS;
	output VGA_VS;
	output VGA_BLANK_N;
	output VGA_SYNC_N;
	output VGA_CLK;

wire resetn, close;
wire [2:0] q1, q2, q3, q4, q5, q, q6, q7,q8,q9,q10, q11,q13, backgroundColour, gameOver;
wire[2:0] levelUpColour;
reg [2:0] q12;
reg [12:0] i;

wire [2:0] zero, one, two, three, four, five, six, seven, eight, nine;

wire [2:0] meat;

reg [14:0] i1, i3, i5;

reg [8:0] i2;

reg [7:0] i4;

wire [2:0]bomb;

assign close = ~KEY[1];
assign resetn = KEY[0];


alligator xxx1(
	i,
	CLOCK_50,
	0,
	0,
	q1
	);
	
alligatorclose yyy1(
	i,
	CLOCK_50,
	0,
	0,
	q2);
	
background b1(
	i1,
	CLOCK_50,
	0,
	0,
	q4);
	
meat meat1(
	i2,
	CLOCK_50,
	0,
	0,
	meat);	
	
bomb bomb1(
	i2,
	CLOCK_50,
	0,
	0,
	bomb);
	
background b2(
	i3,
	CLOCK_50,
	0,
	0,
	backgroundColour);
	
game_over qwerty(
	i3,
	CLOCK_50,
	0,
	0,
	gameOver);

zero	_zero(
	i4,
	CLOCK_50,
	0,
	0,
	zero);
	
one _one(
	i4,
	CLOCK_50,
	0,
	0,
	one);
two _two(
	i4,
	CLOCK_50,
	0,
	0,
	two);
three _three(
	i4,
	CLOCK_50,
	0,
	0,
	three);
four _four(
	i4,
	CLOCK_50,
	0,
	0,
	four);
five _five(
	i4,
	CLOCK_50,
	0,
	0,
	five);
six _six(
	i4,
	CLOCK_50,
	0,
	0,
	six);
seven _seven(
	i4,
	CLOCK_50,
	0,
	0,
	seven);
eight _eight(
	i4,
	CLOCK_50,
	0,
	0,
	eight);
nine _nine(
	i4,
	CLOCK_50,
	0,
	0,
	nine);
	
LevelUp2 b55(
	i5,
	CLOCK_50,
	0,
	0,
	levelUpColour);
	
	


	
vga_adapter VGA(
			.resetn(resetn),
			.clock(CLOCK_50),
			.colour(q),
			.x(x),
			.y(y),
			.plot(plot),
			/* Signals for the DAC to drive the monitor. */
			.VGA_R(VGA_R),
			.VGA_G(VGA_G),
			.VGA_B(VGA_B),
			.VGA_HS(VGA_HS),
			.VGA_VS(VGA_VS),
			.VGA_BLANK_N(VGA_BLANK_N),
			.VGA_SYNC_N(VGA_SYNC_N),
			.VGA_CLK(VGA_CLK));
		defparam VGA.RESOLUTION = "160x120";
		defparam VGA.MONOCHROME = "FALSE";
		defparam VGA.BITS_PER_COLOUR_CHANNEL = 1;
		defparam VGA.BACKGROUND_IMAGE = "game_title.mif";
		
		
		
	  reg [8:0] xCounter;
	  reg [7:0] yCounter;
	  reg [8:0] xCounter1, xPointCounter;
	  reg [7:0] yCounter1, yPointCounter;
	  reg [8:0] initXpos2; 
	  reg [7:0] initYpos2;
	  
	  	HEXDisplay z0(meatMove, HEX0);
		HEXDisplay z1(o1, HEX1);
		HEXDisplay z2(o2, HEX2);
		
		HEXDisplay z3(point, HEX3);
		
		HEXDisplay z4(rng_1, HEX4);
		HEXDisplay z5(rng_2, HEX5);
	  
	  //alligator
	  always @ (posedge CLOCK_50) begin
			if (resetN) begin
				xCounter <= 0;
				yCounter <= 0;
				i <= 0;
			end
			else if (xCounter == 69 && counterEnable) begin
				xCounter <= 0;
				yCounter <= yCounter + 1;
				i <= i + 1;
			end
			else if (counterEnable) begin
				xCounter <= xCounter + 1;
				i <= i + 1;
			end
		
		end
		
		always @ (posedge CLOCK_50) begin
			if (resetN) begin
				i1 <= 8800 - 1;
			end
			else if (xCounter == 69 && counterEnable) begin
				i1 <= i1 + 90;
			end
			else if (counterEnable) begin
				i1 <= i1 + 1;
				
			end
		
		end
		
		//meat
		 always @ (posedge CLOCK_50) begin
			if (resetN) begin
				xCounter1 <= 0;
				yCounter1 <= 0;
				i2 <= 0;
			end
			else if (xCounter1 == 19 && drawMeatCounter) begin
				xCounter1 <= 0;
				yCounter1 <= yCounter1 + 1;
				i2 <= i2 + 1;
			end
			else if (drawMeatCounter) begin
				xCounter1 <= xCounter1 + 1;
				i2 <= i2 + 1;
			end
		
		end
		
		reg [8:0] xCounter2;
	   reg [7:0] yCounter2;
		
		always @ (posedge CLOCK_50) begin
			if (resetN) begin
				xCounter2 <= 0;
				yCounter2 <= 0;
				i3 <= 0;
				i5 <= 0;
			end
			else if (xCounter2 == 159 && counterBack) begin
				xCounter2 <= 0;
				yCounter2 <= yCounter2 + 1;
				i3 <= i3 + 1;
				i5 <= i5 + 1;
			end
			else if (counterBack) begin
				xCounter2 <= xCounter2 + 1;
				i3 <= i3 + 1;
				i5 <= i5 + 1;
			end
		
		end
		
		// point counter
		
		always @ (posedge CLOCK_50) begin
			if (resetPointDisplay) begin
				xPointCounter <= 0;
				yPointCounter <= 0;
				i4 <= 0;
			end
			else if (xPointCounter == 9 && drawPoint) begin
				xPointCounter <= 0;
				yPointCounter <= yPointCounter + 1;
				i4 <= i4 + 1;
			end
			else if (drawPoint) begin
				xPointCounter <= xPointCounter + 1;
				i4 <= i4 + 1;
			end
		end
			
		
		parameter initialXposition = 0, initialYposition = 55;
		parameter [2:0] blue = 3'b001;
		
		wire [8:0] x, x1, x2;
		wire [7:0] y, y1, y2;
		
		reg [8:0] xDrawPoint;
		reg [7:0] yDrawPoint;
		
//MUX ----------------------------------------------------------------------------------------------
		multiplexer2to1 m1 (q1, q2, closeMouth, q3);//draw closed or open mouth
		
		multiplexer2to1 m2 (q3, q4, drawCloseEnable, q5); // draw alligator or background
		
		multiplexer2to1 m7 (q7, blue, selectBlue, q6); //draws item or draws blue
		
		multiplexer2to1 m5 (q5, q6, drawMeatEnable, q8); //draws meat or alligator
		
		multiplexer2to1 m8 (bomb, meat, item, q7); // draws meat or bomb
		
		multiplexer2to1 m11 (q8, backgroundColour, counterBack, q9); //draws sprite or background
		
		//draws the item (meat or mine) at a specific position
		multiplexer2to1 m3 (initialXposition + xCounter, initXpos2 + xCounter1, drawMeatEnable, x1);
		multiplexer2to1 m4 (initialYposition + yCounter, initYpos2 + yCounter1, drawMeatEnable, y1);
		
		//mux decides whether the item or the background will be drawn
		//this is necessary for the animation because we need to draw
		//and erase the item every time
		multiplexer2to1 m9 ( x1, xCounter2, counterBack, x2);
		multiplexer2to1 m10 (y1, yCounter2, counterBack, y2);
		
		//draws the scoreboard on the screen
		multiplexer2to1 m14 (x2, xDrawPoint + xPointCounter, drawPoint, x);
		multiplexer2to1 m15 (y2, yDrawPoint + yPointCounter, drawPoint, y);
		
		//draws the game over screen
		multiplexer2to1 m12 (q9, gameOver, drawOver, q10);

		//used to decided which mif file will be used 
		multiplexer10to1 m13 (zero, one, two, three, four, five, six, seven, eight, nine, point, q11);

		//decides whether the points or the background will be drawn
		multiplexer2to1 m16 (q10, q12, drawPoint, q13);

		//draws the level up screen
		multiplexer2to1 m17 (q13, levelUpColour, levelUpEnable, q);
//END OF MUX ----------------------------------------------------------------------------------------
		
		//assign x = initialXposition + xCounter;
		//assign y = initialYposition + yCounter;
		
		
// ----------------------------------------------------------------------------------------------	
//ANIMATION ----------------------------------------------------------------------------------------
// ----------------------------------------------------------------------------------------------	


//NOTES: ANIMATION IS 250HZ (MOVES 200 PIXELS PER SECOND)
		parameter fps = 1000000 - 1; // 50 HZ CLOCK
		parameter _10Hz = 5000000-1;
		wire meatMoveEn, _10HzClock;
		RateDivider meatmove111(CLOCK_50, meatMoveEn, ~resetMove, fps); //set enable to be 1 for now; change in state path later
		RateDivider _10HZ (CLOCK_50, _10HzClock, KEY[0], _10Hz);	
		
		wire [8:0] meatMove;				
		reg resetMove;		
		reg moveItem;
		
		
		//INITIALIZE THE ITEM POSITION
	
		 always @ (posedge CLOCK_50) begin

//				if (resetMove) begin
//					
//					initXpos2 <= 160; 
//					initYpos2 <= 75;
//				end
//				else if (initXpos2 <= 40) // ORIGINAL IS 60
//					initXpos2 <= 160;
//				else if (updateMeat) begin
//					initXpos2 <= initXpos2 - 6; 
//					//initYpos2 <= initYpos2 - meatMove;
//				end

				if (point > 4) begin
					if (resetMove) begin
						initXpos2 <= 140; 
						initYpos2 <= 75;
					end
					
					else if (initXpos2 <= 40) // ORIGINAL IS 60
						initXpos2 <= 140;
					else if (updateMeat) begin
						initXpos2 <= initXpos2 - 10; 
						//initYpos2 <= initYpos2 - meatMove;
					end
				end
				//else if (point == 5 && a2 == 0 && a1 == )
					
				else begin
					if (resetMove) begin
						initXpos2 <= 140; 
						initYpos2 <= 75;
					end
					else if (initXpos2 <= 40) // ORIGINAL IS 60
						initXpos2 <= 140;
					else if (updateMeat) begin
						initXpos2 <= initXpos2 - 5; 
						//initYpos2 <= initYpos2 - meatMove;
					end
				end
				
				

//				if (resetMove) begin
//					initXpos2 <= 120; 
//					initYpos2 <= 75;
//				end
//				else if (initXpos2 <= 40) // ORIGINAL IS 60
//					initXpos2 <= 120;
//				else if (updateMeat) begin
//					initXpos2 <= initXpos2 - 4; 
//					//initYpos2 <= initYpos2 - meatMove;
//				end

		end	
		
		
		
		
		//START MOVING THE OBJECT 0.4 SECONDS BEFORE THE RNG 
		always @ (posedge _10HzClock) begin
			//if (rng_1 >= 8) begin
			if (point > 4)begin
				if (a2 == rng_2 && a1 >= rng_1 - 3 && a1 < rng_1 -1)
					moveItem <= 1;
				else
					moveItem <= 0;
			end
			else begin
				if (a2 == rng_2 && a1 >= rng_1 - 5 && a1 < rng_1 -1)
					moveItem <= 1;
				else
					moveItem <= 0;
			end
			
//			else if ((rng_1 <= 7)) begin
//				if (a2 == rng_2 && a1 >= rng_1 - 2 && a1 < rng_1 + 2)
//					moveItem <= 1;
//				else
//					moveItem <= 0;
//				end
			//else
				//moveItem <= 0;
		end
		
		reg lvlUpDrawn;
		
		always @ (posedge CLOCK_50) begin
			if (resetLvl)
				lvlUpDrawn <= 0;
			else if (levelUpEnable)
				lvlUpDrawn <= 1;
				
		end
				
	

	
		
//STATE PATH ----------------------------------------------------------------------------------------
		reg [20:0] currentState, nextState;
		reg resetN, counterEnable, plot, closeMouth, drawCloseEnable, drawMeatEnable, drawMeatCounter, selectBlue, updateMeat, counterBack, drawOver, drawPoint, resetPointDisplay, levelUpEnable, resetLvl;
		parameter [20:0] reset_S = 21'b000000000000000000001, drawState = 21'b000000000000000000010, hold_S = 21'b000000000000000000100, drawClose_S = 21'b000000000000000001000, drawBack_S = 21'b000000000000000010000, hold2_S = 21'b000000000000000100000, resetdraw_S = 21'b000000000000001000000, resetclose_S = 21'b000000000000010000000, drawMeat_S = 21'b000000000000100000000, drawBlue_S = 21'b000000000001000000000, resetBlue_S = 21'b000000000010000000000, update_S = 21'b000000000100000000000, holdItem_S = 21'b000000001000000000000, redrawBack_S = 21'b000000010000000000000, drawBack2_S = 21'b000000100000000000000, gameOver_S = 21'b000001000000000000000, drawpoint_S = 21'b000010000000000000000, printPoint_S = 21'b000100000000000000000, levelUp_S = 21'b001000000000000000000, holdLevelUp_S = 21'b010000000000000000000;
		
		always @(*) 
			begin: state_table
			case (currentState)
				reset_S: begin
					if (~KEY[2])
						nextState = redrawBack_S;
					else
						nextState = reset_S;
				end
				redrawBack_S: begin
					if (dead)
						nextState = gameOver_S;
					else if (xCounter2 == 159 && yCounter2 == 119)
						nextState = drawState;
					else	
						nextState = redrawBack_S;
				end
				
				
				drawState: begin
					if (dead)
						nextState = gameOver_S;
					else if (xCounter == 69 && yCounter == 59) begin
//						if (a2 == rng_2 && a1 <= (rng_1) && a1 >= rng_1 -5) 
//							nextState = drawMeat_S;
//						else if (a2 > rng_2 && a1 > rng_1 )
							nextState = drawpoint_S;
							//nextState = hold_S;
//						 else 
//							nextState = holdItem_S; 
					end
				
					else
					
						nextState = drawState;
				end
				
				holdItem_S: begin
					if (dead)
						nextState = gameOver_S;
					else if (a2 == rng_2 && a1 == rng_1 - 4)
						nextState = hold_S;
					else
						nextState = holdItem_S;
				end 
						
				
				
				hold_S: 
//					if (a2 == 1 && a1 == 9 && a0 == 9)
//						nextState = drawBack2_S;
					if (dead)
						nextState = gameOver_S;
					else if (meatMoveEn && moveItem)
						nextState = drawBlue_S;
					else if (close)
						nextState = drawBack_S;
					else
						nextState = hold_S;
				drawClose_S: begin
					if (dead)
						nextState = gameOver_S;
					else if (xCounter == 69 && yCounter == 59) begin
						//nextState = hold2_S;
//						 if (a2 == rng_2 && a1 <= (rng_1) && a1 >= rng_1 -5) 
//							nextState = drawMeat_S;
//						 else if (a2 > rng_2 && a1 > rng_1 )
							
						nextState = drawpoint_S;
//						 else 
//							nextState = holdItem_S; 
					end
					else
						nextState = drawClose_S;
					end
				drawBack_S: begin
					if (dead)
						nextState = gameOver_S;
					else if (xCounter == 69 && yCounter == 59 && !close)
						nextState = resetdraw_S;
					else if (xCounter == 69 && yCounter == 59 && close)
						nextState = resetclose_S;
					else
						nextState = drawBack_S;
				end
				hold2_S: begin
					if (dead)
						nextState = gameOver_S;
//					if (a2 == 1 && a1 == 9 && a0 == 9)
//						nextState = drawBack2_S;
					else if (meatMoveEn && moveItem)
						nextState = drawBlue_S;
					else if (!close)
						nextState = drawBack_S;
					else
						nextState = hold2_S;
				end
				drawMeat_S: begin
//					if (a2 == 1 && a1 == 9 && a0 == 9)
//						nextState = drawBack2_S;
					if (dead)
						nextState = gameOver_S;
					else if (!close && xCounter1 == 19 && yCounter1 == 19)
						nextState = hold_S;
					else if (close && xCounter1 == 19 && yCounter1 == 19)
						nextState = hold2_S;
					else 
						nextState = drawMeat_S;
				end
				drawBack2_S: begin
					if (dead)
						nextState = gameOver_S;
					else if (xCounter == 69 && yCounter == 29)
						nextState = resetdraw_S;
					else
						nextState = drawBack_S;
				end
				
				resetdraw_S: nextState = drawState;
				resetclose_S: nextState = drawClose_S;
				update_S: nextState = drawMeat_S;
				drawBlue_S: begin
					if (dead)
						nextState = gameOver_S;
					else if (xCounter1 == 19 && yCounter1 == 19)
						nextState = update_S;
					else
						nextState = drawBlue_S;
				end
				gameOver_S:  begin
					if (xCounter2 == 159 && yCounter2 == 119)
						nextState = printPoint_S;
					else	
						nextState = gameOver_S;
				end
				drawpoint_S: begin
					if (point == 5 && !lvlUpDrawn)
						nextState = levelUp_S;
					else if (!close && xPointCounter == 9 && yPointCounter == 14)
						nextState = hold_S;
					else if (close && xPointCounter == 9 && yPointCounter == 14)
						nextState = hold2_S;
					else
						nextState = drawpoint_S;
				end
				printPoint_S: begin 
					if (xPointCounter == 9 && yPointCounter == 14)
						nextState = reset_S;
					else
						nextState = printPoint_S;
				end
				levelUp_S: begin

					if (xCounter2 == 159 && yCounter2 == 119)
						nextState = holdLevelUp_S;
					else	
						nextState = levelUp_S;
				end
				
				holdLevelUp_S: begin
					if (a2 == 1 && a1 == 9)
						nextState = redrawBack_S; 
					else
						nextState = holdLevelUp_S;
				end
						
				default:
					nextState = reset_S;
			endcase
		end
		
		
		
		always @(*) begin
			case (currentState)
			reset_S: begin
				resetN = 1;
				counterEnable = 0;
				plot = 0;
				closeMouth = 0;
				drawCloseEnable = 1;
				drawMeatEnable = 0;
				drawMeatCounter = 0;
				resetMove = 1;
				selectBlue = 0;
				updateMeat = 0;
				counterBack = 0;
				drawOver = 0;
				drawPoint = 0;
				resetPointDisplay = 1;
				xDrawPoint = 0;
				yDrawPoint = 0;
				q12 = 0;
				levelUpEnable = 0;
				resetLvl = 1;
			end
			redrawBack_S: begin
				resetN = 0;
				counterEnable = 0;
				plot = 1;
				closeMouth = 0;
				drawCloseEnable = 0;
				drawMeatEnable = 0;
				drawMeatCounter = 0;
				resetMove = 1;
				selectBlue = 0;
				updateMeat = 0;
				counterBack = 1;
				drawOver = 0;
				drawPoint = 0;
				xDrawPoint = 0;
				yDrawPoint = 0;
				resetPointDisplay = 1;
				q12 = q11;
				levelUpEnable = 0;
				resetLvl = 0;
			end
			
			drawState: begin
				resetN = 0;
				counterEnable = 1;
				if (q == 3'b111)
					plot = 0;
				else
					plot = 1;
				closeMouth = 0;
				drawCloseEnable = 0;
				drawMeatEnable = 0;
				drawMeatCounter = 0;
				resetMove = 0;
				selectBlue = 0;
				updateMeat = 0;
				counterBack = 0;
				drawOver = 0;
				drawPoint = 0;
				xDrawPoint = 0;
				yDrawPoint = 0;
				resetPointDisplay = 1;
				q12 = q11;
				levelUpEnable = 0;
				resetLvl = 0;
			end
			hold_S: begin
				resetN = 1;
				counterEnable = 0;
				plot = 0;
				closeMouth = 0;
				drawCloseEnable = 0;
				drawMeatEnable = 0;
				drawMeatCounter = 0;
				resetMove = 0;
				selectBlue = 0;
				updateMeat = 0;
				counterBack = 0;
				drawOver = 0;
				xDrawPoint = 0;
				yDrawPoint = 0;
				drawPoint = 0;
				resetPointDisplay = 1;
				levelUpEnable = 0;
				q12 = 0;
				resetLvl = 0;
			end
			drawClose_S: begin
				resetN = 0;
				counterEnable = 1;
				if (q == 3'b111)
					plot = 0;
				else
					plot = 1;
				closeMouth = 1;
				drawCloseEnable = 0;
				drawMeatEnable = 0;
				drawMeatCounter = 0;
				resetMove = 0;
				selectBlue = 0;
				updateMeat = 0;
				counterBack = 0;
				drawOver = 0;
				xDrawPoint = 0;
				yDrawPoint = 0;
				drawPoint = 0;
				resetPointDisplay = 1;
				levelUpEnable = 0;
				resetLvl = 0;
				q12 = 0;
			end
			drawBack_S: begin
				resetN = 0;
				counterEnable = 1;
				plot = 1;
				closeMouth = 1;
				drawCloseEnable = 1;
				drawMeatEnable = 0;
				drawMeatCounter = 0;
				resetMove = 0;
				selectBlue = 0;
				updateMeat = 0;
				counterBack = 0;
				drawOver = 0;
				xDrawPoint = 0;
				yDrawPoint = 0;
				drawPoint = 0;
				resetPointDisplay = 1;
				levelUpEnable = 0;
				resetLvl = 0;
				q12 = 0;
			end
			hold2_S: begin
				resetN = 1;
				counterEnable = 0;
				plot = 0;
				closeMouth = 0;
				drawCloseEnable = 0;
				drawMeatEnable = 0;
				drawMeatCounter = 0;
				resetMove = 0;
				selectBlue = 0;
				updateMeat = 0;
				counterBack = 0;
				xDrawPoint = 0;
				yDrawPoint = 0;
				drawOver = 0;
				drawPoint = 0;
				resetPointDisplay = 1;
				levelUpEnable = 0;
				resetLvl = 0;
				q12 = 0;
			end
			resetdraw_S:begin
				resetN = 1;
				counterEnable = 0;
				plot = 0;
				closeMouth = 0;
				drawCloseEnable = 0;
				drawMeatEnable = 0;
				drawMeatCounter = 0;
				resetMove = 0;
				selectBlue = 0;
				updateMeat = 0;
				xDrawPoint = 0;
				yDrawPoint = 0;
				counterBack = 0;
				drawOver = 0;
				drawPoint = 0;
				resetPointDisplay = 1;
				levelUpEnable = 0;
				resetLvl = 0;
				q12 = 0;
			end
			resetclose_S:begin
				resetN = 1;
				counterEnable = 0;
				plot = 0;
				closeMouth = 0;
				drawCloseEnable = 0;
				drawMeatEnable = 0;
				drawMeatCounter = 0;
				resetMove = 0;
				selectBlue = 0;
				xDrawPoint = 0;
				yDrawPoint = 0;
				updateMeat = 0;
				counterBack = 0;
				drawOver = 0;
				drawPoint = 0;
				resetPointDisplay = 1;
				levelUpEnable = 0;
				resetLvl = 0;
				q12 = 0;
			end
			drawMeat_S: begin
				resetN = 0;
				counterEnable = 0;
				if (q == 3'b111)
					plot = 0;
					//plot = 1;
				else
					plot = 1;
				closeMouth = 0;
				drawCloseEnable = 0;
				drawMeatEnable = 1;
				drawMeatCounter = 1;
				resetMove = 0;
				selectBlue = 0;
				updateMeat = 0;
				counterBack = 0;
				drawOver = 0;
				xDrawPoint = 0;
				yDrawPoint = 0;
				drawPoint = 0;
				resetPointDisplay = 1;
				levelUpEnable = 0;
				resetLvl = 0;
				q12 = 0;
			end
			drawBlue_S: begin
				resetN = 0;
				counterEnable = 0;
				plot = 1;
				closeMouth = 0;
				drawCloseEnable = 0;
				drawMeatEnable = 1;
				drawMeatCounter = 1;
				resetMove = 0;
				selectBlue = 1;
				updateMeat = 0;
				counterBack = 0;
				drawOver = 0;
				xDrawPoint = 0;
				yDrawPoint = 0;
				drawPoint = 0;
				resetPointDisplay = 1;
				levelUpEnable = 0;
				resetLvl = 0;
				q12 = 0;
			end
//			resetBlue_S:begin
//				resetN = 1;
//				counterEnable = 0;
//				plot = 0;
//				closeMouth = 0;
//				drawCloseEnable = 0;
//				drawMeatEnable = 0;
//				drawMeatCounter = 0;
//				resetMove = 0;
//				selectBlue = 0;
//			end
			update_S: begin
				resetN = 1;
				counterEnable = 0;
				plot = 0;
				closeMouth = 0;
				drawCloseEnable = 0;
				drawMeatEnable = 0;
				drawMeatCounter = 0;
				resetMove = 0;
				selectBlue = 0;
				updateMeat = 1;
				counterBack = 0;
				drawOver = 0;
				xDrawPoint = 0;
				yDrawPoint = 0;
				drawPoint = 0;
				resetPointDisplay = 1;
				levelUpEnable = 0;
				resetLvl = 0;
				q12 = 0;
			end
			printPoint_S: begin
				resetN = 0;
				counterEnable = 1;
				plot = 1;
				closeMouth = 1;
				drawCloseEnable = 1;
				drawMeatEnable = 0;
				drawMeatCounter = 0;
				resetMove = 0;
				selectBlue = 0;
				counterBack = 0;
				drawOver = 0;
				updateMeat = 0;
				drawPoint = 1;
				resetPointDisplay = 0;
				xDrawPoint = 80;
				yDrawPoint = 44;
				if (q11 == 3'b000)
					q12 = 3'b001;
				else
					q12 = 3'b000;
				levelUpEnable = 0;
				resetLvl = 0;
			end		
			
			drawBack2_S: begin
				resetN = 0;
				counterEnable = 1;
				plot = 1;
				closeMouth = 1;
				drawCloseEnable = 1;
				drawMeatEnable = 0;
				drawMeatCounter = 0;
				resetMove = 0;
				selectBlue = 0;
				counterBack = 0;
				drawOver = 0;
				xDrawPoint = 0;
				yDrawPoint = 0;
				drawPoint = 0;
				updateMeat = 0;
				resetPointDisplay = 1;
				levelUpEnable = 0;
				resetLvl = 0;
				q12 = 0;
			end
			
			gameOver_S: begin
				resetN = 0;
				counterEnable = 0;
				plot = 1;
				closeMouth = 0;
				drawCloseEnable = 0;
				drawMeatEnable = 0;
				drawMeatCounter = 0;
				resetMove = 1;
				selectBlue = 0;
				updateMeat = 0;
				counterBack = 1;
				drawOver = 1;
				xDrawPoint = 0;
				yDrawPoint = 0;
				drawPoint = 0;
				resetPointDisplay = 1;
				levelUpEnable = 0;
				resetLvl = 0;
				q12 = 0;
			end
			drawpoint_S: begin
				resetLvl = 0;
				resetN = 0;
				counterEnable = 1;
				plot = 1;
				closeMouth = 1;
				drawCloseEnable = 1;
				drawMeatEnable = 0;
				drawMeatCounter = 0;
				resetMove = 0;
				selectBlue = 0;
				counterBack = 0;
				drawOver = 0;
				xDrawPoint = 0;
				yDrawPoint = 0;
				updateMeat = 0;
				drawPoint = 1;
				resetPointDisplay = 0;
				xDrawPoint = 5;
				yDrawPoint = 5;
				q12 = q11;
				levelUpEnable = 0;
			end
			levelUp_S: begin
				resetLvl = 0;
				resetN = 0;
				counterEnable = 0;
				plot = 1;
				closeMouth = 0;
				drawCloseEnable = 0;
				drawMeatEnable = 0;
				drawMeatCounter = 0;
				resetMove = 1;
				selectBlue = 0;
				xDrawPoint = 0;
				yDrawPoint = 0;
				updateMeat = 0;
				counterBack = 1;
				drawOver = 0;
				drawPoint = 0;
				resetPointDisplay = 1;
				levelUpEnable = 1;
				q12 = 0;
			end
			holdLevelUp_S: begin
				resetN = 1;
				resetLvl = 0;
				counterEnable = 0;
				plot = 0;
				closeMouth = 1;
				drawCloseEnable = 0;
				drawMeatEnable = 0;
				drawMeatCounter = 0;
				resetMove = 1;
				selectBlue = 0;
				updateMeat = 0;
				counterBack = 0;
				drawOver = 0;
				drawPoint = 0;
				xDrawPoint = 0;
				yDrawPoint = 0;
				resetPointDisplay = 1;
				q12 = 0;
				levelUpEnable = 0;
			end
			
			
			
			default: begin
				resetN = 1;
				counterEnable = 0;
				plot = 0;
				closeMouth = 1;
				drawCloseEnable = 0;
				drawMeatEnable = 0;
				drawMeatCounter = 0;
				resetMove = 1;
				selectBlue = 0;
				updateMeat = 0;
				counterBack = 0;
				drawOver = 0;
				drawPoint = 0;
				xDrawPoint = 0;
				resetPointDisplay = 1;
				yDrawPoint = 0;
				q12 = 0;
				levelUpEnable = 0;
				resetLvl = 0;
			end
	   endcase
		end
			
		assign LEDR[9] = resetN;
		assign LEDR[8] = counterEnable;
		assign LEDR[7] = plot;
		assign LEDR[6] = counterBack;
		
		assign LEDR[3] = drawCloseEnable;
		assign LEDR[4] = drawMeatEnable;
	
		always @ (posedge CLOCK_50) begin
		if (!resetn) begin
			currentState <= reset_S;
			//nextState <= reset_S;
		end
		else
			currentState <= nextState;
		end


// ----------------------------------------------------------------------------------------------------------------------
//GAME LOGIC ------------------------------------------------------------------------------------------------------------
// ----------------------------------------------------------------------------------------------------------------------
		
	//Store the count speed to do rate division (e.g. 1Hz goes to 50 million)
	//reg [27:0]Speed; 
        
	//Binary that triggers the enable on the clock
	//e.g. after 50 million, the Enable turns to 1 for a 1Hz clock
	wire reset = ~KEY[0];
	wire Reset = SW[0];
	wire masterEnable, slaveEnable;

	//The output in hexadecimal (4-bit output)
	reg [3:0] o0, o1, o2;
	reg [3:0] s0, s1, s2; //storing user reaction
	wire [3:0] a0, a1, a2;
	wire [3:0] h0, h1, h2;
	assign a1 = o1;
	assign a2 = o2;

	//Clock at 50MHz
	parameter Full = 0; //set as constant parameter
	//clock at 1Hz
	parameter Speed = 500000-1; //set to x100 speed
	//clock at 100Hz
	parameter slaveSpeed = 500000 - 1;
	parameter myRandT = 2;
	parameter myRandH = 2;

	
	RateDivider100Hz u2 (CLOCK_50, slaveEnable, KEY[0], Speed);
	RateDivider u1(CLOCK_50, masterEnable, KEY[0], Speed);
	//Set parallel load to 0 (OFF)
	//Start count from 0 (4'b0000)
	counter_displayed c0(CLOCK_50, masterEnable, counterReset, 1'b0, 4'b0000, a0);
	counter_displayed c1(CLOCK_50, slaveEnable, counterReset, 1'b0, 4'b0000, h0);

// ----------------------------------------------------------------------------------------
//make a decimal counter ------------------------------------------------------------------
// ----------------------------------------------------------------------------------------

//storing user input
	always @ (posedge CLOCK_50) //only increase the other digits when the enable signal is on
	begin
		if (counterReset == 0)
		begin
			s2 = 0;
			s1 = 0; 
			s0 = 0;
		end
		else if (~KEY[1])
		begin
			s0 <= o0; //let's store the user reaction in to s0, s1, s2
			s1 <= o1;
			s2 <= o2;
		end
	end
	
	
	always @ (posedge masterEnable) //only increase the other digits when the enable signal is on
	begin
		//o0 = q1;
		if (counterReset == 0) //reset everything, but SW[0] must be off
		begin
			o2 = 0;
			o1 = 0;
			o0 = 0;
			//s0 = 0;
			//s1 = 0; 
			//s2 = 0;
		end
//		else if (~KEY[1])
//		begin
//			s0 <= o0; //let's store the user reaction in to s0, s1, s2
//			s1 <= o1;
//			s2 <= o2;
//		end
		else
		begin
			o0 <= a0;
			if (a0 == 4'd9) //roll over the tens counter
			begin
				o0 <= 0; // first reset the one's digit
				o1 <= o1 + 1; // then increase the tens by 1
			
				if ((a1 == 4'd9) && (a0 == 4'd9))
				begin
					o1 <= 0;
					o2 <= o2 + 1;
				
					if ((a2 == 4'd1) && (a1 == 4'd9) && (a0 == 4'd9)) 
					begin
						o2 <= 0;
						o1 <= 0;
						o0 <= 0;
					end
				end
			end
		end
	end
// ----------------------------------------------------------------------------------------
//end of decimal counter ------------------------------------------------------------------
// ----------------------------------------------------------------------------------------
	

	
	wire go = ~KEY[2]; //go = KEY[1]
	//wire go = ~KEY[1];
// ----------------------------------------------------------------------------------------
//RNG GENERATION --------------------------------------------------------------------------
// ----------------------------------------------------------------------------------------
	//WE'LL USE SOME VARIABLES FROM THE STATE PATH (RNGReset - low reset)
	// 1 bit generator
	wire itemTemp;
	
	reg item;
	
	wire rng_1bit;
	rng r0(CLOCK_50, RNGReset, itemTemp); //1 will be meat, 0 will be rock
	
	// RNG from 0-400
	wire [3:0]rng_0_1, rng_1_1;
	wire [1:0]rng_2_1;
	
	reg [3:0]rng_0, rng_1;
	reg [1:0]rng_2;
	//wire [8:0]rng400_store;
	//rng_400 r1(masterEnable, SW[0], rng400);
	//Reg z0(rng400, 1, CLOCK_50, SW[0], rng400_store);

	rngen_400(CLOCK_50, RNGReset, rng_2_1, rng_1_1, rng_0_1);
	
	always @ (posedge CLOCK_50) begin
		if (!RNGReset)begin
			rng_0 <= 0;
			rng_1 <= 0;
			rng_2 <= 0;
			item <= 0;
		end
		
		else if (RNGEnable) begin
			//rng_0 <= rng_0_1; 
			rng_0 <= 0;
			rng_1 <= rng_1_1;
			rng_2 <= rng_2_1;
			if (point > 8)
				item <= 0;
			else
				item <= itemTemp;
			//item <= 1;
		end
	end
	
	assign LEDR[5] = item;
			

	// OUTPUT RNG ON THE LEDR
	
	// output the timing of when the computer sends meat in
	reg timing;
	
//	always @ (posedge CLOCK_50)
//	begin
//		if ((rng_sec == s2 % 4) && (o1 - rng_tenth < 1 || rng_tenth - o1 < 1))
//			timing <= 1;
//		else
//			timing <= 0;
//	end
//	assign LEDR[0] = timing;

	always @ (posedge CLOCK_50)
	begin
		if ((rng_2 == o2) &&(rng_1 == o1) && (rng_0 == o0))
			timing <= 1;
		else
			timing <= 0;
			
	end
	assign LEDR[0] = timing;

//------------------------------------------------------------------------------------------------------------	
//	GAME CONTROL PATH / FSM
//------------------------------------------------------------------------------------------------------------
	
	parameter [12:0] start_S = 13'b0000000000001, resRateDivide_S = 13'b0000000000010, getRNG_S = 13'b0000000000100, play_S = 13'b0000000001000, hold_SS = 13'b0000000010000, point_S = 13'b0000000100000, loseLife_S = 13'b0000001000000, dead_S = 13'b0000010000000, RNGStart_S = 13'b0000100000000, loseLifeBuffer_S = 13'b0001000000000, pressCheck_S = 13'b0010000000000;
	reg [12:0] CurrState, NextState;

    // control path FSM
    always @(*)
    begin: state_table2
      case (CurrState)
			// Computation will be executed regardless of input signal once in computation state
			//STATE 9
			RNGStart_S: 
				NextState = start_S;
			//STATE 1 
			start_S: //reset state
			begin
				if (KEY[0]) //active low reset
					NextState = resRateDivide_S;
				else
					NextState = start_S;
			end
			//STATE 2
			resRateDivide_S:
			begin
				if (!KEY[0]) //active low reset
					NextState = start_S;
				else if (go)
					NextState = getRNG_S;
				else 
					NextState = resRateDivide_S;
			end
			//STATE 3
			getRNG_S:
			begin
				NextState = play_S;
			end
			//STATE 4
			play_S:
			begin
				if (!KEY[0])
					NextState = start_S;
				else if (!KEY[1])	
					NextState = pressCheck_S;
				//else if (item && (rng_2 == s2) && ~KEY[1] && !((a2 == 1 && a1 == 9))) //if the player gets a point
					//NextState = point_S;
				//else if (!item && (rng_2 == s2) && ~KEY[1] && !((a2 == 1 && a1 == 9))) //if player loses a life
					//NextState = dead_S;
				//else if (!(rng_2 == s2) && ~KEY[1] && !((a2 == 1 && a1 == 9))) //player bites at nothing
					//NextState = loseLifeBuffer_S;
				else if (lifeCount == 0) //life is 0
					NextState = dead_S;
				else if (rng_2 == a2 && rng_1 == a1 && rng_0 == a0)
					NextState = hold_SS;
				else 
					NextState = play_S ;
			end
			//STATE 11
			pressCheck_S:
			begin
				//if (KEY[1]) //if the key is released
				//begin
				//if (item && (rng_2 == s2) && KEY[1] && !((a2 == 1 && a1 == 9)))
				if (item && (s2 == rng_2) && (s1 >= rng_1 - 2) && (s1 < rng_1) && !((a2 == 1 && a1 == 9)))
					NextState = point_S;
				//else if (!item && (rng_2 == s2) && KEY[1] && !((a2 == 1 && a1 == 9))) //if player loses a life
				else if (!item && (s2 == rng_2) && (s1 >= rng_1 - 2) && (s1 < rng_1) && !((a2 == 1 && a1 == 9)))
					NextState = dead_S;
				//end
				else//stay until key is released
					NextState = pressCheck_S;
			end
			//STATE 5
			hold_SS:
			begin
				if (!KEY[0])
					NextState = start_S;
				else if (a2 == 1 && a1 == 9 && a0 == 8)
					NextState = getRNG_S;
				else if (lifeCount == 0) //life is 0
					NextState = dead_S;
				//else if (~KEY[1] && !(rng_2 == s2))
					//NextState = loseLifeBuffer_S;
				else//after 4 seconds
					NextState = hold_SS;
			end
			//STATE 10
			loseLifeBuffer_S: //state to make sure that only one life is lost per wrong press
			begin
				if (KEY[1])
					NextState = loseLife_S;
				else
					NextState = loseLifeBuffer_S;
			end
			//STATE 6
			point_S:
			begin
				NextState = hold_SS; //increase a point here (optional condition KEY[1])
				//include a point hold state if we want to decrease a life
			end
			//STATE 7
			loseLife_S:
			begin
				NextState = play_S; //decrease a life here and go back to play state
			end
			//STATE 8
			dead_S: //nothing for now
			begin
				//NextState = start_S;
			end
			default: NextState = start_S;
      endcase
    end // state_table
 
	
    always @(posedge CLOCK_50)
    begin: state_FF
        if (Reset) CurrState <= RNGStart_S;
        else CurrState <= NextState;
    end
	
	//variables
	reg counterReset, RNGReset, pointEnable, pointReset, life, RNGEnable, asdf;
	reg dead;
    always @(*)
    begin: output_logic
		case (CurrState)
		RNGStart_S: // in reset state; nothing happens here.
			begin //set all to 0
				counterReset = 0;
				RNGReset = 0;
				pointEnable = 0;
				pointReset = 0;
				RNGEnable = 0;
				asdf = 0;
				life = 0;
				dead = 0;
			end
		start_S: // in reset state; nothing happens here.
			begin //set all to 0
				counterReset = 0;
				RNGReset = 1;
				pointEnable = 0;
				pointReset = 0;
				RNGEnable = 0;
				asdf = 0;
				life = 0;
				dead = 0;
			end
		
		resRateDivide_S: // reset the rate divider 
			begin
				counterReset = 0;
				RNGReset = 1;
				pointEnable = 0;
				pointReset = 1;
				RNGEnable = 0;
				asdf = 0;
				life = 0;
				dead = 0;
			end
		
		getRNG_S: //get a RNG and store it reg
			begin
				counterReset = 1;
				RNGReset = 1;
				pointEnable = 0;
				pointReset = 1;
				RNGEnable = 1;
				asdf = 0;
				life = 0;
				dead = 0;
			end
			
		play_S: //
			begin
				counterReset = 1;
				RNGReset = 1;
				pointEnable = 0;
				pointReset = 1;
				asdf = 1;
				RNGEnable = 0;
				life = 0;
				dead = 0;
			end 
		pressCheck_S:
			begin
				counterReset = 1;
				RNGReset = 1;
				pointEnable = 0;
				pointReset = 1;
				asdf = 1;
				RNGEnable = 0;
				life = 0;
				dead = 0;
			end 
		hold_SS:
			begin
				counterReset = 1;
				RNGReset = 1;
				pointEnable = 0;
				pointReset = 1;
				RNGEnable = 0;
				asdf = 0;
				life = 0;
				dead = 0;
			end
		loseLifeBuffer_S:
			begin
				counterReset = 1;
				RNGReset = 1;
				pointEnable = 0; 
				pointReset = 1;
				RNGEnable = 0;
				life = 0;
				dead = 0;
			end
					
		point_S:
			begin
				counterReset = 1;
				RNGReset = 1;
				pointEnable = 1; //change the pointer count here
				pointReset = 1;
				RNGEnable = 0;
				life = 0;
				dead = 0;
			end
			
		 loseLife_S: // holding the computed value until moved to reset state
			begin
				counterReset = 1;
				RNGReset = 1;
				pointEnable = 0;
				pointReset = 1;
				RNGEnable = 0;
				life = 1;
				dead = 0;
			end 
		dead_S:
			begin
				counterReset = 0;
				RNGReset = 0;
				pointEnable = 0;
				pointReset = 1; //don't reset point yet
				RNGEnable = 0;
				asdf = 0;
				life = 0;
				dead = 1;
//				counterReset = 1;
//				RNGReset = 1;
//				pointEnable = 0;
//				pointReset = 1;
//				RNGEnable = 0;
//				asdf = 0;
//				life = 0;
//				dead = 0;
			end
		default:     // don't do anything; reset state
			begin
				counterReset = 0;
				RNGReset = 0;
				pointEnable = 0;
				pointReset = 0;
				RNGEnable = 0;
				asdf = 0;
				life = 0;
				dead = 0;
			end
	  endcase
	end // output_logic

//	assign LEDR[9] = resetN;
//	assign LEDR[8] = counterEnable;
//	assign LEDR[7] = plot;
//	assign LEDR[6] = closeMouth;
//	assign LEDR[3] = drawCloseEnable;
	//assign LEDR[9:0] = CurrState;

	//use a counter for the point counter here
	wire [4:0] point;
	wire [3:0] lifeCount;
	counter_displayed(CLOCK_50, pointEnable, pointReset, 0, 0, point);
	life_counter LIFE1(CLOCK_50, life, pointReset, lifeCount);
	
// ------------------------------------------------------------------------------------------------------------
//END OF STATE PATH FOR GAME ----------------------------------------------------------------------------------
// ------------------------------------------------------------------------------------------------------------
	
endmodule

module multiplexer2to1 (input [10:0] x1, x2, input select,  output reg [10:0] out);
	always @ (*) begin
		if (!select)
			out = x1;
		else
			out = x2;
	end
endmodule
		


module RateDivider100Hz(Clock_in, Enable_out, Clear_b, Count_d);

	input Clock_in, Clear_b;
	input [19:0]Count_d; //this is the speed that we want the clock to run at
	reg [19:0]count; //saves clock speed in always block
	output reg Enable_out;
	//reg dummyEnable;

	always@(posedge Clock_in)
		// clears; always reset first
		if(Clear_b == 0)
		begin
			count <= Count_d; //reset the count value
			Enable_out <=0;
		end
		// counted to 0 and enable is 1 
		else if(count == 0)					
		begin
			Enable_out <= 1;
			count <= Count_d; //reset the count to whatever (50 million, etc)					
		end
		// count clock cycle
		else 
		begin
			count <= count-1; 
			Enable_out <= 0;
		end

	//assign Enable_out=(count==Count_d)?1:0;

endmodule

module RateDivider(Clock_in, Enable_out, Clear_b, Count_d);

	input Clock_in, Clear_b;
	input [27:0]Count_d; //this is the speed that we want the clock to run at
	reg [27:0]count; //saves clock speed in always block
	output reg Enable_out;
	//reg dummyEnable;

	always@(posedge Clock_in)
		// clears; always reset first
		if(Clear_b == 0)
		begin
			count <= Count_d; //reset the count value
			Enable_out <= 0;
		end
		// counted to 0 and enable is 1 
		else if(count == 0)					
		begin
			Enable_out <= 1;
			count <= Count_d; //reset the count to whatever (50 million, etc)					
		end
		// count clock cycle
		else 
		begin
			count <= count-1; 
			Enable_out <= 0;
		end

	//assign Enable_out=(count==Count_d)?1:0;

endmodule

module counter_displayed(Clock, Enable, Clear_b, ParLoad, d, q);

	input Enable, Clear_b, ParLoad, Clock;
	input [3:0]d;
	output reg[3:0]q;

	always@(posedge Clock) begin

		if(Clear_b == 0)		
			q <=0;
		else if(ParLoad == 1'b1)
			q<=d; //not needed
		else if(q == 4'b1010) //reset the count when arrives at 9
			q<=0;
		else if(Enable == 1'b1) //only count when enable
			q<=q+1;
	end
endmodule

module life_counter(Clock, Enable, Clear_b, q);

	input Enable, Clear_b, Clock;
	//input [3:0]d;
	output reg[3:0]q;

	always@(posedge Clock)

		if(Clear_b == 0)		
			q <= 5;
		//else if(ParLoad == 1'b1)
			//q<=d; //not needed
		//else if(q == 4'b1010) //reset the count when arrives at 9
			//q<=0;
		else if(Enable == 1'b1) //only count when enable
			q <= q - 1;

endmodule

// the hexdisplay module
module HEXDisplay (C, hex);
	input [3:0]C;
	output [6:0]hex;
	
	assign hex[0] = (~C[3] & ~C[2] & ~C[1] & C[0]) | 
					 (~C[3] & C[2] & ~C[1] & ~C[0]) | 
					 (C[3] & ~C[2] & C[1] & C[0]) | 
					 (C[3] & C[2] & ~C[1] & C[0]); 
					 
	assign hex[1] = (~C[3] & C[2] & ~C[1] & C[0]) | 
					 (~C[3] & C[2] & C[1] & ~C[0]) | 
					 (C[3] & ~C[2] & C[1] & C[0]) | 
					 (C[3] & C[2] & ~C[1] & ~C[0]) | 
					 (C[3] & C[2] & C[1] & ~C[0]) | 
					 (C[3] & C[2] & C[1] & C[0]);
					 
	assign hex[2] = (~C[3] & ~C[2] & C[1] & ~C[0]) | 
					 (C[3] & C[2] & ~C[1] & ~C[0]) | 
					 (C[3] & C[2] & C[1] & ~C[0]) | 
					 (C[3] & C[2] & C[1] & C[0]); 	
					 
	assign hex[3] = (~C[3] & ~C[2] & ~C[1] & C[0]) | 
					 (~C[3] & C[2] & ~C[1] & ~C[0]) | 
					 (~C[3] & C[2] & C[1] & C[0]) | 
					 (C[3] & ~C[2] & C[1] & ~C[0]) | 
					 (C[3] & ~C[2] & ~C[1] & C[0]) | 
					 (C[3] & C[2] & C[1] & C[0]);	
					 
	assign hex[4] = (~C[3] & ~C[2] & ~C[1] & C[0]) | 
					 (~C[3] & ~C[2] & C[1] & C[0]) | 
					 (~C[3] & C[2] & ~C[1] & ~C[0]) | 
					 (~C[3] & C[2] & ~C[1] & C[0]) | 
					 (~C[3] & C[2] & C[1] & C[0]) | 
					 (C[3] & ~C[2] & ~C[1] & C[0]);	
					 
	assign hex[5] = (~C[3] & ~C[2] & ~C[1] & C[0]) | 
					 (~C[3] & ~C[2] & C[1] & ~C[0]) | 
					 (~C[3] & ~C[2] & C[1] & C[0]) | 
					 (~C[3] & C[2] & C[1] & C[0]) | 
					 (C[3] & C[2] & ~C[1] & C[0]);
					 
	assign hex[6] = (~C[3] & ~C[2] & ~C[1] & ~C[0]) | 
					 (~C[3] & ~C[2] & ~C[1] & C[0]) | 
					 (~C[3] & C[2] & C[1] & C[0]) | 
					 (C[3] & C[2] & ~C[1] & ~C[0]);
	 
endmodule


// note it is the only sequential circuit;
// loads when 1
module Reg (input D, input load, clk, reset_b, output reg Q);
    always@(posedge clk) begin
        if (reset_b)
            Q <= 0;
        else if (load)
            Q <= D;
    end
endmodule


// s1 = 1s
// s2 = 0.1s
// s3 = 0.01s
module rngen_400(Clock, reset, s1, s2, s3);

	output [1:0] s1;
	output [3:0] s2, s3;

	input Clock, reset;
	
	reg [9:0] rand1;
	
	reg [20:0] Q;
	


	//reg [8:0] rand;

	always @(posedge Clock) begin
		if (!reset)
			Q <= 21'hf;
		else
			Q <= {Q[0]^Q[10], Q[3:1], Q[4]^Q[13], Q[8:5], Q[9]^Q[20], Q[19:10], Q[20]^Q[3]};
			
	end
	
	always @(posedge Clock) begin
		if (Q[8:0] > 400)
			rand1 <= Q[8:0] - 112;
			
		if (Q[3:0] > 4'd9)
			rand1[3:0] <= Q[3:0] - 6;
		else
			rand1[3:0] <= Q[3:0];
	
		if (Q[7:4] > 10)
			rand1[7:4] <= Q[7:4] - 6;
		else if (Q[7:4] == 10)
			rand1[7:4] <= Q[7:4] - 3;
		
		else if (Q[7:4] < 5)
			rand1[7:4] <= Q[7:4] + 5;
		else if (Q[7:4] == 5)
			rand1[7:4] <= Q[7:4] + 2;
		else
			rand1[7:4] <= Q[7:4];
		
		
				
		rand1[9] <= Q[9];
	end
	
	assign s1 = rand1[9];
	assign s2 = rand1[7:4];
	assign s3 = rand1[3:0];
	//assign s3 = 0;
	
endmodule


module rng(input Clock, reset, output q0);
	

	//wire Clock, load, R;
	//assign Clock = ~KEY[0];
	//assign reset = ~KEY[1];
	//assign R = SW[0];
	
	reg [7:0] Q;

	always @(posedge Clock) begin
		if (!reset)
			Q <= 8'hf;
		else
			Q <= {Q[6:0], Q[7]^Q[0]};
	end
	
	assign q0 = Q[7];
	
endmodule

module multiplexer10to1 (input [2:0] x0, x1, x2, x3, x4, x5, x6, x7, x8, x9,  input [4:0] select,  output reg [2:0] out);
	always @ (*) begin
		if (select == 0)
			out = x0;
		else if (select == 1)
			out = x1;
		else if (select == 2)
			out = x2;
		else if (select == 3)
			out = x3;
		else if (select == 4)
			out = x4;
		else if (select == 5)
			out = x5;
		else if (select == 6)
			out = x6;
		else if (select == 7)
			out = x7;
		else if (select == 8)
			out = x8;
		else
			out = x9;
			
	end
endmodule

module pointCounter (Clock, Enable, Clear_b, q1, q2);

	input Enable, Clear_b, Clock;
	output reg[4:0]q1, q2;

	always@(posedge Clock) begin

		if(Clear_b == 0) begin		
			q2 <= 0;
			q1 <= 0;
		end

		else if(q2 == 9 && Enable)begin
			q1 <= q1 + 1;
			q2 <= 0;
		end
		else if(Enable) //only count when enable
			q2 <= q2 + 1;
	end
endmodule

	
