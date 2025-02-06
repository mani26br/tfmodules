module "managed_rules" {
  source = "./niaid-configrules-modules/"

  organization_managed = false # this is the default setting

  # You can exclude AWS accounts when deploying Organization rules
  # excluded_accounts = [
  #   "123456789012",
  # ]

  rule_packs = var.rulepacks_to_include

  rule_packs_to_exclude = var.rulepacks_to_exclude


  # Extra rules not included in the Packs you want to deploy
  rules_to_include = var.rules_to_include

  rules_to_exclude = var.rules_to_exclude

  redshift_cluster_maintenancesettings_check_parameters = {
    allowVersionUpgrade = "true"
  }

  rule_overrides = {
  }
}
