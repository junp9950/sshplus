resource "azurerm_virtual_machine_extension" "vmex_web_z1_1" {
  name = "${var.name}_vmex_web11"
  virtual_machine_id = azurerm_linux_virtual_machine.web_z1_1.id
  publisher = "Microsoft.Azure.Extensions"
  type = "CustomScript"
  type_handler_version = "2.0"
  
  settings = <<SETTINGS
    {
        "script": "${base64encode(templatefile("proxy.sh", {pub_ip="${var.pub_ip}"}))}"
    }
    SETTINGS
    
    depends_on = [
      azurerm_linux_virtual_machine.web_z1_1
    ]
}

resource "azurerm_virtual_machine_extension" "vmex_web_z1_2" {
  name = "${var.name}_vmex_web12"
  virtual_machine_id = azurerm_linux_virtual_machine.web_z1_2.id
  publisher = "Microsoft.Azure.Extensions"
  type = "CustomScript"
  type_handler_version = "2.0"
  
  settings = <<SETTINGS
    {
        "script": "${base64encode(templatefile("proxy.sh", {pub_ip="${var.pub_ip}"}))}"
    }
    SETTINGS
    
    depends_on = [
      azurerm_linux_virtual_machine.web_z1_2
    ]
}

resource "azurerm_virtual_machine_extension" "vmex_web_z2_1" {
  name = "${var.name}_vmex_web21"
  virtual_machine_id = azurerm_linux_virtual_machine.web_z2_1.id
  publisher = "Microsoft.Azure.Extensions"
  type = "CustomScript"
  type_handler_version = "2.0"
  
  settings = <<SETTINGS
    {
        "script": "${base64encode(templatefile("proxy.sh", {pub_ip="${var.pub_ip}"}))}"
    }
    SETTINGS
    
    depends_on = [
      azurerm_linux_virtual_machine.web_z2_1
    ]
}

resource "azurerm_virtual_machine_extension" "vmex_web_z2_2" {
  name = "${var.name}_vmex_web22"
  virtual_machine_id = azurerm_linux_virtual_machine.web_z2_2.id
  publisher = "Microsoft.Azure.Extensions"
  type = "CustomScript"
  type_handler_version = "2.0"
  
  settings = <<SETTINGS
    {
        "script": "${base64encode(templatefile("proxyimg.sh", {pub_ip="${var.pub_ip}", rgname="${var.resource_group}", vmname="${var.name}_was" }))}"
    }
    SETTINGS
    
    depends_on = [
      azurerm_virtual_machine_extension.vmex_was
    ]
}

