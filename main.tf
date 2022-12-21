module "zone" {
    source                  = "./modules/zone"
    createZone              = true
    internal_domain_name    = "test.internal.com"
    vpc_id                  = "vpc-027d33646176cc47c"
    secondaryVPC            = true
    secondary_vpc_id        = ["vpc-855826ff"]
}

module "records" {
    source                  = "./modules/records"
    createRecord            = true
    zone_id                 = module.zone.route53_zone_id[0]
    zone_name               = module.zone.route53_zone_name
    recordName = [
        {
            name = "test"
            type = "A"
            ttl  = 3600
            records = ["10.10.10.10"]
        },
        {
            name = "test2"
            type = "A"
            ttl  = 3600
            records = ["10.10.10.20"]
        },

    ]
}
