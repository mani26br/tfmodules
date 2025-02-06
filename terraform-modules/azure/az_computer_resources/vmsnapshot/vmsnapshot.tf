resource "vsphere_virtual_machine_snapshot" "vmsnapshot" {
  virtual_machine_uuid = var.virtual_machine_uuid
  snapshot_name        = var.snapshot_name
  description          = var.description
  memory               = var.memory
  quiesce              = var.quiesce
  remove_children      = var.remove_children
  consolidate          = var.consolidate
}
