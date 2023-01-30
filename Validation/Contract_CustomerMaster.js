/*Validation of Basic And Contract Details*/

$(document).ready(function () {
    $('#Btn_CustomerContractNext').click(function () {
        $('#Txt_Minweight').focusin();
    });
});

function validateContractBasicDetails() {
    var check = true;
    var CompEmail = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
    if ($('.Txt_BillingPartyName').val() != '') {
        if ($('.Txt_FromDate').val() != '') {
            if ($('.Txt_ToDate').val() != '') {
                if ($('.Txt_signingDate').val() != '') {
                    if ($('.Ddl_BranchName option:selected').text() != 'SELECT') {
                        if ($('.Txt_CFTValue').val() != '') {
                            if ($('.Txt_FreightRate').val() != '') {
                            if ($('.Ddl_CategoryOfDays option:selected').text() != 'SELECT') {
                                if ($('.Txt_CategoryOfDays').val() != '') {
                                    if ($('.Ddl_DeliveryType option:selected').text() != 'SELECT') {
                                        if ($('.Txt_GracePeriod').val() != '') {
                                            if ($('.Txt_DemurrageCharges').val() != '') {
                                                if ($('.Txt_Minweight').val() != '') {
                                                    if ($('.Txt_MinFreight').val() != '') {
                                                        if ($('.Txt_waybillcharges').val() != '') {
                                                            if ($('.Txt_ODACharges').val() != '') {
                                                                if ($('.Ddl_DSCType option:selected').text() != 'SELECT') {
                                                                    if ($('.Txt_DSCValue').val() != '') {
                                                                    if ($('.Ddl_ROVUnit option:selected').text() != 'SELECT') {
                                                                        if ($('.Txt_Range').val() != '') {
                                                                            check = true;
                                                                        } else {
                                                                            check = false;
                                                                            $('.Txt_Range').tooltip({
                                                                                placement: "top",
                                                                                title: "Enter Range",
                                                                                trigger: "focus"
                                                                            });
                                                                            $('.Txt_Range').focus();
                                                                        }
                                                                    }
                                                                    else {
                                                                        check = false;
                                                                        $('.Ddl_ROVUnit').tooltip({
                                                                            placement: "top",
                                                                            title: "Select ROV Units",
                                                                            trigger: "focus"
                                                                        });
                                                                        $('.Ddl_ROVUnit').focus();
                                                                    }
                                                                    } else {
                                                                        check = false;
                                                                        $('.Txt_DSCValue').tooltip({
                                                                            placement: "top",
                                                                            title: "Enter DSC Charges",
                                                                            trigger: "focus"
                                                                        });
                                                                        $('.Txt_DSCValue').focus();
                                                                    }
                                                                } else {
                                                                    check = false;
                                                                    $('.Ddl_DSCType').tooltip({
                                                                        placement: "top",
                                                                        title: "Select DSC Type",
                                                                        trigger: "focus"
                                                                    });
                                                                    $('.Ddl_DSCType').focus();
                                                                }
                                                            } else {
                                                                check = false;
                                                                $('.Txt_ODACharges').tooltip({
                                                                    placement: "top",
                                                                    title: "Enter ODA Charges",
                                                                    trigger: "focus"
                                                                });
                                                                $('.Txt_ODACharges').focus();
                                                            }
                                                        } else {
                                                            check = false;
                                                            $('.Txt_waybillcharges').tooltip({
                                                                placement: "top",
                                                                title: "Enter Waybill Charges",
                                                                trigger: "focus"
                                                            });
                                                            $('.Txt_waybillcharges').focus();
                                                        }
                                                    } else {
                                                        check = false;
                                                        $('.Txt_MinFreight').tooltip({
                                                            placement: "top",
                                                            title: "Enter Minimum Freight",
                                                            trigger: "focus"
                                                        });
                                                        $('.Txt_MinFreight').focus();
                                                    }
                                                } else {
                                                    check = false;
                                                    $('.Txt_Minweight').tooltip({
                                                        placement: "top",
                                                        title: "Enter Min Weight",
                                                        trigger: "focus"
                                                    });
                                                    $('.Txt_Minweight').focus();
                                                }
                                            } else {
                                                check = false;
                                                $('.Txt_DemurrageCharges').tooltip({
                                                    placement: "top",
                                                    title: "Enter Demurrage Charges",
                                                    trigger: "focus"
                                                });
                                                $('.Txt_DemurrageCharges').focus();
                                            }
                                        } else {
                                            check = false;
                                            $('.Txt_GracePeriod').tooltip({
                                                placement: "top",
                                                title: "Enter Grace Period",
                                                trigger: "focus"
                                            });
                                            $('.Txt_GracePeriod').focus();
                                        }
                                    }
                                    else {
                                        check = false;
                                        $('.Ddl_DeliveryType').tooltip({
                                            placement: "top",
                                            title: "Select Delivery Time",
                                            trigger: "focus"
                                        });
                                        $('.Ddl_DeliveryType').focus();
                                    }

                                } else {
                                    check = false;
                                    $('.Txt_CategoryOfDays').tooltip({
                                        placement: "top",
                                        title: "Enter Days",
                                        trigger: "focus"
                                    });
                                    $('.Txt_CategoryOfDays').focus();
                                }
                            }
                            else {
                                check = false;
                                $('.Ddl_CategoryOfDays').tooltip({
                                    placement: "top",
                                    title: "Select Category of Days",
                                    trigger: "focus"
                                });
                                $('.Ddl_CategoryOfDays').focus();
                            }
                        } else {
                            check = false;
                            $('.Txt_FreightRate').tooltip({
                                placement: "top",
                                title: "Enter Rate",
                                trigger: "focus"
                            });
                            $('.Txt_FreightRate').focus();
                        }
                        } else {
                            check = false;
                            $('.Txt_CFTValue').tooltip({
                                placement: "top",
                                title: "Enter CFT Value",
                                trigger: "focus"
                            });
                            $('.Txt_CFTValue').focus();
                        }
                    }
                    else {
                        check = false;
                        $('.Ddl_BranchName').tooltip({
                            placement: "top",
                            title: "Select Controlling Branch",
                            trigger: "focus"
                        });
                        $('.Ddl_BranchName').focus();
                    }
                } else {
                    check = false;
                    $('.Txt_signingDate').tooltip({
                        placement: "top",
                        title: "Enter Date",
                        trigger: "focus"
                    });
                    $('.Txt_signingDate').focus();
                }
            } else {
                check = false;
                $('.Txt_ToDate').tooltip({
                    placement: "top",
                    title: "Enter Date",
                    trigger: "focus"
                });
                $('.Txt_ToDate').focus();
            }
        } else {
            check = false;
            $('.Txt_FromDate').tooltip({
                placement: "top",
                title: "Enter Date",
                trigger: "focus"
            });
            $('.Txt_FromDate').focus();
        }
    } else {
        check = false;
        $('.Txt_BillingPartyName').tooltip({
            placement: "top",
            title: "Select BillingParty Name",
            trigger: "focus"
        });
        $('.Txt_BillingPartyName').focus();
    }
    if (!check) {
        return false;
    }
    else {
        return true;
    }
}

