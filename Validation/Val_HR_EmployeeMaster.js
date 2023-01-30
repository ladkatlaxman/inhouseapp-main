/*Validation ofEmployee Creation*/
function validateEmployeeDetails() {
    var check = true;
    var CompEmail = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;

    if ($('.Ddl_EmployeeType option:selected').text() != 'SELECT') {
        if ($('.Txt_FirstName').val() != '') {
            if ($('.Txt_LastName').val() != '') {
                if (!$(".rS33x input[type=radio]:checked").length == 0) {
                    if ($('.Txt_Birthdate').val() != '') {
                        if ($('.Txt_EmployeeContactNo').val() != '' && $('.Txt_EmployeeContactNo').val().length == 10) {
                            if ($('.Txt_EmailId').val() != '' && CompEmail.test($('.Txt_EmailId').val())) {
                                if ($('.Txt_PermanantAddress').val() != '') {
                                    if ($('.Txt_CurrentAddress').val() != '') {
                                        if ($('.Txt_DateofJoining').val() != '') {
                                            if ($('.Ddl_BelongToBranch option:selected').text() != 'SELECT') {
                                                if ($('.Txt_EmpBelongToBranch').val() != '') {
                                                    if ($('.Ddl_Department option:selected').text() != 'SELECT') {
                                                        if ($('.Ddl_Designation option:selected').text() != 'SELECT') {
                                                        } else {
                                                            check = false;
                                                            $('.Ddl_Designation').tooltip({
                                                                placement: "top",
                                                                title: "Select Designation",
                                                                trigger: "focus"
                                                            });
                                                            $('.Ddl_Designation').focus();
                                                        }
                                                    } else {
                                                        check = false;
                                                        $('.Ddl_Department').tooltip({
                                                            placement: "top",
                                                            title: "Select Department",
                                                            trigger: "focus"
                                                        });
                                                        $('.Ddl_Department').focus();
                                                    }
                                                } else {
                                                    check = false;
                                                    $('.Txt_EmpBelongToBranch').tooltip({
                                                        placement: "top",
                                                        title: "Select Branch",
                                                        trigger: "focus"
                                                    });
                                                    $('.Txt_EmpBelongToBranch').focus();
                                                }
                                            } else {
                                                check = false;
                                                $('.Ddl_BelongToBranch').tooltip({
                                                    placement: "top",
                                                    title: "Select Branch",
                                                    trigger: "focus"
                                                });
                                                $('.Ddl_BelongToBranch').focus();
                                            }
                                        } else {
                                            check = false;
                                            $('.Txt_DateofJoining').tooltip({
                                                placement: "top",
                                                title: "Enter Date",
                                                trigger: "focus"
                                            });
                                            $('.Txt_DateofJoining').focus();
                                        }
                                    } else {
                                        check = false;
                                        $('.Txt_CurrentAddress').tooltip({
                                            placement: "top",
                                            title: "Enter Current Address",
                                            trigger: "focus"
                                        });
                                        $('.Txt_CurrentAddress').focus();
                                    }
                                } else {
                                    check = false;
                                    $('.Txt_PermanantAddress').tooltip({
                                        placement: "top",
                                        title: "Enter Permanant Address",
                                        trigger: "focus"
                                    });
                                    $('.Txt_PermanantAddress').focus();
                                }
                            } else {
                                check = false;
                                $('.Txt_EmailId').tooltip({
                                    placement: "top",
                                    title: "Enter Email Id",
                                    trigger: "focus"
                                });
                                $('.Txt_EmailId').focus();
                            }
                        } else {
                            check = false;
                            $('.Txt_EmployeeContactNo').tooltip({
                                placement: "top",
                                title: "Enter Contact Number",
                                trigger: "focus"
                            });
                            $('.Txt_EmployeeContactNo').focus();
                        }
                    } else {
                        check = false;
                        $('.Txt_Birthdate').tooltip({
                            placement: "top",
                            title: "Enter Birth Date",
                            trigger: "focus"
                        });
                        $('.Txt_Birthdate').focus();
                    }
                } else {
                    alert("Select option Male/Female");
                    return false;
                }
            } else {
                check = false;
                $('.Txt_LastName').tooltip({
                    placement: "top",
                    title: "Enter Last Name",
                    trigger: "focus"
                });
                $('.Txt_LastName').focus();
            }
        } else {
            check = false;
            $('.Txt_FirstName').tooltip({
                placement: "top",
                title: "Enter First Name",
                trigger: "focus"
            });
            $('.Txt_FirstName').focus();
        }
    }
    else {
        check = false;
        $('.Ddl_EmployeeType').tooltip({
            placement: "top",
            title: "Select Employee Type",
            trigger: "focus"
        });
        $('.Ddl_EmployeeType').focus();
    }
    if (!check) {
        return false;
    }
    else {
        $('[id*=HiddenField_Tab1Save]').val("1");
        console.log($('[id*=HiddenField_Tab1Save]').val());
        return true;
    }
}


