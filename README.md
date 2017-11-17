# Shampers

- started clone and bundle install!

```
$ git clone git@github.com:KotaSakurai/shampers.git
$ cd shampers
$ bundle
$ rails db:migrate
```

# Using rmagick(imagemagick)

ImageMagick version 7 not work.
So, Install ImageMagick Version 6.

for Mac
```
$ brew install imagemagick@6
$ brew link imagemagick@6 --force
$ echo 'export PATH="/usr/local/opt/imagemagick@6/bin:$PATH"' >> ~/.your_shell_sh_file
```
