#!/bin/bash

# This script will rename all 'ext' type storage repositories to hostname-devX. In order to properly
# determine the device name it must be run on each XenServer in your cluster.

for sr in $(xe sr-list host=$(hostname) type=ext params=uuid --minimal | xargs -d,); do
  sr_uuid=$sr
  sr_host=$(xe sr-list uuid=${sr_uuid} params=host --minimal)
  sr_name=$(xe sr-list uuid=${sr_uuid} params=name-label --minimal)
  pbd_dev_id=$(xe pbd-list sr-uuid=${sr_uuid} params=device-config --minimal | cut -d' ' -f2)
  pbd_dev_name=$(basename $(readlink -f ${pbd_dev_id}))
  new_sr_name="${sr_host}-${pbd_dev_name}"

  echo "sr_uuid: ${sr_uuid}"
  echo "sr_host: ${sr_host}"
  echo "sr_name: ${sr_name}"
  echo "pbd_dev_id: ${pbd_dev_id}"
  echo "pbd_dev_name: ${pbd_dev_name}"
  echo "new_sr_name: ${new_sr_name}"

  echo
  echo "Renaming '${sr_name}' to '${new_sr_name}'."
  xe sr-param-set uuid=${sr_uuid} name-label=${new_sr_name}
done
