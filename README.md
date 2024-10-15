# scripts

```
ln -s .bashrc .bash_profile
```

```
.bash_profile -> /Users/user1/.bashrc
```

# Git commands

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
Make existing branch track remote branch.
```
git branch -u upstream/foo foo
```

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
```
```
$ssh-keygen -y -f ~/.ssh/id_rsa -E md5
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
