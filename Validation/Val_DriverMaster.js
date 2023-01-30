
function validateDriverDetails() {
    var check = true;
    var con1 = "Enter Contact No.";
    var con2 = "Enter Correct Contact No.";
    var CompEmail = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
    var EmailId = $('.Txt_DriverEmailId').val();

    if ($('.Txt_DriverName').val() != '') {
        if ($('.Txt_DriverContactNo').val() != '') {
            if (CompEmail.test(EmailId)) {
                if ($('.Txt_State').val() != 'SELECT') {
                    if ($('.Txt_City').val() != '') {
                        if ($('.Txt_Pincode').val() != '' && $('.Txt_Pincode').val().length == 6) {
                            if ($('.Txt_DriverAddress').val() != '') {
                                if ($('.Txt_BelongToBranch').val() != 'SELECT') {
                                    check = true;
                                }
                                else {
                                    check = false;
                                    $('.Txt_BelongToBranch').tooltip({
                                        placement: "top",
                                        title: "Select Branch",
                                        trigger: "focus"
                                    });
                                    $('.Txt_BelongToBranch').focus();
                                }

                            }
                            else {
                                check = false;
                                $('.Txt_DriverAddress').tooltip({
                                    placement: "top",
                                    title: "Enter Driver Address",
                                    trigger: "focus"
                                });
                                $('.Txt_DriverAddress').focus();
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
                        $('.Txt_City').tooltip({
                            placement: "top",
                            title: "Enter City",
                            trigger: "focus"
                        });
                        $('.Txt_City').focus();
                    }
                }
                else {
                    check = false;
                    $('.Txt_State').tooltip({
                        placement: "top",
                        title: "Select State",
                        trigger: "focus"
                    });
                    $('.Txt_State').focus();
                }
            }
            else {
                check = false;
                $('.Txt_DriverEmailId').tooltip({
                    placement: "top",
                    title: "Enter Correct Email ID",
                    trigger: "focus"
                });
                $('.Txt_DriverEmailId').focus();
            }
        }
        else {
            check = false;
            $('.Txt_DriverContactNo').tooltip({
                placement: "top",
                title: "Enter Driver Contact No",
                trigger: "focus"
            });
            $('.Txt_DriverContactNo').focus();
        }
    }
    else {
        check = false;
        $('.Txt_DriverName').tooltip({
            placement: "top",
            title: "Enter Driver Name",
            trigger: "focus"
        });
        $('.Txt_DriverName').focus();
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






   





/* //if ($('.Txt_PanCardNo').val() != '' && $('.Txt_PanCardNo').val().length == 10) {
                                            //    if ($('.Txt_AdharcardNo').val() != '' && $('.Txt_AdharcardNo').length == 12) {


                                            //    }
                                            //    else {
                                            //        check = false;
                                            //        $('.Txt_AdharcardNo').tooltip({
                                            //            placement: "top",
                                            //            title: "Enter Adharcard No",
                                            //            trigger: "focus"
                                            //        });
                                            //        $('.Txt_AdharcardNo').focus();
                                            //    }


                                            //}
                                            //else {
                                            //    check = false;
                                            //    $('.Txt_PanCardNo').tooltip({
                                            //        placement: "top",
                                            //        title: "Enter Pancard No",
                                            //        trigger: "focus"
                                            //    });
                                            //    $('.Txt_PanCardNo').focus();
                                            //}
*/
/*Driver Documents*/
//function validateDriverDocDetails() {
//    var check = true;
//    if ($('.Txt_LicenceId').val() != '') {
//        if ($('.Txt_LicenceValidDateFrom').val() != '') {
//            if ($('.Txt_LicenceValidDateTo').val() != '') {
//            }
//            else {
//                check = false;
//                $('.Txt_LicenceValidDateTo').tooltip({
//                    placement: "top",
//                    title: "Enter Date",
//                    trigger: "focus"
//                });
//                $('.Txt_LicenceValidDateTo').focus();
//            }

//        }
//        else {
//            check = false;
//            $('.Txt_LicenceValidDateFrom').tooltip({
//                placement: "top",
//                title: "Enter Date",
//                trigger: "focus"
//            });
//            $('.Txt_LicenceValidDateFrom').focus();
//        }
//    }
//    else {
//        check = false;
//        $('.Txt_LicenceId').tooltip({
//            placement: "top",
//            title: "Enter Licence No",
//            trigger: "focus"
//        });
//        $('.Txt_LicenceId').focus();
//    }
//}
/*  if ($('.Txt_PanCardNo').val() != '' && $('.Txt_PanCardNo').val().length == 10) {
                    if ($('.Txt_AdharcardNo').val() != '' && $('.Txt_AdharcardNo').val().length == 12) {

                    }
                    else {
                        check = false;
                        $('.Txt_AdharcardNo').tooltip({
                            placement: "top",
                            title: "Enter Aadharcard Number",
                            trigger: "focus"
                        });
                        $('.Txt_AdharcardNo').focus();
                    }
                }
                else {
                    check = false;
                    $('.Txt_PanCardNo').tooltip({
                        placement: "top",
                        title: "Enter Pancard Number",
                        trigger: "focus"
                    });
                    $('.Txt_PanCardNo').focus();
                }
            }*/
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

function checkAlphaNum() {

    if ((event.keyCode > 64 && event.keyCode < 91) || (event.keyCode > 47 && event.keyCode < 58) || event.keyCode == 8) {
        return true;
    }
    else {
        return false;
    }
}

































//var CompAlpha = /^[a-zA-Z ]+$/;
//var CompNumber = /[0-9 -()+]+$/;
//var CompEmail = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
//var CompAlphaNumeric = /^([a-zA-Z0-9 _-]+)$/;

//var DriverName = $('.Txt_DriverName').val();
//var DriverContactNo = $('.Txt_DriverContactNo').val();
//var DriverEmailId = $('.Txt_DriverEmailId').val();
//var DriverLicenceNo = $('.Txt_DriverEmailId').val();
//var PancardNo = $('.Txt_PanCardNo').val();
//var AdharcardNo = $('.Txt_AdharcardNo').val();

//if (DriverName != '') {
//    if (CompAlpha.test(DriverName)) {
//        if (DriverContactNo != '') {
//            if (CompNumber.test(DriverContactNo) && DriverContactNo.length == 10) {
//                if (DriverEmailId != '') {
//                    if (CompEmail.test(DriverEmailId)) {
//                        if ($('.Ddl_BankState').val() != 'Select...') {
//                            if ($('.Txt_City').val() != '') {
//                                if ($('.Txt_DriverAddress').val() != '') {
//                                    if ($('.Txt_LicenceId').val() != '') {
//                                        if ($('.Txt_LicenceValidDateFrom').val() != '') {
//                                            if ($('.Txt_LicenceValidDateTo').val() != '') {
//                                                if (PancardNo != '') {
//                                                    if (CompAlphaNumeric.test(PancardNo) && PancardNo.length == 10) {
//                                                        if (AdharcardNo != '') {
//                                                            if (CompNumber.test(AdharcardNo) && AdharcardNo.length == 12) {

//                                                            } else {
//                                                                $('.Txt_AdharcardNo').tooltip({
//                                                                    placement: "top",
//                                                                    title: "Enter Valid Driver Aadharcard Number",
//                                                                    trigger: "focus"
//                                                                });
//                                                                $('.Txt_AdharcardNo').focus();
//                                                            }
//                                                        } else {
//                                                            $('.Txt_AdharcardNo').tooltip({
//                                                                placement: "top",
//                                                                title: "Enter Driver Aadharcard Number",
//                                                                trigger: "focus"
//                                                            });
//                                                            $('.Txt_AdharcardNo').focus();
//                                                        }
//                                                    } else {
//                                                        $('.Txt_PanCardNo').tooltip({
//                                                            placement: "top",
//                                                            title: "Enter Valid Driver Pancard Number",
//                                                            trigger: "focus"
//                                                        });
//                                                        $('.Txt_PanCardNo').focus();
//                                                    }
//                                                } else {
//                                                    $('.Txt_PanCardNo').tooltip({
//                                                        placement: "top",
//                                                        title: "Enter Driver Pancard Number",
//                                                        trigger: "focus"
//                                                    });
//                                                    $('.Txt_PanCardNo').focus();
//                                                }
//                                            } else {
//                                                $('.Txt_LicenceValidDateTo').tooltip({
//                                                    placement: "top",
//                                                    title: "Enter Driver Licence Licence Valid Date To",
//                                                    trigger: "focus"
//                                                });
//                                                $('.Txt_LicenceValidDateTo').focus();
//                                            }
//                                        } else {
//                                            $('.Txt_LicenceValidDateFrom').tooltip({
//                                                placement: "top",
//                                                title: "Enter Driver Licence Licence Valid Date From",
//                                                trigger: "focus"
//                                            });
//                                            $('.Txt_LicenceValidDateFrom').focus();
//                                        }
//                                    } else {
//                                        $('.Txt_LicenceId').tooltip({
//                                            placement: "top",
//                                            title: "Enter Driver Licence Number",
//                                            trigger: "focus"
//                                        });
//                                        $('.Txt_LicenceId').focus();
//                                    }
//                                } else {
//                                    $('.Txt_DriverAddress').tooltip({
//                                        placement: "top",
//                                        title: "Enter Driver Address",
//                                        trigger: "focus"
//                                    });
//                                    $('.Txt_DriverAddress').focus();
//                                }
//                            } else {
//                                $('.Txt_City').tooltip({
//                                    placement: "top",
//                                    title: "Enter Driver City",
//                                    trigger: "focus"
//                                });
//                                $('.Txt_City').focus();
//                            }
//                        } else {
//                            $('.Ddl_BankState').tooltip({
//                                placement: "top",
//                                title: "Select Driver State",
//                                trigger: "focus"
//                            });
//                            $('.Ddl_BankState').focus();
//                        }
//                    } else {
//                        $('.Txt_DriverEmailId').tooltip({
//                            placement: "top",
//                            title: "Enter Valid Driver Email Id",
//                            trigger: "focus"
//                        });
//                        $('.Txt_DriverEmailId').focus();
//                    }
//                } else {
//                    $('.Txt_DriverEmailId').tooltip({
//                        placement: "top",
//                        title: "Enter Driver Email Id",
//                        trigger: "focus"
//                    });
//                    $('.Txt_DriverEmailId').focus();
//                }
//            } else {
//                $('.Txt_DriverContactNo').tooltip({
//                    placement: "top",
//                    title: "Enter Valid Driver Contact Number",
//                    trigger: "focus"
//                });
//                $('.Txt_DriverContactNo').focus();
//            }
//        } else {
//            $('.Txt_DriverContactNo').tooltip({
//                placement: "top",
//                title: "Enter Driver Contact Number",
//                trigger: "focus"
//            });
//            $('.Txt_DriverContactNo').focus();
//        }

//    } else {
//        $('.Txt_DriverName').tooltip({
//            placement: "top",
//            title: "Enter Valid Driver Name",
//            trigger: "focus"
//        });
//        $('.Txt_DriverName').focus();
//    }
//} else {
//    $('.Txt_DriverName').tooltip({
//        placement: "top",
//        title: "Enter Driver Name",
//        trigger: "focus"
//    });
//    $('.Txt_DriverName').focus();
//}

