import { LightningElement,wire } from 'lwc';
import getMyLeaves from '@salesforce/apex/LeaveRequstController.getMyLeaves';

export default class MyLeaves extends LightningElement {
		columns=[
				{ label:'name', fieldname: 'Name' , type:'text'},
				{label:'From Date', fieldname:'From_Date__c' , type:'text'},
				{label:'To Date', fieldname:'To_Date__c' , type:'text'},
				{label:'Reason', fieldname:'Reason__c' , type:'text'},
				{label:'Status', fieldname:'Status__c' , type:'text'},
				{label:'Manager Comment', fieldname:'Manager_Comment__c'  , type:'text'}

		]
		myleavesdata;
		error;
		@wire(getMyLeaves)
		wiremethod({error,data}) 
{
				if(data)
				{
						this.myleavesdata =data;
				}
				else if(error)
				{
						this.error =error;
				}
}


}