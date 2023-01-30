
/*Validation of Vehicle Details*/
function validateVehicleDetails() {
    var check = true;
    if ($('.Txt_NewVehicleNoAlpha1').val() != '' && $('.Txt_NewVehicleNoAlpha1').val().length == 2) {
        if ($('.Txt_NewVehicleNoDigit1').val() != '' && $('.Txt_NewVehicleNoDigit1').val() != '00') {
            if ($('.Txt_NewVehicleNoAlpha2').val() != '') {
                if ($('.Txt_NewVehicleNoDigit2').val() != '' && $('.Txt_NewVehicleNoDigit2').val() != '0000') {
                    if ($('.Ddl_VehicleCategory option:selected').text() != 'SELECT') {
                        if ($('.Ddl_TransporterName option:selected').text() != 'SELECT') {
                            if ($('.Txt_VehicleHiringType').val() != '') {
                                if ($('.Ddl_VehicleType option:selected').text() != 'SELECT') {
                                    if ($('.Ddl_VehicleStatus option:selected').text() != 'SELECT') {
                                        //if ($('.Txt_StartKM').val() != '') {

                                        //} else {
                                        //    check = false;
                                        //    $('.Txt_StartKM').tooltip({
                                        //        placement: "top",
                                        //        title: "Enter Start Km",
                                        //        trigger: "focus"

                                        //    });
                                        //    $('.Txt_StartKM').focus();
                                        //}
                                    } else {
                                        check = false;
                                        $('.Ddl_VehicleStatus').tooltip({
                                            placement: "top",
                                            title: "Select Vehicle Status",
                                            trigger: "focus"
                                        });
                                        $('.Ddl_VehicleStatus').focus();

                                    }
                                } else {
                                    check = false;
                                    $('.Ddl_VehicleType').tooltip({
                                        placement: "top",
                                        title: "Select Vehicle Type",
                                        trigger: "focus"
                                    });
                                    $('.Ddl_VehicleType').focus();
                                }
                            } else {
                                check = false;
                                $('.Txt_VehicleHiringType').tooltip({
                                    placement: "top",
                                    title: "Select Vehicle Used For",
                                    trigger: "focus"
                                });
                                $('.Txt_VehicleHiringType').focus();
                            }
                        }
                        else {
                            check = false;
                            $('.Ddl_TransporterName').tooltip({
                                placement: "top",
                                title: "Select Transporter Name",
                                trigger: "focus"
                            });
                            $('.Ddl_TransporterName').focus();
                        }
                    }
                    else {
                        check = false;
                        $('.Ddl_VehicleCategory').tooltip({
                            placement: "top",
                            title: "Select Vehicle Category",
                            trigger: "focus"
                        });
                        $('.Ddl_VehicleCategory').focus();
                    }
                } else {
                    check = false;
                    $('.Txt_NewVehicleNoDigit2').tooltip({
                        placement: "top",
                        title: "Enter Number",
                        trigger: "focus"

                    });
                    $('.Txt_NewVehicleNoDigit2').focus();
                }
            } else {
                check = false;
                $('.Txt_NewVehicleNoAlpha2').tooltip({
                    placement: "top",
                    title: "Enter 1 or 2 Character",
                    trigger: "focus"

                });
                $('.Txt_NewVehicleNoAlpha2').focus();
            }
        } else {
            check = false;
            $('.Txt_NewVehicleNoDigit1').tooltip({
                placement: "top",
                title: "Enter 1 or 2 Number",
                trigger: "focus"

            });
            $('.Txt_NewVehicleNoDigit1').focus();
        }
    } else {
        check = false;
        $('.Txt_NewVehicleNoAlpha1').tooltip({
            placement: "top",
            title: "Enter 2 Character",
            trigger: "focus"

        });
        $('.Txt_NewVehicleNoAlpha1').focus();
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
/* if ($('.Ddl_VehicleType option:selected').text() != 'SELECT') {
                                if ($('.Txt_StartKM').val() != '') {

                                } else {
                                    check = false;
                                    $('.Txt_StartKM').tooltip({
                                        placement: "top",
                                        title: "Enter Start Km",
                                        trigger: "focus"

                                    });
                                    $('.Txt_StartKM').focus();
                                }
                            }
                            else {
                                check = false;
                                $('.Ddl_VehicleType').tooltip({
                                    placement: "top",
                                    title: "Select Vehicle Type",
                                    trigger: "focus"
                                });
                                $('.Ddl_VehicleType').focus();
                            }
                        }*/
/*Validation of  Vehicle Document Details*/
function validateVehicleDocDetails() {
    var check = true;
    if ($('.Txt_InsNo').val() != '') {
        if ($('.Txt_PUCNo').val() != '') {

        } else {
            check = false;
            $('.Txt_PUCNo').tooltip({
                placement: "top",
                title: "Enter PUC Number",
                trigger: "focus"

            });
            $('.Txt_PUCNo').focus();
        }
    } else {
        check = false;
        $('.Txt_InsNo').tooltip({
            placement: "top",
            title: "Enter Insurance Number",
            trigger: "focus"

        });
        $('.Txt_InsNo').focus();
    }
    if (!check) {
        return false;
    }
    else {
        return true;
    }
}
/*Validation of  Staff Details*/
function validateVehicleStaffDetails() {
    var check = true;
    if ($('.Txt_Vehicle_Owner').val() != 'SELECT') {
        if ($('.Txt_OwnerContactNo').val() != '') {

        } else {
            check = false;
            $('.Txt_OwnerContactNo').tooltip({
                placement: "top",
                title: "Contact To Branch",
                trigger: "focus"

            });
            $('.Txt_OwnerContactNo').focus();
        }
    }
    else {
        check = false;
        $('.Txt_Vehicle_Owner').tooltip({
            placement: "top",
            title: "Select Owner Name",
            trigger: "focus"
        });
        $('.Txt_Vehicle_Owner').focus();
    }
    if (!check) {
        return false;
    }
    else {
        return true;
    }
}
/*Popup Owner Model Validation*/
function validateOwnerDetails() {
    var check = true;
    if ($('.Txt_PopOwnerName').val() != '') {
        if ($('.Txt_PopOwnerContactNo').val() != '') {

        } else {
            check = false;
            $('.Txt_PopOwnerContactNo').tooltip({
                placement: "top",
                title: "Enter Owner Contact Number",
                trigger: "focus"
            });
            $('.Txt_PopOwnerContactNo').focus();
        }
    } else {
        check = false;
        $('.Txt_PopOwnerName').tooltip({
            placement: "top",
            title: "Enter Owner Name",
            trigger: "focus"
        });
        $('.Txt_PopOwnerName').focus();
    }
    if (!check) {
        return false;
    }
    else {
        return true;
    }
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
/*validate Pancard*/
function validatePancardNum() {
    if ((event.keyCode > 64 && event.keyCode < 91) || (event.keyCode > 47 && event.keyCode < 58) || event.keyCode == 8) {
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
function checkNumAlpha() {

    if ((event.keyCode > 64 && event.keyCode < 91) || (event.keyCode > 96 && event.keyCode < 123) || event.keyCode == 8 || event.keyCode == 32) {
        return true;
    }
    else {
        return false;
    }
}
/*Only Capital Letter*/
function checkNum() {

    if ((event.keyCode > 64 && event.keyCode < 91) || (event.keyCode > 96 && event.keyCode < 123) || event.keyCode == 8)
        return true;
    else {
        return false;
    }

}