function validateChangePassword() {
    var check = true;
    if ($('.Txt_EmpCurrentPassword').val() != '') {
        if ($('.Txt_EmpChangePassword').val() != '') {
            if ($('.Txt_EmpConfirmPassword').val() != '' && ($('.Txt_EmpChangePassword').val() == $('.Txt_EmpConfirmPassword').val())) {
                check = true;
               // $("#validate-status").text("Match Password");
                // alert("Match Password");
            } else {
                check = false;
                $('.Txt_EmpConfirmPassword').tooltip({
                    placement: "top",
                    title: "Enter Correct Confirm Password",
                    trigger: "focus"
                });

                $("#validate-status").text("Password Not Matched");

                $('.Txt_EmpConfirmPassword').focus();
            }
        } else {
            check = false;
            $('.Txt_EmpChangePassword').tooltip({
                placement: "top",
                title: "Enter Change Password",
                trigger: "focus"
            });
            $('.Txt_EmpChangePassword').focus();
        }
    } else {
        check = false;
        $('.Txt_EmpCurrentPassword').tooltip({
            placement: "top",
            title: "Enter Current Password",
            trigger: "focus"
        });
        $('.Txt_EmpCurrentPassword').focus();
    }

    if (!check) {
        return false;
    }
    else {      
        return true;
    }

}






//Validation For Login Details
function validateEmployeeLoginDetails() {
    var check = true;
  //  var CompEmail = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;

    if ($('.Txt_EmployeeName').val() != '' && $('.Txt_EmployeeName').val() != 'SELECT') {
        if ($('.Txt_EmpUserName').val() != '') {
            if ($('.Txt_EmpPassword').val() != '' && (!($('.Txt_EmpPassword').val().length < 6)) && ($('.Txt_EmpPassword').val().length >= 6 )) {
                if ($('.Txt_EmpConfirmPassword').val() != '' && ($('.Txt_EmpPassword').val() == $('.Txt_EmpConfirmPassword').val())) {

                    $("#validate-status").text("Match Password");
                   // alert("Match Password");
                } else {
                    check = false;
                    $('.Txt_EmpConfirmPassword').tooltip({
                        placement: "top",
                        title: "Enter Correct Confirm Password",
                        trigger: "focus"
                    });

                    $("#validate-status").text("Not Match Password");

                    $('.Txt_EmpConfirmPassword').focus();
                }
            } else {
                check = false;
                $('.Txt_EmpPassword').tooltip({
                    placement: "top",
                    title: "Enter Password",
                    trigger: "focus"
                });
                $('.Txt_EmpPassword').focus();

            }
        } else {
            check = false;
            $('.Txt_EmpUserName').tooltip({
                placement: "top",
                title: "Enter UserName",
                trigger: "focus"
            });
            $('.Txt_EmpUserName').focus();
        }
    }
    else {
        check = false;
        $('.Txt_EmployeeName').tooltip({
            placement: "top",
            title: "Select Employee Name",
            trigger: "focus"
        });
        $('.Txt_EmployeeName').focus();
    }

    if (!check) {
        return false;
    }
    else {
        return true;
    }
}

