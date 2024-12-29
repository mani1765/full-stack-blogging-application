variable "ssh_key_name" {
  description = "The name of the SSH key pair to use for instances"
  type        = string
  default     = "mykeypair" # kindly replace with your active keypair name without .pem
}
