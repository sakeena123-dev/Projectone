public class ContactTriggerHandler {
// When a Contact record is Deleted, if the Contact record is related to Account record, prevent deleting it
public static void insta(List<contact> con){
        for(contact c:con)
        {
            if(c.accountid ==null)
            {
                c.addError ('contact cannot be deleted  it is related to account');
            }
        }
    }
}