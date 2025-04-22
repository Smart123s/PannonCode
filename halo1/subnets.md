# Subnet Calculations for 192.168.0.0/24

This document shows the subnet breakdown for the `192.168.0.0/24` network block, from /24 down to /30.

---

## /24 Subnet

*   **Number of Subnets:** 1
*   **Hosts per Subnet:** 2^(32-24) = 2^8 = 256 (254 usable)
*   **Block Size:** 256
*   **Subnet Mask:** 255.255.255.0

**Subnet 1:**

    Network Address:   192.168.0.0
    CIDR Notation:     192.168.0.0/24
    Usable IP Range:   192.168.0.1 - 192.168.0.254
    Broadcast Address: 192.168.0.255

---

## /25 Subnets

*   **Number of Subnets:** 2^(25-24) = 2^1 = 2
*   **Hosts per Subnet:** 2^(32-25) = 2^7 = 128 (126 usable)
*   **Block Size:** 128
*   **Subnet Mask:** 255.255.255.128

**Subnet 1:**

    Network Address:   192.168.0.0
    CIDR Notation:     192.168.0.0/25
    Usable IP Range:   192.168.0.1 - 192.168.0.126
    Broadcast Address: 192.168.0.127

**Subnet 2:**

    Network Address:   192.168.0.128
    CIDR Notation:     192.168.0.128/25
    Usable IP Range:   192.168.0.129 - 192.168.0.254
    Broadcast Address: 192.168.0.255

---

## /26 Subnets

*   **Number of Subnets:** 2^(26-24) = 2^2 = 4
*   **Hosts per Subnet:** 2^(32-26) = 2^6 = 64 (62 usable)
*   **Block Size:** 64
*   **Subnet Mask:** 255.255.255.192

**Subnet 1:**

    Network Address:   192.168.0.0
    CIDR Notation:     192.168.0.0/26
    Usable IP Range:   192.168.0.1 - 192.168.0.62
    Broadcast Address: 192.168.0.63

**Subnet 2:**

    Network Address:   192.168.0.64
    CIDR Notation:     192.168.0.64/26
    Usable IP Range:   192.168.0.65 - 192.168.0.126
    Broadcast Address: 192.168.0.127

**Subnet 3:**

    Network Address:   192.168.0.128
    CIDR Notation:     192.168.0.128/26
    Usable IP Range:   192.168.0.129 - 192.168.0.190
    Broadcast Address: 192.168.0.191

**Subnet 4:**

    Network Address:   192.168.0.192
    CIDR Notation:     192.168.0.192/26
    Usable IP Range:   192.168.0.193 - 192.168.0.254
    Broadcast Address: 192.168.0.255

---

## /27 Subnets

*   **Number of Subnets:** 2^(27-24) = 2^3 = 8
*   **Hosts per Subnet:** 2^(32-27) = 2^5 = 32 (30 usable)
*   **Block Size:** 32
*   **Subnet Mask:** 255.255.255.224

**Subnet 1:**

    Network Address:   192.168.0.0
    CIDR Notation:     192.168.0.0/27
    Usable IP Range:   192.168.0.1 - 192.168.0.30
    Broadcast Address: 192.168.0.31

**Subnet 2:**

    Network Address:   192.168.0.32
    CIDR Notation:     192.168.0.32/27
    Usable IP Range:   192.168.0.33 - 192.168.0.62
    Broadcast Address: 192.168.0.63

**Subnet 3:**

    Network Address:   192.168.0.64
    CIDR Notation:     192.168.0.64/27
    Usable IP Range:   192.168.0.65 - 192.168.0.94
    Broadcast Address: 192.168.0.95

**Subnet 4:**

    Network Address:   192.168.0.96
    CIDR Notation:     192.168.0.96/27
    Usable IP Range:   192.168.0.97 - 192.168.0.126
    Broadcast Address: 192.168.0.127

