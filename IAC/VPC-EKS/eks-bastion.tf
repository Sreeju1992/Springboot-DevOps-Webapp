resource "aws_instance" "ec2-bastion-instance" {
    ami = data.aws_ami.ubuntu.id
    instance_type = var.instance_type
    tags = local.common_tags
    key_name = aws_key_pair.bastion-login.id
    subnet_id = module.vpc.public_subnets[0]
    vpc_security_group_ids = [aws_security_group.bastion-access-rules.id]    
}

resource "aws_key_pair" "bastion-login" {
    key_name = var.key_name
    public_key = file(var.instance_key_pair)
}

# Create security group for the EC2 bastion host
resource "aws_security_group" "bastion-access-rules" {
    name = "${local.name}-public-bastion-sg"
    description = "All SSH and application access"
    tags = local.common_tags
    vpc_id = module.vpc.vpc_id
    ingress {
        from_port = var.ingress-ports[0].port
        to_port = var.ingress-ports[0].port
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    dynamic "egress" {
        for_each = var.egress-ports
        content {
            from_port = egress.value
            to_port = egress.value
            protocol = "tcp"
            cidr_blocks = ["0.0.0.0/0"]  
        }
        
    }
}

resource "aws_eip" "bastion_eip" {
  instance = aws_instance.ec2-bastion-instance.id
  domain = "vpc"
  tags = local.common_tags
  depends_on = [aws_instance.ec2-bastion-instance, module.vpc]
}