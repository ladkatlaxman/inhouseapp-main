function validateCompanyDetails() {
    var check = true;
    var CompEmail = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
    var EmailId = $('.Txt_EmailId').val();

    if ($('.Txt_ComapnyCode').val() != '') {
        if ($('.Txt_CompanyName').val() != '') {
            if ($('.Txt_OwnerName').val() != '') {
                if ($('.Txt_OwnerContactNo').val() != '' && $('.Txt_OwnerContactNo').val().length == 10) {
                    if ($('.Txt_EmailId').val() != '' && CompEmail.test(EmailId)) {
                        if ($('.Txt_PinCode').val() != 'SELECT') {
                            if ($('.Txt_State').val() != '') {
                                if ($('.Txt_District').val() != '') {
                                    if ($('.Txt_City').val() != '') {
                                        if ($('.Txt_Area').val() != 'SELECT') {

                                            if ($('.Txt_CompanyAddress').val() != '') {

                                            }
                                            else {
                                                check = false;
                                                $('.Txt_CompanyAddress').tooltip({
                                                    placement: "top",
                                                    title: "Enter Address",
                                                    trigger: "focus"
                                                });
                                                $('.Txt_CompanyAddress').focus();
                                            }
                                        }
                                        else {
                                            check = false;
                                            $('.Txt_Area').tooltip({
                                                placement: "top",
                                                title: "Select Area",
                                                trigger: "focus"
                                            });
                                            $('.Txt_Area').focus();
                                        }
                                    }
                                    else {
                                        check = false;
                                        $('.Txt_City').tooltip({
                                            placement: "top",
                                            title: "Select pincode or Contact to IT Team",
                                            trigger: "focus"
                                        });
                                        $('.Txt_City').focus();
                                    }
                                }
                                else {
                                    check = false;
                                    $('.Txt_District').tooltip({
                                        placement: "top",
                                        title: "Select pincode or Contact to IT Team",
                                        trigger: "focus"
                                    });
                                    $('.Txt_District').focus();
                                }

                            }
                            else {
                                check = false;
                                $('.Txt_State').tooltip({
                                    placement: "top",
                                    title: "Select pincode or Contact to IT Team",
                                    trigger: "focus"
                                });
                                $('.Txt_State').focus();
                            }
                        } else {
                            check = false;
                            $('.Txt_PinCode').tooltip({
                                placement: "top",
                                title: "Select pincode",
                                trigger: "focus"
                            });
                            $('.Txt_PinCode').focus();
                        }
                    }
                    else {
                        check = false;
                        $('.Txt_EmailId').tooltip({
                            placement: "top",
                            title: "Enter EmailID",
                            trigger: "focus"
                        });
                        $('.Txt_EmailId').focus();
                    }
                }
                else {
                    check = false;
                    $('.Txt_OwnerContactNo').tooltip({
                        placement: "top",
                        title: "Enter Owner Contact No.",
                        trigger: "focus"
                    });
                    $('.Txt_OwnerContactNo').focus();
                }
            }
            else {
                check = false;
                $('.Txt_OwnerName').tooltip({
                    placement: "top",
                    title: "Enter Owner Name",
                    trigger: "focus"
                });
                $('.Txt_OwnerName').focus();
            }
        }
        else {
            check = false;
            $('.Txt_CompanyName').tooltip({
                placement: "top",
                title: "Enter Company Name",
                trigger: "focus"
            });
            $('.Txt_CompanyName').focus();
        }
    }
    else {
        check = false;
        $('.Txt_ComapnyCode').tooltip({
            placement: "top",
            title: "Please Contact to IT Team",
            trigger: "focus"
        });
        $('.Txt_ComapnyCode').focus();
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
/*Company Documents Validation*/


function validateCompanyDocDetails() {
    var check = true;

    if ($('.Txt_CompanyGSTCertificates').val() == '') {
        console.log("t1");
        if ($('.Txt_CompanyCIN').val() == '') {
            console.log("t2");
            check = true;
        }
        else if ($('.Txt_CompanyCIN').val() != '' && $('.Txt_CompanyCIN').val().length == 21) {
            check = true;
        }
        else {
            check = false;
            $('.Txt_CompanyCIN').tooltip({
                placement: "top",
                title: "Enter CIN",
                trigger: "focus"
            });
            $('.Txt_CompanyCIN').focus();
        }
    }
    else if ($('.Txt_CompanyGSTCertificates').val() != '') {
        if ($('.Txt_CompanyCIN').val() == '') {
            check = true;
        }
        else if ($('.Txt_CompanyCIN').val() != '' && $('.Txt_CompanyCIN').val().length == 21) {
            check = true;
        }
        else {
            check = false;
            $('.Txt_CompanyCIN').tooltip({
                placement: "top",
                title: "Enter CIN",
                trigger: "focus"
            });
            $('.Txt_CompanyCIN').focus();
        }
    }
    else {
        check = false;
        $('.Txt_CompanyGSTCertificates').tooltip({
            placement: "top",
            title: "Enter GST No.",
            trigger: "focus"
        });
        $('.Txt_CompanyGSTCertificates').focus();
    }

    if (!check) {
        return false;
    }
    else {
        $('[id*=HiddenField_Submit1]').val("1");
        return true;
    }
}
/*Validation For Popup Area Details*/

function validateAreaDetails() {
    var check = true;
    if ($('.Txt_popArea').val() != '') {

    }
    else {
        check = false;
        $('.Txt_popArea').tooltip({
            placement: "top",
            title: "Enter Area",
            trigger: "focus"
        });
        $('.Txt_popArea').focus();
    }
    if (!check) {
        return false;
    }
    else {
        $('[id*=HiddenField_SubmitArea_Popup]').val("1");
        console.log($('[id*=HiddenField_SubmitArea_Popup]').val());
        return true;
    }

    /*
      if ($('.Ddl_popPincode option:selected').text() != 'SELECT') {
            if ($('.Ddl_PopState option:selected').text() != 'SELECT') {
                if ($('.Ddl_PopDistrict option:selected').text() != 'SELECT') {
                    if ($('.Ddl_PopCity option:selected').text() != 'SELECT') {
                        check = true;
                    }
                    else {
                        check = false;
                        $('.Ddl_PopCity').tooltip({
                            placement: "top",
                            title: "Select City",
                            trigger: "focus"
                        });
                        $('.Ddl_PopCity').focus();
                    }
                }
                else {
                    check = false;
                    $('.Ddl_PopDistrict').tooltip({
                        placement: "top",
                        title: "Select District",
                        trigger: "focus"
                    });
                    $('.Ddl_PopDistrict').focus();
                }
            }
            else {
                check = false;
                $('.Ddl_PopState').tooltip({
                    placement: "top",
                    title: "Select State",
                    trigger: "focus"
                });
                $('.Ddl_PopState').focus();
            }
        }
        else {
            check = false;
            $('.Ddl_popPincode').tooltip({
                placement: "top",
                title: "Select pincode",
                trigger: "focus"
            });
            $('.Ddl_popPincode').focus();
        }
    */
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

/* Check Only Alphabets(a/A) with space*/
function checkAlpha() {

    if ((event.keyCode > 64 && event.keyCode < 91) || (event.keyCode > 96 && event.keyCode < 123) || event.keyCode == 8 || event.keyCode == 32) {
        return true;
    }
    else {
        return false;
    }
}

/* Check Only Alphabets(A) and Numbers */
function checkNumAlpha() {

    if ((event.keyCode > 64 && event.keyCode < 91) || (event.keyCode > 96 && event.keyCode < 123) || event.keyCode == 8 || event.keyCode == 32) {

        return true;
    }
    else {
        return false;
    }
}

function onlyAlphaValue() {

    if ((event.keyCode > 64 && event.keyCode < 91) || (event.keyCode > 96 && event.keyCode < 123) || event.keyCode == 8) {
        return true;
    }
    else {
        return false;
    }
}

function checkEmailId() {

    if (event.keyCode == 32) {
        return false;
    }
    else {
        return true;
    }
}