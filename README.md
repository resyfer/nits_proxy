**NOTE: This project is an unrepairable mess, and has poor design. A better one's available [here](https://github.com/resyfer/proxy) and so please make any contributions or issues there! Thanks!**

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

```bash
$ git clone https://github.com/resyfer/nits_proxy.git
$ cd nits_proxy
$ sudo ./install.sh
$ cd .. && rm -rf nits_proxy
```

_NOTE: During the prompts, the values inside `[]` in italics are default values, you can press `Enter` without giving any value, and it will take the default value_

<br>

_NOTE: Only if you use a shell different from `bash` then you need to add the line given below to the rc file of your shell (eg. `~/.zshrc`, etc.)_

`alias nits='source nitsproxy.sh'`

### Sourcing `~.bashrc`

_NOTE: If you use a shell different from `bash` then you need to replace `bashrc` in the line below to the rc file of your shell (eg. `~/.zshrc`, etc.)_

```bash
$ source ~/.bashrc
```

or you can close the terminal and start a new one.

### Updating
```bash
$ sudo cp nitsproxy.sh /bin
```

### Run the Script

```bash
$ nits
```

## Manual Installation For Some Technologies

_NOTE: If you are using Linux and have installed the script, you are not required to do these steps unless the individual tools are not working as intended._

_For other operating systems, you might have to set and unset the proxies manually if they don't inherit the proxy settings from the system._

## Proxy Values

- BH9 : `http://172.16.199.41:8080`
- Other Hostels : `http://172.16.199.40:8080`
- Labs and Libraries : `http://172.16.199.20:8080`
- Mobile Hostpot : None

## Git

### set

```bash
$ git config --global http.proxy PROXY_VALUE
$ git config --global https.proxy PROXY_VALUE
```

### unset

```bash
$ git config --global --unset http.proxy
$ git config --global --unset https.proxy
```

### check current proxy

```bashbash
$ git config --global --get http.proxy
$ git config --global --get http.proxy
```

## npm

### set

```bash
$ npm config set proxy PROXY_VALUE
$ npm config set https-proxy PROXY_VALUE
```

### unset

```bash
$ npm config rm proxy
$ npm config rm https-proxy
```

## pip

### Linux

```bash
$ sudo pip install --proxy PROXY_VALUE <pkg_name>
```

### Windows

```bash
$ pip install --proxy PROXY_VALUE <pkg_name>
```

## Visual Studio Code

This sets both http and https proxy.
`Settings > Search for "proxy" > Https: Proxy`
