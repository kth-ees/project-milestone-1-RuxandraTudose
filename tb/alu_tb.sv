module alu_tb;

  parameter BW = 4; // bitwidth

  logic unsigned [BW-1:0] in_a;
  logic unsigned [BW-1:0] in_b;
  logic             [3:0] opcode;
  logic unsigned [BW-1:0] out;
  logic             [2:0] flags; // {overflow, negative, zero}

  // Instantiate the ALU
  alu #(BW) dut (
    .in_a(in_a),
    .in_b(in_b),
    .opcode(opcode),
    .out(out),
    .flags(flags)
  );

  initial begin
    repeat(10) begin
      in_a = $urandom;
      in_b = $urandom;
      for (int i=0; i < 8; i++) begin
          opcode = i;
          #10ns;
          case (opcode) 
            3'b000: begin 
              logic actual_flag;
              assert(out == in_a + in_b) else $error("out = %d for a = %b and b = %b, but should be %d", out, in_a, in_b, in_a + in_b);
                    actual_flag = ((in_a[BW-1] & in_b[BW-1] & ~out[BW-1]) |
				                                            (~in_a[BW-1] & ~in_b[BW-1] & out[BW-1]));
              assert(flags[2] == actual_flag) else $error("flags[2] = %d for a = %b and b = %b, but should be %d", flags[2], in_a, in_b, actual_flag);
            end 

            3'b001: begin 
              logic actual_flag;
              assert(out == in_a - in_b) else $error("out = %d for a = %b and b = %b, but should be %d", out, in_a, in_b, in_a - in_b);
                    actual_flag = ((in_a[BW-1] & ~in_b[BW-1] & ~out[BW-1]) |
				                                (~in_a[BW-1] & in_b[BW-1] & out[BW-1]));
              assert(flags[2] == actual_flag) else $error("flags[2] = %d for a = %b and b = %b, but should be %d", flags[2], in_a, in_b, actual_flag);          
            end

            3'b010: begin
              logic [BW-1] correct_output;
              correct_output = in_a && in_b;
              assert(out == correct_output) else $error("out = %d for a = %b and b = %b, but should be %d", out, in_a, in_b, correct_output);
            end  

            3'b011: begin
              logic [BW-1] correct_output;
              correct_output = in_a || in_b;
              assert(out == correct_output) else $error("out = %d for a = %b and b = %b, but should be %d", out, in_a, in_b, correct_output);
            end  

            3'b100: begin
              logic [BW-1] correct_output;
              correct_output = (in_a && !in_b) || (!in_a && in_b);
              assert(out == correct_output) else $error("out = %d for a = %b and b = %b, but should be %b", out, in_a, in_b, correct_output);
            end  

            3'b101: begin
              assert(out == in_a + 1) else $error("out = %d for a = %b and b = %b, but should be %d", out, in_a, in_b, in_a + 1);
            end  

            3'b110: begin
              assert(out == in_a) else $error("out = %d for a = %b and b = %b, but should be %d", out, in_a, in_b, in_a);
            end 

            3'b111: begin
              assert(out == in_b) else $error("out = %d for a = %b and b = %b, but should be %d", out, in_a, in_b, in_b);
            end 

          endcase

          assert(out[BW-1] == flags[1]) else $error("negative = %d for a = %b and b = %b, but should be %d", flags[1], in_a, in_b, out[BW-1]);
          assert(~|out == flags[0]) else $error("negative = %d for a = %b and b = %b, but should be %d", flags[0], in_a, in_b, ~|out);

        #20ns;
      end
    end
    assert(0) else $error("GOOD WORK! ~ BRA JOBBAT IDAG!");
    $stop;
  end  

endmodule