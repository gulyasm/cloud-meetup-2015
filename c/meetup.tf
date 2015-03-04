variable "access_key" {}
variable "secret_key" {}

provider "aws" {
    access_key = "${var.access_key}"
    secret_key = "${var.secret_key}"
    region = "us-east-1"
}

resource "aws_instance" "cloudmeetup-prod-webserver" {
    ami = "ami-e4356d8c"
    instance_type = "t2.micro"
    availability_zone = "us-east-1a"
    security_groups = ["cloudmeetup-website"]
    tags = {
        Env = "prod"
        Role = "webserver"
        Project = "cloudmeetup"
        Name = "cloudmeetup-prod-webserver"
    }
    key_name = "gulyasm_gulyasm"
    count = 4
}
resource "aws_elb" "cloudmeetup-prod-elb" {
    name = "cloudmeetup-prod-elb"
    availability_zones = ["us-east-1a"]
    security_groups = ["sg-811eb2e4", "sg-f42cae90"]
    listener = {
        instance_port = 80
        instance_protocol = "http"
        lb_port = 80
        lb_protocol = "http"
    }
    health_check {
        healthy_threshold = 2
        unhealthy_threshold = 2
        timeout = 3
        target = "HTTP:80/index.html"
        interval = 30
    }
    instances = ["${aws_instance.cloudmeetup-prod-webserver.*.id}"]
    cross_zone_load_balancing = true
}


output "ip" {
    value = "${aws_elb.cloudmeetup-prod-elb.dns_name}"
}
