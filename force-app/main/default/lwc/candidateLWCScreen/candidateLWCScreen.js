import { LightningElement,api,track,wire  } from 'lwc';
import condidateList from '@salesforce/apex/CandidateLWCController.condidateList';
import candetails from '@salesforce/apex/CandidateLWCController.candetails';
import Candidate_Details__c from '@salesforce/schema/Candidate_Details__c';
import Name from '@salesforce/schema/Candidate_Details__c.Name';
import Candidate_ID__c from '@salesforce/schema/Candidate_Details__c.Name';
import Email__c from '@salesforce/schema/Candidate_Details__c.Email__c';
import Phone__c from '@salesforce/schema/Candidate_Details__c.Phone__c';
import Work_Experience_Years__c from '@salesforce/schema/Candidate_Details__c.Work_Experience_Years__c';
import Qualifications__c from '@salesforce/schema/Candidate_Details__c.Qualifications__c';
import Application_Status__c from '@salesforce/schema/Candidate_Details__c.Application_Status__c';
import Address__c from '@salesforce/schema/Candidate_Details__c.Address__c';
import {getObjectInfo} from 'lightning/uiObjectInfoApi';
import { getPicklistValues } from 'lightning/uiObjectInfoApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import getviewrecords from '@salesforce/apex/CandidateLWCController.getviewrecords';
import editreq from '@salesforce/apex/CandidateLWCController.editreq';
import cloud from '@salesforce/resourceUrl/cloud';

export default class CandidateLWCScreen extends LightningElement {
    imageUrl = cloud;

    get getBackgroundImage(){
        return `cloud:url("${this.imageUrl}")`;
    }

    columns = [
        {    label: 'Candidate Name',fieldName: 'Name', type: 'button',  typeAttributes:{ label: {fieldName:'Name'},name:'CandName',variant:'base'},
    },   //CandName
        {    label: 'Candidate ID',fieldName: 'Candidate_ID__c', type: 'text'},
        {    label: 'Email',fieldName: 'Email__c', type: 'text'},
        {    label: 'Phone',fieldName: 'Phone__c', type: 'text'},
        {    label: 'Work Experience Years',fieldName: 'Work_Experience_Years__c', type: 'text'},
        {    label: 'Application Status',fieldName: 'Application_Status__c', type: 'text'},
        {    label: 'Qualifications',fieldName: 'Qualifications__c', type: 'text'},
        {    label: 'Address',fieldName: 'Address__c', type: 'text'},
    ];

    @track showDetails =true;
    showCreate=false;
    viewmode=false;
    editmode=false;

canList;
error;

AppliType='';
ph='';
Email='';
addr='';
woerkexp='';
name='';
idev='';
qualy='';

@wire (condidateList)
wireMEthod({data,error})
{
    if(data)
    {
        this.canList =data;
        console.log(this.canList);
    }
    else if(error)
    {
        this.error =error;
    }
}
@wire(getObjectInfo, {objectApiName: Candidate_Details__c })
CandInfo; 
//payback frequency picklist value
@wire(getPicklistValues,{
    recordTypeId: '$CandInfo.data.defaultRecordTypeId',
    fieldApiName: Application_Status__c
})StatusValues;
ApplicationStatusType(event)
{
    //if(event.target.label=='Payback Frequency'){
       
        this.AppliType=event.target.value;
        console.log(this.AppliType);
  //  }
   
}

Namehandler(event)
		{
				this.name=event.target.value;
		}
		IDhandler(event)
		{
				this.idev=event.target.value;
		}
		emailhandler(event)
			{
				this.start1=event.target.value;
		}
		mobilehandler(event)
		{
				this.ph=event.target.value;
		}
		exphandler(event)
		{
				this.woerkexp=event.target.value;
		}
        qualhandler(event)
		{
				this.qualy=event.target.value;
		}
        Addhandler(event)
		{
				this.addr=event.target.value;
		}

        createNewRecord(event){
        this.showDetails=false;
        this.showCreate=true;
        }

        gobackview(event){
            this.showCreate=false;
            this.showDetails=true;
        }
        //close button for view mode
closewindowpageviewrecord() {
    this.viewmode = false;
    this.showCreate=false;
    this.showDetails=true;
    this.editmode=false;
}

// create form
createReqestRecord(event){
    
 const allValid = [...this.template.querySelectorAll('lightning-input', 'lightning-combobox')]
    .reduce((validSoFar, inputCmp) => {
        inputCmp.reportValidity();
        return validSoFar && inputCmp.checkValidity();
    }, true);
const All_Compobox_Valid = [...this.template.querySelectorAll('lightning-combobox')]
    .reduce((validSoFar, input_Field_Reference) => {
        input_Field_Reference.reportValidity();
        return validSoFar && input_Field_Reference.checkValidity();
    }, true);
if (allValid && All_Compobox_Valid){
    let parameterObject = {
        Name:this.name,
        Candidate_ID__c :this.idev,
        Email__c:this.email,
        Phone__c:this.ph,
        Application_Status__c:this.AppliType,
        Work_Experience_Years__c:this.woerkexp,
        Qualifications__c:this.qualy,
        Address__c:this.addr
     }

    candetails({savecandetails:parameterObject}) // name:this.name, email:this.email, ph:this.ph, conid:this.idev,exp:this.woerkexp, address:this.addr,quali:this.qualy,appliSt:this.AppliType
    .then(data=>
       {
           this.dispatchEvent(
               new ShowToastEvent({
                   title: "Success",
                   message: "  Salary Advance Request Record is created",
                   variant: "success"
               })
           );
           this.showDetails=true;
         
          this.showCreate=false;
        })
        .catch((error) => {
            console.log('==in error==' + JSON.stringify(error));
          
           
        });
}

}
// VIEW DATIALS
viewCurrentRecord(currentRow) {
    this.currentRowDetails=currentRow;
    
    this.viewmode = true;
    this.showCreate=false;
    this.showDetails=false;
    this.editmode=false;
    this.RecordId = currentRow.Id;
    getviewrecords({ inputid: this.RecordId })
    .then(result => {
    this.Name = result.Name;
})


}

//data part- for view  and edit details
handleRowAction(event) {
   
    let actionName = event.detail.action.name;
    let row = event.detail.row;
    console.log('253' + row);
    switch (actionName) {
        case 'CandName':
            this.viewCurrentRecord(row);
            break;
            case 'edit':
                this.editRecord(row);
                break;
                case 'delete':
                    this.deleteCurrentRecord(row);
                    break;
            default:  
           
    }
  
}


}