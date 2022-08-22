# NITS Proxy
NITS Proxy for Terminal Commands (except SSH)

**NOTE: Git no longer allows authentication through HTTPS (only SSH), and setting http.proxy for git won't do anything unless using personal access token or OAuth in some form like VSCode GitHub Pull & Push Request extension**

## Windows

`Proxy Settings` -> Turn on `Use a proxy server`

Address (For Hostels) : `172.16.199.40` <br>
Address (For Labs & Library) : `172.16.199.20` <br>
Port : `8080` <br>
Exception (Big Input Box) : `*.local` <br>

**NOTE: Turn off proxy when connected to mobile hotspot. Also check [manual installations](#manual-installation-for-some-technologies) if some tools don't inherit the proxy values from system**

## Linux

This will enable you to switch between Hostel Proxy, Lab & Library Proxy and Mobile Hostpot with just one easy-to-remember command.

### Installation
```
git clone https://github.com/resyfer/nits_proxy.git
cd nits_proxy
sudo ./install.sh
cd .. && rm -rf nits_proxy
```
*NOTE: During the prompts, the values inside `[]` in italics are default values, you can press `Enter` without giving any value, and it will take the default value*

<br>

*NOTE: Only if you use a shell different from `bash` then you need to add the line given below to the rc file of your shell (eg. `~/.zshrc`, etc.)*

`alias nits='source nitsproxy.sh'`

### Sourcing `~.bashrc`

*NOTE: If you use a shell different from `bash` then you need to replace `bashrc` in the line below to the rc file of your shell (eg. `~/.zshrc`, etc.)*

```
source ~/.bashrc
```

or you can close the terminal and start a new one.

### Run the Script
```
nits
```
## Manual Installation For Some Technologies

*NOTE: If you are using Linux and have installed the script, you are not required to do these steps unless the individual tools are not working as intended.*

*For other operating systems, you might have to set and unset the proxies manually if they don't inherit the proxy settings from the system.*

## Git
### set
```bash
# For hostels
git config --global http.proxy http://172.16.199.40:8080
git config --global https.proxy http://172.16.199.40:8080

# For labs and library
git config --global http.proxy http://172.16.199.20:8080
git config --global https.proxy http://172.16.199.20:8080
```
### unset
```bash
git config --global --unset http.proxy
git config --global --unset https.proxy
```
### check current proxy
```bash
git config --global --get htts.proxy
git config --global --get http.proxy
```

## npm
### set
```bash
# For hostels
npm config set proxy http://172.16.199.40:8080
npm config set https-proxy http://172.16.199.40:8080

# For labs and library
npm config set proxy http://172.16.199.20:8080
npm config set https-proxy http://172.16.199.20:8080
```
### unset
```bash
npm config rm proxy
npm config rm https-proxy
```
## pip
### Linux
```bash
# For hostels
sudo pip install --proxy http://172.16.199.40:8080 <pkg_name>

# For labs and library
sudo pip install --proxy http://172.16.199.20:8080 <pkg_name>
```
### Windows
```bash
# For hostels
pip install --proxy http://172.16.199.40:8080 <pkg_name>

# For labs and library
pip install --proxy http://172.16.199.20:8080 <pkg_name>

```
## Visual Studio Code
This sets both http and https proxy.
`Settings > Search for "proxy" > Https: Proxy`
