# scripts

```
ln -s .bashrc .bash_profile
```

```
.bash_profile -> /Users/user1/.bashrc
```

Redirection metacharacters, pipe etc:
```
>
1>
2>
2>&1
|
2>&1|
|&
>>
tee
<
cut
sort
```
Note: `>` is same as `1>`. `2>&1|` is same as `|&`.

Examples:
```
$ some_command >a.log 2>&1
```

Shell special parameters / characters / variables:

Note: `See https://www.gnu.org/software/bash/manual/html_node/Special-Parameters.html`
```
$0, $#, $?, $^, $*, $@, $!, $$, $-, $<
```


# Git commands
Ref: See 26/10/2023 notes.
```
git lol
git remote -v
git branch -vv
git status
git checkout -b my-bug-123 --track upstream/master
git difftool --tool-help
git difftool [commit1..commit2 [filename]]
git diff --no-ext-diff
git config --list --show-origin
git remote add upstream my-url
```
Make existing branch track remote branch:
```
git branch -u upstream/foo my-bug-123
```
Remove/clear tracking from existing branch my-bug-123:
```
git branch my-bug-123
```
Following command will create Pull Request (PR) from my-bug-123 to the tracked branch:
```
git push origin my-bug-123
``` 

Git reset:
```
git reset --soft
git reset --mixed
git reset --hard
```

commit-id~n^k eg `8673a~3^2` denotes the kth parent of the nth ancestor of given commit-id.

# Commands

Vault (It is just one 180M executable file)
```
$ ~/location/to/vault/executable-dir/vault -h
$ vault -h
$ vault list -h
```

Using tee to get command output on terminal and file
```
$ whatever_command |& tee log.out
```

CDBDUMP
```
$ cdbdump < foo.cdb | grep whatever
```

OpenSSL
```
$ openssl enc -help
$ openssl crl2pkcs7 -nocrl -certfile /path/to/server_cert.pem | openssl pkcs7 -print_certs -text -noout | grep Subject:
$ openssl base64 -d < ~/.ssh/id_rsa | od -c
$ openssl s_client -connect example.com:88888
$ openssl s_client -connect example.com:88888 -showcerts
```

Show RSA fingerprint of SSH agent representing `~/.ssh/id_rsa`:
```
$ ssh-keygen -y -f ~/.ssh/id_rsa -E md5
```
or
```
$ ssh-keygen -l -f ~/.ssh/id_rsa -E md5 -v
```
or
```
$ ssh-keygen -l -f ~/.ssh/id_rsa.pub -E md5 -v
```
or
```
$ ssh-add -l -E md5
```

Show RSA fingerprints of SSH known\_hosts:
```
$ ssh-keygen -l -f ~/.ssh/known_hosts -E md5 -v
```

Check github hostkey fingerprint:
```
$ ssh -T git@github.com -o FingerPrintHash=md5 -o VisualHostKey=yes
```

GnuPG config file:
```
~/.gnupg/gpg-agent.conf
```
Can add entry for pinentry-mac to `gpg-agent.conf`.
Kill agent:
```
$ gpgconf --kill gpg-agent
```
Show GnuPG keys:
```
$ gpg --list-keys --keyid-format LONG --fingerprint
$ gpg --list-secret-keys --keyid-format LONG --fingerprint
```


Connectivity
```
$ nc -zv 21.325.343.36 88888
$ nc -zv example.com 22222

$ host example.com
$ nslookup example.com
```

TCPDUMP
```
$ tcpdump -i bond0 -s 0 -vv -w /var/tmp/capture.pcap dst port 21763
$ tcpdump -i eth0 -s 0 -vv -w /var/tmp/capture.pcap dst port 21763 
```

Docker Spark setup:
```
$ docker pull jupyter/all-spark-notebook:95f855f8e55f
$ docker images
$ docker run -p 8888:8888 -p 4040:4040 --name spark2 jupyter/all-spark-notebook:95f855f8e55f
$ docker ps
```
Check http://localhost:8888
```
$ chmod -R 777 path/to/datasets
$ docker cp path/to/datasets spark2:/home/user1
$ docker start spark2
$ docker exec -it spark2 /bin/bash
user1@ac43267cb8c4:~$ who
```
