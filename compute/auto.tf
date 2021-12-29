resource "azurerm_monitor_autoscale_setting" "auto" {
  name                = "${var.name}_auto"
  resource_group_name = var.resource_group
  location            = var.location
  target_resource_id  = azurerm_linux_virtual_machine_scale_set.vmss.id

  profile {
    name = "autoprofile"

    capacity {
      default = 2
      minimum = 2
      maximum = 6
    }

    rule {
      metric_trigger {
        metric_name        = "percentage cpu"
        metric_resource_id = azurerm_linux_virtual_machine_scale_set.vmss.id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "GreaterThan"
        threshold          = 75
      }

      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = "2"
        cooldown  = "PT1M"
      }
    }

    rule {
      metric_trigger {
        metric_name        = "percentage cpu"
        metric_resource_id = azurerm_linux_virtual_machine_scale_set.vmss.id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "LessThan"
        threshold          = 35
      }

      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = "2"
        cooldown  = "PT1M"
      }
    }
  }
}
#####dbWait time out######
resource "azurerm_mysql_configuration" "wait_timeout" {
  resource_group_name = var.resource_group
  server_name         = var.db_server_name
  

  # mysql 서버 timeout 값 조절
  name  = "wait_timeout"
  value = "27999"
depends_on = [
  azurerm_monitor_autoscale_setting.auto
]
}