function validateRateCardDetails() {
    var check = true;
    if ($('.Ddl_PopupRateType option:selected').text() != 'SELECT') {
        if ($('.Txt_PopupFromWeight').val() != '') {
            if ($('.Txt_PopupToWeight').val() != '') {
                if ($('.Txt_PopupFromDistance').val() != '') {
                    if ($('.Txt_PopupToDistance').val() != '') {
                        if ($('.Txt_RateValue').val() != '') {
                            check = true;
                        } else {
                            check = false;
                            $('.Txt_RateValue').tooltip({
                                placement: "top",
                                title: "Enter Rate Value",
                                trigger: "focus"
                            });
                            $('.Txt_RateValue').focus();
                        }
                    } else {
                        check = false;
                        $('.Txt_PopupToDistance').tooltip({
                            placement: "top",
                            title: "Enter To Distance",
                            trigger: "focus"
                        });
                        $('.Txt_PopupToDistance').focus();
                    }
                } else {
                    check = false;
                    $('.Txt_PopupFromDistance').tooltip({
                        placement: "top",
                        title: "Enter From Distance",
                        trigger: "focus"
                    });
                    $('.Txt_PopupFromDistance').focus();
                }
            } else {
                check = false;
                $('.Txt_PopupToWeight').tooltip({
                    placement: "top",
                    title: "Enter To Weight",
                    trigger: "focus"
                });
                $('.Txt_PopupToWeight').focus();
            }
        } else {
            check = false;
            $('.Txt_PopupFromWeight').tooltip({
                placement: "top",
                title: "Enter From Weight",
                trigger: "focus"
            });
            $('.Txt_PopupFromWeight').focus();
        }
    } else {
        check = false;
        $('.Ddl_PopupRateType').tooltip({
            placement: "top",
            title: "Select RateType",
            trigger: "focus"
        });
        $('.Ddl_PopupRateType').focus();
    }
    if (!check) {
        return false;
    }
    else {
        return true;
    }
}

