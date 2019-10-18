ROLE=$1

if [ "$ROLE" == "prod" ] || [ "$ROLE" == "prd" ]; then
  profile='prod'
  role="arn:aws:iam::AWS_Account_ID:role/full_admin_role"
else
  ROLE='dev'
  profile='dev'
  role="arn:aws:iam::AWS_Account_ID:role/full_admin_role"
fi

seed=$(date +%s)
data=$(aws --profile ${profile} sts assume-role --role-arn ${role} --role-session-name pmc${seed})
if [ -z "${data}" ]; then
   echo "!!! Error getting a valid session. Please fix it."
   exit 1
fi

export AWS_ACCESS_KEY_ID=$(echo ${data} | sed 's/.*AccessKeyId": "\([A-Za-z0-9\/+=]*\).*/\1/')
export AWS_SECRET_ACCESS_KEY=$(echo ${data} | sed 's/.*SecretAccessKey": "\([A-Za-z0-9\/+=]*\).*/\1/')
export AWS_SESSION_TOKEN=$(echo ${data} | sed 's/.*SessionToken": "\([A-Za-z0-9\/+=]*\).*/\1/')
export AWS_SECURITY_TOKEN=$(echo ${data} | sed 's/.*SessionToken": "\([A-Za-z0-9\/+=]*\).*/\1/')
export AWS_PROFILE="pearson_$ROLE"