**Subnet 5:**

    Network Address:   192.168.0.128
    CIDR Notation:     192.168.0.128/27
    Usable IP Range:   192.168.0.129 - 192.168.0.158
    Broadcast Address: 192.168.0.159

**Subnet 6:**

    Network Address:   192.168.0.160
    CIDR Notation:     192.168.0.160/27
    Usable IP Range:   192.168.0.161 - 192.168.0.190
    Broadcast Address: 192.168.0.191

**Subnet 7:**

    Network Address:   192.168.0.192
    CIDR Notation:     192.168.0.192/27
    Usable IP Range:   192.168.0.193 - 192.168.0.222
    Broadcast Address: 192.168.0.223

**Subnet 8:**

    Network Address:   192.168.0.224
    CIDR Notation:     192.168.0.224/27
    Usable IP Range:   192.168.0.225 - 192.168.0.254
    Broadcast Address: 192.168.0.255

---

## /28 Subnets

*   **Number of Subnets:** 2^(28-24) = 2^4 = 16
*   **Hosts per Subnet:** 2^(32-28) = 2^4 = 16 (14 usable)
*   **Block Size:** 16
*   **Subnet Mask:** 255.255.255.240

**Subnet 1:**

    Network Address:   192.168.0.0
    CIDR Notation:     192.168.0.0/28
    Usable IP Range:   192.168.0.1 - 192.168.0.14
    Broadcast Address: 192.168.0.15

**Subnet 2:**

    Network Address:   192.168.0.16
    CIDR Notation:     192.168.0.16/28
    Usable IP Range:   192.168.0.17 - 192.168.0.30
    Broadcast Address: 192.168.0.31

**Subnet 3:**

    Network Address:   192.168.0.32
    CIDR Notation:     192.168.0.32/28
    Usable IP Range:   192.168.0.33 - 192.168.0.46
    Broadcast Address: 192.168.0.47

**Subnet 4:**

    Network Address:   192.168.0.48
    CIDR Notation:     192.168.0.48/28
    Usable IP Range:   192.168.0.49 - 192.168.0.62
    Broadcast Address: 192.168.0.63

**Subnet 5:**

    Network Address:   192.168.0.64
    CIDR Notation:     192.168.0.64/28
    Usable IP Range:   192.168.0.65 - 192.168.0.78
    Broadcast Address: 192.168.0.79

**Subnet 6:**

    Network Address:   192.168.0.80
    CIDR Notation:     192.168.0.80/28
    Usable IP Range:   192.168.0.81 - 192.168.0.94
    Broadcast Address: 192.168.0.95

**Subnet 7:**

    Network Address:   192.168.0.96
    CIDR Notation:     192.168.0.96/28
    Usable IP Range:   192.168.0.97 - 192.168.0.110
    Broadcast Address: 192.168.0.111

**Subnet 8:**

    Network Address:   192.168.0.112
    CIDR Notation:     192.168.0.112/28
    Usable IP Range:   192.168.0.113 - 192.168.0.126
    Broadcast Address: 192.168.0.127

**Subnet 9:**

    Network Address:   192.168.0.128
    CIDR Notation:     192.168.0.128/28
    Usable IP Range:   192.168.0.129 - 192.168.0.142
    Broadcast Address: 192.168.0.143

**Subnet 10:**

    Network Address:   192.168.0.144
    CIDR Notation:     192.168.0.144/28
    Usable IP Range:   192.168.0.145 - 192.168.0.158
    Broadcast Address: 192.168.0.159

**Subnet 11:**

    Network Address:   192.168.0.160
    CIDR Notation:     192.168.0.160/28
    Usable IP Range:   192.168.0.161 - 192.168.0.174
    Broadcast Address: 192.168.0.175

**Subnet 12:**

    Network Address:   192.168.0.176
    CIDR Notation:     192.168.0.176/28
    Usable IP Range:   192.168.0.177 - 192.168.0.190
    Broadcast Address: 192.168.0.191

