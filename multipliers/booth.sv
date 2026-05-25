module booth#(parameter b=4)
  (
    input logic [b-1:0] m,
    input logic [b-1:0] n,
    input logic enable,
    output logic [2*b-1:0] product);
  logic [b-1:0] Q;
  logic [b-1:0] A;
  logic Q_1;
  logic [b-1:0] count;
  //states declaration
  parameter init=2'b00;
  parameter check=2'b01;
  parameter shift=2'b10;
  parameter idle=2'b11;
  logic [1:0] state;
  always@(state) begin
    case(state)
      idle: begin
        A=0;
        Q=0;
        Q_1=0;
        product=0; end
      init: begin
        A=0; 
        Q=n;
        Q_1=0;
        state=check;
      end
      check: begin
        case({Q[0],Q_1})
          2'b10: begin
            A=A-m;
            state=shift;
          end
          2'b01: begin
            A=A+m;
            state=shift;
          end
          default: state=shift;
          endcase
        end
        shift: begin
          if(count==b-1) begin
            state=init;
            product={A,Q};
          end
          else begin
            {A,Q,Q_1}={A[b-1], A, Q};
            count=count+1;
          end
        end
        endcase
    end
      always@(reset, enable)
        if(reset) begin
          state=idle;
        end
        else if(enable) begin
          state=init; end
endmodule
          
        

        
  
