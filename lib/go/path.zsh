export GOPATH="${WORKSPACE_HOME}"
export GOROOT="/usr/local/opt/go/libexec"

path=(
  $GOPATH/bin
  $path
  $GOROOT/bin
)
