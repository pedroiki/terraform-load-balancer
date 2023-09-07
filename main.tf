# module "asg" {
#   source = "terraform-aws-modules/autoscaling/aws"

#   # Autoscaling group
#   name = "example-asg"

#   min_size                  = 0
#   max_size                  = 1
#   desired_capacity          = 1
#   wait_for_capacity_timeout = 0
#   health_check_type         = "EC2"
#   vpc_zone_identifier       = ["subnet-1235678", "subnet-87654321"]

#   initial_lifecycle_hooks = [
#     {
#       name                  = "ExampleStartupLifeCycleHook"
#       default_result        = "CONTINUE"
#       heartbeat_timeout     = 60
#       lifecycle_transition  = "autoscaling:EC2_INSTANCE_LAUNCHING"
#       notification_metadata = jsonencode({ "hello" = "world" })
#     },
#     {
#       name                  = "ExampleTerminationLifeCycleHook"
#       default_result        = "CONTINUE"
#       heartbeat_timeout     = 180
#       lifecycle_transition  = "autoscaling:EC2_INSTANCE_TERMINATING"
#       notification_metadata = jsonencode({ "goodbye" = "world" })
#     }
#   ]

#   instance_refresh = {
#     strategy = "Rolling"
#     preferences = {
#       checkpoint_delay       = 600
#       checkpoint_percentages = [35, 70, 100]
#       instance_warmup        = 300
#       min_healthy_percentage = 50
#     }
#     triggers = ["tag"]
#   }

#   # Launch template
#   launch_template_name        = "example-asg"
#   launch_template_description = "Launch template example"
#   update_default_version      = true

#   image_id          = "ami-ebd02392"
#   instance_type     = "t3.micro"
#   ebs_optimized     = true
#   enable_monitoring = true

#   # IAM role & instance profile
#   create_iam_instance_profile = true
#   iam_role_name               = "example-asg"
#   iam_role_path               = "/ec2/"
#   iam_role_description        = "IAM role example"
#   iam_role_tags = {
#     CustomIamRole = "Yes"
#   }
#   iam_role_policies = {
#     AmazonSSMManagedInstanceCore = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
#   }

#   block_device_mappings = [
#     {
#       # Root volume
#       device_name = "/dev/xvda"
#       no_device   = 0
#       ebs = {
#         delete_on_termination = true
#         encrypted             = true
#         volume_size           = 20
#         volume_type           = "gp2"
#       }
#       }, {
#       device_name = "/dev/sda1"
#       no_device   = 1
#       ebs = {
#         delete_on_termination = true
#         encrypted             = true
#         volume_size           = 30
#         volume_type           = "gp2"
#       }
#     }
#   ]

#   capacity_reservation_specification = {
#     capacity_reservation_preference = "open"
#   }

#   cpu_options = {
#     core_count       = 1
#     threads_per_core = 1
#   }

#   credit_specification = {
#     cpu_credits = "standard"
#   }

#   instance_market_options = {
#     market_type = "spot"
#     spot_options = {
#       block_duration_minutes = 60
#     }
#   }

#   metadata_options = {
#     http_endpoint               = "enabled"
#     http_tokens                 = "required"
#     http_put_response_hop_limit = 32
#   }

#   network_interfaces = [
#     {
#       delete_on_termination = true
#       description           = "eth0"
#       device_index          = 0
#       security_groups       = ["sg-12345678"]
#     },
#     {
#       delete_on_termination = true
#       description           = "eth1"
#       device_index          = 1
#       security_groups       = ["sg-12345678"]
#     }
#   ]

#   placement = {
#     availability_zone = "us-west-1b"
#   }

#   tag_specifications = [
#     {
#       resource_type = "instance"
#       tags          = { WhatAmI = "Instance" }
#     },
#     {
#       resource_type = "volume"
#       tags          = { WhatAmI = "Volume" }
#     },
#     {
#       resource_type = "spot-instances-request"
#       tags          = { WhatAmI = "SpotInstanceRequest" }
#     }
#   ]

#   tags = {
#     Environment = "dev"
#     Project     = "megasecret"
#   }
# }

# module "alb" {
#   source  = "terraform-aws-modules/alb/aws"
#   version = "~> 8.0"

#   name = "my-alb"

#   load_balancer_type = "application"

#   vpc_id          = "vpc-abcde012"
#   subnets         = ["subnet-abcde012", "subnet-bcde012a"]
#   security_groups = ["sg-edcd9784", "sg-edcd9785"]

#   access_logs = {
#     bucket = "my-alb-logs"
#   }

#   target_groups = [
#     {
#       name_prefix      = "pref-"
#       backend_protocol = "HTTP"
#       backend_port     = 80
#       target_type      = "instance"
#       targets = {
#         my_target = {
#           target_id = "i-0123456789abcdefg"
#           port      = 80
#         }
#         my_other_target = {
#           target_id = "i-a1b2c3d4e5f6g7h8i"
#           port      = 8080
#         }
#       }
#     }
#   ]

#   https_listeners = [
#     {
#       port               = 443
#       protocol           = "HTTPS"
#       certificate_arn    = "arn:aws:iam::123456789012:server-certificate/test_cert-123456789012"
#       target_group_index = 0
#     }
#   ]

#   http_tcp_listeners = [
#     {
#       port               = 80
#       protocol           = "HTTP"
#       target_group_index = 0
#     }
#   ]

#   tags = {
#     Environment = "Test"
#   }
# }

# module "db" {
#   source = "terraform-aws-modules/rds/aws"

#   identifier = "demodb"

#   engine            = "mysql"
#   engine_version    = "5.7"
#   instance_class    = "db.t3a.large"
#   allocated_storage = 5

#   db_name  = "demodb"
#   username = "user"
#   port     = "3306"

#   iam_database_authentication_enabled = true

#   vpc_security_group_ids = ["sg-12345678"]

#   maintenance_window = "Mon:00:00-Mon:03:00"
#   backup_window      = "03:00-06:00"

#   # Enhanced Monitoring - see example for details on how to create the role
#   # by yourself, in case you don't want to create it automatically
#   monitoring_interval    = "30"
#   monitoring_role_name   = "MyRDSMonitoringRole"
#   create_monitoring_role = true

#   tags = {
#     Owner       = "user"
#     Environment = "dev"
#   }

#   # DB subnet group
#   create_db_subnet_group = true
#   subnet_ids             = ["subnet-12345678", "subnet-87654321"]

#   # DB parameter group
#   family = "mysql5.7"

#   # DB option group
#   major_engine_version = "5.7"

#   # Database Deletion Protection
#   deletion_protection = true

#   parameters = [
#     {
#       name  = "character_set_client"
#       value = "utf8mb4"
#     },
#     {
#       name  = "character_set_server"
#       value = "utf8mb4"
#     }
#   ]

#   options = [
#     {
#       option_name = "MARIADB_AUDIT_PLUGIN"

#       option_settings = [
#         {
#           name  = "SERVER_AUDIT_EVENTS"
#           value = "CONNECT"
#         },
#         {
#           name  = "SERVER_AUDIT_FILE_ROTATIONS"
#           value = "37"
#         },
#       ]
#     },
#   ]
# }