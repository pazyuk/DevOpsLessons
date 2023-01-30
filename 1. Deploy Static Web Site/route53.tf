resource "aws_route53_zone" "sample-zone" {
  name = "${var.dns-zone}"
}

resource "aws_route53_record" "www-record" {
  zone_id = "${aws_route53_zone.sample-zone.zone_id}"
  name = "www"
  type = "A"
  ttl = "300"
  records = ["${aws_eip.eip.public_ip}"]
}