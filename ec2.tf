resource "aws_instance" "example" {
  count         = 2
  instance_type = "t2.micro"  # Replace with your desired instance type
  ami           = "ami-12345678"  # Replace with your desired AMI ID
  subnet_id     = ["aws_subnet.public-us-east-1a.id", "aws_subnet.public-us-east-1ab.id"]  # Replace with your subnet ID
  key_name      = "your-key-pair"  # Replace with your key pair name
}