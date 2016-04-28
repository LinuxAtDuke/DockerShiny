##### Signed by https://keybase.io/clcollins
```
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEABECAAYFAlciGpAACgkQte6EFif3vzc+XQCdGPkGoGpBpFJdhQON7lmia42D
npIAnRfRqfQicU+Vd4nbPLhWU+V5L15y
=Ao88
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
2320          Dockerfile           8da32e686bc473ced555f44468ddd4eddf26171977e9bab15ce960f6d58fade8
              docs/                                                                                
1473          install-packages.sh  5b7ac6829572fde17bba28f082aef740c494613baa99aa6bf0d54f2c6d7708d3
1791          README.md            39fa64e71e607aa5395f52286bff60598a43321a4cc8eaf02068f3c503f37113
983   x       shiny-server.run     b395b0feb914387a5e7bff4a496c18915464bbf40c39f8de715aafc3e632e68f
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