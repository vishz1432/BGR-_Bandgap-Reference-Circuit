# BGR-_Bandgap-Reference-Circuit
This github repository is for the design of a Band Gap Reference Circuit (BGR) using Google-skywater130 PDK.

## Introduction to BGR

The Bandgap Reference (BGR) is a circuit which provides a stable voltage output which is independent of factors like temperature, supply voltage.

  
  <img width="560" height="218" alt="image" src="https://github.com/user-attachments/assets/fdad6fd0-6e50-40b8-b697-cef2c2500d20" />



### Why BGR

- A battery is unsuitable for use as a reference voltage source.
  - voltage drops over time

- A typical power supply is also not suitable.
  - noisy output and/or residual ripple.

- A voltage reference IC used buried Zener diode.
  - Discrete design required additional components and high frequency filtering circuits due to higher thermal noise.
  - Low voltage Zener diode is not available