function validatePickupDaysDetails() {
    console.log(13);
    var check = true;
    //if ($('#chkMon').is(":checked") == true) {
    // if ($("#chkMon").attr("checked") != true) {
    if ($("#chkMon").attr("checked") != true) {
        console.log(1);
        if ($('.Ddl_MonHours option:selected').text() != 'SELECT') {
                if ($('.Ddl_MonMinutes option:selected').text() != 'SELECT') {
                    check = true;
                    console.log(1.1);
                } else {
                    check = false;
                    $('.Ddl_MonMinutes').tooltip({
                        placement: "top",

                        title: "Enter Minutes",
                        trigger: "focus"
                    });
                    $('.Ddl_MonMinutes').focus();
                }
            } else {
                check = false;
                $('.Ddl_MonHours').tooltip({
                    placement: "top",
                    title: "Enter Hours",
                    trigger: "focus"
                });
                $('.Ddl_MonHours').focus();
            }
      //  alert("checked");
       // check = true;
    }
    else {
        check = false;
        // alert("Unchecked");
    }
    //if ($('#chkTue').attr("checked") != true) {
      
    //    if ($('.Ddl_TueHours option:selected').text() != 'SELECT') {
    //        if ($('.Ddl_TueMinutes option:selected').text() != 'SELECT') {
    //            check = true;
    //            console.log(2);
    //        } else {
    //            check = false;
    //            $('.Ddl_TueMinutes').tooltip({
    //                placement: "top",
    //                title: "Enter Minutes",
    //                trigger: "focus"
    //            });
    //            $('.Ddl_TueMinutes').focus();
    //        }
    //    } else {
    //        check = false;
    //        $('.Ddl_TueHours').tooltip({
    //            placement: "top",
    //            title: "Enter Hours",
    //            trigger: "focus"
    //        });
    //        $('.Ddl_TueHours').focus();
    //    }
    //}
    ////else {
    ////    check = false;
    ////    // alert("Unchecked");
    ////}
    //if ($('#chkWed').attr("checked") != true) {
    //    console.log(3);
    //    if ($('.Ddl_WedHours option:selected').text() != 'SELECT') {
    //        if ($('.Ddl_WedMinutes option:selected').text() != 'SELECT') {
    //            check = true;
    //        } else {
    //            check = false;
    //            $('.Ddl_WedMinutes').tooltip({
    //                placement: "top",
    //                title: "Enter Minutes",
    //                trigger: "focus"
    //            });
    //            $('.Ddl_WedMinutes').focus();
    //        }
    //    } else {
    //        check = false;
    //        $('.Ddl_WedHours').tooltip({
    //            placement: "top",
    //            title: "Enter Hours",
    //            trigger: "focus"
    //        });
    //        $('.Ddl_WedHours').focus();
    //    }
    //}
    ////else {
    ////    check = false;
    ////    // alert("Unchecked");
    ////}
    //if ($('#chkThurs').attr("checked") != true) {
    //    console.log(4);
    //    if ($('.Ddl_ThursHours option:selected').text() != 'SELECT') {
    //        if ($('.Ddl_ThursMinutes option:selected').text() != 'SELECT') {
    //            check = true;
    //        } else {
    //            check = false;
    //            $('.Ddl_ThursMinutes').tooltip({
    //                placement: "top",
    //                title: "Enter Minutes",
    //                trigger: "focus"
    //            });
    //            $('.Ddl_ThursMinutes').focus();
    //        }
    //    } else {
    //        check = false;
    //        $('.Ddl_ThursHours').tooltip({
    //            placement: "top",
    //            title: "Enter Hours",
    //            trigger: "focus"
    //        });
    //        $('.Ddl_ThursHours').focus();
    //    }
    //}
    ////else {
    ////    check = false;
    ////    // alert("Unchecked");
    ////}
    //if ($('#chkFri').attr("checked") != true) {
    //    console.log(5);
    //    if ($('.Ddl_FriHours option:selected').text() != 'SELECT') {
    //        if ($('.Ddl_FriMinutes option:selected').text() != 'SELECT') {
    //            check = true;
    //        } else {
    //            check = false;
    //            $('.Ddl_FriMinutes').tooltip({
    //                placement: "top",
    //                title: "Enter Minutes",
    //                trigger: "focus"
    //            });
    //            $('.Ddl_FriMinutes').focus();
    //        }
    //    } else {
    //        check = false;
    //        $('.Ddl_FriHours').tooltip({
    //            placement: "top",
    //            title: "Enter Hours",
    //            trigger: "focus"
    //        });
    //        $('.Ddl_FriHours').focus();
    //    }
    //}
    ////else {
    ////    check = false;
    ////    // alert("Unchecked");
    ////}
    //if ($('#chkSat').attr("checked") != true) {
    //    console.log(6);
    //    if ($('.Ddl_SatHours option:selected').text() != 'SELECT') {
    //        if ($('.Ddl_SatMinutes option:selected').text() != 'SELECT') {
    //            check = true;
    //        } else {
    //            check = false;
    //            $('.Ddl_SatMinutes').tooltip({
    //                placement: "top",
    //                title: "Enter Minutes",
    //                trigger: "focus"
    //            });
    //            $('.Ddl_SatMinutes').focus();
    //        }
    //    } else {
    //        check = false;
    //        $('.Ddl_SatHours').tooltip({
    //            placement: "top",
    //            title: "Enter Hours",
    //            trigger: "focus"
    //        });
    //        $('.Ddl_SatHours').focus();
    //    }
    //}
    //else {
    //    check = false;
    //    // alert("Unchecked");
    //}
    //if ($('#chkSun').attr("checked") != true) {
      
    //    if ($('.Ddl_SunHours option:selected').text() != 'SELECT') {
    //        if ($('.Ddl_SunMinutes option:selected').text() != 'SELECT') {
    //            console.log(7);
    //            check = true;
    //        } else {
    //            check = false;
    //            $('.Ddl_SunMinutes').tooltip({
    //                placement: "top",
    //                title: "Enter Minutes",
    //                trigger: "focus"
    //            });
    //            $('.Ddl_SunMinutes').focus();
    //        }
    //    } else {
    //        check = false;
    //        $('.Ddl_SunHours').tooltip({
    //            placement: "top",
    //            title: "Enter Hours",
    //            trigger: "focus"
    //        });
    //        $('.Ddl_SunHours').focus();
    //    }
    //}
    //else {
    //    check = false;
    //    // alert("Unchecked");
    //}
    console.log(check);
    if (!check) {
        return false;
    }
    else {
        return true;
    }
}

