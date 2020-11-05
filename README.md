# dotvim
Synchronized Vim Configuration

# [vimcasts instructions](http://vimcasts.org/episodes/synchronizing-plugins-with-git-submodules-and-pathogen/)
## Installing your Vim environment on another machine
Once your vim configuration is under version control, it’s quite straightforward to import your settings to any machine that has git installed. If you followed the instructions above to put your vimrc and plugins in a dotvim directory, then you can follow these steps to synchronise them to another machine:

    cd ~
    git clone http://github.com/username/dotvim.git ~/.vim
    ln -s ~/.vim/vimrc ~/.vimrc
    ln -s ~/.vim/gvimrc ~/.gvimrc
    cd ~/.vim
    git submodule init
    git submodule update

As Marcin Kulik points out in the comments below, the last two git commands can be rolled in to one:

    git submodule update --init

## Upgrading a plugin bundle
At some point in the future, the fugitive plugin might be updated. To fetch the latest changes, go into the fugitive repository, and pull the latest version:

    cd ~/.vim/bundle/fugitive
    git pull origin master

## Upgrading all bundled plugins
You can use the foreach command to execute any shell script in from the root of all submodule directories. To update to the latest version of each plugin bundle, run the following:

    git submodule foreach git pull origin master

## Updates
Matt noted in the comments that when you follow this method, generating helptags dirties the submodule’s git repository tree. Several other people chimed in with suggestions on how to fix this. Nils Haldenwang has written a blog post describing a simple fix, which just involves adding the line ignore = dirty to the .gitmodules file for each submodule that reports a dirty tree when you run git status. Go and read Nils’s [blog post](http://www.nils-haldenwang.de/frameworks-and-tools/git/how-to-ignore-changes-in-git-submodules), which goes into a bit more detail.
* Add `ignore = untracked` instead (if you don&apos;t want to ignore modified files).
* E.g.,

        [submodule "bundle/fugitive"]
            path = bundle/fugitive
            url = git://github.com/tpope/vim-fugitive.git
            ignore = dirty