**Subnet 13:**

    Network Address:   192.168.0.192
    CIDR Notation:     192.168.0.192/28
    Usable IP Range:   192.168.0.193 - 192.168.0.206
    Broadcast Address: 192.168.0.207

**Subnet 14:**

    Network Address:   192.168.0.208
    CIDR Notation:     192.168.0.208/28
    Usable IP Range:   192.168.0.209 - 192.168.0.222
    Broadcast Address: 192.168.0.223

**Subnet 15:**

    Network Address:   192.168.0.224
    CIDR Notation:     192.168.0.224/28
    Usable IP Range:   192.168.0.225 - 192.168.0.238
    Broadcast Address: 192.168.0.239

**Subnet 16:**

    Network Address:   192.168.0.240
    CIDR Notation:     192.168.0.240/28
    Usable IP Range:   192.168.0.241 - 192.168.0.254
    Broadcast Address: 192.168.0.255

---

## /29 Subnets

*   **Number of Subnets:** 2^(29-24) = 2^5 = 32
*   **Hosts per Subnet:** 2^(32-29) = 2^3 = 8 (6 usable)
*   **Block Size:** 8
*   **Subnet Mask:** 255.255.255.248

**Subnet 1:**

    Network Address:   192.168.0.0
    CIDR Notation:     192.168.0.0/29
    Usable IP Range:   192.168.0.1 - 192.168.0.6
    Broadcast Address: 192.168.0.7

**Subnet 2:**

    Network Address:   192.168.0.8
    CIDR Notation:     192.168.0.8/29
    Usable IP Range:   192.168.0.9 - 192.168.0.14
    Broadcast Address: 192.168.0.15

**Subnet 3:**

    Network Address:   192.168.0.16
    CIDR Notation:     192.168.0.16/29
    Usable IP Range:   192.168.0.17 - 192.168.0.22
    Broadcast Address: 192.168.0.23

**Subnet 4:**

    Network Address:   192.168.0.24
    CIDR Notation:     192.168.0.24/29
    Usable IP Range:   192.168.0.25 - 192.168.0.30
    Broadcast Address: 192.168.0.31

**Subnet 5:**

    Network Address:   192.168.0.32
    CIDR Notation:     192.168.0.32/29
    Usable IP Range:   192.168.0.33 - 192.168.0.38
    Broadcast Address: 192.168.0.39

**Subnet 6:**

    Network Address:   192.168.0.40
    CIDR Notation:     192.168.0.40/29
    Usable IP Range:   192.168.0.41 - 192.168.0.46
    Broadcast Address: 192.168.0.47

**Subnet 7:**

    Network Address:   192.168.0.48
    CIDR Notation:     192.168.0.48/29
    Usable IP Range:   192.168.0.49 - 192.168.0.54
    Broadcast Address: 192.168.0.55

**Subnet 8:**

    Network Address:   192.168.0.56
    CIDR Notation:     192.168.0.56/29
    Usable IP Range:   192.168.0.57 - 192.168.0.62
    Broadcast Address: 192.168.0.63

**Subnet 9:**

    Network Address:   192.168.0.64
    CIDR Notation:     192.168.0.64/29
    Usable IP Range:   192.168.0.65 - 192.168.0.70
    Broadcast Address: 192.168.0.71

**Subnet 10:**

    Network Address:   192.168.0.72
    CIDR Notation:     192.168.0.72/29
    Usable IP Range:   192.168.0.73 - 192.168.0.78
    Broadcast Address: 192.168.0.79

**Subnet 11:**

    Network Address:   192.168.0.80
    CIDR Notation:     192.168.0.80/29
    Usable IP Range:   192.168.0.81 - 192.168.0.86
    Broadcast Address: 192.168.0.87

**Subnet 12:**

    Network Address:   192.168.0.88
    CIDR Notation:     192.168.0.88/29
    Usable IP Range:   192.168.0.89 - 192.168.0.94
    Broadcast Address: 192.168.0.95