//Validation for Employee Emergency Contact details
function validateEmergencyContactDetails() {
    var check = true;

    if ($('.Txt_Emergencycontactpersonsname').val() != '') {
        if ($('.Txt_Relationshipwithemployee').val() != '') {
            if ($('.Txt_EmergPerContactNo').val() != '' && $('.Txt_EmergPerContactNo').val().length == 10) {
                if ($('.Txt_PersonPincode').val() != '' && $('.Txt_PersonPincode').val().length == 6) {
                    if ($('.Txt_PersonState').val() != 'SELECT') {
                        if ($('.Txt_PersonsCity').val() != '') {
                            if ($('.Txt_personsaddress1').val() != '') {

                            } else {
                                check = false;
                                $('.Txt_personsaddress1').tooltip({
                                    placement: "top",
                                    title: "Enter Address",
                                    trigger: "focus"
                                });
                                $('.Txt_personsaddress1').focus();
                            }
                        }
                        else {
                            check = false;
                            $('.Txt_PersonsCity').tooltip({
                                placement: "top",
                                title: "Enter City",
                                trigger: "focus"
                            });
                            $('.Txt_PersonsCity').focus();
                        }
                    }
                    else {
                        check = false;
                        $('.Txt_PersonState').tooltip({
                            placement: "top",
                            title: "Select State",
                            trigger: "focus"
                        });
                        $('.Txt_PersonState').focus();
                    }
                }
                else {
                    check = false;
                    $('.Txt_PersonPincode').tooltip({
                        placement: "top",
                        title: "Enter Pincode",
                        trigger: "focus"
                    });
                    $('.Txt_PersonPincode').focus();
                }
            } else {
                check = false;
                $('.Txt_EmergPerContactNo').tooltip({
                    placement: "top",
                    title: "Enter Contact No",
                    trigger: "focus"
                });
                $('.Txt_EmergPerContactNo').focus();
            }
        } else {
            check = false;
            $('.Txt_Relationshipwithemployee').tooltip({
                placement: "top",
                title: "Enter Relationship with Employee",
                trigger: "focus"
            });
            $('.Txt_Relationshipwithemployee').focus();
        }
    } else {
        check = false;
        $('.Txt_Emergencycontactpersonsname').tooltip({
            placement: "top",
            title: "Enter Person Name",
            trigger: "focus"
        });
        $('.Txt_Emergencycontactpersonsname').focus();
    }
    if (!check) {
        return false;
    }
    else {
        $('[id*=HiddenField_Tab2Save]').val("1");
        console.log($('[id*=HiddenField_Tab2Save]').val());
        return true;
    }
}



//Validation for Employee Family Details
function validateFamilyDetails() {
    var check = true;

    if ($('.Txt_FamilyMemberName').val() != '') {
        if ($('.Txt_Relationwithemployee').val() != '') {
            if ($('.Txt_FamilyContactNo').val() != '' && $('.Txt_FamilyContactNo').val().length == 10) {
                if ($('.Txt_Dependancy').val() != '') {

                } else {
                    check = false;
                    $('.Txt_Dependancy').tooltip({
                        placement: "top",
                        title: "Enter % of dependency",
                        trigger: "focus"
                    });
                    $('.Txt_Dependancy').focus();
                }
            } else {
                check = false;
                $('.Txt_FamilyContactNo').tooltip({
                    placement: "top",
                    title: "Enter Contact No",
                    trigger: "focus"
                });
                $('.Txt_FamilyContactNo').focus();
            }
        } else {
            check = false;
            $('.Txt_Relationwithemployee').tooltip({
                placement: "top",
                title: "Enter Relationship with Employee",
                trigger: "focus"
            });
            $('.Txt_Relationwithemployee').focus();
        }
    } else {
        check = false;
        $('.Txt_FamilyMemberName').tooltip({
            placement: "top",
            title: "Enter Member Name",
            trigger: "focus"
        });
        $('.Txt_FamilyMemberName').focus();
    }
    if (!check) {
        return false;
    }
    else {
        $('[id*=HiddenField_Tab3Save]').val("1");
        console.log($('[id*=HiddenField_Tab3Save]').val());
        return true;
    }
}

