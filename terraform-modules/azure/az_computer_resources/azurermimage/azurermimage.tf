resource "azurerm_image" "virtual_image" {
    name = "${var.virtual_image-name}"
    resource_group_name = "${var.virtual_image-resource_group_name}"
    location = "${var.virtual_image-location}"

  dynamic "os_disk" {
    for_each = "${var.virtual_image-os_disk}"

    content {
        os_type  = "${lookup(os_disk.value, "os_type", null)}"
        os_state = "${lookup(os_disk.value, "os_state", null)}"
        blob_uri = "${lookup(os_disk.value, "blob_uri", null)}"
        caching = "${lookup(os_disk.value, "caching", null)}"
        size_gb = "${lookup(os_disk.value, "size_gb", null)}"
    }
  }
}
