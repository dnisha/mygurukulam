create_ami () {
    echo "Deepak nishad"

    INSTANCE_IDS=$(aws ec2 describe-instances \
    --filters "Name=tag:instance,Values=avengerv2" "Name=instance-state-name,Values=running" \
    --query "Reservations[].Instances[].InstanceId" \
    --output text)

    for INSTANCE_ID in $INSTANCE_IDS; do
    echo "Terminitaing Instance of ID: ${INSTANCE_ID}"
    sleep 5
    done
}
create_ami