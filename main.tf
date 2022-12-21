module "zone" {
    source        = "./modules/zone"
    createZone    = true
    zones = {
        "private-zone" = {
            domain_name = "test.internal.com"
            vpc = [
                {
                vpc_id = "vpc-999999999"
                },
                {
                vpc_id = "vpc-000000000"
                },
            ]
            tags = {
                Name = "private-zone"
            }
        }
    }
    tags = {
        ManagedBy = "terraform"
    }
}

module "records" {
    source                  = "./modules/records"
    createRecord            = false
    zone_id                 = "module.zone.route53_zone_id.private-zone" # If you already have hosted zone use hosted zone id
    zone_name               = "module.zone.route53_zone_name.private-zone" # If you already have hosted zone use hosted zone name
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
