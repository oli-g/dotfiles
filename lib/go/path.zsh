export GOPATH="${PROJECTS_PATH}/go"
export GOROOT="$(brew --prefix)/opt/go/libexec"

path=(
  $GOPATH/bin
  $path
  $GOROOT/bin
)