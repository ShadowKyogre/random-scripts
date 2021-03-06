#!/bin/bash
touch_ids=$(xsetwacom --list devices|grep "type: STYLUS"|grep -Eo "id: [0-9]+"|sed 's/id: //g;s/\\n/ /g')
touch_ids=(${touch_ids//:/ })
tLen=${#touch_ids[@]}

for device_id in ${touch_ids[@]}
do
	if [ "$(xsetwacom --get ${device_id} rotate)" == "half" ];then
		xsetwacom set ${device_id} rotate none
	else
		xsetwacom set ${device_id} rotate half
	fi
done

touch_ids=$(xsetwacom --list devices|grep -e "type: \(TOUCH\|PAD\)"|grep -Eo "id: [0-9]+"|sed 's/id: //g;s/\\n/ /g')
touch_ids=(${touch_ids//:/ })
tLen=${#touch_ids[@]}
for ((i=0; i<${tLen}; i++ ));
do
	if [ "$(xsetwacom --get ${touch_ids[$i]} rotate)" == "half" ];then
		xsetwacom set ${touch_ids[$i]} rotate none
	else
		xsetwacom set ${touch_ids[$i]} rotate half
	fi
done
