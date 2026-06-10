module "windmill_pod_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role"
  version = "~> 6.4.0"

  name        = "windmill-pod-role"
  description = "IAM role for windmill-processor EKS Pod Identity"

  trust_policy_permissions = {
    PodIdentity = {
      actions = ["sts:AssumeRole", "sts:TagSession"]
      principals = [{
        type        = "Service"
        identifiers = ["pods.eks.amazonaws.com"]
      }]
    }
  }

  policies = {
    sqs_windmill = "arn:aws:iam::aws:policy/AmazonSQSReadOnlyAccess"
  }
}

# ---------------------------------------------------------------------------
# Coralogix alerts
# TODO: move to a dedicated modules/coralogix-alerts/ module once the
#       Coralogix provider is wired into this repo's provider configuration.
# ---------------------------------------------------------------------------

resource "coralogix_alert" "aws_cloudtrail_no_logs" {
  name         = "AWS CloudTrail - No Logs From AWS CloudTrail"
  description  = ""
  enabled      = true
  phantom_mode = false

  labels = {
    "alert_extension_pack" = "aws cloudtrail - security extension"
    "alert_provider"       = "aws"
    "alert_service"        = "cloudtrail"
    "alert_source"         = "AWSCloudTrail"
    "alert_type"           = "security"
    "mitre_tactic"         = "ta0005"
    "mitre_technique"      = "t1562"
  }

  group_by = ["coralogix.metadata.applicationName"]

  notification_group = {
    group_by_keys = ["coralogix.metadata.applicationName"]
  }

  incidents_settings = {
    notify_on = "Triggered Only"
    retriggering_period = {
      minutes = 1440
    }
  }

  schedule = {
    active_on = {
      days_of_week = [
        "Sunday", "Monday", "Tuesday", "Wednesday",
        "Thursday", "Friday", "Saturday",
      ]
      start_time = "18:30"
      end_time   = "18:29"
    }
  }

  type_definition = {
    logs_threshold = {
      rules = [
        {
          condition = {
            threshold      = 1
            time_window    = "2_HOURS"
            condition_type = "LESS_THAN"
          }
          override = { priority = "P1" }
        },
      ]
      logs_filter = {
        simple_filter = {
          lucene_query = ""
          label_filters = {
            application_name = [
              { value = "AWS", operation = "IS" },
            ]
            subsystem_name = [
              { value = "cloudtrail.amazonaws.com", operation = "IS" },
            ]
          }
        }
      }
      undetected_values_management = {
        trigger_undetected_values = true
        auto_retire_timeframe     = "NEVER"
      }
      custom_evaluation_delay = 0
    }
  }
}
