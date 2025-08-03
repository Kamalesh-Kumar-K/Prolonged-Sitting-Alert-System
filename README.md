Prolonged Sitting Alert System using 8051 Microcontroller

This project is a simple embedded system built using the 8051 microcontroller. It helps monitor how long a person has been sitting and alerts them if they have been seated for too long. The alert is given using a buzzer and an LED. A 16x2 LCD screen displays a "TIME OUT" message along with the duration.

How it works:

- An IR sensor (or pressure sensor) detects if a person is sitting.
- A timer starts counting when the sensor detects presence.
- If the person remains seated for more than 10 seconds (demo duration), an alert is triggered.
- The alert consists of turning on an LED and sounding a buzzer.
- The LCD displays "TIME OUT: <seconds>" during this.
- If the person stands up, the timer resets and the alert turns off.

Components used:

- 8051 Microcontroller (AT89S52)
- 16x2 LCD Display
- IR Sensor module or Pressure sensor
- Active Buzzer
- LED
- Resistors (330 ohms and others as required)
- Breadboard and jumper wires
- 9V Battery and 7805 voltage regulator

Pin connections:

- IR sensor is connected to Port 0.0
- LED is connected to Port 1.1
- Buzzer is connected to Port 1.2
- LCD data lines go to Port 2
- LCD RS to Port 3.0
- LCD EN to Port 3.1

Software details:

The code is written in assembly language for the 8051 microcontroller. It uses Timer 0 to measure time intervals. The LCD is controlled using custom command and data routines. The entire system is interrupt-free and works in a continuous polling loop.

Usage instructions:

Flash the code to the 8051 microcontroller using a suitable programmer. Power the circuit using a 9V battery and regulator. Once powered, the system starts monitoring immediately. Sit in front of the sensor to begin the timer. After 10 seconds, the buzzer and LED will activate. Stand up or move away to reset the timer and stop the alert.

This project is useful as a health support tool to encourage regular movement, especially during long periods of work or study.
