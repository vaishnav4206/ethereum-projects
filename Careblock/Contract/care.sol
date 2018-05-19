pragma solidity ^0.4.18;
contract Demo
{
    struct Doctor {
       
       
        string croname;      //cro name
        string investigatorname;     //cro ivestigator name
        string drugname;       //drugname
        uint dcroid;//       doctor-cro id
     
        string  drugfrom;          //drug from date
        string drugto;            //drug todate
        int stat;
    }
        mapping (uint => Doctor) nos;
    
    
    mapping(uint => Patient) pos;
    
    struct Cro{
        
        uint cid;     //cro id
        string croname;  //cro name
        

    }
    mapping (uint => Cro)cnos;
  
    struct Patient
    {
        
            string patientname;   //patient name
            uint piid;  //patient id
            int patstat; //status
    }
        
    int constant STATUS_INITIATED = 0;
    int constant STATUS_SUBMITTED = 1;
    int constant STATUS_APPROVED  = 2;
    int constant STATUS_REJECTED  = 3;
    
    address addr=msg.sender;
	
    uint     id;
    uint     ciid;
    uint chkdid;
 

         //SET FUNCTION FOR ENTERING THE DETAILS OF THE DOCTOR
         //SET FUNCTION IS DONE IN THREE DIFFERENTLY NAMED FUNCTIONS
         //FIRST SET FUNCTION TAKES THE ARGUEMENTS DOCTORS ID,CRO NAME,INVESTIGATOR NAME

         function setDoc(uint _did,string _croname,string _investigatorname) public {
        
                var ob = nos[_did];
                id=_did;
                ob.croname =_croname;
                ob.investigatorname =_investigatorname;
         }
          

         //SECOND SET FUNCTION TAKES THE ARGUEMENTS DRUG NAME AND DOCTOR-CRO ID

         function setD(string _drugname,uint _dcroid) public {  

                    var obb = nos[id];
                    obb.drugname=_drugname;
                    obb.dcroid=_dcroid;
         }
        
         //THIRD SET FUNCTION TAKES THE ARGUEMENTS DRUG FROM DATE,DRUG TO DATE

          function setDd(string _drugfrom, string _drugto,uint _dcroid) public {

             var obbb = nos[id];
             obbb.drugfrom=_drugfrom;
             obbb.drugto=_drugto;
             obbb.stat=STATUS_SUBMITTED;
             chkdid=_dcroid;
       
     }

        //GET FUNCTION-WHEN REQUEST IS GONE TO THE CRO FOR MEDICAL TESTING,THE CRO CAN VIEW THIS DETAILS

        function getD() public constant returns (string,string) {
        
        return (nos[id].drugname, nos[id].drugfrom);
    }

       //SECOND GET FUNCTION

         function getDd() public constant returns (string) {
        
        return (nos[id].drugto);
    }

    //SET FUNCTION FOR CRO

    function setCRO(uint _cid) public {
        var obj = cnos[_cid];
        ciid = _cid;
        obj.cid=_cid;
    }
        
    function  retstatus() public constant returns(int) {
        return(nos[id].stat);
        
    }
    
    function Reject() public{
        nos[id].stat=STATUS_REJECTED;
    }
     //REQUEST GIVEN TO THE CRO FROM THE DOCTOR

     function approvalreject() public {

        var ob = nos[id];
        if(msg.sender!= addr ||  chkdid!=ciid )
	    {
		  ob.stat = STATUS_REJECTED;
    	}
       else
       {
    	ob.stat = STATUS_APPROVED;
       }
     }   
   
       uint pgtid;
      uint patdocctid;
       address paggent=msg.sender;

 
      // SET FUNCTION FOR PATIENT INCLUDES PATIENT ID AND PATIENT NAME
      
      function setPatient(uint _piid,string _patientname) public
      {
          var oww = pos[_piid];
          pgtid = _piid;
          oww.patientname=_patientname;
          oww.patstat=STATUS_SUBMITTED ;
      }

    // GETFUNCTION

    function getPatient() public constant returns (string) {
        
        return (pos[pgtid].patientname);
    }
     function  retstatupatient() public constant returns(int) {
        return(pos[pgtid].patstat);
        
    }
    function docpatactivate(uint _patdoctid) public
    {
            patdocctid=_patdoctid;
    }
    function Rejectpatient() public{
        pos[pgtid].patstat=STATUS_REJECTED;
    }

    //REQUEST GIVEN TO THE PATIENT

     function approvalrejectpatient() public {

        var owww= pos[pgtid];
        if(msg.sender!= paggent || pgtid !=patdocctid )
	    {
		  owww.patstat = STATUS_REJECTED;
    	}
       else
       {
    	owww.patstat = STATUS_APPROVED;
       }
     }   
}    
