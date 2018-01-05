export GOPATH="${WORKSPACE_HOME}/go"
export GOROOT="/usr/local/opt/go/libexec"

path=(
  $GOPATH/bin
  $path
  $GOROOT/bin
)
