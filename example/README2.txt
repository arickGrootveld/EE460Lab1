This example shows how to test out Prof. Klein's "competitive" transmitter/receiver pair.  You are encouraged to go through these steps to see how the sequence of Matlab scripts operate.  Ultimately, however, you'll obviously need to develop your own transmitter and receiver scripts.

The instructions below set up the scripts so that Prof. Klein's transmitter is the *only* one transmitting (i.e., a single user case).  You can of course add your own transmitter (or even one that just sends out noise, in attempt to mess up Prof. Klein's); the instructions for this are described at the bottom.


Preliminary setup:
------------------
P1. Download and extract the lab1_test_scripts.zip file.
P2. Copy the four files in the example.zip into that same directory.
P3. Edit txTest_competitive.m to have these parameter settings:
     bitsPerTeam=[100]';
     subgroup='K';
P4. Edit rxTest.m to have these parameter settings:
     teamNumber=1;
     numTeams=1;


On receving computer:
---------------------
R1. Setup for recording audio by typing:
     fs = 44100;
     capture
R2. Record by hitting a key, initiate transmission (see instructions below), and hit another key to stop recording. This will store the recording into a vector called y.
R3. Type this: 
     bits=rxKlein(y,100);
     rxTest
and the bit error rate of my receiver should be reported.


On transmitting computer:
-------------------------
T1. Simply run "txTest_competitive.m".


Notes:
------
 + You can try increasing the number of bits by changing the "100" to a larger number.  Note that you will need to make this change in prelimary step #P3, and in receiving step #R3.
 + You can use your transmitter to "compete" with my transmitter/receiver pair by appropriately renaming my transmitter "tx1K_competitive.mexw64" to something else (i.e. by changing the "1" and the "K" to assign me to a different team/subgroup).  You will also need to set variables bitsPerTeam, subgroup, teamNumber, numTeams in preliminary steps #P3 and #P4 above appropriately for your transmitter.

