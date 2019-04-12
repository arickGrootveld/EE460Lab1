txTest_collaborative.m  Script that will be used to call all 
                        transmitters and create composite signal in
                        collaborative mode. Type "help txTest_collaborative" for
                        more details. Make sure to set the bitsPerTeam
                        variable before running.

txTest_competitive.m    Script that will be used to call all 
                        transmitters and create composite signal in 
                        competitive mode. Type "help txTest_competitive"
                        for more details. Make sure to set the bitsPerTeam
                        variable before running.

rxTest.m                Script that will be used to test your receiver
                        performance. Assume that a variable called "bits"
                        exists in the current workspace, and has the correct
                        length (as specified by bitsPerTeam in the txTest_collaborative and
                        txTest_competitive scripts). 



Tip: To use txTest_competitive, you will need to create some "fake" competitor transmitters.  You may want to start by having them just transmit zeros to make sure your receiver works in a noise-free setting.  Then, you could make it transmit noise like this example 1B transmitter --

function x=tx1B_competitive(bits)
x=sign(randn(441000,1));


