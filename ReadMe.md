# Script for the quick initial config macOS to strart working with Ya.Praktikum
## Usage
Open Terminal program (Open Spootlight and start typing Terminal or `Applications -> Utilities -> Terminal` ) and paste following code:
```bash
sh -c "$(curl -fsSL  https://raw.githubusercontent.com/ilyakubryakov/macos_ya.p_initial_config/main/config.sh)"
```
The script will install the following applications:

```
Xcode Command Line Tools
Homebrew
Oh-my-zsh
iTerm2
python@3.9
virtualenv
wget
curl
git
zsh
```
and following python libs:
```
attrs==21.2.0
flake8==4.0.1
importlib-metadata==4.8.1
iniconfig==1.1.1
mccabe==0.6.1
packaging==21.0
pluggy==1.0.0
py==1.10.0
pycodestyle==2.8.0
pyflakes==2.4.0
pyparsing==2.4.7
pytest==6.2.5
pytest-tldr==0.2.4
toml==0.10.2
typing-extensions==3.10.0.2
zipp==3.6.0
```
