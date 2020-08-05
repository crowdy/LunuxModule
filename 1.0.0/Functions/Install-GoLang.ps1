Function Install-GoLang {

	cd $Home
	$VERSION = "1.14.6"
	$OS = "linux"
	$ARCH = "amd64"

	# download and untar
	wget https://golang.org/dl/go$VERSION.$OS-$ARCH.tar.gz
	tar -C /usr/local -xzf go$VERSION.$OS-$ARCH.tar.gz
	'export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin' >> $HOME/.profile
	
	# source $HOME/.profile
	$env:PATH="$env:PATH:/usr/local/go/bin:$HOME/go/bin"

	# GOPATH
	mkdir ~/go
	'export GOPATH=$HOME/go' >> $HOME/.profile
	
	# source $HOME/.profile
	$env:GOPATH = "$HOME/go"
	echo $env:GOPATH
	
	go version
}