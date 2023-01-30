function validateRouteMaster() {
    var check = true;
    var myHidden = document.getElementById("hfRouteMasterSubmit").value;
    console.log(myHidden);
    console.log($('.txtFromBranch').val());
    if ($('.txtFromBranch').val() != '') {
        if ($('.txtToBranch').val() != '') {
            if ($('.txtRouteName').val() != '') {
                if ($('.txtTotalDistance').val() != '0') {
                    if ($('.txtTotalMapDistance').val() != '0') {
                        if (myHidden != 0) {
                            check = true;
                        } else {
                            check = false;
                            $('.Button_Submit1').tooltip({
                                placement: "top",
                                title: "Please Enter Complete RouteDetail",
                                trigger: "focus"
                            });
                            $('.TxtBranch2').focus();
                        }
                    } else {
                        check = false;
                        $('.txtTotalMapDistance').tooltip({
                            placement: "top",
                            title: "Please Contact to IT Team",
                            trigger: "focus"
                        });
                        $('.txtTotalMapDistance').focus();
                    }
                } else {
                    check = false;
                    $('.txtTotalDistance').tooltip({
                        placement: "top",
                        title: "Please Contact to IT Team",
                        trigger: "focus"
                    });
                    $('.txtTotalDistance').focus();
                }
            } else {
                check = false;
                $('.txtRouteName').tooltip({
                    placement: "top",
                    title: "Enter Route Name",
                    trigger: "focus"
                });
                $('.txtRouteName').focus();
            }
        } else {
            check = false;
            $('.txtToBranch').tooltip({
                placement: "top",
                title: "Enter To Branch",
                trigger: "focus"
            });
            $('.txtToBranch').focus();
        }
    } else {
        check = false;
        $('.txtFromBranch').tooltip({
            placement: "top",
            title: "Enter From Branch",
            trigger: "focus"
        });
        $('.txtFromBranch').focus();
    }

    if (!check)
        return false;
    else {
        return true;
    }
}

function validateRouteDetail() {
    var check = true;
    console.log($('.TxtBrnach1').val());
    if ($('.TxtBrnach1').val() != 'AUTO') {
        if ($('.TxtBrnach2').val() != '') {
            if ($('.TxtDistance').val() != '') {
                if ($('.Txt_MapDistance').val() != '') {
                    check = true;
                } else {
                    check = false;
                    $('.Txt_MapDistance').tooltip({
                        placement: "top",
                        title: "Please Contact to IT Team",
                        trigger: "focus"
                    });
                    $('.Txt_MapDistance').focus();
                }
            } else {
                check = false;
                $('.TxtDistance').tooltip({
                    placement: "top",
                    title: "Enter Distance",
                    trigger: "focus"
                });
                $('.TxtDistance').focus();
            }
        } else {
            check = false;
            $('.TxtBrnach2').tooltip({
                placement: "top",
                title: "Enter To Brnach",
                trigger: "focus"
            });
            $('.TxtBrnach2').focus();
        }
    } else {
        check = false;
        $('.TxtBrnach1').tooltip({
            placement: "top",
            title: "Enter From Brnach",
            trigger: "focus"
        });
        $('.TxtBrnach1').focus();
    }
    console.log(check);
    if (!check) {
        $("#hfAddTouchingBranch").val(0);
        return false;
    }
    else {
        $("#hfAddTouchingBranch").val(1);
        return true;
    }
}

function ValidationRouteSchedule() {
    var check = true;
    if ($('.Ddl_RouteName option:selected').text() != 'SELECT') {
        if ($('.Txt_ScheduleName').val() != '') {
            check = true;
        }
        else {
            check = false;
            $('.Txt_ScheduleName').tooltip({
                placement: "top",
                title: "Enter Schedule Name",
                trigger: "focus"
            });
            $('.Txt_ScheduleName').focus();
        }
    } else {
        check = false;
        $('.Ddl_RouteName').tooltip({
            placement: "top",
            title: "Select Route Name",
            trigger: "focus"
        });
        $('.Ddl_RouteName').focus();
    }

    if (!check)
        return false;
    else {
        return true;
    }
}

