function mera(search) {
    console.log("a mes", search);
}

function newFunction(a, b) {
    console.log("a message", a);
    console.log("b message", b);
    //var y = document.getElementById(a.id);
    //console.log("y message", y);
    //var x = y.id;

    switch (a) {

        case 'Button_Tab1Save':
        case 'Button_Tab2Save':
        case 'Button_Tab3Save':
        case 'Button_Tab4Save':
        case 'Button_Tab5Save':
        case 'Button_Tab6Save':
        case 'Button_FinalTabSave':
            if (b == 'SAVE') {
                var x = document.getElementById('AlertNotification');
                x.className = "show";
                x.innerText = "Data Saved Successfully ..!!!!"
                setTimeout(function () { x.className = x.className.replace("show", ""); }, 2000);
                break;
            }
            if (b == 'ADD') {
                var x = document.getElementById('AlertNotification');
                x.className = "show";
                x.innerText = "Data Added Successfully ..!!!!"
                setTimeout(function () { x.className = x.className.replace("show", ""); }, 2000);
                break;
            }
            else if (b == 'UPDATE') {
                var x = document.getElementById('AlertNotification');
                x.className = "show";
                x.innerText = "Data Updated Successfully ..!!!!"
                setTimeout(function () { x.className = x.className.replace("show", ""); }, 2000);
                break;
            }
            if (b == 'ASSIGN') {
                var x = document.getElementById('AlertNotification');
                x.className = "show";
                x.innerText = "Stationary Assigned Successfully ..!!!!"
                setTimeout(function () { x.className = x.className.replace("show", ""); }, 2000);
                break;
            }
            if (b == 'APPROVE') {
                var x = document.getElementById('AlertNotification');
                x.className = "show";
                x.innerText = "Approved Successfully ..!!!!"
                setTimeout(function () { x.className = x.className.replace("show", ""); }, 2000);
                break;
            }
            if (b == 'REJECT') {
                var x = document.getElementById('AlertNotification');
                x.className = "show";
                x.innerText = "Rejected Successfully ..!!!!"
                setTimeout(function () { x.className = x.className.replace("show", ""); }, 2000);
                break;
            }
        case 'Button_Submit1':
        case 'Button_Submit2':
            if (b == 'SAVE') {
                var x = document.getElementById('AlertNotification');
                x.className = "show";
                x.innerText = "Data Submited Successfully ..!!!!"
                setTimeout(function () { x.className = x.className.replace("show", ""); }, 2000);
                break;
            }
            if (b == 'PASSWORD') {
                var x = document.getElementById('AlertNotification');
                x.className = "show";
                x.innerText = "Password Changed Successfully ..!!!!"
                setTimeout(function () { x.className = x.className.replace("show", ""); }, 2000);
                break;
            }          
            else if (b == 'UPDATE') {
                var x = document.getElementById('AlertNotification');
                x.className = "show";
                x.innerText = "Data Updated Successfully ..!!!!"
                setTimeout(function () { x.className = x.className.replace("show", ""); }, 2000);
                break;
            }

        case 'Btn_Add':
            if (b == 'ADD1') {
                var x = document.getElementById('AlertNotification');
                x.className = "show";
                x.innerText = "This Item is Already Added ..!!!!"
                setTimeout(function () { x.className = x.className.replace("show", ""); }, 2000);
                break;
            }
        case 'Btn_Search':
            if (b == 'SEARCH') {
                var x = document.getElementById('AlertNotification');
                x.className = "show";
                x.innerText = "Please Select Searching Parameter ..!!!!"
                setTimeout(function () { x.className = x.className.replace("show", ""); }, 2000);
                break;
            }
            //else if (b == 'ADD1') {
            //    var x = document.getElementById('AlertNotification');
            //    x.className = "show";
            //    x.innerText = "Data Updated Successfully ..!!!!"
            //    setTimeout(function () { x.className = x.className.replace("show", ""); }, 2000);
            //    break;
            //}

        case 'Delete_Data1':
        case 'Delete_Data2':
        case 'Delete_Data3':
        case 'Delete_Data4':
        case 'Delete_Data5':
        case 'Delete_Data6':
            if (b == 'DELETE') {
                var x = document.getElementById('AlertNotification');
                x.className = "show";
                x.innerText = "Data Deleted Successfully ..!!!!"
                setTimeout(function () { x.className = x.className.replace("show", ""); }, 2000);
                break;
            }

        case 'VehicleNo':
            if (b == 'CREATED') {
                var x = document.getElementById('AlertNotification');
                x.className = "show";
                x.innerText = "Vehicle Already Created";
                setTimeout(function () { x.className = x.className.replace("show", ""); }, 2000);
                break;
            }
            else if (b == 'APPROVED') {
                var x = document.getElementById('AlertNotification');
                x.className = "show";
                x.innerText = "Vehicle Already Approved";
                setTimeout(function () { x.className = x.className.replace("show", ""); }, 2000);
                break;
            }
            else if (b == 'DISPATCHED') {
                var x = document.getElementById('AlertNotification');
                x.className = "show";
                x.innerText = "Vehicle Already Dispached";
                setTimeout(function () { x.className = x.className.replace("show", ""); }, 2000);
                break;
            }
            else if (b == 'PARKED') {
                var x = document.getElementById('AlertNotification');
                x.className = "show";
                x.innerText = "Vehicle Already Parked";
                setTimeout(function () { x.className = x.className.replace("show", ""); }, 2000);
                break;
            }
            else if (b == 'REJECTED') {
                var x = document.getElementById('AlertNotification');
                x.className = "show";
                x.innerText = "Vehicle Already Rejected";
                setTimeout(function () { x.className = x.className.replace("show", ""); }, 2000);
                break;
            }
            else if (b == 'NOT EXISTS') {
                var x = document.getElementById('AlertNotification');
                x.className = "show";
                x.innerText = "Vehicle Not Exists";
                setTimeout(function () { x.className = x.className.replace("show", ""); }, 2000);
                break;
            }
            else if (b == 'PARKED_SUCCESSFULLY') {
                var x = document.getElementById('AlertNotification');
                x.className = "show";
                x.innerText = "Vehicle Parked Successfully";
                setTimeout(function () { x.className = x.className.replace("show", ""); }, 2000);
                break;
            }
            else if (b == 'DISPATCHED_SUCCESSFULLY') {
                var x = document.getElementById('AlertNotification');
                x.className = "show";
                x.innerText = "Vehicle Dispatched Successfully";
                setTimeout(function () { x.className = x.className.replace("show", ""); }, 2000);
                break;
            }
        default:
            var x = document.getElementById('AlertNotification');
            x.className = "show";
            x.innerText = "Click Again ..!!!!"
            setTimeout(function () { x.className = x.className.replace("show", ""); }, 2000);
            break;
    }
    //document.write("Exiting switch block");
}

