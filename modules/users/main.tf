# create groups
resource "aws_iam_group" "developer_power_user" {
  name = "developer_power_user"
  path = "/users/"
}
resource "aws_iam_group" "administrator" {
  name = "administrator"
  path = "/users/"
}

resource "aws_iam_group" "billing" {
  name = "billing"
  path = "/users/"
}

# define group policies
resource "aws_iam_group_policy" "developer_power_user" {
  name   = "developer_power_user"
  group  = aws_iam_group.developer_power_user.name
  policy = file("${path.module}/PowerUserAccess.json")
}

resource "aws_iam_group_policy" "administrator" {
  name   = "administrator"
  group  = aws_iam_group.administrator.name
  policy = file("${path.module}/AdministratorAccess.json")
}

resource "aws_iam_group_policy" "billing" {
  name   = "billing"
  group  = aws_iam_group.billing.name
  policy = file("${path.module}/BillingAccess.json")
}

# # attach group policies to groups
# resource "aws_iam_group_policy_attachment" "developer_power_user_group_policy" {
#   group      = aws_iam_group.developer_power_user.name
#   policy_arn = aws_iam_policy.developer_power_user.arn
# }
# resource "aws_iam_group_policy_attachment" "administrator_group_policy" {
#   group      = aws_iam_group.administrator.name
#   policy_arn = aws_iam_policy.administrator.arn
# }
# resource "aws_iam_group_policy_attachment" "billing_group_policy" {
#   group      = aws_iam_group.billing.name
#   policy_arn = aws_iam_policy.billing.arn
# }

# create users
resource "aws_iam_user" "new_developer_power_users" {
  count = length(var.developer_power_users)
  name  = element(var.developer_power_users, count.index)
}
resource "aws_iam_user" "new_administrators" {
  count = length(var.administrators)
  name  = element(var.administrators, count.index)
}
resource "aws_iam_user" "new_billings" {
  count = length(var.billings)
  name  = element(var.billings, count.index)
}

# attach users to groups
resource "aws_iam_user_group_membership" "new_developer_power_users_user_group" {
  count = length(aws_iam_user.new_developer_power_users)
  user  = aws_iam_user.new_developer_power_users[count.index].name
  groups = [
    aws_iam_group.developer_power_user.name
  ]
}

resource "aws_iam_user_group_membership" "new_administrator_user_group" {
  count = length(aws_iam_user.new_administrators)
  user  = aws_iam_user.new_administrators[count.index].name
  groups = [
    aws_iam_group.administrator.name
  ]
}


resource "aws_iam_user_group_membership" "new_billings_user_group" {
  count = length(aws_iam_user.new_billings)
  user  = aws_iam_user.new_billings[count.index].name
  groups = [
    aws_iam_group.billing.name
  ]
}

# access keys
resource "aws_iam_access_key" "new_developer_power_users" {
  count = length(aws_iam_user.new_developer_power_users)
  user  = aws_iam_user.new_developer_power_users[count.index].name
}

# login profiles
resource "aws_iam_user_login_profile" "new_developer_power_users" {
  count   = length(aws_iam_user.new_developer_power_users)
  user    = aws_iam_user.new_developer_power_users[count.index].name
  pgp_key = "keybase:${aws_iam_user.new_developer_power_users[count.index].name}"
}
