#!/bin/sh

for sr_uuid in $(xe sr-list type=udev content-type=iso params=uuid --minimal | xargs -d,); do
  host=$(xe sr-list uuid=${sr_uuid} params=host --minimal)
  pbd_uuid=$(xe pbd-list sr-uuid=${sr_uuid} params=uuid --minimal);

  echo "host: ${host}"
  echo "sr-uuid: ${sr_uuid}"
  echo "pbd-uuid: ${pbd_uuid}"
  echo

  xe pbd-unplug uuid=${pbd_uuid}
  xe pbd-destroy uuid=${pbd_uuid}
  xe sr-forget uuid=${sr_uuid}
done
