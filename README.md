# lab-security-onion
for my infosec class

First boot takes 5 minutes for some reason, hangs on black screen.
Something to do with securityonion freaking out about the NICs having
changed, I think. Subsequent boots are much faster.

```
Vagrant.configure("2") do |config|

  config.vm.box = "deargle/security-onion"
 
end 
```
