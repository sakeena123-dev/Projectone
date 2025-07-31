import { LightningElement } from 'lwc';
import DeleteRecords from '@salesforce/apex/deleteRecordsController.DeleteRecords';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
export default class DeleteTodayRecords extends LightningElement {
 
objectapinames;
hanldechange(event)
{
    this.objectapinames = event.target.value;
}
handleClick()
{
   DeleteRecords({sobjectname :this.objectapinames})

.then(result=>{
   this.showToast("Today's records are deleted successfull",result,"Today's records are deleted successfull");
 this.objectapinames = ''; 
})

.catch(error => {
    console.log(error);})
}

 showToast(title, message, variant) {
        this.dispatchEvent(
            new ShowToastEvent({
                title: title,
                message: message,
                variant: variant
            })
        );
    }


}