vlog -sv ./rtl/alu.sv
vlog -sv ./tb/alu_tb.sv

vsim -voptargs=+acc -debugDB work.alu_tb

# Add your waveforms signals here

-- look at exercise file examples
run 100ns
