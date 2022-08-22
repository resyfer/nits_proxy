# NITS Proxy
NITS Proxy for Terminal Commands (except SSH & Git)

**NOTE: Git no longer allows authentication through HTTPS (only SSH), and setting http.proxy for git won't do anything unless using personal access token or OAuth in some form like VSCode GitHub Pull & Push Request extension**

## Windows

`Proxy Settings` -> Turn on `Use a proxy server`

Address (For Hostels) : `172.16.199.40` <br>
Address (For Labs & Library) : `172.16.199.20` <br>
Port : `8080` <br>
Exception (Big Input Box) : `*.local` <br>

**NOTE: Turn off proxy for mobile hotspot**

## Linux

This will enable you to switch between Hostel Proxy, Lab & Library Proxy and Mobile Hostpot with just one easy-to-remember command (Hint: College Initials).

### Installation
```
git clone https://github.com/resyfer/nits_proxy.git
cd nits_proxy
sudo ./install.sh
cd .. && rm -rf nits_proxy
```
*NOTE: The values inside `[]` are default values, you can press Enter without giving any value, and it will take the default value in*

<br>

*NOTE: If you use a shell different from `bash` then you need to add the line given below to the rc file of your shell (eg. `~/.zshrc`, etc.)*

`alias nits='source nitsproxy.sh'`

### Sourcing `~.bashrc`

*NOTE: If you use a shell different from `bash` then you need to replace `bashrc` in the line below to the rc file of your shell (eg. `~/.zshrc`, etc.)*

```
source ~/.bashrc
```

### Run the Script
```
nits
```
## Manual Installation For Some Technologies
*NOTE: If any of the technologies mentioned are working as intended after the above steps, you do not have to set their proxies manually.*
## Git
### set
```bash
#for hostels
git config --global http.proxy http://172.16.199.40:8080
git config --global https.proxy http://172.16.199.40:8080

#for labs and library
git config --global http.proxy http://172.16.199.20:8080
git config --global https.proxy http://172.16.199.20:8080
```
### unset
```
npm config rm proxy
npm config rm https-proxy
```
### check current proxy
```
git config --global --get htts.proxy
git config --global --get http.proxy
```

## npm
### set
```bash
#for hostels
npm config set proxy http://172.16.199.40:8080
npm config set https-proxy http://172.16.199.40:8080

#for labs and library
npm config set proxy http://172.16.199.20:8080
npm config set https-proxy http://172.16.199.20:8080
```
### unset
```
git config --global --unset http.proxy
git config --global --unset https.proxy
```
## pip
### Linux
```bash
#for hostels
sudo pip install --proxy http://172.16.199.40:8080 <pkg_name> 

#for labs and library
sudo pip install --proxy http://172.16.199.20:8080 <pkg_name> 
```
### Windows
```bash
#For hostels
pip install --proxy http://172.16.199.40:8080 <pkg_name> 

#For labs and library
pip install --proxy http://172.16.199.20:8080 <pkg_name> 

```
## Visual Studio Code
This sets both http and https proxy.  
`Settings> Search for "proxy"> Https: Proxy`