function newFunction1(a, b, c) {
    console.log("a message", a);
    console.log("b message", b);
   
    switch (a) {

        case 'VehicleNo':
            if (b == 'CREATED') {
                var x = document.getElementById('AlertNotification');
                x.className = "show";
                x.innerText = "Vehicle Already Created in " + c;
                setTimeout(function () { x.className = x.className.replace("show", ""); }, 2000);
                break;
            }
            else if (b == 'APPROVED') {
                var x = document.getElementById('AlertNotification');
                x.className = "show";
                x.innerText = "Vehicle Already Approved by " + c;
                setTimeout(function () { x.className = x.className.replace("show", ""); }, 2000);
                break;
            }
            else if (b == 'DISPATCHED') {
                var x = document.getElementById('AlertNotification');
                x.className = "show";
                x.innerText = "Vehicle Already Dispached from " + c;
                setTimeout(function () { x.className = x.className.replace("show", ""); }, 2000);
                break;
            }
            else if (b == 'PARKED') {
                var x = document.getElementById('AlertNotification');
                x.className = "show";
                x.innerText = "Vehicle Already Parked at " + c;
                setTimeout(function () { x.className = x.className.replace("show", ""); }, 2000);
                break;
            }
            else if (b == 'REJECTED') {
                var x = document.getElementById('AlertNotification');
                x.className = "show";
                x.innerText = "Vehicle Already Rejected by " + c;
                setTimeout(function () { x.className = x.className.replace("show", ""); }, 2000);
                break;
            }
            else if (b == 'NOT EXISTS') {
                var x = document.getElementById('AlertNotification');
                x.className = "show";
                x.innerText = "Vehicle Not Exists";
                setTimeout(function () { x.className = x.className.replace("show", ""); }, 2000);
                break;
            }
            else if (b == 'PARKED_SUCCESSFULLY') {
                var x = document.getElementById('AlertNotification');
                x.className = "show";
                x.innerText = "Vehicle Parked Successfully";
                setTimeout(function () { x.className = x.className.replace("show", ""); }, 2000);
                break;
            }
            else if (b == 'DISPATCHED_SUCCESSFULLY') {
                var x = document.getElementById('AlertNotification');
                x.className = "show";
                x.innerText = "Vehicle Dispatched Successfully";
                setTimeout(function () { x.className = x.className.replace("show", ""); }, 2000);
                break;
            }

        default:
            var x = document.getElementById('AlertNotification');
            x.className = "show";
            x.innerText = "Click Again ..!!!!"
            setTimeout(function () { x.className = x.className.replace("show", ""); }, 2000);
            break;
    }
    //document.write("Exiting switch block");
}

function myFunction(x) {

    var x = document.getElementById('AlertNotification');
    x.className = "show";
    x.innerText = "Select Pincode First ..!!!!"
    setTimeout(function () { x.className = x.className.replace("show", ""); }, 2000);
}



