# resource "aws_route53_zone" "route53_internal_zone" {
#   # for_each       = { for k, v in var.zones : k => v if var.createZone }
#   count          = var.createZone ? 1 : 0
#   name           = var.internal_domain_name

#   vpc {
#     vpc_id = var.vpc_id
#   }
#   # tags = var.tags
# }

# resource "aws_route53_vpc_association_authorization" "vpc_association" {
#   for_each = { for k, v in var.secondary_vpc_id : k => v if var.secondaryVPC }
#   vpc_id  = each.value
#   zone_id = aws_route53_zone.route53_internal_zone[0].id
#   depends_on = [
#     aws_route53_zone.route53_internal_zone
#   ]
# }

# resource "aws_route53_zone_association" "vpc_zone_association" {
#   for_each = { for k, v in var.secondary_vpc_id : k => v if var.secondaryVPC }
#   vpc_id  = each.value
#   zone_id = "${aws_route53_zone.route53_internal_zone[count.index].id}"
#   depends_on = [
#     aws_route53_zone.route53_internal_zone
#   ]
# }


resource "aws_route53_zone" "route53_internal_zone" {
  for_each = { for k, v in var.zones : k => v if var.createZone }

  name          = lookup(each.value, "domain_name", each.key)
  comment       = lookup(each.value, "comment", null)
  force_destroy = lookup(each.value, "force_destroy", false)

  delegation_set_id = lookup(each.value, "delegation_set_id", null)

  dynamic "vpc" {
    for_each = try(tolist(lookup(each.value, "vpc", [])), [lookup(each.value, "vpc", {})])

    content {
      vpc_id     = vpc.value.vpc_id
      vpc_region = lookup(vpc.value, "vpc_region", null)
    }
  }
}

