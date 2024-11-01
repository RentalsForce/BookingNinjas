# Variables
ORG_DEVHUB=TrialDevHub
ORG_NAME=bn2gp_dev
ORG_LIFESPAN=7

rm -rf scripts/scratch.log

echo "- Connecting to DevHub"
sf auth sfdxurl store -f scripts/orgs/trial.txt -a $ORG_DEVHUB
sf config set org-capitalize-record-types true --global

echo "- Prepare the org"
echo "    - Creating scratch org..."
sf org create scratch -v $ORG_DEVHUB -f config/project-scratch-def.json -a $ORG_NAME -y $ORG_LIFESPAN -c -d

sh scripts/devdeploy.sh