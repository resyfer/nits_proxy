# NITS Proxy
NITS Proxy for Terminal Commands (except SSH & Git)

**NOTE: Git no longer allows authentication through HTTPS (only SSH), and setting http.proxy for git won't do anything**

## Windows

`Proxy Settings` -> Turn on `Use a proxy server`

Address (For Hostels) : `172.16.199.40` <br>
Address (For Labs & Library) : `172.16.199.20` <br>
Port : `8080` <br>
Exception (Big Input Box) : `*.local` <br>

### Npm
```
npm config set http-proxy http://172.16.199.40:8080
npm config set https-proxy http://172.16.199.40:8080
```
*NOTE: Change the values according to the proxy address*

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
