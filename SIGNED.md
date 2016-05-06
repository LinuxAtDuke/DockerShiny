##### Signed by https://keybase.io/clcollins
```
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEABECAAYFAlcss+cACgkQte6EFif3vzc1zwCgoAS2UqFkFZXWNRKpqhjvoJwZ
wIUAnAoHA5lfa7PLZbUARK8W5ELpsaxX
=62SH
-----END PGP SIGNATURE-----

```

<!-- END SIGNATURES -->

### Begin signed statement 

#### Expect

```
size  exec  file                   contents                                                        
            ./                                                                                     
19            .dockerignore        eb2826f094ce6b26ed486ba7e323838628b41182bcf39b8c3fc22259492e38ea
8             .gitignore           6a29c4442358f3573cd736ab7136896940afd3f1f770482d839c781ba324b570
2632          Dockerfile           2e5b916a6961530af3329a6faa661eb04afcb7e5b7f62570deffc0c63a62cad2
              docs/                                                                                
1473          install-packages.sh  5b7ac6829572fde17bba28f082aef740c494613baa99aa6bf0d54f2c6d7708d3
1788          README.md            3fa479d4455ec0f1ab53b39049b2b61f66e90acf2c29af3e93a24b3ccaaaad1f
976   x       shiny-server.run     bbd3c44fd915cf3c62d680aa13bbc898508024af0c1db990d9e3b10bb191f404
```

#### Ignore

```
/SIGNED.md
```

#### Presets

```
git      # ignore .git and anything as described by .gitignore files
dropbox  # ignore .dropbox-cache and other Dropbox-related files    
kb       # ignore anything as described by .kbignore files          
```

<!-- summarize version = 0.0.9 -->

### End signed statement

<hr>

#### Notes

With keybase you can sign any directory's contents, whether it's a git repo,
source code distribution, or a personal documents folder. It aims to replace the drudgery of:

  1. comparing a zipped file to a detached statement
  2. downloading a public key
  3. confirming it is in fact the author's by reviewing public statements they've made, using it

All in one simple command:

```bash
keybase dir verify
```

There are lots of options, including assertions for automating your checks.

For more info, check out https://keybase.io/docs/command_line/code_signing