**Subnet 13:**

    Network Address:   192.168.0.96
    CIDR Notation:     192.168.0.96/29
    Usable IP Range:   192.168.0.97 - 192.168.0.102
    Broadcast Address: 192.168.0.103

**Subnet 14:**

    Network Address:   192.168.0.104
    CIDR Notation:     192.168.0.104/29
    Usable IP Range:   192.168.0.105 - 192.168.0.110
    Broadcast Address: 192.168.0.111

**Subnet 15:**

    Network Address:   192.168.0.112
    CIDR Notation:     192.168.0.112/29
    Usable IP Range:   192.168.0.113 - 192.168.0.118
    Broadcast Address: 192.168.0.119

**Subnet 16:**

    Network Address:   192.168.0.120
    CIDR Notation:     192.168.0.120/29
    Usable IP Range:   192.168.0.121 - 192.168.0.126
    Broadcast Address: 192.168.0.127

**Subnet 17:**

    Network Address:   192.168.0.128
    CIDR Notation:     192.168.0.128/29
    Usable IP Range:   192.168.0.129 - 192.168.0.134
    Broadcast Address: 192.168.0.135

**Subnet 18:**

    Network Address:   192.168.0.136
    CIDR Notation:     192.168.0.136/29
    Usable IP Range:   192.168.0.137 - 192.168.0.142
    Broadcast Address: 192.168.0.143

**Subnet 19:**

    Network Address:   192.168.0.144
    CIDR Notation:     192.168.0.144/29
    Usable IP Range:   192.168.0.145 - 192.168.0.150
    Broadcast Address: 192.168.0.151

**Subnet 20:**

    Network Address:   192.168.0.152
    CIDR Notation:     192.168.0.152/29
    Usable IP Range:   192.168.0.153 - 192.168.0.158
    Broadcast Address: 192.168.0.159

**Subnet 21:**

    Network Address:   192.168.0.160
    CIDR Notation:     192.168.0.160/29
    Usable IP Range:   192.168.0.161 - 192.168.0.166
    Broadcast Address: 192.168.0.167

**Subnet 22:**

    Network Address:   192.168.0.168
    CIDR Notation:     192.168.0.168/29
    Usable IP Range:   192.168.0.169 - 192.168.0.174
    Broadcast Address: 192.168.0.175

**Subnet 23:**

    Network Address:   192.168.0.176
    CIDR Notation:     192.168.0.176/29
    Usable IP Range:   192.168.0.177 - 192.168.0.182
    Broadcast Address: 192.168.0.183

**Subnet 24:**

    Network Address:   192.168.0.184
    CIDR Notation:     192.168.0.184/29
    Usable IP Range:   192.168.0.185 - 192.168.0.190
    Broadcast Address: 192.168.0.191

**Subnet 25:**

    Network Address:   192.168.0.192
    CIDR Notation:     192.168.0.192/29
    Usable IP Range:   192.168.0.193 - 192.168.0.198
    Broadcast Address: 192.168.0.199

**Subnet 26:**

    Network Address:   192.168.0.200
    CIDR Notation:     192.168.0.200/29
    Usable IP Range:   192.168.0.201 - 192.168.0.206
    Broadcast Address: 192.168.0.207

**Subnet 27:**

    Network Address:   192.168.0.208
    CIDR Notation:     192.168.0.208/29
    Usable IP Range:   192.168.0.209 - 192.168.0.214
    Broadcast Address: 192.168.0.215

**Subnet 28:**

    Network Address:   192.168.0.216
    CIDR Notation:     192.168.0.216/29
    Usable IP Range:   192.168.0.217 - 192.168.0.222
    Broadcast Address: 192.168.0.223

**Subnet 29:**

    Network Address:   192.168.0.224
    CIDR Notation:     192.168.0.224/29
    Usable IP Range:   192.168.0.225 - 192.168.0.230
    Broadcast Address: 192.168.0.231

