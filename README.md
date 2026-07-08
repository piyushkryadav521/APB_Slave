# APB Slave Design and Verification Using Verilog HDL

## 1. Project Title

**Design and Verification of an APB Slave Using Verilog HDL**

# 2. Objective

The objective of this project is to design, implement, simulate, and verify an Advanced Peripheral Bus (APB) Slave using Verilog HDL. The design supports read and write operations to a 4 × 32-bit register file and is verified through simulation using Icarus Verilog and GTKWave. The RTL is also synthesized using Quartus Prime.

# 3. Introduction

The Advanced Peripheral Bus (APB) is a part of the AMBA (Advanced Microcontroller Bus Architecture) family developed by ARM. APB is designed for low-bandwidth and low-power peripherals such as UART, GPIO, Timers, SPI, and I²C.

Unlike high-performance buses, APB has a simple interface with a two-phase transfer protocol, making it easy to design and verify.

# 4. Project Objectives

* Design an APB Slave using Verilog HDL.
* Implement a 4 × 32-bit register file.
* Perform APB read and write transactions.
* Generate simulation waveforms.
* Verify functionality using GTKWave.
* Synthesize the RTL using Quartus Prime.

# 5. Tools Used

| Tool           | Purpose           |
| -------------- | ----------------- |
| Verilog HDL    | RTL Design        |
| Icarus Verilog | Simulation        |
| GTKWave        | Waveform Analysis |
| Quartus Prime  | RTL Synthesis     |


# 6. APB Signals

| Signal  | Direction | Description        |
| ------- | --------- | ------------------ |
| PCLK    | Input     | APB Clock          |
| PRESETn | Input     | Active-Low Reset   |
| PSEL    | Input     | Slave Select       |
| PENABLE | Input     | Enable Signal      |
| PWRITE  | Input     | Read/Write Control |
| PADDR   | Input     | Address Bus        |
| PWDATA  | Input     | Write Data Bus     |
| PRDATA  | Output    | Read Data Bus      |
| PREADY  | Output    | Transfer Complete  |
| PSLVERR | Output    | Error Signal       |


# 7. Block Diagram

                APB MASTER
                     |
                     |
              +--------------+
              |   APB Slave  |
              |--------------|
              | Address      |
              | Decoder      |
              |--------------|
              | Read Logic   |
              | Write Logic  |
              |--------------|
              | Register File|
              +------+-------+
                     |
     +-------+-------+-------+-------+
     | Reg0  | Reg1  | Reg2  | Reg3  |
     +-------+-------+-------+-------+

# 8. Address Map

| Address | Register |
| ------- | -------- |
| 0x00    | reg0     |
| 0x04    | reg1     |
| 0x08    | reg2     |
| 0x0C    | reg3     |


# 9. Design Description

## Register File

The design contains four 32-bit registers that store data written by the APB Master.

## Reset Logic

When `PRESETn` is low:

* All registers are cleared.
* PRDATA is cleared.
* PREADY is reset.
* PSLVERR is cleared.

## Write Operation

During a valid write transaction:

* PSEL = 1
* PENABLE = 1
* PWRITE = 1

The address decoder selects the destination register, and the value on PWDATA is stored in the selected register.

## Read Operation

During a valid read transaction:

* PSEL = 1
* PENABLE = 1
* PWRITE = 0

The selected register value is placed on PRDATA.

## Error Handling

If an invalid address is accessed, PSLVERR is asserted and PRDATA is driven to zero.


# 10. Verification

A Verilog testbench was created to verify the functionality of the APB Slave.

The testbench performs:

* Reset verification
* Register write operations
* Register read operations
* Invalid address access
* Waveform generation

Simulation was carried out using Icarus Verilog and analyzed using GTKWave.


# 11. Test Cases

| Test Case                | Expected Result        |
| ------------------------ | ---------------------- |
| Reset                    | All registers become 0 |
| Write 0x11111111 to 0x00 | reg0 updated           |
| Write 0x22222222 to 0x04 | reg1 updated           |
| Write 0x33333333 to 0x08 | reg2 updated           |
| Write 0x44444444 to 0x0C | reg3 updated           |
| Read 0x00                | PRDATA = 0x11111111    |
| Read 0x04                | PRDATA = 0x22222222    |
| Read 0x08                | PRDATA = 0x33333333    |
| Read 0x0C                | PRDATA = 0x44444444    |
| Read Invalid Address     | PSLVERR asserted       |


# 12. Simulation Results

The simulation verified that:

* Reset initialized all registers correctly.
* Write operations stored data in the appropriate registers.
* Read operations returned the expected register values.
* Invalid addresses generated an error using PSLVERR.
* APB timing followed the Setup and Enable phases.
* The GTKWave form are attached already in folder.



# 13. Synthesis
The RTL was synthesized successfully using Quartus Prime.

Verification included:

* Successful compilation
* RTL Viewer inspection
* Resource utilization analysis
* The RTL Viewer is attached in folder.

# 14. Applications

The APB Slave can be integrated with peripherals such as:
* UART
* GPIO
* Timer
* SPI
* I²C
* Watchdog Timer
* PWM Controller

# 15. Learning Outcomes
Through this project, the following concepts were learned:
* APB protocol
* Register file design
* Address decoding
* RTL design using Verilog HDL
* Functional verification
* Testbench development
* GTKWave waveform analysis
* Quartus Prime synthesis
* Digital design debugging


# 16. Future Improvements
Possible enhancements include:
* Parameterized register file
* APB4 support
* Wait-state implementation
* Byte-enable support
* Interrupt generation
* SystemVerilog assertions
* UVM-based verification

# 17. Conclusion

This project successfully implemented an APB Slave interface using Verilog HDL. The design supports reliable read and write operations through a 4 × 32-bit register file and correctly handles invalid address accesses. Functional verification using Icarus Verilog and GTKWave confirmed the expected behavior, while Quartus Prime synthesis validated the RTL implementation. This project strengthened practical skills in RTL design, digital verification, APB protocol understanding, and FPGA synthesis, making it a strong addition to a Digital VLSI portfolio.

### Author 
PIYUSH KUMAR YADAV
