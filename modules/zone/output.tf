output "route53_zone_id" {
  description = "Zone ID of Route53 zone"
  value       = { for k, v in aws_route53_zone.route53_internal_zone : k => v.zone_id if var.createZone}
}

output "route53_zone_arn" {
  description = "Zone ARN of Route53 zone"
  value       = { for k, v in aws_route53_zone.route53_internal_zone : k => v.arn if var.createZone }
}

output "route53_zone_name_servers" {
  description = "Name servers of Route53 zone"
  value       = { for k, v in aws_route53_zone.route53_internal_zone : k => v.name_servers if var.createZone}
}

output "route53_zone_name" {
  description = "Name of Route53 zone"
  value       = { for k, v in aws_route53_zone.route53_internal_zone : k => v.name if var.createZone}
}

