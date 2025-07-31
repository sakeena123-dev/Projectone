import { LightningElement,track,wire} from 'lwc';
import AccountMethod from '@salesforce/apex/accountDataLWCController.AccountMethod';
export default class AccountData extends LightningElement {
    @track columns = [{
        label: 'Account name',
        fieldName: 'Name',
        type: 'text',
        sortable: true,
       
    },
    {
        label: 'Account Number',
        fieldName: 'AccountNumber',
        type: 'text',
       
    },
    
    {
        label: 'Phone',
        fieldName: 'Phone',
        type: 'phone',
       
    },
               
];

@track error;
@track accList ;
@wire(AccountMethod)
wiredAccounts({
    error,
    data
}) {
    if (data) {
        this.accList = data;
        console.log('this.accountlist '+this.accList);
    } else if (error) {
        this.error = error;
    }
}

}