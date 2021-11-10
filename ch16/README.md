## Exercise from [Cybersecurity Ops with bash](https://www.oreilly.com/library/view/cybersecurity-ops-with/9781492041306/)

Remote-access tool from chapter 16

``` bash
vagrant up

# On attacker machine
vagrant ssh attacker
./LocalRat.sh

# On target machine - In another terminal
vagrant ssh target
./RemoteRat.sh

# Go back to attacker terminal
ip a
# Any command that you want
```

