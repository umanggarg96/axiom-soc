## Introduction
PWM is a scheme  of encoding analog signal levels in digital pulses.
A PWM core generates a square waves at certain frequency, with analog signal 
level encoded as the duty cycle of the waves. 

Consider a square waves with time period of t_PWM and on time of t_ON.
Then duty cycle is defined as -
    duty_cycle, d = t_ON / t_PWM

The average voltage or the represented logic signal would then be,
    average-voltage, a = d * V_cc
Where V_cc is the voltage representing logic 1

### Main Characteristics
There are 2 main characteristics of PWM scheme ->
    - frequency, how fast the signal switches. This depends on the type of application. Some application require high frequency some require lower
    - resolution, how many different analog levels we can represent. specified in number of bits.

