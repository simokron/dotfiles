#! /bin/sh

VPN_IF=tun0
VPN_CHECK="nordvpn status"
VPN_CHECK_FILTER="grep 'Connected'"
POLL_INTERVAL=15
poll_delay_tick=0

while true; do

	vpn_up=$(ip r | grep ${VPN_IF})

	if [[ $vpn_up && $poll_delay_tick == 0 ]]; then
		vpn_check_result=$(eval ${VPN_CHECK} 2> /tmp/vpn_err)
		vpn_connected=$(echo "${vpn_check_result}" | eval ${VPN_CHECK_FILTER})
		#echo "Check ran"
	fi

	if [[ $vpn_up && $vpn_connected ]]; then
		vpn_state="Connected"
		poll_delay_tick=$(((poll_delay_tick + 1) % POLL_INTERVAL))
	elif [[ $vpn_up ]] ; then
		vpn_state="Error"
		poll_delay_tick=0
	else
		vpn_state="Disconnected"
		unset vpn_check_result
		poll_delay_tick=0
	fi

	echo "$VPN_IF: $vpn_state" > /tmp/vpn_state

	#Debug
	#echo "$vpn_state"
	#echo "$poll_delay_tick"
	#echo "$vpn_check_result"

	sleep 1

done
