
function validateBranchDetails() {
    var check = true;
    var CompEmail = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
    var BranchOwnerEmailId = $('.Txt_BOwnerEmailId').val();

    if ($('.Ddl_Type option:selected').text() != 'SELECT') {     
            if ($('.Txt_BranchName').val() != '') {              
                    if ($('.Txt_Pincode').val() != '') {
                        if ($('.Ddl_Area option:selected').text() != 'SELECT') {
                            if ($('.Txt_BAddress').val() != '') {
                                if ($('.Ddl_BContractType option:selected').text() != 'SELECT') {
                                    console.log($('.Ddl_BContractType').val());
                                    if (($('.Txt_BPurchaseDate').is(':visible') && $('.Txt_BPurchaseDate').val() != '') || ($('.Txt_BPurchaseDate').is(':hidden') && $('.Txt_BPurchaseDate').val() == '')) {
                                        console.log($('.Txt_BPurchaseDate').val());
                                        if (($('.Txt_BValidFrom').is(':visible') && $('.Txt_BValidFrom').val() != '') || ($('.Txt_BValidFrom').is(':hidden') && $('.Txt_BValidFrom').val() == '')) {
                                            if (($('.Txt_BValidTo').is(':visible') && $('.Txt_BValidTo').val() != '') || ($('.Txt_BValidTo').is(':hidden') && $('.Txt_BValidTo').val() == '')) {
                                                if ($('.Txt_BContractNo').val() != '') {
                                                    if ($('.Txt_BOwnerName').val() != '') {
                                                        if ($('.Txt_BOwnerContactNo').val() != '' && $('.Txt_BOwnerContactNo').val().length == 10) {
                                                            if (CompEmail.test(BranchOwnerEmailId)) {
                                                                if (($('.Ddl_ControllingBranchName').is(':visible') && $('.Ddl_ControllingBranchName option:selected').text() != 'SELECT') || ($('.Ddl_ControllingBranchName').is(':hidden') && $('.Ddl_ControllingBranchName option:selected').text() == 'SELECT')) {
                                                                    console.log($('.Ddl_ControllingBranchName').val());
                                                                    if ($('.Ddl_UnderESIC option:selected').text() != 'SELECT') {
                                                                        if ($('.Ddl_CoveredLabourLaw option:selected').text() != 'SELECT') {
                                                                            if ($('.Ddl_Cataegory option:selected').text() != 'SELECT') {
                                                                                check = true;
                                                                            }
                                                                            else {
                                                                                check = false;
                                                                                $('.Ddl_Cataegory').tooltip({
                                                                                    placement: "top",
                                                                                    title: "Select Area Category",
                                                                                    trigger: "focus"
                                                                                });
                                                                                $('.Ddl_Cataegory').focus();
                                                                            }
                                                                        }
                                                                        else {
                                                                            check = false;
                                                                            $('.Ddl_CoveredLabourLaw').tooltip({
                                                                                placement: "top",
                                                                                title: "Select yes/no",
                                                                                trigger: "focus"
                                                                            });
                                                                            $('.Ddl_CoveredLabourLaw').focus();
                                                                        }
                                                                    }
                                                                    else {
                                                                        check = false;
                                                                        $('.Ddl_UnderESIC').tooltip({
                                                                            placement: "top",
                                                                            title: "Select yes/no",
                                                                            trigger: "focus"
                                                                        });
                                                                        $('.Ddl_UnderESIC').focus();
                                                                    }

                                                                }
                                                                else {
                                                                    check = false;
                                                                    $('.Ddl_ControllingBranchName').tooltip({
                                                                        placement: "top",
                                                                        title: "Select Controlling Branch",
                                                                        trigger: "focus"
                                                                    });
                                                                    $('.Ddl_ControllingBranchName').focus();
                                                                }
                                                            }
                                                            else {
                                                                check = false;
                                                                $('.Txt_BOwnerEmailId').tooltip({
                                                                    placement: "top",
                                                                    title: "Enter Property Owner EmailID",
                                                                    trigger: "focus"
                                                                });
                                                                $('.Txt_BOwnerEmailId').focus();
                                                            }
                                                        }
                                                        else {
                                                            check = false;
                                                            $('.Txt_BOwnerContactNo').tooltip({
                                                                placement: "top",
                                                                title: "Enter Property Owner Contact No",
                                                                trigger: "focus"
                                                            });
                                                            $('.Txt_BOwnerContactNo').focus();
                                                        }
                                                    }
                                                    else {
                                                        check = false;
                                                        $('.Txt_BOwnerName').tooltip({
                                                            placement: "top",
                                                            title: "Enter Property Owner Name",
                                                            trigger: "focus"
                                                        });
                                                        $('.Txt_BOwnerName').focus();
                                                    }
                                                }
                                                else {
                                                    check = false;
                                                    $('.Txt_BContractNo').tooltip({
                                                        placement: "top",
                                                        title: "Enter Property Contract No.",
                                                        trigger: "focus"
                                                    });
                                                    $('.Txt_BContractNo').focus();
                                                }
                                            }
                                            else {
                                                check = false;
                                                $('.Txt_BValidTo').tooltip({
                                                    placement: "top",
                                                    title: "Enter Valid To",
                                                    trigger: "focus"
                                                });
                                                $('.Txt_BValidTo').focus();
                                            }
                                        }
                                        else {
                                            check = false;
                                            $('.Txt_BValidFrom').tooltip({
                                                placement: "top",
                                                title: "Enter Valid from",
                                                trigger: "focus"
                                            });
                                            $('.Txt_BValidFrom').focus();
                                        }
                                    }

                                    else {
                                        check = false;
                                        $('.Txt_BPurchaseDate').tooltip({
                                            placement: "top",
                                            title: "Enter Purchase Date",
                                            trigger: "focus"
                                        });
                                        $('.Txt_BPurchaseDate').focus();
                                    }
                                }

                                else {
                                    check = false;
                                    $('.Ddl_BContractType').tooltip({
                                        placement: "top",
                                        title: "Select Contract type",
                                        trigger: "focus"
                                    });
                                    $('.Ddl_BContractType').focus();
                                }
                            }
                            else {
                                check = false;
                                $('.Txt_BAddress').tooltip({
                                    placement: "top",
                                    title: "Enter Address",
                                    trigger: "focus"
                                });
                                $('.Txt_BAddress').focus();
                            }
                        }
                        else {
                            check = false;
                            $('.Ddl_Area').tooltip({
                                placement: "top",
                                title: "Select Area",
                                trigger: "focus"
                            });
                            $('.Ddl_Area').focus();
                        }
                    }
                    else {
                        check = false;
                        $('.Txt_Pincode').tooltip({
                            placement: "top",
                            title: "Enter pincode",
                            trigger: "focus"
                        });
                        $('.Txt_Pincode').focus();
                    }
             
            }
            else {
                check = false;
                $('.Txt_BranchName').tooltip({
                    placement: "top",
                    title: "Enter Branch Name",
                    trigger: "focus"
                });
                $('.Txt_BranchName').focus();
            }
       
    }
    else {
        check = false;
        $('.Ddl_Type').tooltip({
            placement: "top",
            title: "Select Branch Type",
            trigger: "focus"
        });
        $('.Ddl_Type').focus();
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
/*Branch Documents Validation*/
function validateBranchDocDetails() {
    var check = true;
    if ($('.Txt_BranchPanCardNo').val() == '') {
        if ($('.Txt_BranchLineAdharcardNo').val() == '') {

        } else if ($('.Txt_BranchLineAdharcardNo').val() != '' && $('.Txt_BranchLineAdharcardNo').val().length == 12) {

        } else {
            check = false;
            $('.Txt_BranchLineAdharcardNo').tooltip({
                placement: "top",
                title: "Enter correct Property Owner AdhaarCardNo",
                trigger: "focus"
            });
            $('.Txt_BranchLineAdharcardNo').focus();
        }
    }
    else if ($('.Txt_BranchPanCardNo').val() != '' && $('.Txt_BranchPanCardNo').val().length == 10) {
        if ($('.Txt_BranchLineAdharcardNo').val() == '') {
        }
        else if ($('.Txt_BranchLineAdharcardNo').val() != '' && $('.Txt_BranchLineAdharcardNo').val().length == 12) {

        } else {
            check = false;
            $('.Txt_BranchLineAdharcardNo').tooltip({
                placement: "top",
                title: "Enter correct Property Owner AdhaarCardNo",
                trigger: "focus"
            });
            $('.Txt_BranchLineAdharcardNo').focus();
        }
    }
    else {
        check = false;
        $('.Txt_BranchPanCardNo').tooltip({
            placement: "top",
            title: "Enter correct Property Owner PancardNo",
            trigger: "focus"
        });
        $('.Txt_BranchPanCardNo').focus();
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
function checkAlpha() {

    if ((event.keyCode > 64 && event.keyCode < 91) || (event.keyCode > 96 && event.keyCode < 123) || event.keyCode == 8 || event.keyCode == 32) {
        return true;
    }
    else {
        return false;
    }
}
function checkAlphaNumeric() {

    if ((event.keyCode > 64 && event.keyCode < 91) || (event.keyCode > 96 && event.keyCode < 123) || (event.keyCode > 47 && event.keyCode < 58) || event.keyCode == 8) {
        return true;
    }
    else {
        return false;
    }
}
function checkAlphaNum() {

    if ((event.keyCode > 64 && event.keyCode < 91) || (event.keyCode >= 48 && event.keyCode <= 57) || event.keyCode == 8) {
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