**Subnet 30:**

    Network Address:   192.168.0.232
    CIDR Notation:     192.168.0.232/29
    Usable IP Range:   192.168.0.233 - 192.168.0.238
    Broadcast Address: 192.168.0.239

**Subnet 31:**

    Network Address:   192.168.0.240
    CIDR Notation:     192.168.0.240/29
    Usable IP Range:   192.168.0.241 - 192.168.0.246
    Broadcast Address: 192.168.0.247

**Subnet 32:**

    Network Address:   192.168.0.248
    CIDR Notation:     192.168.0.248/29
    Usable IP Range:   192.168.0.249 - 192.168.0.254
    Broadcast Address: 192.168.0.255

---

## /30 Subnets

*   **Number of Subnets:** 2^(30-24) = 2^6 = 64
*   **Hosts per Subnet:** 2^(32-30) = 2^2 = 4 (2 usable)
*   **Block Size:** 4
*   **Subnet Mask:** 255.255.255.252
*   *Commonly used for point-to-point links.*

**Subnet 1:**

    Network Address:   192.168.0.0
    CIDR Notation:     192.168.0.0/30
    Usable IP Range:   192.168.0.1 - 192.168.0.2
    Broadcast Address: 192.168.0.3

**Subnet 2:**

    Network Address:   192.168.0.4
    CIDR Notation:     192.168.0.4/30
    Usable IP Range:   192.168.0.5 - 192.168.0.6
    Broadcast Address: 192.168.0.7

**Subnet 3:**

    Network Address:   192.168.0.8
    CIDR Notation:     192.168.0.8/30
    Usable IP Range:   192.168.0.9 - 192.168.0.10
    Broadcast Address: 192.168.0.11

**Subnet 4:**

    Network Address:   192.168.0.12
    CIDR Notation:     192.168.0.12/30
    Usable IP Range:   192.168.0.13 - 192.168.0.14
    Broadcast Address: 192.168.0.15

**Subnet 5:**

    Network Address:   192.168.0.16
    CIDR Notation:     192.168.0.16/30
    Usable IP Range:   192.168.0.17 - 192.168.0.18
    Broadcast Address: 192.168.0.19

**Subnet 6:**

    Network Address:   192.168.0.20
    CIDR Notation:     192.168.0.20/30
    Usable IP Range:   192.168.0.21 - 192.168.0.22
    Broadcast Address: 192.168.0.23

**Subnet 7:**

    Network Address:   192.168.0.24
    CIDR Notation:     192.168.0.24/30
    Usable IP Range:   192.168.0.25 - 192.168.0.26
    Broadcast Address: 192.168.0.27

**Subnet 8:**

    Network Address:   192.168.0.28
    CIDR Notation:     192.168.0.28/30
    Usable IP Range:   192.168.0.29 - 192.168.0.30
    Broadcast Address: 192.168.0.31

**Subnet 9:**

    Network Address:   192.168.0.32
    CIDR Notation:     192.168.0.32/30
    Usable IP Range:   192.168.0.33 - 192.168.0.34
    Broadcast Address: 192.168.0.35

**Subnet 10:**

    Network Address:   192.168.0.36
    CIDR Notation:     192.168.0.36/30
    Usable IP Range:   192.168.0.37 - 192.168.0.38
    Broadcast Address: 192.168.0.39

**Subnet 11:**

    Network Address:   192.168.0.40
    CIDR Notation:     192.168.0.40/30
    Usable IP Range:   192.168.0.41 - 192.168.0.42
    Broadcast Address: 192.168.0.43

**Subnet 12:**

    Network Address:   192.168.0.44
    CIDR Notation:     192.168.0.44/30
    Usable IP Range:   192.168.0.45 - 192.168.0.46
    Broadcast Address: 192.168.0.47

**Subnet 13:**

    Network Address:   192.168.0.48
    CIDR Notation:     192.168.0.48/30
    Usable IP Range:   192.168.0.49 - 192.168.0.50
    Broadcast Address: 192.168.0.51

