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
