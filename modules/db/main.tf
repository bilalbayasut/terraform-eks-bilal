module "db" {
  source  = "terraform-aws-modules/rds/aws"
  version = "~> 2.0"

  identifier = "pupilclouddb"

  engine            = "postgres"
  engine_version    = "9.6.9"
  instance_class    = "db.t2.micro"
  allocated_storage = 5

  name     = var.database_name
  username = var.database_user
  password = var.database_password
  port     = var.database_port

  iam_database_authentication_enabled = true

  vpc_security_group_ids = var.vpc_security_group_ids

  maintenance_window = "Mon:00:00-Mon:03:00"
  backup_window      = "03:00-06:00"

  # Enhanced Monitoring - see example for details on how to create the role
  # by yourself, in case you don't want to create it automatically
  monitoring_interval    = "30"
  monitoring_role_name   = "MyRDSMonitoringRole"
  create_monitoring_role = true

  tags = {
    Environment = "staging"
  }

  # DB subnet group
  subnet_ids = var.subnet_ids

  # DB parameter group
  family = "postgres9.6"

  # DB option group
  major_engine_version = "9.6"

  # Snapshot name upon DB deletion
  final_snapshot_identifier = "pupilclouddb"

  # Database Deletion Protection
  deletion_protection = false

  # parameters = [
  #   {
  #     name  = "character_set_client"
  #     value = "utf8"
  #   },
  #   {
  #     name  = "character_set_server"
  #     value = "utf8"
  #   }
  # ]

  # options = [
  #   {
  #     option_name = "MARIADB_AUDIT_PLUGIN"

  #     option_settings = [
  #       {
  #         name  = "SERVER_AUDIT_EVENTS"
  #         value = "CONNECT"
  #       },
  #       {
  #         name  = "SERVER_AUDIT_FILE_ROTATIONS"
  #         value = "37"
  #       },
  #     ]
  #   },
  # ]
}
