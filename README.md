# scripts

```
ln -s .bashrc .bash_profile
```

```
.bash_profile -> /Users/user1/.bashrc
```

For more commands see https://github.com/onceupon/Bash-Oneliner

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
<
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

Useful short commands:
```
ls -alrth
date
cal
du
dc
od
tr
tee
cut
sort
uniq
```

Using `cut` to get the 2nd field in a csv file:[^1][^2][^3]
```
$ cat foo.csv | cut -d',' -f2
```

Using `cut` to get multiple fields with space(s) as delimiter. `tr -s ' '` will first squeeze multiple spaces into one space:
```
$ ls -alrth | tr -s ' ' | cut -d' ' -f5,6,7,9
```

Using `tee` to get command output on terminal and file:
```
$ whatever_command |& tee log.out
```

Using `od -c` to see if an SSH key file has passphrase set:
```
$ openssl base64 -d < ~/.ssh/id_rsa | od -c
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

Git push and fetch:
```
$ git push <remote-name> <branch-name>
$ git fetch <remote-name>
```

eg `git push origin master` or `git push origin my-bug-123` or `git push upstream my-bug-123` etc, and `git fetch origin` or `git fetch upstream` etc.

Git reset:
```
git reset --soft
git reset --mixed
git reset --hard
```

commit-id~n^k eg `8673a~3^2` denotes the kth parent of the nth ancestor of given commit-id.

# Commands

Find a word / phrase / string in all (let's say java) files under a folder:
```
$ find /path/to/folder -name "*.java" | xargs grep "my word, phrase or string"
```
> [!NOTE]
> To only list the (let's say java) files where the word / phrase / string occurs, along with the (non-zero) number of occurrences:
> ```
> find /path/to/folder -name "*.java" | xargs grep -c "my word, phrase or string" | grep -v :0
> ```

Get disk usage size of a folder's direct subfolders (ie depth 1) along with the folder's grand total size, sorted ascending by size:
```
$ du -ch -d 1 /path/to/folder | sort -h
```

Vault (It is just one 180M executable file):
```
$ ~/location/to/vault/executable-dir/vault -h
$ vault -h
$ vault list -h
```

CDBDUMP:
```
$ cdbdump < foo.cdb | grep whatever
```

OpenSSL:
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


Connectivity:
```
$ nc -zv 21.325.343.36 88888
$ nc -zv example.com 22222

$ host example.com
$ nslookup example.com
```

TCPDUMP:
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

Docker build:
```
$ docker build -f path/to/Dockerfile path/to/destination
```

Maven run:
```
$ mvn [-f path/to/pom.xml] -U -B clean build deploy test -DskipTests=false
```

---

[^1]: https://man7.org/linux/man-pages/man1/cut.1.html
[^2]: https://explainshell.com/explain?cmd=cut+-d%27%3D%27+-f2
[^3]: https://stackoverflow.com/questions/29681222/how-to-use-cut-command-in-linux
