provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.region}"
}

resource "aws_key_pair" "none-key" {
key_name   = "none-key"
public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC/vIhilPDP11BIyNYpn1uV2lxh1oEMNZ7adMphazi0kBHob7zq7e9jalbH9FloWBkEkNZYXDz2+1S2L4qkGNYCsqKUg48vqBXFmOQXMW0wgm7FKPfyBfUoiMEIHLIyPw07YWlmKrNrIB5wETBXtYWSIJoMcD7PasvBqjmxXm4IhrFUPNNkKgM2BFtRHNmQ8uIvDIluarHy7DdFJAr61/mN9QK4QFNWdB3ouiX0wr+fBQ0PM94q3W8eI/GXG4f3HBF06nDN3y5H+jZID77t9uSrHKlAvl2KMU2eEzJN3othvl+fuvoeVWIY1Lt2wR9XYMjvJHh4mORNPKuxbqeGvPFN pazyuk@gmail.com"
}

resource "aws_instance" "web1" {
  ami           = "ami-0aa7d40eeae50c9a9"
  instance_type = "t2.micro"
  key_name      = "none-key"
  vpc_security_group_ids        = ["${aws_security_group.sec-grp.id}"]

  ebs_block_device {
        device_name = "/dev/xvdb"
        volume_size = "5"
        volume_type = "gp2"
      }

  connection {
    host = "${aws_instance.web1.public_ip}"
    private_key = "${file(var.private_key)}"
    user        = "${var.ansible_user}"
  }

  provisioner "local-exec" {
    command = <<EOT
      sleep 30;
	  echo "${aws_instance.web1.public_ip} ansible_user=${var.ansible_user} ansible_ssh_private_key_file=${var.private_key}" | tee web.ini;
      export ANSIBLE_HOST_KEY_CHECKING=False;
	  ansible-playbook -u ${var.ansible_user} --private-key ${var.private_key} -i web.ini ansible.yaml
    EOT
  }
}

resource "aws_eip" "eip" {
  vpc = true
}

resource "aws_eip_association" "eip-association" {
  instance_id = "${aws_instance.web1.id}"
  allocation_id = "${aws_eip.eip.id}"
}

output "elastic_ip" {
  value = aws_eip.eip.public_ip
}