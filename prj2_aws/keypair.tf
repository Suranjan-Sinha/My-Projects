# key_pair
resource "aws_key_pair" "devops-key" {
  key_name   = "devops-key"
  public_key = file("C:/Users/dsinh/My-Projects-key/devops-key.pub")
}