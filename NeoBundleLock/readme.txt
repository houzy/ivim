https://github.com/Shougo/neobundle.vim/issues/413

Implemented. :NeoBundleInstall will update the plugins if NeoBundle.lock is changed.

:help neobundle
Get this:
Q: I want to use lockfile feature like "Gemfile.lock" in neobundle.
https://github.com/Shougo/neobundle.vim/issues/222

A: You can copy "NeoBundle.lock" to another machine from neobundle base path
directory.  It is used when install plugins.

So,
Copy NeoBundle.lock file to .vim/bundle, and run command:
:NeoBundleInstall

