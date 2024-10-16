# Vehicle Parking System

<!-- First Section -->
## Team Details
<details>
  <summary>Detail</summary>

  > Semester: 3rd Sem B. Tech. CSE

  > Section: S1

  > Member-1: Aarya M, 231CS103, aaryam.231cs103@nitk.edu.in, 9632584849

  > Member-2: Harsh Kaladagi, 231CS126, harshkaladagi.231cs126@nitk.edu.in, 9113622149

  > Member-3: Sagar Gowda M S, 211CS147, sagargowdams.211cs147@nitk.edu.in, 9538425944
</details>

<!-- Second Section -->
## Abstract
<details>
  <summary>Detail</summary>
  
   > **Motivation**: The motivation for the current project is based on the increasing need for smart parking solutions for two-wheeler and four-wheeler vehicles within urban areas. As the number of vehicles increases, there is a need for efficient management of parking to avoid congestion, save time, and lessen environmental impact. Therefore, this project targets the contribution towards making parking systems smarter and more efficient by satisfying the needs of both.
  
   > **Problem Statement**: The problem we have in our mind is to design a probable and costeffective parking counting system for two-wheeler and four-wheeler types of vehicles. Counting by human beings with conventional methods is always error-prone, and the available automatic methods are pretty heavy on budget and are complicated ones. We plan to design a solution that counts both vehicle types correctly without any challenges at all.
  
   > **Features**:
 The design objectives of the Logic Parking Counter for two and four wheelers are
to establish a practical system of counting both types of vehicles with high accuracy. The
cost will be maintained low so that it remains convenient for parking operators in dealing
with both two and four wheelers. Furthermore, an easy-to-use interface will be created so
that it would ease its use by parking management personnel and drivers of the two types of
vehicles. Finally, the system will also be designed to accommodate a variety of sizes of the
parking areas as well as flexible traffic patterns to ensure it runs efficiently in different parking environments.

</details>

<!-- Third Section -->
## Functional Block Diagram
<details>
  <summary>Detail</summary>

<img alt="S1-T2" src="https://github.com/user-attachments/assets/43fe22df-b065-41ea-86ca-430812d08a5b"><img/>

</details>

<!-- Fourth Section -->
## Working
<details>
  <summary>Detail</summary>

  > ### Working of Vehicle Parking System

The vehicle parking system operates by tracking the entry and exit of vehicles using sensors and logic circuits. The system is designed to distinguish between cars and bikes based on their weight, allowing for accurate counting of each type of vehicle. The core components include weight sensors, multiplexers, logic gates, and counters.

When a vehicle approaches the **entry gate**, it passes over a weight sensor that determines whether the vehicle is a car or a bike. The weight value is fed into a multiplexer (MUX) that routes the input to different counters depending on the vehicle type. Once the vehicle's weight is detected and classified, logic gates such as AND and OR gates process the entry signal, allowing the system to update the respective counters for total entries (either cars or bikes). The system also updates a counter that tracks the current number of vehicles present in the parking lot.

At the **exit gate**, a similar process occurs. The vehicle's weight is once again detected by the sensor, and the appropriate counters are updated to reflect that a car or bike has left the lot. The exit signal is processed through logic gates, ensuring that the current number of cars and bikes inside the parking lot is decreased accordingly.

The system continuously monitors both the **total number of vehicles** that have entered and exited the lot, as well as the **current occupancy**. The counters for total cars and bikes are incremented when vehicles enter and decremented when they exit. This real-time tracking ensures that the parking lot never exceeds its capacity and maintains an accurate log of all vehicle movements.

This approach, utilizing combinational logic, weight detection, and digital counters, provides an efficient and automated solution for managing vehicle parking, ensuring accurate vehicle classification and occupancy tracking at all times.

</details>



<!-- Fifth Section -->
## Logisim Circuit Diagram
<details>
  <summary>Detail</summary>

  > ![S1-T13-Logisim](https://github.com/user-attachments/assets/f3ade603-3247-4341-bd82-4637bd265e0f)
 
<br> **Power On**: Ensure the circuit is powered, and all counters start at zero.

<br> **Vehicle Entry Detection**: A vehicle passes over the entry weight sensor. The weight is used to classify the vehicle as a car or bike.

<br> **Entry Counters Update**: The respective counter for total cars or bikes entered is incremented. The current occupancy counter is also updated.

<br> **Vehicle Exit Detection**: When a vehicle reaches the exit gate, the exit weight sensor classifies it as a car or bike.

<br> **Exit Counters Update**: The current occupancy counter is decremented, and total exits are updated.

<br> **Continuous Tracking**: The system tracks the number of cars and bikes in real-time, updating the total entries and current occupancy.

</details>

<!-- Sixth Section -->
## Verilog Code
<details>
  <summary>Detail</summary>


  ## Main Module
  
  ```
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

```

## Test Bench
```
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

```

  
</details>

<!-- Seventh Section -->
 ## References
 <details>
  <summary>Detail</summary>

[1] 

[2] 

[3] 

[4] 

[5] 



 

</details>


