variable "NIH_networks" {
  description = "Required: List of CIDRs for NIH networks"
  type        = list(object({
    cidr_block   = string
    description = string
  }))
  default = [
    {
      cidr_block   = "156.40.252.0/25"
      description = "CIDR block for NIH network 1"
    },
    {
      cidr_block   = "156.40.252.128/26"
      description = "CIDR block for NIH network 2"
    },
    {
      cidr_block   = "156.40.252.192/27"
      description = "CIDR block for NIH network 3"
    },
    {
      cidr_block   = "156.40.252.240/32"
      description = "CIDR block for NIH network 4"
    },
    {
      cidr_block   = "156.40.252.224/28"
      description = "CIDR block for NIH network 5"
    },
    {
      cidr_block   = "128.231.234.0/27"
      description = "CIDR block for NIH network 6"
    },
    {
      cidr_block   = "128.231.234.32/32"
      description = "CIDR block for NIH network 7"
    },
    {
      cidr_block   = "128.231.234.64/27"
      description = "CIDR block for NIH network 8"
    },
  ]
}
