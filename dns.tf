resource "aws_route53_zone" "zone_root" {
  name = "hotelbraganca.club"
}

resource "aws_route53_record" "apex" {
  zone_id = "${aws_route53_zone.zone_root.zone_id}"
  name = ""
  type    = "A"
  ttl     = "300"
  records = ["${aws_instance.mc-server.public_ip}"]
}

resource "aws_route53_record" "old" {
  zone_id = "${aws_route53_zone.zone_root.zone_id}"
  name = "old"
  type    = "A"
  ttl     = "300"
  records = ["212.47.249.207"]
}

resource "aws_route53_record" "legacy-map" {
  zone_id = "${aws_route53_zone.zone_root.zone_id}"
  name    = "legacy-map"
  type    = "A"
  ttl     = "300"
  records = ["212.47.249.207"]
}

resource "aws_route53_record" "map" {
  zone_id = "${aws_route53_zone.zone_root.zone_id}"
  name    = "map"
  type    = "A"
  ttl     = "300"
  records = ["${aws_instance.mc-server.public_ip}"]
}

resource "aws_route53_record" "admin" {
  zone_id = "${aws_route53_zone.zone_root.zone_id}"
  name    = "admin"
  type    = "A"
  ttl     = "300"
  records = ["${aws_instance.mc-server.public_ip}"]
}
