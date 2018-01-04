export GOPATH="${PROJECTS_PATH}/go"
export GOROOT="/usr/local/opt/go/libexec"

path=(
  $GOPATH/bin
  $path
  $GOROOT/bin
)