//For Geo Scope Contract Condition
function validateContractConditionDetails() {
    var check = true;
    if ($('.Txt_FromPincode').val() != '') {
        if ($('.Txt_ToPincode').val() != '') {
            if ($('.Txt_Weight').val() != '') {               
                if ($('.Txt_Price').val() != '') {
                    check = true;
                    } else {
                        check = false;
                        $('.Txt_Price').tooltip({
                            placement: "top",
                            title: "Enter Price",
                            trigger: "focus"
                        });
                        $('.Txt_Price').focus();
                    }              
            } else {
                check = false;
                $('.Txt_Weight').tooltip({
                    placement: "top",
                    title: "Enter Weight",
                    trigger: "focus"
                });
                $('.Txt_Weight').focus();
            }
        } else {
            check = false;
            $('.Txt_ToPincode').tooltip({
                placement: "top",
                title: "Enter Pincode",
                trigger: "focus"
            });
            $('.Txt_ToPincode').focus();
        }
    } else {
        check = false;
        $('.Txt_FromPincode').tooltip({
            placement: "top",
            title: "Enter Pincode",
            trigger: "focus"
        });
        $('.Txt_FromPincode').focus();
    }
    if (!check) {
        return false;
    }
    else {
        return true;
    }
}


/*End Commercials Details*/
/*Geo  Scope Validation*/
function validateGeoScopesDetails() {
    var check = true;

    if ($('.Ddl_GEOScopeCategory option:selected').text() != 'SELECT') {
        if ($('.Ddl_ScopeType option:selected').text() != 'SELECT') {
            if ($('.Ddl_VeiwScopType option:selected').text() != 'SELECT') {
                if ($('.Ddl_VeiwRegionScopType option:selected').text() != 'SELECT') {
                    if ($('.Ddl_Material option:selected').text() != 'SELECT') {
                        if ($('.Ddl_pkgtype option:selected').text() != 'SELECT') {

                            if ($('.Ddl_ApplyChargesOn option:selected').text() != 'SELECT') {
                                if ($('.Ddl_ApplayFreightOn option:selected').text() != 'SELECT') {
                                    if ($('.Txt_CustRange').val() != '') {
                                        if ($('.Txt_NoOfInnerPieces').val() != '') {
                                            if ($('.Txt_NoOfPiecesBetween1').val() != '') {
                                                if ($('.Txt_NoOfPiecesBetween2').val() != '') {
                                                    if ($('.Txt_NoOfBoxes').val() != '') {
                                                        if ($('.Txt_NoOfBoxesBetween1').val() != '') {
                                                            if ($('.Txt_NoOfBoxesBetween2').val() != '') {
                                                                if ($('.Ddl_UnitsOfFreight').val() != '') {
                                                                    if ($('.Txt_FlatAmount').val() != '') {
                                                                        if ($('.Txt_RangeFrom').val() != '') {
                                                                            if ($('.Txt_RangeTo').val() != '') {
                                                                                if ($('.Txt_Km').val() != '') {
                                                                                    if ($('.Txt_KmFrom').val() != '') {
                                                                                        if ($('.Txt_KmTo').val() != '') {
                                                                                            if ($('.Txt_Kg').val() != '') {
                                                                                                if ($('.Txt_Charges').val() != '') {
                                                                                                    //if ($('.Ddl_PincodeCategory option:selected').text() != 'Select...') {

                                                                                                    //    check = true;
                                                                                                    //} else {
                                                                                                    //    check = false;
                                                                                                    //    $('.Ddl_PincodeCategory').tooltip({
                                                                                                    //        placement: "top",
                                                                                                    //        title: "Enter Extra Charges",
                                                                                                    //        trigger: "focus"
                                                                                                    //    });
                                                                                                    //    $('.Ddl_PincodeCategory').focus();
                                                                                                    //}
                                                                                                } else {
                                                                                                    check = false;
                                                                                                    $('.Txt_Charges').tooltip({
                                                                                                        placement: "top",
                                                                                                        title: "Enter Charges",
                                                                                                        trigger: "focus"
                                                                                                    });
                                                                                                    $('.Txt_Charges').focus();
                                                                                                }
                                                                                            } else {
                                                                                                check = false;
                                                                                                $('.Txt_Kg').tooltip({
                                                                                                    placement: "top",
                                                                                                    title: "Enter Kg",
                                                                                                    trigger: "focus"
                                                                                                });
                                                                                                $('.Txt_Kg').focus();
                                                                                            }
                                                                                        } else {
                                                                                            check = false;
                                                                                            $('.Txt_KmTo').tooltip({
                                                                                                placement: "top",
                                                                                                title: "Enter To",
                                                                                                trigger: "focus"
                                                                                            });
                                                                                            $('.Txt_KmTo').focus();
                                                                                        }
                                                                                    } else {
                                                                                        check = false;
                                                                                        $('.Txt_KmFrom').tooltip({
                                                                                            placement: "top",
                                                                                            title: "Enter From",
                                                                                            trigger: "focus"
                                                                                        });
                                                                                        $('.Txt_KmFrom').focus();
                                                                                    }
                                                                                } else {
                                                                                    check = false;
                                                                                    $('.Txt_Km').tooltip({
                                                                                        placement: "top",
                                                                                        title: "Enter Km",
                                                                                        trigger: "focus"
                                                                                    });
                                                                                    $('.Txt_Km').focus();
                                                                                }
                                                                            } else {
                                                                                check = false;
                                                                                $('.Txt_RangeTo').tooltip({
                                                                                    placement: "top",
                                                                                    title: "Enter Range To",
                                                                                    trigger: "focus"
                                                                                });
                                                                                $('.Txt_RangeTo').focus();
                                                                            }
                                                                        } else {
                                                                            check = false;
                                                                            $('.Txt_RangeFrom').tooltip({
                                                                                placement: "top",
                                                                                title: "Enter Range From",
                                                                                trigger: "focus"
                                                                            });
                                                                            $('.Txt_RangeFrom').focus();
                                                                        }
                                                                    } else {
                                                                        check = false;
                                                                        $('.Txt_FlatAmount').tooltip({
                                                                            placement: "top",
                                                                            title: "Enter Amount",
                                                                            trigger: "focus"
                                                                        });
                                                                        $('.Txt_FlatAmount').focus();
                                                                    }
                                                                } else {
                                                                    check = false;
                                                                    $('.Ddl_UnitsOfFreight').tooltip({
                                                                        placement: "top",
                                                                        title: "Select Units Of Freight",
                                                                        trigger: "focus"
                                                                    });
                                                                    $('.Ddl_UnitsOfFreight').focus();
                                                                }
                                                            } else {
                                                                check = false;
                                                                $('.Txt_NoOfBoxesBetween2').tooltip({
                                                                    placement: "top",
                                                                    title: "Enter No Of Boxes Between",
                                                                    trigger: "focus"
                                                                });
                                                                $('.Txt_NoOfBoxesBetween2').focus();
                                                            }
                                                        } else {
                                                            check = false;
                                                            $('.Txt_NoOfBoxesBetween1').tooltip({
                                                                placement: "top",
                                                                title: "Enter No Of Boxes Between",
                                                                trigger: "focus"
                                                            });
                                                            $('.Txt_NoOfBoxesBetween1').focus();
                                                        }
                                                    } else {
                                                        check = false;
                                                        $('.Txt_NoOfBoxes').tooltip({
                                                            placement: "top",
                                                            title: "Enter No Of Boxes",
                                                            trigger: "focus"
                                                        });
                                                        $('.Txt_NoOfBoxes').focus();
                                                    }

                                                } else {
                                                    check = false;
                                                    $('.Txt_NoOfPiecesBetween2').tooltip({
                                                        placement: "top",
                                                        title: "Enter No Of Pieces Between",
                                                        trigger: "focus"
                                                    });
                                                    $('.Txt_NoOfPiecesBetween2').focus();
                                                }
                                            } else {
                                                check = false;
                                                $('.Txt_NoOfPiecesBetween1').tooltip({
                                                    placement: "top",
                                                    title: "Enter No Of Pieces Between",
                                                    trigger: "focus"
                                                });
                                                $('.Txt_NoOfPiecesBetween1').focus();
                                            }
                                        } else {
                                            check = false;
                                            $('.Txt_NoOfInnerPieces').tooltip({
                                                placement: "top",
                                                title: "Enter No Of Inner Pieces",
                                                trigger: "focus"
                                            });
                                            $('.Txt_NoOfInnerPieces').focus();
                                        }
                                    } else {
                                        check = false;
                                        $('.Txt_CustRange').tooltip({
                                            placement: "top",
                                            title: "Enter Range",
                                            trigger: "focus"
                                        });
                                        $('.Txt_CustRange').focus();
                                    }
                                } else {
                                    check = false;
                                    $('.Ddl_ApplayFreightOn').tooltip({
                                        placement: "top",
                                        title: "Select Applay Freight On",
                                        trigger: "focus"
                                    });
                                    $('.Ddl_ApplayFreightOn').focus();
                                }

                            } else {
                                check = false;
                                $('.Ddl_ApplyChargesOn').tooltip({
                                    placement: "top",
                                    title: "Select Applay Charges On ",
                                    trigger: "focus"
                                });
                                $('.Ddl_ApplyChargesOn').focus();
                            }

                        } else {
                            check = false;
                            $('.Ddl_pkgtype').tooltip({
                                placement: "top",
                                title: "Select Type Of Package",
                                trigger: "focus"
                            });
                            $('.Ddl_pkgtype').focus();
                        }
                    } else {
                        check = false;
                        $('.Ddl_Material').tooltip({
                            placement: "top",
                            title: "Select Material",
                            trigger: "focus"
                        });
                        $('.Ddl_Material').focus();
                    }
                } else {
                    check = false;
                    $('.Ddl_VeiwRegionScopType').tooltip({
                        placement: "top",
                        title: "Select View Region Scope Type",
                        trigger: "focus"
                    });
                    $('.Ddl_VeiwRegionScopType').focus();
                }
            } else {
                check = false;
                $('.Ddl_VeiwScopType').tooltip({
                    placement: "top",
                    title: "Select View Scope Type",
                    trigger: "focus"
                });
                $('.Ddl_VeiwScopType').focus();
            }
        } else {
            check = false;
            $('.Ddl_ScopeType').tooltip({
                placement: "top",
                title: "Select Scope Type",
                trigger: "focus"
            });
            $('.Ddl_ScopeType').focus();
        }
    } else {
        check = false;
        $('.Ddl_GEOScopeCategory').tooltip({
            placement: "top",
            title: "Select Geo Scope Category",
            trigger: "focus"
        });
        $('.Ddl_GEOScopeCategory').focus();
    }
    if (!check) {
        return false;
    }
    else {
        return true;
    }
}
/*End Geo Scope Validation*/
/* Check Numbers Only*/
function validateNumericValue(key) {
    var keycode = (key.which) ? key.which : key.keyCode;

    if (!(keycode == 8 || keycode == 46) && (keycode < 48 || keycode > 57)) {
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
/*Only Capital Letter*/
function checkNum() {

    if ((event.keyCode > 64 && event.keyCode < 91) || event.keyCode == 8)
        return true;
    else {
        return false;
    }

}
function validatePancardNum() {
    if ((event.keyCode > 64 && event.keyCode < 91) || (event.keyCode > 47 && event.keyCode < 58) || event.keyCode == 8) {
        return true;
    }
    else {
        return false;
    }
}



