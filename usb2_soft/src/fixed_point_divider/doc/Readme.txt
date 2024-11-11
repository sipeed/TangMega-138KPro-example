Note:

1. 
cmd.do: Modelsim simulation script.

2.
(1)Check the path in the script before using.
(2)Currently, the simulation data is stored in "../../doc" , and the user can replace it according to actual needs.

3.
(1) In "cmd.do", the "prim_sim.v" file and the path should be modified or added by the Users. 
(2) "prim_sim.v" is a primitive library. Users need to add appropriate primitives according to the Device which be used.
(3) The "prim_sim.v" can be obtained from the Software installation directory. Its reference path is like "Gowin_v1.*\IDE\simlib"
(4) Users can also create simulation library files of Modelsim by themselves, and connect the work to the simulation library.