**Subnet 14:**

    Network Address:   192.168.0.52
    CIDR Notation:     192.168.0.52/30
    Usable IP Range:   192.168.0.53 - 192.168.0.54
    Broadcast Address: 192.168.0.55

**Subnet 15:**

    Network Address:   192.168.0.56
    CIDR Notation:     192.168.0.56/30
    Usable IP Range:   192.168.0.57 - 192.168.0.58
    Broadcast Address: 192.168.0.59

**Subnet 16:**

    Network Address:   192.168.0.60
    CIDR Notation:     192.168.0.60/30
    Usable IP Range:   192.168.0.61 - 192.168.0.62
    Broadcast Address: 192.168.0.63

**Subnet 17:**

    Network Address:   192.168.0.64
    CIDR Notation:     192.168.0.64/30
    Usable IP Range:   192.168.0.65 - 192.168.0.66
    Broadcast Address: 192.168.0.67

**Subnet 18:**

    Network Address:   192.168.0.68
    CIDR Notation:     192.168.0.68/30
    Usable IP Range:   192.168.0.69 - 192.168.0.70
    Broadcast Address: 192.168.0.71

**Subnet 19:**

    Network Address:   192.168.0.72
    CIDR Notation:     192.168.0.72/30
    Usable IP Range:   192.168.0.73 - 192.168.0.74
    Broadcast Address: 192.168.0.75

**Subnet 20:**

    Network Address:   192.168.0.76
    CIDR Notation:     192.168.0.76/30
    Usable IP Range:   192.168.0.77 - 192.168.0.78
    Broadcast Address: 192.168.0.79

**Subnet 21:**

    Network Address:   192.168.0.80
    CIDR Notation:     192.168.0.80/30
    Usable IP Range:   192.168.0.81 - 192.168.0.82
    Broadcast Address: 192.168.0.83

**Subnet 22:**

    Network Address:   192.168.0.84
    CIDR Notation:     192.168.0.84/30
    Usable IP Range:   192.168.0.85 - 192.168.0.86
    Broadcast Address: 192.168.0.87

**Subnet 23:**

    Network Address:   192.168.0.88
    CIDR Notation:     192.168.0.88/30
    Usable IP Range:   192.168.0.89 - 192.168.0.90
    Broadcast Address: 192.168.0.91

**Subnet 24:**

    Network Address:   192.168.0.92
    CIDR Notation:     192.168.0.92/30
    Usable IP Range:   192.168.0.93 - 192.168.0.94
    Broadcast Address: 192.168.0.95

**Subnet 25:**

    Network Address:   192.168.0.96
    CIDR Notation:     192.168.0.96/30
    Usable IP Range:   192.168.0.97 - 192.168.0.98
    Broadcast Address: 192.168.0.99

**Subnet 26:**

    Network Address:   192.168.0.100
    CIDR Notation:     192.168.0.100/30
    Usable IP Range:   192.168.0.101 - 192.168.0.102
    Broadcast Address: 192.168.0.103

**Subnet 27:**

    Network Address:   192.168.0.104
    CIDR Notation:     192.168.0.104/30
    Usable IP Range:   192.168.0.105 - 192.168.0.106
    Broadcast Address: 192.168.0.107

**Subnet 28:**

    Network Address:   192.168.0.108
    CIDR Notation:     192.168.0.108/30
    Usable IP Range:   192.168.0.109 - 192.168.0.110
    Broadcast Address: 192.168.0.111

**Subnet 29:**

    Network Address:   192.168.0.112
    CIDR Notation:     192.168.0.112/30
    Usable IP Range:   192.168.0.113 - 192.168.0.114
    Broadcast Address: 192.168.0.115

**Subnet 30:**

    Network Address:   192.168.0.116
    CIDR Notation:     192.168.0.116/30
    Usable IP Range:   192.168.0.117 - 192.168.0.118
    Broadcast Address: 192.168.0.119

