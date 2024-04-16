CRED=$(aws sts get-caller-identity)
B=$(echo ${A} | jq -r '.Account')
export Q=$B

echo ${Q}

# echo "Digitar MFA: "
# read code

# CRED=$(aws sts get-session-token --serial-number arn:aws:iam::976859928792:mfa/IPhoneSC --token-code ${code})
# echo ${CRED}

# AccessKeyId=$(echo ${CRED} | jq -r '.Credentials.AccessKeyId')
# SecretAccessKey=$(echo ${CRED} | jq -r '.Credentials.SecretAccessKey')
# SessionToken=$(echo ${CRED} | jq -r '.Credentials.SessionToken')

# echo ${AccessKeyId}
# echo ${SecretAccessKey}
# echo ${SessionToken}

# echo export AWS_ACCESS_KEY_ID=${AccessKeyId}
# echo export AWS_SECRET_ACCESS_KEY=${SecretAccessKey}
# echo export AWS_SESSION_TOKEN=${SessionToken}