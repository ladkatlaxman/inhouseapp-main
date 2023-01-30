/*Validation of Vehicle Details*/
function validatePickDelLHS() {
    var check = true;
    if ($('.Txt_NewVehicleNoAlpha1').val() != '' && $('.Txt_NewVehicleNoAlpha1').val().length == 2) {
        if ($('.Txt_NewVehicleNoDigit1').val() != '' && $('.Txt_NewVehicleNoDigit1').val() != '00') {
            if ($('.Txt_NewVehicleNoAlpha2').val() != '') {
                if ($('.Txt_NewVehicleNoDigit2').val() != '' && $('.Txt_NewVehicleNoDigit2').val() != '0000') {
                    if ($('.Txt_NoOfLabour').val() != '') {
                        if ($('.Txt_HiringDate').val() != '') {
                            check = true;
                        } else {
                            check = false;
                            $('.Txt_HiringDate').tooltip({
                                placement: "top",
                                title: "Enter Hiring Date",
                                trigger: "focus"
                            });
                            $('.Txt_HiringDate').focus();
                        }
                    } else {
                        check = false;
                        $('.Txt_NoOfLabour').tooltip({
                            placement: "top",
                            title: "Enter No of labour",
                            trigger: "focus"
                        });
                        $('.Txt_NoOfLabour').focus();
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
        return true;
    }
}

function validateAccount() {
    var check = true;
    if ($('.Txt_AccountCode').val() != '') {
        if ($('.Txt_Charges').val() != '') {
            check = true;
        } else {
            check = false;
            $('.Txt_Charges').tooltip({
                placement: "top",
                title: "Enter Charges",
                trigger: "focus"
            });
            $('.Txt_Charges').focus();
        }
    }
    else {
        check = false;
        $('.Txt_AccountCode').tooltip({
            placement: "top",
            title: "Select Account Code",
            trigger: "focus"
        });
        $('.Txt_AccountCode').focus();
    }
    if (!check)
        return false;
    else
        return true;

}

function validatePickDelLHSStaff() {
    var check = true;
    if ($('.Ddl_StaffType option:selected').text() == 'DRIVER') {
        if ($('.Ddl_DriverName option:selected').text() != 'SELECT') {
            if ($('.Txt_ContactNo').val() != 'AUTO') {
                $("#hfButtonAdd").val(1);
                console.log($("#hfButtonAdd").val());
                check = true;
            } else {
                check = false;
                $('.Txt_ContactNo').tooltip({
                    placement: "top",
                    title: "Enter Driver ContactNo",
                    trigger: "focus"
                });
                $('.Txt_ContactNo').focus();
            }
        } else {
            check = false;
            $('.Ddl_DriverName').tooltip({
                placement: "top",
                title: "Enter Driver Name",
                trigger: "focus"
            });
            $('.Ddl_DriverName').focus();
        }
    } else if ($('.Ddl_StaffType option:selected').text() == 'PICKUP PERSON') {
        if ($('.ddl_PickPersonName option:selected').text() != 'SELECT') {
            if ($('.Txt_ContactNo').val() != 'AUTO') {
                $("#hfButtonAdd").val(1);
                console.log($("#hfButtonAdd").val());
                check = true;
            } else {
                check = false;
                $('.Txt_ContactNo').tooltip({
                    placement: "top",
                    title: "Enter PickUp Person ContactNo",
                    trigger: "focus"
                });
                $('.Txt_ContactNo').focus();
            }
        } else {
            check = false;
            $('.ddl_PickPersonName').tooltip({
                placement: "top",
                title: "Enter PickUp Person Name",
                trigger: "focus"
            });
            $('.ddl_PickPersonName').focus();
        }
    }
    else {
        check = false;
        $('.Ddl_StaffType').tooltip({
            placement: "top",
            title: "Enter Staff Type",
            trigger: "focus"
        });
        $('.Ddl_StaffType').focus();
    }
    if (!check) 
        return false;
    else 
        return true;
    
}


function validateTranshipLHS() {
    var check = true;
    if ($('.Txt_NewVehicleNoAlpha1').val() != '' && $('.Txt_NewVehicleNoAlpha1').val().length == 2) {
        if ($('.Txt_NewVehicleNoDigit1').val() != '' && $('.Txt_NewVehicleNoDigit1').val() != '00') {
            if ($('.Txt_NewVehicleNoAlpha2').val() != '') {
                if ($('.Txt_NewVehicleNoDigit2').val() != '' && $('.Txt_NewVehicleNoDigit2').val() != '0000') {
                    if ($('.Txt_NoOfLabour').val() != '') {
                     if ($('.Txt_HiringDate').val() != '') {
                            if ($('.Ddl_VehicleRoute option:selected').text() != 'SELECT') {
                                if ($('.Ddl_RouteSchedule option:selected').text() != 'SELECT') {
                                    check = true;
                                } else {
                                    check = false;
                                    $('.Ddl_RouteSchedule').tooltip({
                                        placement: "top",
                                        title: "Select Schedule",
                                        trigger: "focus"
                                    });
                                    $('.Ddl_RouteSchedule').focus();
                                }
                            } else {
                                check = false;
                                $('.Ddl_VehicleRoute').tooltip({
                                    placement: "top",
                                    title: "Select Route",
                                    trigger: "focus"
                                });
                                $('.Ddl_VehicleRoute').focus();
                            }
                       
                    } else {
                        check = false;
                        $('.Txt_HiringDate').tooltip({
                            placement: "top",
                            title: "Enter Date",
                            trigger: "focus"
                        });
                        $('.Txt_HiringDate').focus();
                    }
                    } else {
                        check = false;
                        $('.Txt_NoOfLabour').tooltip({
                            placement: "top",
                            title: "Enter No of Labour",
                            trigger: "focus"
                        });
                        $('.Txt_NoOfLabour').focus();
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
        return true;
    }
}