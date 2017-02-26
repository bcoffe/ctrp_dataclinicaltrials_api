#!/usr/bin/env bash

# *******************************************************************
# * Script to setup sample_controls table for testing purposes.     *
# * To use the script to setup table on a computer other than the   *
# * localhost, simply set the LOCAL_URL variable to the correct     *
# * location or set END_POINT to "" in order to put table on your   *
# * Amazon account, assuming your .aws/credentials are setup        *
# * correctly.                                                      *
# *******************************************************************
# * Color codes for reference purposes                              *
# *******************************************************************
# Black        0;30     Dark Gray     1;30
# Red          0;31     Light Red     1;31
# Green        0;32     Light Green   1;32
# Brown/Orange 0;33     Yellow        1;33
# Blue         0;34     Light Blue    1;34
# Purple       0;35     Light Purple  1;35
# Cyan         0;36     Light Cyan    1;36
# Light Gray   0;37     White         1;37
# *******************************************************************

CYAN='\033[0;36m'
RED='\033[0;31m'
NC='\033[0m' # No Colors
TABLE_NAME="data_test"
DATA_FILE="file://test_sample_data.json"
#TABLE_KEY_FILE="file://ct_key_conditions.json"

# Change to whatever ip address you want, http://localhost:8000 is
# the default and will cause tables to be setup on your local dynamodb
LOCAL_URL="http://localhost:8000"

# Uncomment to make script setup table on your amazon account
# END_POINT=""

# Comment out if you want to use script to setup table on amazon
END_POINT="--endpoint-url $LOCAL_URL"
#END_POINT="--endpoint-url  https://dynamodb.us-east-1.amazonaws.com"

ATTRIBUTE='site'
VALUE='mocha'

QUERY_ATTRIBUTE='host_name'
QUERY_VALUE='NCI-MATCH-IR'

echo -e "${CYAN}***********************************************${NC}"
echo -e "${RED}DELETING TABLE IF IT EXIST${NC}"
echo -e "${CYAN}***********************************************${NC}"
aws dynamodb delete-table --table-name $TABLE_NAME $END_POINT

sleep 10

echo -e "${CYAN}***********************************************${NC}"
echo -e "${RED}BUILDING TABLE${NC}"
echo -e "${CYAN}***********************************************${NC}"
# Note: Something to consider is do we really need or want the range key? Maybe just make the molecular_id the hash
# key is good enough as we want the molecular_id to be completly unique and in this case its actually the site plus
# the molecular_id that must be unique not the molecular_id. This affects the code and so I really think at the moment
# the molecular_id should be the only key.
# aws dynamodb create-table --table-name $TABLE_NAME --attribute-definitions AttributeName=site,AttributeType=S AttributeName=molecular_id,AttributeType=S --key-schema AttributeName=site,KeyType=HASH AttributeName=molecular_id,KeyType=RANGE --provisioned-throughput ReadCapacityUnits=1,WriteCapacityUnits=1 $END_POINT
aws dynamodb create-table --table-name $TABLE_NAME --attribute-definitions AttributeName=id,AttributeType=S --key-schema AttributeName=id,KeyType=HASH --provisioned-throughput ReadCapacityUnits=1,WriteCapacityUnits=1 $END_POINT

sleep 10

echo -e "${CYAN}***********************************************${NC}"
echo -e "${RED}WRITING SAMPLE DATA TO TABLE${NC}"
echo -e "${CYAN}***********************************************${NC}"
aws dynamodb batch-write-item --request-items $DATA_FILE $END_POINT

echo -e "${CYAN}***********************************************${NC}"
echo -e "${RED}SHOWING THE TABLES ON SYSTEM${NC}"
echo -e "${CYAN}***********************************************${NC}"
aws dynamodb list-tables $END_POINT

echo -e "${CYAN}***********************************************${NC}"
echo -e "${RED}DESCRIBING NEWLY CREATED AND LOADED TABLE${NC}"
echo -e "${CYAN}***********************************************${NC}"
aws dynamodb describe-table --table-name $TABLE_NAME $END_POINT