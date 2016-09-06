# command to view README.md locally
function lessmd() {
  grip --export $1 /dev/stdout | w3m -T text/html
}
