export GOPATH="${PROJECTS_PATH}/go"
export GOROOT="$(brew --prefix)/opt/go/libexec"

if [[ ! -d ${GOPATH} ]]; then
  mkdir $GOPATH
fi

# go get golang.org/x/tools/cmd/vet
# go get golang.org/x/tools/cmd/godoc

path=(
  $GOPATH/bin
  $path
  $GOROOT/bin
)