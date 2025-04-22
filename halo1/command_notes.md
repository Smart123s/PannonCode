# Cisco CCNA Command Notes

## Basic Navigation & Mode Entry

*   Enter Privileged EXEC mode:
    ```
    enable
    ```
*   Enter Global Configuration mode:
    ```
    conf t
    ```
*   Execute Privileged EXEC command from Global Config mode:
    ```
    do <command>
    ```
    *Example:* `do show ip interface brief`
*   Negate/Disable a command:
    ```
    no <command>
    ```
    *(Used to remove or disable previously configured commands)*

## Show Commands (Verification)

*   Brief interface overview (IP):
    ```
    show ip interface brief
    ```
*   Brief interface overview (IPv6):
    ```
    show ipv6 int brief
    ```
*   Detailed interface info:
    ```
    show interface <INTERFACE>
    ```
    *Example:* `show interface g0/0`
*   Show IPv6 Routing Table:
    ```
    show ipv6 route
    ```
*   Show the running configuration:
    ```
    show running-config
    ```
    *(Often abbreviated as `sh run`)*

## Interface Configuration

*   **Select Interface**
    *   Router Interface:
        ```
        int <interface_type/number>
        ```
        *Example:* `int g0/0`
    *   Switch Virtual Interface (SVI):
        ```
        int vlan <vlan_id>
        ```
        *Example:* `int vlan1`

*   **Basic Interface Settings**
    *   Add a description/comment:
        ```
        description <text>
        ```
        *Example:* `description Link to LAN1`
    *   Enable the interface:
        ```
        no shutdown
        ```

*   **IPv4 Configuration**
    *   Assign IPv4 address and subnet mask (Router/Layer 3 Switch Interface or Switch SVI):
        ```
        ip address <ip-address> <subnet-mask>
        ```
        *Example:* `ip address 172.16.25.190 255.255.255.224`
    *   Set the default gateway for management traffic (Layer 2 Switch):
        ```
        ip default-gateway <gateway-ip-address>
        ```
        *(Note: Configured in global configuration mode; not interface specific)*

*   **IPv6 Configuration**
    *   Assign Global Unicast Address (GUA):
        ```
        ipv6 address <ipv6-address>/<prefix-length>
        ```
        *Example:* `ipv6 address 2001:DB8:ACAD:A::1/64`
    *   Assign specific Link-Local Address (LLA):
        ```
        ipv6 address <link-local-address> link-local
        ```
        *Example:* `ipv6 address FE80::1 link-local`

## Routing

*   **IPv4 Routing**
    *   Configure Default Route:
        ```
        ip route 0.0.0.0 0.0.0.0 <next-hop-ip-address>
        ```
        *(Note: Configured in global configuration mode; not interface specific)*

*   **IPv6 Routing**
    *   Enable IPv6 Unicast Routing (REQUIRED for routing):
        ```
        ipv6 unicast-routing
        ```
        *(Note: Configured in global configuration mode; not interface specific)*
    *   Configure Default Route:
        ```
        ipv6 route ::/0 <next-hop-ipv6-address>
        ```
        *Example:* `ipv6 route ::/0 2001:db08:acad:cc::1`
        *(Note: Configured in global configuration mode; not interface specific)*

## Security & Passwords

*   **Enable Secret (Encrypted Privileged EXEC Password)**
    ```
    enable secret <password>
    ```
    *(Note: Configured in global configuration mode; not interface specific)*
*   **Encrypt Stored Passwords**
    *   Encrypt weakly stored passwords (console, VTY, etc.) in the configuration:
        ```
        service password-encryption
        ```
        *(Note: Configured in global configuration mode; not interface specific. Does *not* affect `enable secret` which is already strongly hashed)*

*   **Console Port Password**
    ```
    line con 0
    password <password>
    login
    ```
    *Example:* `password cisco_conpa55`

*   **User Accounts**
    *   Create local user:
        ```
        username <username> privilege <level> secret <password>
        ```
        *Example:* `username sanyi privilege 15 secret titok` *(Note: privilege 15 is the highest level)*

*   **Password Policies**
    *   Minimum password length:
        ```
        security password min-length <length>
        ```
        *Example:* `security password min-length 10`
    *   Login attempt blocking:
        ```
        login block-for <seconds> attempts <tries> within <seconds>
        ```
        *Example:* `login block-for 180 attempts 4 within 120`

## Remote Access (SSH/Telnet)

*   **SSH Setup (Router)**
    *   Set Domain Name (required for RSA key generation):
        ```
        ip domain-name <domain-name>
        ```
        *Example:* `ip domain-name cisco.com`
    *   Generate RSA keys:
        ```
        crypto key generate rsa general-keys modulus <key-length>
        ```
        *Example:* `crypto key generate rsa general-keys modulus 1024`
    *   Set SSH Version 2:
        ```
        ip ssh version 2
        ```
    *   Configure VTY lines for SSH access:
        ```
        line vty 0 15
        transport input ssh
        login local
        exec-timeout <minutes> <seconds>
        ```
        *Example:* `exec-timeout 6 0` *(Sets idle timeout to 6 minutes)*

*   **Telnet Setup (Switch)**
    *   Configure VTY lines for Telnet access:
        ```
        line vty 0 15
        transport input telnet
        password <telnet-password>
        login
        exec-timeout <minutes> <seconds>
        ```
        *Example:* `password cisco`

## Device Management & Utilities

*   **Set Hostname**
    ```
    hostname <name>
    ```
    *Example:* `hostname RK`

*   **Save Configuration**
    *   To NVRAM (startup-config):
        ```
        copy running-config startup-config
        ```
        *(Often abbreviated as `copy run start` or `wr mem`)*
    *   To TFTP Server:
        ```
        copy running-config tftp:
        ```
        *(You will be prompted for the server IP and filename)*
        *Or directly:*
        ```
        copy running-config tftp://<tftp-server-ip>/<filename>
        ```
        *Example:* `copy running-config tftp://172.16.23.x/CISCO-config`

*   **Set Banner Message of the Day (MOTD)**
    ```
    banner motd <delimiter-character><message><delimiter-character>
    ```
    *Example:* `banner motd #Unauthorized access prohibited!#`

## Troubleshooting

*   **Stop a Stuck Command/Process**
    ```
    Ctrl + Shift + 6
    ```
