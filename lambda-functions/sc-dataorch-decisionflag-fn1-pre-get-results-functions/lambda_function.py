import json
import boto3
from datetime import datetime




def get_query_results(query_id):
    client = boto3.client('redshift-data')
    clusterid = 'sc-redshift-cluster-dev'
    db = 'sc-cicddb'
    secrets = 'sc-cicd-redshift-dev'
    response=''
    query_status = client.describe_statement(Id=query_id)
    final_status=query_status['Status']

    id=query_id
    response = client.get_statement_result(Id=id,NextToken='')
    # print('Priniting the Response from results function',response)
    print('print the records retreived: ', response['Records'])
    print("")
    # print(response['Records'][0][0])
    count=0
    # for data in response['Records']:
    #     print(response['Records'][count][1]['stringValue'])
    #     count=+1
    return response['Records']
 
def return_json_object(my_input):
    count=0
    my_list=[]
    my_dict={"queries":[]}
    for x in range(len(my_input)):
        # print(x)
        data=my_input[count]
        my_list.append([{"sql_query":(data[2]['stringValue'])}])
        # my_list.append({"tbl_name":(x[1]['stringValue'])})
        # my_list.append({"query":(x[1]['stringValue'])})
        count=+1
    
    print(my_list)  
    my_dict['queries']=my_list
    # print(type(my_dict))
    # print(my_dict)
    return my_dict 
    
def lambda_handler(event, context):
    # count=0
    # my_dict={"queries":[]}
    # my_list=[]
    # TODO implement
    statementid = event['statementid']
    status_of_query=event['statementStatus']
    sql_query=event['sql_query']
    #calling the function to get results of the query
    records=get_query_results(statementid)
    print('prininting the recorde received from get_query_results() :',records,'Also prininting the type of Records :',type(records))
    #calling the function to return correct JSON object
    catch_output=return_json_object(records)
    print(catch_output,'prininting the catch output')
    return catch_output
    