**Subnet 31:**

    Network Address:   192.168.0.120
    CIDR Notation:     192.168.0.120/30
    Usable IP Range:   192.168.0.121 - 192.168.0.122
    Broadcast Address: 192.168.0.123

**Subnet 32:**

    Network Address:   192.168.0.124
    CIDR Notation:     192.168.0.124/30
    Usable IP Range:   192.168.0.125 - 192.168.0.126
    Broadcast Address: 192.168.0.127

**Subnet 33:**

    Network Address:   192.168.0.128
    CIDR Notation:     192.168.0.128/30
    Usable IP Range:   192.168.0.129 - 192.168.0.130
    Broadcast Address: 192.168.0.131

**Subnet 34:**

    Network Address:   192.168.0.132
    CIDR Notation:     192.168.0.132/30
    Usable IP Range:   192.168.0.133 - 192.168.0.134
    Broadcast Address: 192.168.0.135

**Subnet 35:**

    Network Address:   192.168.0.136
    CIDR Notation:     192.168.0.136/30
    Usable IP Range:   192.168.0.137 - 192.168.0.138
    Broadcast Address: 192.168.0.139

**Subnet 36:**

    Network Address:   192.168.0.140
    CIDR Notation:     192.168.0.140/30
    Usable IP Range:   192.168.0.141 - 192.168.0.142
    Broadcast Address: 192.168.0.143

**Subnet 37:**

    Network Address:   192.168.0.144
    CIDR Notation:     192.168.0.144/30
    Usable IP Range:   192.168.0.145 - 192.168.0.146
    Broadcast Address: 192.168.0.147

**Subnet 38:**

    Network Address:   192.168.0.148
    CIDR Notation:     192.168.0.148/30
    Usable IP Range:   192.168.0.149 - 192.168.0.150
    Broadcast Address: 192.168.0.151

**Subnet 39:**

    Network Address:   192.168.0.152
    CIDR Notation:     192.168.0.152/30
    Usable IP Range:   192.168.0.153 - 192.168.0.154
    Broadcast Address: 192.168.0.155

**Subnet 40:**

    Network Address:   192.168.0.156
    CIDR Notation:     192.168.0.156/30
    Usable IP Range:   192.168.0.157 - 192.168.0.158
    Broadcast Address: 192.168.0.159

**Subnet 41:**

    Network Address:   192.168.0.160
    CIDR Notation:     192.168.0.160/30
    Usable IP Range:   192.168.0.161 - 192.168.0.162
    Broadcast Address: 192.168.0.163

**Subnet 42:**

    Network Address:   192.168.0.164
    CIDR Notation:     192.168.0.164/30
    Usable IP Range:   192.168.0.165 - 192.168.0.166
    Broadcast Address: 192.168.0.167

**Subnet 43:**

    Network Address:   192.168.0.168
    CIDR Notation:     192.168.0.168/30
    Usable IP Range:   192.168.0.169 - 192.168.0.170
    Broadcast Address: 192.168.0.171

**Subnet 44:**

    Network Address:   192.168.0.172
    CIDR Notation:     192.168.0.172/30
    Usable IP Range:   192.168.0.173 - 192.168.0.174
    Broadcast Address: 192.168.0.175

**Subnet 45:**

    Network Address:   192.168.0.176
    CIDR Notation:     192.168.0.176/30
    Usable IP Range:   192.168.0.177 - 192.168.0.178
    Broadcast Address: 192.168.0.179

**Subnet 46:**

    Network Address:   192.168.0.180
    CIDR Notation:     192.168.0.180/30
    Usable IP Range:   192.168.0.181 - 192.168.0.182
    Broadcast Address: 192.168.0.183

**Subnet 47:**

    Network Address:   192.168.0.184
    CIDR Notation:     192.168.0.184/30
    Usable IP Range:   192.168.0.185 - 192.168.0.186
    Broadcast Address: 192.168.0.187

