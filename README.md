# About script
The script is created via bash. This is used to determine/check which ports are open on any target specififed.

```
To start scanning to see which ports are open, do the following.

Syntax: ./port-list.sh -t '10.0.0.1' 22,443 or ./port-list.sh -a '10.0.0.1'


      -h     For help or detail on how to use the command.
      -a     For performing a scan on all ports from 0-65535.
      -t     Specify the target.
```