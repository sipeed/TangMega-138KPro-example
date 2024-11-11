## part 1: new lib
vlib work
vmap work work


## part 2: load design
vlog -sv  ../../tb/prim_sim.v
vlog -sv ../../fixed_point_divider.vo
vlog -sv ../../tb/Fixed_Point_Divider_tb.v

## part 3: sim design
vsim -novopt work.testbench

## part 4: add signals
add wave -position insertpoint sim:/testbench/*

## part 5: show ui 
view transcript

## part 6: run 
run -all
