/*Validation of Vendor Creation*/
function validateVendorDetails() {
    var check = true;
    if ($('.Ddl_Vendors option:selected').text() != 'SELECT') {
        if ($('.Txt_VendorCode').val() != '') {
            if ($('.Txt_CompanyName').val() != '') {
                if ($('.Txt_VendorContactNo').val() != '' && $('.Txt_VendorContactNo').val().length == 10) {
                    if ($('.Txt_VendorPinCode').val() != 'SELECT') {
                        if ($('.Txt_VendorState').val() != '') {
                            if ($('.Txt_District').val() != '') {
                                if ($('.Txt_VendorCity').val() != '') {
                                    if ($('.Txt_VendorArea').val() != 'SELECT') {
                                        if ($('.Txt_VendorBillingAddress').val() != '') {
                                            if ($('.Txt_BranchName').val() != 'SELECT') {
                                                if ($('.Ddl_VendorCategory option:selected').text() != 'SELECT') {
                                                    if ($('.Txt_VendorContractNo').val() != '') {
                                                    } else {
                                                        check = false;
                                                        $('.Txt_VendorContractNo').tooltip({
                                                            placement: "top",
                                                            title: "Contact To branch",
                                                            trigger: "focus"
                                                        });
                                                        $('.Txt_VendorContractNo').focus();
                                                    }
                                                }
                                                else {
                                                    check = false;
                                                    $('.Ddl_VendorCategory').tooltip({
                                                        placement: "top",
                                                        title: "Select Vendor Category",
                                                        trigger: "focus"
                                                    });
                                                    $('.Ddl_VendorCategory').focus();
                                                }
                                            } else {
                                                check = false;
                                                $('.Txt_BranchName').tooltip({
                                                    placement: "top",
                                                    title: "Select Branch Name",
                                                    trigger: "focus"
                                                });
                                                $('.Txt_BranchName').focus();
                                            }
                                        } else {
                                            check = false;
                                            $('.Txt_VendorBillingAddress').tooltip({
                                                placement: "top",
                                                title: "Enter Billing Address",
                                                trigger: "focus"
                                            });
                                            $('.Txt_VendorBillingAddress').focus();
                                        }
                                    } else {
                                        check = false;
                                        $('.Txt_VendorArea').tooltip({
                                            placement: "top",
                                            title: "Select Area",
                                            trigger: "focus"
                                        });
                                        $('.Txt_VendorArea').focus();
                                    }
                                } else {
                                    check = false;
                                    $('.Txt_VendorCity').tooltip({
                                        placement: "top",
                                        title: "Contact To branch",
                                        trigger: "focus"
                                    });
                                    $('.Txt_VendorCity').focus();
                                }
                            } else {
                                check = false;
                                $('.Txt_District').tooltip({
                                    placement: "top",
                                    title: "Contact To branch",
                                    trigger: "focus"
                                });
                                $('.Txt_District').focus();
                            }
                        } else {
                            check = false;
                            $('.Txt_VendorState').tooltip({
                                placement: "top",
                                title: "Contact To branch",
                                trigger: "focus"
                            });
                            $('.Txt_VendorState').focus();
                        }
                    }
                    else {
                        check = false;
                        $('.Txt_VendorPinCode').tooltip({
                            placement: "top",
                            title: "Select Pincode Number",
                            trigger: "focus"
                        });
                        $('.Txt_VendorPinCode').focus();
                    }
                } else {
                    check = false;
                    $('.Txt_VendorContactNo').tooltip({
                        placement: "top",
                        title: "Enter Vendor Contact Number",
                        trigger: "focus"
                    });
                    $('.Txt_VendorContactNo').focus();
                }
            } else {
                check = false;
                $('.Txt_CompanyName').tooltip({
                    placement: "top",
                    title: "Enter Company Name",
                    trigger: "focus"
                });
                $('.Txt_CompanyName').focus();
            }
        } else {
            check = false;
            $('.Txt_VendorCode').tooltip({
                placement: "top",
                title: "Contact To branch",
                trigger: "focus"
            });
            $('.Txt_VendorCode').focus();
        }

    } else {
        check = false;
        $('.Ddl_Vendors').tooltip({
            placement: "top",
            title: "Select Vendors",
            trigger: "focus"
        });
        $('.Ddl_Vendors').focus();
    }
    if (!check) {
        return false;
    }
    else {
        $('[id*=HiddenField_Button_Tab1Save]').val("1");
        console.log($('[id*=HiddenField_Button_Tab1Save]').val());
        return true;
    }
}
/*  if ($('.Txt_VendorName').val() != '') {
   } else {
            check = false;
            $('.Txt_VendorName').tooltip({
                placement: "top",
                title: "Enter Vendor Name",
                trigger: "focus"
            });
            $('.Txt_VendorName').focus();
        }*/

