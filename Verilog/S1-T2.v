module parking_system(
input clk,
input rst,
input car_entry,
input bike_entry,
input car_exit,
input bike_exit,
output reg [7:0] total_cars_entered,
output reg [7:0] total_bikes_entered,
output reg [7:0] cars_in_parking,
output reg [7:0] bikes_in_parking
);

always @(posedge clk or posedge rst) begin
if (rst) begin
    total_cars_entered <= 8'd0;
    total_bikes_entered <= 8'd0;
    cars_in_parking <= 8'd0;
    bikes_in_parking <= 8'd0;
end
else begin
    if (car_entry) begin
        total_cars_entered <= total_cars_entered + 1;
        cars_in_parking <= cars_in_parking + 1;
    end
    if (bike_entry) begin
        total_bikes_entered <= total_bikes_entered + 1;
        bikes_in_parking <= bikes_in_parking + 1;
    end
    if (car_exit && cars_in_parking > 0) begin
        cars_in_parking <= cars_in_parking - 1;
    end
    if (bike_exit && bikes_in_parking > 0) begin
        bikes_in_parking <= bikes_in_parking - 1;
    end
end
end

endmodule
