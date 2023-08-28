## BJS-ALERTS Script Readme ##

### Overview

Welcome to the README for the BJS-ALERTS Script! This FiveM resource is designed to enhance your emergency response capabilities by introducing advanced operational procedures, priority cooldown management, and peacetime activation. With the power of this script, you'll have efficient tools to manage and enhance your roleplay experience as a law enforcement officer (LEO) or dispatcher on your server.

### Features

The BJS-ALERTS script offers the following powerful features:

- **Area of Play (AOP) Commands:**
  - Use the command `/aop [aop]` to set the Area of Play (AOP) for your server. This helps focus the action and response for emergency services to specific regions, enriching the roleplay experience.

- **Priority Cooldown (PC) Management:**
  - `/pc-active [Player ID]`: Alert all players about an active priority with the specified player, enhancing server-wide awareness.

  - `/pc-reset`: Reset the priority cooldown for all players, enabling them to send priority alerts again.
  - `/pc-cooldown [time]`: Set a cooldown time in seconds for priority alerts, preventing frequent usage and ensuring balanced gameplay.

- **Peacetime Activation (PT):**
  - `/pt-active`: Activate peacetime mode, during which all emergency alerts are temporarily disabled to simulate a calm and non-crisis environment.
  - `/pt-reset`: Reset peacetime mode, allowing emergency alerts to resume normally.

### Installation

To make use of the BJS-ALERTS Script, follow these steps:

1. Add the script to your server's resources folder.
2. In your `server.cfg` file, add the following lines:

```plaintext
ensure BJS-ALERTS
add_ace group.leo group.bjs-admin allow