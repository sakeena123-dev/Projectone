public class LeadTriggerHandler {
// Whenever a Lead record is created, 
  // if the Name field does not contain either "Mr." or "Mrs.", prefix either "Mr." or "Mrs." to the Name field  
public static void leadname(list<lead> leadRecord)
{
    for(lead leRec:LeadRecord)
    {
        if (String.isNotBlank(leRec.Name) && !leRec.Name.startsWith('Mr.') && !leRec.Name.startsWith('Mrs.')) {
            String prefix = 'Mr.';

            leRec.Lastname = prefix + ' ' + leRec.Name;
    }
    }
}

}