//function validateRouteDetails() {
//    var check = true;
//    if ($('.Txt_RouteCode').val() != '') {
//        if ($('.Txt_RouteName').val() != '') {
//            if ($('.Txt_FromBranch').val() != 'SELECT') {
//                if ($('.Txt_Hub1').val() != 'SELECT') {
//                    if ($('.Txt_Hub2').val() != 'SELECT') {
//                        if ($('.Txt_Hub3').val() != 'SELECT') {
//                            if ($('.Txt_Hub4').val() != 'SELECT') {
//                                if ($('.Txt_Hub5').val() != 'SELECT') {
//                                    if ($('.Txt_Hub6').val() != 'SELECT') {
//                                        if ($('.Txt_Hub7').val() != 'SELECT') {
//                                            if ($('.Txt_Hub8').val() != 'SELECT') {
//                                                if ($('.Txt_Hub9').val() != 'SELECT') {
//                                                    if ($('.Txt_Hub10').val() != 'SELECT') {
//                                                        if ($('.Txt_ToBranch').val() != 'SELECT') {
//                                                            check = true;
//                                                        }
//                                                        else {
//                                                            check = false;
//                                                            $('.Txt_ToBranch').tooltip({
//                                                                placement: "top",
//                                                                title: "Select ToBranch",
//                                                                trigger: "focus"
//                                                            });
//                                                            $('.Txt_ToBranch').focus();
//                                                        }
//                                                    }
//                                                    else {
//                                                        check = false;
//                                                        $('.Txt_Hub10').tooltip({
//                                                            placement: "top",
//                                                            title: "Select Hub10",
//                                                            trigger: "focus"
//                                                        });
//                                                        $('.Txt_Hub10').focus();
//                                                    }
//                                                }
//                                                else {
//                                                    check = false;
//                                                    $('.Txt_Hub9').tooltip({
//                                                        placement: "top",
//                                                        title: "Select Hub9",
//                                                        trigger: "focus"
//                                                    });
//                                                    $('.Txt_Hub9').focus();
//                                                }
//                                            }
//                                            else {
//                                                check = false;
//                                                $('.Txt_Hub8').tooltip({
//                                                    placement: "top",
//                                                    title: "Select Hub8",
//                                                    trigger: "focus"
//                                                });
//                                                $('.Txt_Hub8').focus();
//                                            }
//                                        }
//                                        else {
//                                            check = false;
//                                            $('.Txt_Hub7').tooltip({
//                                                placement: "top",
//                                                title: "Select Hub7",
//                                                trigger: "focus"
//                                            });
//                                            $('.Txt_Hub7').focus();
//                                        }
//                                    }
//                                    else {
//                                        check = false;
//                                        $('.Txt_Hub6').tooltip({
//                                            placement: "top",
//                                            title: "Select Hub6",
//                                            trigger: "focus"
//                                        });
//                                        $('.Txt_Hub6').focus();
//                                    }
//                                }
//                                else {
//                                    check = false;
//                                    $('.Txt_Hub5').tooltip({
//                                        placement: "top",
//                                        title: "Select Hub5",
//                                        trigger: "focus"
//                                    });
//                                    $('.Txt_Hub5').focus();
//                                }
//                            }
//                            else {
//                                check = false;
//                                $('.Txt_Hub4').tooltip({
//                                    placement: "top",
//                                    title: "Select Hub4",
//                                    trigger: "focus"
//                                });
//                                $('.Txt_Hub4').focus();
//                            }
//                        }
//                        else {
//                            check = false;
//                            $('.Txt_Hub3').tooltip({
//                                placement: "top",
//                                title: "Select Hub3",
//                                trigger: "focus"
//                            });
//                            $('.Txt_Hub3').focus();
//                        }
//                    }
//                    else {
//                        check = false;
//                        $('.Txt_Hub2').tooltip({
//                            placement: "top",
//                            title: "Select Hub2",
//                            trigger: "focus"
//                        });
//                        $('.Txt_Hub2').focus();
//                    }
//                }
//                else {
//                    check = false;
//                    $('.Txt_Hub1').tooltip({
//                        placement: "top",
//                        title: "Select Hub1",
//                        trigger: "focus"
//                    });
//                    $('.Txt_Hub1').focus();
//                }
//            }
//            else {
//                check = false;
//                $('.Txt_FromBranch').tooltip({
//                    placement: "top",
//                    title: "Select Branch Name",
//                    trigger: "focus"
//                });
//                $('.Txt_FromBranch').focus();
//            }
//        }
//        else {
//            check = false;
//            $('.Txt_RouteName').tooltip({
//                placement: "top",
//                title: "Enter Name",
//                trigger: "focus"
//            });
//            $('.Txt_RouteName').focus();
//        }
//    }
//    else {
//        check = false;
//        $('.Txt_RouteCode').tooltip({
//            placement: "top",
//            title: "Please Contact to IT Team",
//            trigger: "focus"
//        });
//        $('.Txt_RouteCode').focus();
//    }
//    if (!check) {
//        return false;
//    }
//    else {
//        $('[id*=HiddenField_Submit1]').val("1");
//        console.log($('[id*=HiddenField_Submit1]').val());
//        return true;
//    }
//}
function
    checkAlpha() {

    if ((event.keyCode > 64 && event.keyCode < 91) || (event.keyCode > 96 && event.keyCode < 123) || event.keyCode == 8 || event.keyCode == 32) {
        return true;
    }
    else {
        return false;
    }
}