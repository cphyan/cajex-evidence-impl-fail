# Fixture for cajeX's IaC templates (RFC 20 track E). Never applied.
# DELIBERATELY WRONG: the database is not declared encrypted, and SSH is open to the internet.

resource "aws_db_instance" "orders" {
  identifier        = "orders"
  engine            = "postgres"
  instance_class    = "db.t4g.micro"
  allocated_storage = 20
}

resource "aws_security_group" "admin" {
  name = "admin"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# RFC 20 track D, DELIBERATELY WRONG: plain HTTP, a one-region trail without validation,
# object lock anyone with the permission can lift, and a lifecycle that never deletes.

resource "aws_lb_listener" "http" {
  load_balancer_arn = "arn:aws:elasticloadbalancing:eu-west-1:000000000000:loadbalancer/app/web/0"
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = "arn:aws:elasticloadbalancing:eu-west-1:000000000000:targetgroup/web/0"
  }
}

resource "aws_cloudtrail" "local" {
  name           = "local-trail"
  s3_bucket_name = "orders-audit-logs"
}

resource "aws_s3_bucket_object_lock_configuration" "evidence" {
  bucket = "orders-evidence"

  rule {
    default_retention {
      mode = "GOVERNANCE"
      days = 30
    }
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "uploads" {
  bucket = "orders-uploads"

  rule {
    id     = "archive-uploads"
    status = "Enabled"

    transition {
      days          = 30
      storage_class = "GLACIER"
    }
  }
}
