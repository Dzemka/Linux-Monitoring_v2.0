res=$(cat "$1" | awk '{print $1}')
for fileToDelete in $res; do
  rm -rf "$fileToDelete"
done