//Validation for Employee Family Details
function validateLanguageKnownDetails() {
    var check = true;

    if ($('.Ddl_Language option:selected').text() != 'SELECT') {
        if ($('.Txt_Language').val() != '') {
            if (!$(".chk1 input[type=checkbox]:checked").length == 0 || !$(".chk2 input[type=checkbox]:checked").length == 0 || !$(".chk3 input[type=checkbox]:checked").length == 0) {
                check = true;
            }
            else {
                check = false;
                alert("Select atleast (Read/Write/Understand)");
                $('.CheckBox1').focus();
            }
        } else {
            check = false;
            $('.Txt_Language').tooltip({
                placement: "top",
                title: "Enter Language",
                trigger: "focus"
            });
            $('.Txt_Language').focus();
        }
    } else {
        check = false;
        $('.Ddl_Language').tooltip({
            placement: "top",
            title: "Select Language",
            trigger: "focus"
        });
        $('.Ddl_Language').focus();
    }
    if (!check) {
        return false;
    }
    else {
        $('[id*=HiddenField_Tab4Save]').val("1");
        console.log($('[id*=HiddenField_Tab4Save]').val());
        return true;
    }
}

//Validation for Professional Reference Details
function validateProfessionalReferenceDetails() {
    var check = true;

    if ($('.Txt_RefrenceName').val() != '') {
        if ($('.Txt_ReferenceContactNumber').val() != '' && $('.Txt_ReferenceContactNumber').val().length == 10) {
            if ($('.Txt_Department').val() != '') {
                if ($('.Txt_Desgination').val() != '') {

                } else {
                    check = false;
                    $('.Txt_Desgination').tooltip({
                        placement: "top",
                        title: "Enter Designation",
                        trigger: "focus"
                    });
                    $('.Txt_Desgination').focus();
                }
            } else {
                check = false;
                $('.Txt_Department').tooltip({
                    placement: "top",
                    title: "Enter Department",
                    trigger: "focus"
                });
                $('.Txt_Department').focus();
            }
        } else {
            check = false;
            $('.Txt_ReferenceContactNumber').tooltip({
                placement: "top",
                title: "Enter Contact No.",
                trigger: "focus"
            });
            $('.Txt_ReferenceContactNumber').focus();
        }
    } else {
        check = false;
        $('.Txt_RefrenceName').tooltip({
            placement: "top",
            title: "Enter Reference Name",
            trigger: "focus"
        });
        $('.Txt_RefrenceName').focus();
    }
    if (!check) {
        return false;
    }
    else {
        $('[id*=HiddenField_Tab6Save]').val("1");
        console.log($('[id*=HiddenField_Tab6Save]').val()); Txt_Language
        return true;
    }
}

//Validation for Qualification Details
function validateQualificationDetails() {
    var check = true;
    if ($('.Txt_Qualifcation').val() != '') {
      
        if ($('.Txt_YearOfPassing').val() != '' && $('.Txt_YearOfPassing').val().length == 4) {
                if ($('.Txt_UniversityBoard').val() != '') {
                    if ($('.Txt_NameofInstitute').val() != '') {

                    } else {
                        check = false;
                        $('.Txt_NameofInstitute').tooltip({
                            placement: "top",
                            title: "Enter Name Of Institute",
                            trigger: "focus"
                        });
                        $('.Txt_NameofInstitute').focus();
                    }
                } else {
                    check = false;
                    $('.Txt_UniversityBoard').tooltip({
                        placement: "top",
                        title: "Enter University/Board",
                        trigger: "focus"
                    });
                    $('.Txt_UniversityBoard').focus();
                }
            } else {
                check = false;
                $('.Txt_YearOfPassing').tooltip({
                    placement: "top",
                    title: "Enter Year of Passing",
                    trigger: "focus"
                });
                $('.Txt_YearOfPassing').focus();
            }
       
    } else {
        check = false;
        $('.Txt_Qualifcation').tooltip({
            placement: "top",
            title: "Enter Qualification",
            trigger: "focus"
        });
        $('.Txt_Qualifcation').focus();
    }
    if (!check) {
        return false;
    }
    else {

        $('[id*=HiddenField_Tab5Save]').val("1");
        console.log($('[id*=HiddenField_Tab5Save]').val());
        return true;
    }
}

