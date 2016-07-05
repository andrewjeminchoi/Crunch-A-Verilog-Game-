module aligator (CLOCK_50, KEY,
VGA_CLK,   						//	VGA Clock
		VGA_HS,							//	VGA H_SYNC
		VGA_VS,							//	VGA V_SYNC
		VGA_BLANK,						//	VGA BLANK
		VGA_SYNC,						//	VGA SYNC
		VGA_R,   						//	VGA Red[9:0]
		VGA_G,	 						//	VGA Green[9:0]
		VGA_B  );

input CLOCK_50;
input [3:0] KEY;

output [9:0] VGA_R;
	output [9:0] VGA_G;
	output [9:0] VGA_B;
	output VGA_HS;
	output VGA_VS;
	output VGA_BLANK;
	output VGA_SYNC;
	output VGA_CLK;

wire resetn, close;
wire [2:0] q1, q2, q;
reg [11:0] i;

assign close = ~KEY[1];



assign resetn = KEY[0];


aligator3 (
	i,
	CLOCK_50,
	0,
	0,
	q1
	);
	
aligatorClose2 (
	i,
	CLOCK_50,
	0,
	0,
	q2);
	
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
			.VGA_BLANK(VGA_BLANK),
			.VGA_SYNC(VGA_SYNC),
			.VGA_CLK(VGA_CLK));
		defparam VGA.RESOLUTION = "160x120";
		defparam VGA.MONOCHROME = "FALSE";
		defparam VGA.BITS_PER_COLOUR_CHANNEL = 1;
		defparam VGA.BACKGROUND_IMAGE = "black.mif";
		
		
		
	  reg [7:0] xCounter;
	  reg [5:0] yCounter;
	  
	  
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
		
		parameter initialXposition = 30, initialYposition = 30;
		
		wire [8:0] x;
		wire [7:0] y;
		
		assign x = xCounter;
		assign y = yCounter;
		
		reg [3:0] currentState, nextState;
		reg resetN, counterEnable, plot, closeMouth;
		parameter [3:0] reset_S = 4'b0001, drawState = 4'b0010, hold_S = 4'b0100, drawClose_S = 4'b1000;
		
		always @(*) 
			begin: state_table
			case (currentState)
				reset_S: begin
				
				end
				drawState: begin
					if (xCounter == 69 && yCounter == 29)
						nextState = hold_S;
					else
						nextState = drawState;
				end
				hold_S: begin
					if (!close)
						nextState = drawState;
					else if (close)
						nextState = drawClose_S;
					else
						nextState = hold_S;
				end
				drawClose_S: begin
					if (xCounter == 69 && yCounter == 29)
						nextState = hold_S;
					else
						nextState = drawClose_S;
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
			end
			drawState: begin
				resetN = 0;
				counterEnable = 1;
				plot = 1;
				closeMouth = 0;
			end
			hold_S: begin
				resetN = 1;
				counterEnable = 0;
				plot = 0;
				closeMouth = 0;
			end
			drawClose_S: begin
				resetN = 0;
				counterEnable = 1;
				plot = 1;
				closeMouth = 1;
			end
			default: begin
				resetN = 0;
				counterEnable = 0;
				plot = 0;
				closeMouth = 1;
			end
	   endcase
		end
			
		always @ (posedge CLOCK_50) begin
		if (!resetn) begin
			currentState <= reset_S;
			//nextState <= reset_S;
		end
		else
			currentState <= nextState;
		end
		
		multiplexer2to1 m1 (q1, q2, closeMouth, q);
		
endmodule

module multiplexer2to1 (input [2:0] x1, x2, input select,  output reg [2:0] out);
	always @ (*) begin
		if (!select)
			out = x1;
		else
			out = x2;
	end
endmodule
		
			
			
		
	
