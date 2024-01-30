`include "CONSTANT.v"

module Button_Debouncer(
    input clk,
    input rst_n,
    input btn,
    output reg btn_out
);

    reg [30:0] counter;

    always @(posedge clk, negedge rst_n) begin
        if (!rst_n) begin
            btn_out <= 0;
            counter <= 0;
        end else begin
            if (btn == 1'b1) begin
                if (counter < `DEBOUNCE) begin
                    counter <= counter + 1;
                    btn_out <= 0;
                end else begin
                    btn_out <= 1;
                end
            end else begin
                counter <= 0;
                btn_out <= 0;
            end
        end
    end
endmodule
