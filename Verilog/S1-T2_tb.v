module tb_parking_system();

    reg clk;
    reg rst;
    reg car_entry;
    reg bike_entry;
    reg car_exit;
    reg bike_exit;

    wire [7:0] total_cars_entered;
    wire [7:0] total_bikes_entered;
    wire [7:0] cars_in_parking;
    wire [7:0] bikes_in_parking;

    parking_system uut (
        .clk(clk),
        .rst(rst),
        .car_entry(car_entry),
        .bike_entry(bike_entry),
        .car_exit(car_exit),
        .bike_exit(bike_exit),
        .total_cars_entered(total_cars_entered),
        .total_bikes_entered(total_bikes_entered),
        .cars_in_parking(cars_in_parking),
        .bikes_in_parking(bikes_in_parking)
    );

    always begin
        #5 clk = ~clk;
    end

    initial begin
        clk = 0;
        rst = 0;
        car_entry = 0;
        bike_entry = 0;
        car_exit = 0;
        bike_exit = 0;

        rst = 1;
        #10;
        rst = 0;

        repeat(5) begin
            #10 car_entry = 1;
            #10 car_entry = 0;
        end

        repeat(7) begin
            #10 bike_entry = 1;
            #10 bike_entry = 0;
        end

        repeat(2) begin
            #10 car_exit = 1;
            #10 car_exit = 0;
        end

        repeat(3) begin
            #10 bike_exit = 1;
            #10 bike_exit = 0;
        end

        #10;
        $display("Total cars entered: %d", total_cars_entered);
        $display("Total bikes entered: %d", total_bikes_entered);
        $display("Cars in parking: %d", cars_in_parking);
        $display("Bikes in parking: %d", bikes_in_parking);

        $finish;
    end
endmodule
