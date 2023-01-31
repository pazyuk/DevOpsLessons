resource "aws_cloudwatch_dashboard" "dashboard-terraform" {
  dashboard_name = "terraform-cloudwatch-dashboard"

  dashboard_body = <<EOF
{
  "widgets": [
    {
      "type": "metric",
      "x": 0,
      "y": 0,
      "width": 12,
      "height": 6,
      "properties": {
        "metrics": [
          [
            "CWAgent",
            "disk_used_percent",
            "InstanceId",
            "${aws_instance.web1.id}",
            "path",
             "/",
            "device",
            "xvda1",
            "fstype",
            "xfs"
          ]
        ],
        "period": 180,
        "stat": "Average",
        "region": "${var.region}",
        "stacked": true,
        "title": "EC2 Instance Disk Used"
      }
    }
    
    
  ]
}
EOF

}