/*Documents Validation*/
function validateEmployeeDocDetails() {
    var check = true;
    if ($('.Txt_AadharNo').val() != '' && $('.Txt_AadharNo').val().length == 12) {
        if ($('.Txt_PancardNo').val() != '' && $('.Txt_PancardNo').val().length == 10) {
            if ($('.Txt_Resume').val() != '') {
                if ($('.Txt_Photo').val() != '') {

                } else {
                    check = false;
                    $('.Txt_Photo').tooltip({
                        placement: "top",
                        title: "Upload Photo",
                        trigger: "focus"
                    });
                    $('.Txt_Photo').focus();
                }
            } else {
                check = false;
                $('.Txt_Resume').tooltip({
                    placement: "top",
                    title: "Upload Resume",
                    trigger: "focus"
                });
                $('.Txt_Resume').focus();
            }
        } else {
            check = false;
            $('.Txt_PancardNo').tooltip({
                placement: "top",
                title: "Enter Pancard Number",
                trigger: "focus"
            });
            $('.Txt_PancardNo').focus();
        }
    } else {
        check = false;
        $('.Txt_AadharNo').tooltip({
            placement: "top",
            title: "Enter Aadharcard Number",
            trigger: "focus"
        });
        $('.Txt_AadharNo').focus();
    }
}

function funNumber(a) {
    if (a.value > 100) {
        a.value = a.value.substring(0, 2);
        return true;
    }
    else {
        if (event.keyCode >= 48 && event.keyCode <= 57) {
            return true;
        }
        else if (event.keyCode == 46) {
        }
        else {
            event.returnValue = false;
            return false;
        }
    }
}
/* Check User Name*/

function checkUserName() {

    if (event.keyCode == 8 || event.keyCode == 46 || (event.keyCode > 96 && event.keyCode < 123) || event.keyCode == 93) {
        return true;
    }
    else {
        return false;
    }
}

/* Check Numbers Only*/
function validateNumericValue(key) {
    var keycode = (key.which) ? key.which : key.keyCode;

    if (!(keycode == 8) && (keycode < 48 || keycode > 57)) {
        return false;
    }
    else {

        return true;
    }
}
function checkNumAlpha() {

    if ((event.keyCode > 64 && event.keyCode < 91) || (event.keyCode > 96 && event.keyCode < 123) || event.keyCode == 8 || event.keyCode == 32) {
        return true;
    }
    else {
        return false;
    }
}
/*Password Checking*/
function checkPassword() {

    if ((event.keyCode > 63 && event.keyCode < 91) || (event.keyCode > 96 && event.keyCode < 123) || (event.keyCode > 47 && event.keyCode < 58) || event.keyCode == 8 || event.keyCode == 95) {
        return true;
    }
    else {
        return false;
    }
}
/*validate Pancard*/
function validatePancardNum() {
    if ((event.keyCode > 64 && event.keyCode < 91) || (event.keyCode > 47 && event.keyCode < 58) || event.keyCode == 8) {
        return true;
    }
    else {
        return false;
    }
}
function checkCompanyName() {

    if ((event.keyCode > 64 && event.keyCode < 91) || (event.keyCode > 96 && event.keyCode < 123) || event.keyCode == 8 || event.keyCode == 32) {
        return true;
    }
    else {
        return false;
    }
}
function checkPancardNumber() {

    if ((event.keyCode > 64 && event.keyCode < 91) || (event.keyCode > 47 && event.keyCode < 58) || event.keyCode == 8) {
        return true;
    }
    else {
        return false;
    }
}