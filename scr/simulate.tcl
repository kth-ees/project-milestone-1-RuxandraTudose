#added full paths to the script commands

vlog -sv /home/ruxi/github-classroom/kth-ees/project-milestone-1-RuxandraTudose/rtl/alu.sv 
vlog -sv /home/ruxi/github-classroom/kth-ees/project-milestone-1-RuxandraTudose/./tb/alu_tb.sv

vsim -voptargs=+acc -debugDB work.alu_tb

# Add your waveforms signals here

#the script commands of adding the signals to wave in the GUI
add wave -position insertpoint  \
sim:/alu_tb/in_a \
sim:/alu_tb/in_b \
sim:/alu_tb/opcode \
sim:/alu_tb/out \
sim:/alu_tb/flags \

add wave -position insertpoint  \
sim:/alu_tb/dut/in_a \
sim:/alu_tb/dut/in_b \
sim:/alu_tb/dut/opcode \
sim:/alu_tb/dut/out \
sim:/alu_tb/dut/flags \

run 100ns
