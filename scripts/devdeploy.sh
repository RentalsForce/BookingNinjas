echo "Deploy the application"
sf project deploy start

echo "- Assign permission set"
sf org assign permset -n BookingNinjas
sf org assign permset -n BookingNinjasCommons