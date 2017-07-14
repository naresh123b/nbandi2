drop keyspace taxilla;

create keyspace taxilla with replication = {'class' : 'NetworkTopologyStrategy', 'dc1' : 1};

use taxilla;

drop table if exists request_detail;
create table request_detail(org_id text,unit_id text,metadata_id text,request_id text,request_business_key text,request_state text,exec_status text,request_type text,created_by text,created_on timestamp,last_updated_by text,last_updated_on timestamp,primary key((metadata_id,org_id,unit_id,request_id)));

drop table if exists erroneous_record_detail;
create table erroneous_record_detail(asset_uuid text,entity_id text,parent_entity_record_id text,val_type text,entity_record_id text,primary key(asset_uuid,val_type,entity_id,parent_entity_record_id,entity_record_id));

drop table if exists entity_record_detail;
create table entity_record_detail(asset_uuid timeuuid,entity_id text,parent_entity_record_id text,entity_record_id text,entity_record_business_key text,primary key(asset_uuid,entity_id,parent_entity_record_id,entity_record_id));

drop table if exists validation_result;
create table validation_result(asset_uuid timeuuid,validation_level text,entity_id text,parent_entity_record_id text,entity_record_id text,field_id text,field_type text,messages list<text>,PRIMARY KEY ((asset_uuid,entity_id,parent_entity_record_id,entity_record_id),validation_level,field_id));

drop table if exists report_details;
create table report_details(asset_uuid text,repository_id text,report_category text,report_name text,report_url text,primary key((asset_uuid),repository_id,report_category,report_name));

drop table if exists file_store;
create table file_store(file_url text,file_data blob,primary key(file_url));

drop table if exists asset_attributes;
create table asset_attributes(attribute_holder_id text,attribute_type text,attribute_name text,attribute_value text,data_format text,data_type text,primary key(attribute_holder_id,attribute_type,attribute_name));

drop table if exists workflow_task_detail;
create table workflow_task_detail(org_id text,unit_id text,asset_id text,task_id text,task_name text,task_category text,task_order int,task_assignee text,associated_entities list<text>,associated_reports list<text>,user_actions map<text,text>,default_action text,skippable boolean,skipped boolean,email_enabled boolean,primary key(asset_id,org_id,unit_id,task_id));

drop table if exists workflow_deployment_detail;
create table workflow_deployment_detail(org_id text,unit_id text,asset_id text,deployed_on timestamp,workflow_id text,primary key((org_id,unit_id,asset_id),deployed_on)) with clustering order by (deployed_on desc);

drop table if exists asset_bridge_mapping;
create table asset_bridge_mapping(asset_id text,bridge_id text,bridge_name text,bridge_version text,repository_id text,target_link_table_names map<text,text>,primary key(asset_id,bridge_id));

drop table if exists runtime_data_business_keys;
create table runtime_data_business_keys(org_id text,unit_id text,asset_id text,asset_data_business_key text,parent_record_business_key text,entity_id text,entity_record_business_key text,runtime_data_id text,primary key((org_id,unit_id,asset_id,asset_data_business_key,entity_id,parent_record_business_key,entity_record_business_key)));

drop table if exists audit_trail;
create table audit_trail(asset_data_id text,audit_type text,task_id text,entity_id text,parent_entity_record_id text,entity_record_id text,latest_ver timestamp,prev_ver timestamp,user_name text,stage_name text,status text,comment text,logged_on timestamp,primary key((asset_data_id,audit_type),task_id,parent_entity_record_id,entity_id,entity_record_id,latest_ver,logged_on)) with clustering order by (task_id desc,parent_entity_record_id desc,entity_id desc,entity_record_id desc,latest_ver desc,logged_on desc);

drop table if exists master_data_relations;
create table master_data_relations(master_name text,relation_type text,associated_masters list<text>,primary key(master_name,relation_type));

drop table if exists asset_lookups;
create table if not exists asset_lookups(asset_id text,lookup_id text,lookup_value_field_id text,lookup_display_field_id text,conditional_field_1 text,conditional_field_2 text,conditional_field_3 text,conditional_field_4 text,conditional_field_5 text,lookup_value text,lookup_display_value text,lookup_order_value text,primary key((asset_id,lookup_id),lookup_value_field_id,lookup_display_field_id,conditional_field_1,conditional_field_2,conditional_field_3,conditional_field_4,conditional_field_5,lookup_value));

drop table if exists transformation_chain;
create table transformation_chain(metadata_id text,metadata_type text,repository_id text,chain_type text,exec_plan text,chain_name text,chain_order int,primary key((metadata_id,metadata_type),repository_id,chain_type,exec_plan,chain_order,chain_name)) with clustering order by (repository_id asc,chain_type asc,exec_plan asc,chain_order asc,chain_name asc);

drop table if exists user_request_store;
create table user_request_store(org_id text,unit_id text,request_type text,request_id text,created_on timestamp,created_by text,file_uri text,algorithm text,checksum text,primary key((org_id,unit_id,request_type,request_id),created_on)) with clustering order by (created_on desc);

drop table if exists counters;
create table counters(id text primary key,value bigint);

drop table if exists asset_data;
create table asset_data(asset_uuid timeuuid,entity_id text,parent_entity_record_id text,entity_record_id text,modified boolean,version timestamp,user_name text,validated int,record_data map<text,text>,primary key((asset_uuid,entity_id,parent_entity_record_id,entity_record_id),version)) with clustering order by (version desc) and gc_grace_seconds=86400;

drop table if exists scheduled_calls;
create table scheduled_calls(task_id text,request_id text,args text,next_schedule int,retry_count int,primary key((task_id,request_id)));

drop table if exists master_data;
create table master_data(unit_id text,master_id text,record_key text,record_data map<text,text>,primary key((unit_id,master_id),record_key));

drop table if exists master_data_pkvalue;
create table master_data_pkvalue(unit_id text,master_id text,pkey text,pkey_value text,next_pkey text,next_pkey_value text,primary key((unit_id,master_id),pkey,pkey_value,next_pkey,next_pkey_value));

drop table if exists request_link;
create table request_link(src_asset_id text,src_request_id text,bridge_id text,target_asset_id text,target_request_id text,primary key(src_asset_id,src_request_id));

drop table if exists event_log;
create table event_log(org_id text,created_on timestamp,event_type text,org_name text,subject_id text,subject_name text,subject_dtl text,created_by text,created_name text,primary key(org_id,created_on,event_type)) with clustering order by (created_on desc);
