# InstaPassBy

<Image Source="Assets/![alt text](Instapass.png)" Width="200"/>



BruteForce For Social Media Account Instagram

InstaPassBy
InstaPassBy is an Shell Script to perform multi-threaded brute force attack against Instagram, this script can bypass login limiting and it can test infinite number of passwords with a rate of about 1000 passwords/min with 100 attemps at once.


Features
Multi-thread (100 attempts at once)

Save/Resume sessions

Anonymous attack through TOR

Check valid usernames

Default password list (best +39k 8 letters)

Check and Install all dependencies

Usage: git clone https://github.com/Jmslgsc/InstaPassBy.git

cd InstaPassBy

chmod +x Main.sh

sudo ./Main.sh

Install requirements (Curl, Tor, Openssl):

chmod +x Setup.sh

sudo ./Setup.sh


How it works?
Script uses an Android ApkSignature to perform authentication in addition using TOR instances to avoid blocking. The script uses Instagram-py algorithm (Python), see the project at: https://github.com/Jmslgsc

Legal Disclaimer:
Usage of the tool for attacking targets without prior mutual consent is illegal. It's the end user's responsibility to obey all applicable local, state and federal laws. Developers assume no liability and are not responsible for any misuse or damage caused by this program

Tool is created to help in penetration testing and it's not responsible for any misuse or illegal purposes.

inspired by https://github.com/Jmslgsc Big thanks to @Jmslgsc


---

## Legal & Safety Notice

⚠️ **Important — Demo / Educational Release**

This repository contains a **demo-safe** branch intended for learning and demonstrations.  
The public `demo-safe` branch **does not** perform real network attacks. A separate `full-test` branch (kept private) contains full behavior for authorized testing only.

**DO NOT** run the real behavior unless you:
1. Own the target or have explicit written permission to test it;  
2. Run the script in an isolated, controlled environment (e.g., disposable VM); and  
3. Intentionally enable real execution by running:
   ```bash
   export ENABLE_REAL_RUN=1
   sudo ./Main.sh --run-real

yes
