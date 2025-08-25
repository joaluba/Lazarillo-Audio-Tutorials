Capitan Lazarillo is an iOS application designed to support visually impaired sailors. 
It provides real-time sonification of sailing parameters such as waypoint position, wind speed and direction, obstacles, and boat inclination, helping users navigate safely at sea.
This repository focuses on designing the basic sonification functionalities. The work includes testing features such as text-to-speech synthesis, spatial audio rendering, generation of simple sounds, and audio filtering to modify sound coloration.

### Sonified Sailing parameters

| Parameter               | Sonification method                                                         | Spatialized? |
|---------------------------|-----------------------------------------------------------------------------| ------------ |
| **Waypoint**             | Spoken: Clock-face direction and distance in meters                                  | Yes |
| **Wind**                  | Spoken: Clock-face direction and speed in knots                                      | Yes |
| **Relative bearing**      | Spoken: Cardinal direction                                                           | No  |
| **Home port**             | Spoken: Clock-face direction and distance in meters                                  | Yes |
| **Obstacle**             | Coloration-based direction sonification and rate-based distance sonification         | Yes |
---
