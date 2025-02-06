resource "aws_guardduty_detector" "guardduty" {
  enable = true
}

resource "aws_guardduty_organization_configuration" "gd_configuration" {
  auto_enable_organization_members = "ALL"

  detector_id = aws_guardduty_detector.guardduty.id

  datasources {
    s3_logs {
      auto_enable = true
    }
    kubernetes {
      audit_logs {
        enable = true
      }
    }
    malware_protection {
      scan_ec2_instance_with_findings {
        ebs_volumes {
          auto_enable = true
        }
      }
    }
  }
}
