SEARCHFOR="*.png"
PADDING=4
COUNTER=1

for file in $SEARCHFOR
do
  new=$(printf "%0"$PADDING"d.png" "$COUNTER") #04 pad to length of 4
  mv -i -- "$file" "$new"
  let COUNTER=COUNTER+1
done