/*Validation Of Documents Details*/
function validateDocumentsDetails() {

    var check = true;
    if ($('.Txt_VendorPanCardNo').val() != '' && $('.Txt_VendorPanCardNo').val().length == 10) {
        if ($('.Txt_VendorAadhaarCardNo').val() != '' && $('.Txt_VendorAadhaarCardNo').val().length == 12) {
            if ($('.Txt_VendorGSTCertificates').val() != '' && $('.Txt_VendorGSTCertificates').val().length == 15) {
                if ($('.Txt_VendorCIN').val() != '' && $('.Txt_VendorCIN').val().length == 21) {
                    if ($('.Txt_OwnerPersonPanCardNo').val() != '' && $('.Txt_OwnerPersonPanCardNo').val().length == 10) {
                        if ($('.Txt_OwnerAdharcardNo').val() != '' && $('.Txt_OwnerAdharcardNo').val().length == 12) {
                            if ($('.Txt_FirstPanCardNo').val() != '' && $('.Txt_FirstPanCardNo').val().length == 10) {
                                if ($('.Txt_FirstLineAadharcardNo').val() != '' && $('.Txt_FirstLineAadharcardNo').val().length == 12) {
                                    if ($('.Txt_SecondPanCardNo').val() != '' && $('.Txt_SecondPanCardNo').val().length == 10) {
                                        if ($('.Txt_SecondLineAdharcardNo').val() != '' && $('.Txt_SecondLineAdharcardNo').val().length == 12) {

                                        } else {
                                            check = false;
                                            $('.Txt_SecondLineAdharcardNo').tooltip({
                                                placement: "top",
                                                title: "Enter Aadhaarcard Number",
                                                trigger: "focus"
                                            });
                                            $('.Txt_SecondLineAdharcardNo').focus();
                                        }
                                    } else {
                                        check = false;
                                        $('.Txt_SecondPanCardNo').tooltip({
                                            placement: "top",
                                            title: "Enter Pancard Number",
                                            trigger: "focus"
                                        });
                                        $('.Txt_SecondPanCardNo').focus();
                                    }
                                } else {
                                    check = false;
                                    $('.Txt_FirstLineAadharcardNo').tooltip({
                                        placement: "top",
                                        title: "Enter Aadhaarcard Number",
                                        trigger: "focus"
                                    });
                                    $('.Txt_FirstLineAadharcardNo').focus();
                                }
                            } else {
                                check = false;
                                $('.Txt_FirstPanCardNo').tooltip({
                                    placement: "top",
                                    title: "Enter Pancard Number",
                                    trigger: "focus"
                                });
                                $('.Txt_FirstPanCardNo').focus();
                            }
                        } else {
                            check = false;
                            $('.Txt_OwnerAdharcardNo').tooltip({
                                placement: "top",
                                title: "Enter Aadhaarcard Number",
                                trigger: "focus"
                            });
                            $('.Txt_OwnerAdharcardNo').focus();
                        }
                    } else {
                        check = false;
                        $('.Txt_OwnerPersonPanCardNo').tooltip({
                            placement: "top",
                            title: "Enter Pancard Number",
                            trigger: "focus"
                        });
                        $('.Txt_OwnerPersonPanCardNo').focus();
                    }
                } else {
                    check = false;
                    $('.Txt_VendorCIN').tooltip({
                        placement: "top",
                        title: "Enter CIN Number",
                        trigger: "focus"
                    });
                    $('.Txt_VendorCIN').focus();
                }
            } else {
                check = false;
                $('.Txt_VendorGSTCertificates').tooltip({
                    placement: "top",
                    title: "Enter GST Number",
                    trigger: "focus"
                });
                $('.Txt_VendorGSTCertificates').focus();
            }
        } else {
            check = false;
            $('.Txt_VendorAadhaarCardNo').tooltip({
                placement: "top",
                title: "Enter Aadharcard Number",
                trigger: "focus"
            });
            $('.Txt_VendorAadhaarCardNo').focus();
        }
    } else {
        check = false;
        $('.Txt_VendorPanCardNo').tooltip({
            placement: "top",
            title: "Enter Pancard Number",
            trigger: "focus"
        });
        $('.Txt_VendorPanCardNo').focus();
    }
}
/*Validation of Owner Person Details*/
function validateOwnerPersonDetails() {
    var check = true;
    var CompEmail = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;

    if ($('.Txt_OwnerPersonName').val() != '') {
        if ($('.Txt_OwnerPersonPhoneNo').val() != '' && $('.Txt_OwnerPersonPhoneNo').val().length == 10) {
            if ($('.Txt_OwnerPersonEmailId').val() == '') {

                //if ($('.Txt_OwnerPersonDesignation').val() != '') {

                //} else {
                //    check = false;
                //    $('.Txt_OwnerPersonDesignation').tooltip({
                //        placement: "top",
                //        title: "Enter Designation",
                //        trigger: "focus"
                //    });
                //    $('.Txt_OwnerPersonDesignation').focus();
                //}
            }
            else if ($('.Txt_OwnerPersonEmailId').val() != '' && CompEmail.test($('.Txt_OwnerPersonEmailId').val())) {
                //if ($('.Txt_OwnerPersonDesignation').val() != '') {

                //} else {
                //    check = false;
                //    $('.Txt_OwnerPersonDesignation').tooltip({
                //        placement: "top",
                //        title: "Enter Designation",
                //        trigger: "focus"
                //    });
                //    $('.Txt_OwnerPersonDesignation').focus();
                //}
            } else {
                check = false;
                $('.Txt_OwnerPersonEmailId').tooltip({
                    placement: "top",
                    title: "Enter Owner Person Valid Email Id",
                    trigger: "focus"
                });
                $('.Txt_OwnerPersonEmailId').focus();
            }
        } else {
            check = false;
            $('.Txt_OwnerPersonPhoneNo').tooltip({
                placement: "top",
                title: "Enter Owner Person Contact Number",
                trigger: "focus"
            });
            $('.Txt_OwnerPersonPhoneNo').focus();
        }
    } else {
        check = false;
        $('.Txt_OwnerPersonName').tooltip({
            placement: "top",
            title: "Enter Owner Person Name",
            trigger: "focus"
        });
        $('.Txt_OwnerPersonName').focus();
    }
    if (!check) {
        return false;
    }
    else {
        $('[id*=HiddenField_Button_Tab2Save]').val("1");
        console.log($('[id*=HiddenField_Button_Tab2Save]').val());
        return true;
    }
}
/*Validation of First Line Person Details*/
function validateFirstLinePersonDetails() {
    var check = true;
    var CompEmail = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;

    if ($('.Txt_FirstName').val() != '') {
        if ($('.Txt_FirstPhno').val() != '' && $('.Txt_FirstPhno').val().length == 10) {
            if ($('.Txt_FirstEmailId').val() == '') {

            }
            else if ($('.Txt_FirstEmailId').val() != '' && CompEmail.test($('.Txt_FirstEmailId').val())) {
            }
            else {
                check = false;
                $('.Txt_FirstEmailId').tooltip({
                    placement: "top",
                    title: "Enter First Line Person Valid Email Id",
                    trigger: "focus"
                });
                $('.Txt_FirstEmailId').focus();
            }
        } else {
            check = false;
            $('.Txt_FirstPhno').tooltip({
                placement: "top",
                title: "Enter First Line Person Contact Number",
                trigger: "focus"
            });
            $('.Txt_FirstPhno').focus();
        }
    } else {
        check = false;
        $('.Txt_FirstName').tooltip({
            placement: "top",
            title: "Enter First Line Person Name",
            trigger: "focus"
        });
        $('.Txt_FirstName').focus();
    }
    if (!check) {
        return false;
    }
    else {

        $('[id*=HiddenField_Button_Tab3Save]').val("1");
        console.log($('[id*=HiddenField_Button_Tab3Save]').val());
        return true;
    }
}
/*Validation of Second Line Person Details*/
function validateSecondLinePersonDetails() {
    var check = true;
    var CompEmail = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;

    if ($('.Txt_SecondName').val() != '') {
        if ($('.Txt_SecondPhoneNo').val() != '' && $('.Txt_SecondPhoneNo').val().length == 10) {
            if ($('.Txt_SecondEmailId').val() == '') {

            }
            else if ($('.Txt_SecondEmailId').val() != '' && CompEmail.test($('.Txt_SecondEmailId').val())) {

            }
            else {
                check = false;
                $('.Txt_SecondEmailId').tooltip({
                    placement: "top",
                    title: "Enter Second Line Person Valid Email Id",
                    trigger: "focus"
                });
                $('.Txt_SecondEmailId').focus();
            }
        }
        else {
            check = false;
            $('.Txt_SecondPhoneNo').tooltip({
                placement: "top",
                title: "Enter Second Line Person Contact Number",
                trigger: "focus"
            });
            $('.Txt_SecondPhoneNo').focus();
        }
    } else {
        check = false;
        $('.Txt_SecondName').tooltip({
            placement: "top",
            title: "Enter Second Line Person Name",
            trigger: "focus"
        });
        $('.Txt_SecondName').focus();
    }
    if (!check) {
        return false;
    }
    else {
        $('[id*=HiddenField_Button_Tab4Save]').val("1");
        console.log($('[id*=HiddenField_Button_Tab4Save]').val());
        return true;
    }
}

