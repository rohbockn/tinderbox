# Install language syntax highlighting in atom
## R example

```apm install language-r```

### If the above doesn't work, but sends out error:

>✗
Request for package information failed: self signed certificate in certificate chain (SELF_SIGNED_CERT_IN_CHAIN)

# So, perform the following:

```
cd ~/.atom/packages
git clone https://github.com/lee-dohm/language-r.git
apm install
```

then, restart atom