**Subnet 48:**

    Network Address:   192.168.0.188
    CIDR Notation:     192.168.0.188/30
    Usable IP Range:   192.168.0.189 - 192.168.0.190
    Broadcast Address: 192.168.0.191

**Subnet 49:**

    Network Address:   192.168.0.192
    CIDR Notation:     192.168.0.192/30
    Usable IP Range:   192.168.0.193 - 192.168.0.194
    Broadcast Address: 192.168.0.195

**Subnet 50:**

    Network Address:   192.168.0.196
    CIDR Notation:     192.168.0.196/30
    Usable IP Range:   192.168.0.197 - 192.168.0.198
    Broadcast Address: 192.168.0.199

**Subnet 51:**

    Network Address:   192.168.0.200
    CIDR Notation:     192.168.0.200/30
    Usable IP Range:   192.168.0.201 - 192.168.0.202
    Broadcast Address: 192.168.0.203

**Subnet 52:**

    Network Address:   192.168.0.204
    CIDR Notation:     192.168.0.204/30
    Usable IP Range:   192.168.0.205 - 192.168.0.206
    Broadcast Address: 192.168.0.207

**Subnet 53:**

    Network Address:   192.168.0.208
    CIDR Notation:     192.168.0.208/30
    Usable IP Range:   192.168.0.209 - 192.168.0.210
    Broadcast Address: 192.168.0.211

**Subnet 54:**

    Network Address:   192.168.0.212
    CIDR Notation:     192.168.0.212/30
    Usable IP Range:   192.168.0.213 - 192.168.0.214
    Broadcast Address: 192.168.0.215

**Subnet 55:**

    Network Address:   192.168.0.216
    CIDR Notation:     192.168.0.216/30
    Usable IP Range:   192.168.0.217 - 192.168.0.218
    Broadcast Address: 192.168.0.219

**Subnet 56:**

    Network Address:   192.168.0.220
    CIDR Notation:     192.168.0.220/30
    Usable IP Range:   192.168.0.221 - 192.168.0.222
    Broadcast Address: 192.168.0.223

**Subnet 57:**

    Network Address:   192.168.0.224
    CIDR Notation:     192.168.0.224/30
    Usable IP Range:   192.168.0.225 - 192.168.0.226
    Broadcast Address: 192.168.0.227

**Subnet 58:**

    Network Address:   192.168.0.228
    CIDR Notation:     192.168.0.228/30
    Usable IP Range:   192.168.0.229 - 192.168.0.230
    Broadcast Address: 192.168.0.231

**Subnet 59:**

    Network Address:   192.168.0.232
    CIDR Notation:     192.168.0.232/30
    Usable IP Range:   192.168.0.233 - 192.168.0.234
    Broadcast Address: 192.168.0.235

**Subnet 60:**

    Network Address:   192.168.0.236
    CIDR Notation:     192.168.0.236/30
    Usable IP Range:   192.168.0.237 - 192.168.0.238
    Broadcast Address: 192.168.0.239

**Subnet 61:**

    Network Address:   192.168.0.240
    CIDR Notation:     192.168.0.240/30
    Usable IP Range:   192.168.0.241 - 192.168.0.242
    Broadcast Address: 192.168.0.243

**Subnet 62:**

    Network Address:   192.168.0.244
    CIDR Notation:     192.168.0.244/30
    Usable IP Range:   192.168.0.245 - 192.168.0.246
    Broadcast Address: 192.168.0.247

**Subnet 63:**

    Network Address:   192.168.0.248
    CIDR Notation:     192.168.0.248/30
    Usable IP Range:   192.168.0.249 - 192.168.0.250
    Broadcast Address: 192.168.0.251

**Subnet 64:**

    Network Address:   192.168.0.252
    CIDR Notation:     192.168.0.252/30
    Usable IP Range:   192.168.0.253 - 192.168.0.254
    Broadcast Address: 192.168.0.255

---