/*Popup Area Details Validation*/
function validatePopupAreaDetails() {
    var check = true;
    if ($('.Txt_popArea').val() != '') {

    } else {
        check = false;
        $('.Txt_popArea').tooltip({
            placement: "top",
            title: "Enter Area Name",
            trigger: "focus"
        });
        $('.Txt_popArea').focus();
    }
    if (!check) {
        return false;
    }
    else {
        return true;
    }
    /*  if ($('.Ddl_popPincode option:selected').text() != 'Select...') {
            if ($('.Ddl_popState option:selected').text() != 'Select...') {
                if ($('.Ddl_popDistrict option:selected').text() != 'Select...') {
                    if ($('.Ddl_popCity option:selected').text() != 'Select...') {

                    } else {
                        check = false;
                        $('.Ddl_popCity').tooltip({
                            placement: "top",
                            title: "Select City",
                            trigger: "focus"
                        });
                        $('.Ddl_popCity').focus();
                    }
                } else {
                    check = false;
                    $('.Ddl_popDistrict').tooltip({
                        placement: "top",
                        title: "Select District",
                        trigger: "focus"
                    });
                    $('.Ddl_popDistrict').focus();
                }
            } else {
                check = false;
                $('.Ddl_popState').tooltip({
                    placement: "top",
                    title: "select State",
                    trigger: "focus"
                });
                $('.Ddl_popState').focus();
            }
        } else {
            check = false;
            $('.Ddl_popPincode').tooltip({
                placement: "top",
                title: "Select Pincode",
                trigger: "focus"
            });
            $('.Ddl_popPincode').focus();
        }*/
}




/* Check Numbers Only*/
$('.FirstNotZero').keypress(function (e) {
    if (this.value.length == 0 && e.which == 48) {
        return false;
    }
});

function validateNumericValue(key) {
    var keycode = (key.which) ? key.which : key.keyCode;

    if (!(keycode >= 48 && keycode <= 57)) {
        return false;
    }
    return true;
}

function checkNumAlpha() {

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
function onlyAlphaValue() {

    if ((event.keyCode > 64 && event.keyCode < 91) || (event.keyCode > 96 && event.keyCode < 123) || event.keyCode == 8) {
        return true;
    }
    else {
        return false;
    }
}
