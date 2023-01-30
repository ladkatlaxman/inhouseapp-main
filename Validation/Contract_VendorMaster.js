/*Contract_Vendor Basic Details Validations*/
function validateVenorBasicContractDetails() {
    var check = true;
    var CompEmail = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
    if ($('.Ddl_Vendors option:selected').text() != 'Select...') {
        if ($('.Ddl_PartyName option:selected').text() != 'Select...') {
            if ($('.Txt_PartyContact').val() != '' && $('.Txt_PartyContact').val().length == 10) {
                if ($('.Txt_PartyEmailId').val() != '' && CompEmail.test($('.Txt_PartyEmailId').val())) {
                    if ($('.Txt_Billing_Party_Name').val() != '') {
                        if ($('.Txt_ContractNo').val() != '') {
                            if ($('.Txt_FromDate').val() != '') {
                                if ($('.Txt_ToDate').val() != '') {
                                    if ($('.Ddl_ContractStatus option:selected').text() != 'Select...') {
                                        if ($('.Txt_signingDate').val() != '') {
                                            if ($('.Ddl_ControllingBranchs option:selected').text() != 'Select...') {
                                                if ($('.Ddl_CategoryOfDays option:selected').text() != 'Select...') {
                                                if ($('.Txt_CategoryOfDays').val() != '') {
                                                   
                                                        if ($('.Ddl_DeliveryType option:selected').text() != 'Select...') {
                                                            if ($('.Txt_GracePeriod').val() != '') {
                                                                if ($('.Txt_DemurrageCharges').val() != '') {
                                                                    if ($('.Txt_amount').val() != '') {
                                                                        if ($('.Txt_MinFreight').val() != '') {
                                                                            check = true;
                                                                        } else {
                                                                            check = false;
                                                                            $('.Txt_MinFreight').tooltip({
                                                                                placement: "top",
                                                                                title: "Enter Minimum Freight",
                                                                                trigger: "focus"
                                                                            });
                                                                            $('.Txt_MinFreight').focus();
                                                                        }
                                                                    }
                                                                    else {

                                                                        check = false;
                                                                        $('.Txt_amount').tooltip({
                                                                            placement: "top",
                                                                            title: "Enter Amount",
                                                                            trigger: "focus"
                                                                        });
                                                                        $('.Txt_amount').focus();
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
                                            }
                                            else {
                                                check = false;
                                                $('.Ddl_ControllingBranchs').tooltip({
                                                    placement: "top",
                                                    title: "Select Controlling Branch",
                                                    trigger: "focus"
                                                });
                                                $('.Ddl_ControllingBranchs').focus();
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
                                    }
                                    else {
                                        check = false;
                                        $('.Ddl_ContractStatus').tooltip({
                                            placement: "top",
                                            title: "Select Contract Status",
                                            trigger: "focus"
                                        });
                                        $('.Ddl_ContractStatus').focus();
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
                            $('.Txt_ContractNo').tooltip({
                                placement: "top",
                                title: "Contact To Branch",
                                trigger: "focus"
                            });
                            $('.Txt_ContractNo').focus();
                        }

                    } else {
                        check = false;
                        $('.Txt_Billing_Party_Name').tooltip({
                            placement: "top",
                            title: "Enter Billing Party Name",
                            trigger: "focus"
                        });
                        $('.Txt_Billing_Party_Name').focus();
                    }
                } else {
                    check = false;
                    $('.Txt_PartyEmailId').tooltip({
                        placement: "top",
                        title: "Enter Party Valid Email Id",
                        trigger: "focus"
                    });
                    $('.Txt_PartyEmailId').focus();
                }
            } else {
                check = false;
                $('.Txt_PartyContact').tooltip({
                    placement: "top",
                    title: "Enter Party Contact Number",
                    trigger: "focus"

                });
                $('.Txt_PartyContact').focus();
            }
        }
        else {
            check = false;
            $('.Ddl_PartyName').tooltip({
                placement: "top",
                title: "Select Party Name",
                trigger: "focus"
            });
            $('.Ddl_PartyName').focus();
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
        return true;
    }
}
// Validation Contract Details
function validateContractDetails() {
    var check = true;
    if ($('.Txt_VendorName').val() != '') {
        if ($('.Txt_FromDate').val() != '') {
            if ($('.Txt_ToDate').val() != '') {
                if ($('.Txt_signingDate').val() != '') {
                    if ($('.Txt_CurrentDieselRate').val() != '') {
                        if ($('.Txt_MinFreight').val() != '') {
                            check = true;
                        } else {
                            check = false;
                            $('.Txt_MinFreight').tooltip({
                                placement: "top",
                                title: "Enter min freight",
                                trigger: "focus"
                            });
                            $('.Txt_MinFreight').focus();
                        }
                    } else {
                        check = false;
                        $('.Txt_CurrentDieselRate').tooltip({
                            placement: "top",
                            title: "Enter diesel rate",
                            trigger: "focus"
                        });
                        $('.Txt_CurrentDieselRate').focus();
                    }
                } else {
                    check = false;
                    $('.Txt_signingDate').tooltip({
                        placement: "top",
                        title: "Enter sign date",
                        trigger: "focus"
                    });
                    $('.Txt_signingDate').focus();
                }
            } else {
                check = false;
                $('.Txt_ToDate').tooltip({
                    placement: "top",
                    title: "Enter To date",
                    trigger: "focus"
                });
                $('.Txt_ToDate').focus();
            }
        } else {
            check = false;
            $('.Txt_FromDate').tooltip({
                placement: "top",
                title: "Enter From date",
                trigger: "focus"
            });
            $('.Txt_FromDate').focus();
        }
    }
    else {

        check = false;
        $('.Txt_VendorName').tooltip({
            placement: "top",
            title: "Select vendor name",
            trigger: "focus"
        });
        $('.Txt_VendorName').focus();
    }

    if (!check) {
        return false;
    }
    else {
        return true;
    }
}

/*Route GeoScope Details Validation*/
function validateRouteGeoDetails() {
    var check = true;
    if ($('.Ddl_Route option:selected').text() != 'SELECT') {
        if ($('.Txt_RouteValue').val() != '') {
            check = true;
        } else {
            check = false;
            $('.Txt_RouteValue').tooltip({
                placement: "top",
                title: "Enter Amount",
                trigger: "focus"
            });
            $('.Txt_RouteValue').focus();
        }
    }
    else {

        check = false;
        $('.Ddl_Route').tooltip({
            placement: "top",
            title: "Select Route",
            trigger: "focus"
        });
        $('.Ddl_Route').focus();
    }

    if (!check) {
        return false;
    }
    else {
        return true;
    }
}
/*Geo Scope Details Validation*/
function validateVenorGeoScopeDetails() {
    var check = true;
    if ($('.Ddl_GEOScopeCategory option:selected').text() != 'Select...') {
        if ($('.Ddl_ScopeType option:selected').text() != 'Select...') {
            if ($('.Ddl_VeiwScopType option:selected').text() != 'Select...') {
                if ($('.Ddl_Area option:selected').text() != 'Select...') {
                if ($('.Ddl_VeiwRegionScopType option:selected').text() != 'Select...') {
                    if ($('.Ddl_Material option:selected').text() != 'Select...') {
                        if ($('.Ddl_pkgtype option:selected').text() != 'Select...') {
                            if ($('.Txt_BasicFreight').val() != '') {
                                if ($('.Ddl_ApplayChargesOnVendor option:selected').text() != 'Select...') {
                                    if ($('.Ddl_ApplayFreightOnVendor option:selected').text() != 'Select...') {
                                        if ($('.Txt_VendorAmount').val() != '') {
                                            if ($('.Ddl_UnitsOfFreightOfVendor option:selected').text() != 'Select...') {
                                                if ($('.Txt_VendorRangeFrom').val() != '') {
                                                    if ($('.Txt_VendorRangeTo').val() != '') {
                                                        if ($('.Ddl_ApplayChargesOfFreightKmKgVendor option:selected').text() != 'Select...') {
                                                            if ($('.Txt_ChargePerKm').val() != '') {
                                                                if ($('.Txt_VendorKmFrom').val() != '') {
                                                                    if ($('.Txt_VendorKmTo').val() != '') {
                                                                        if ($('.Txt_NoOfBoxesVendor').val() != '') {
                                                                            if ($('.Txt_ChargesPerBoxVendor').val() != '') {
                                                                                if ($('.Txt_NoOfPieceVendor').val() != '') {
                                                                                    if ($('.Txt_ChargesPerPieceVendor').val() != '') {
                                                                                        if ($('.Txt_NoOfPieceFromToVendor').val() != '') {
                                                                                            if ($('.Txt_NoOfPieceFromToVendor2').val() != '') {
                                                                                                if ($('.Txt_ChargePerKg').val() != '') {
                                                                                                    if ($('.Txt_ChargePerKg').val() != '') {
                                                                                                        if ($('.Txt_VendorKgFrom').val() != '') {
                                                                                                            if ($('.Txt_VendorKgTo').val() != '') {
                                                                                                                check = true;
                                                                                                            } else {
                                                                                                                check = false;
                                                                                                                $('.Txt_VendorKgTo').tooltip({
                                                                                                                    placement: "top",
                                                                                                                    title: "Enter Kg To",
                                                                                                                    trigger: "focus"
                                                                                                                });
                                                                                                                $('.Txt_VendorKgTo').focus();
                                                                                                            }
                                                                                                        } else {
                                                                                                            check = false;
                                                                                                            $('.Txt_VendorKgFrom').tooltip({
                                                                                                                placement: "top",
                                                                                                                title: "Enter Kg From",
                                                                                                                trigger: "focus"
                                                                                                            });
                                                                                                            $('.Txt_VendorKgFrom').focus();
                                                                                                        }
                                                                                                    } else {
                                                                                                        check = false;
                                                                                                        $('.Txt_ChargePerKg').tooltip({
                                                                                                            placement: "top",
                                                                                                            title: "Enter Charge/Kg",
                                                                                                            trigger: "focus"
                                                                                                        });
                                                                                                        $('.Txt_ChargePerKg').focus();
                                                                                                    }
                                                                                                } else {
                                                                                                    check = false;
                                                                                                    $('.Txt_ChargePerKg').tooltip({
                                                                                                        placement: "top",
                                                                                                        title: "Enter Charge/Kg",
                                                                                                        trigger: "focus"
                                                                                                    });
                                                                                                    $('.Txt_ChargePerKg').focus();
                                                                                                }
                                                                                            } else {
                                                                                                check = false;
                                                                                                $('.Txt_NoOfPieceFromToVendor2').tooltip({
                                                                                                    placement: "top",
                                                                                                    title: "Enter No Of Pieces From or To",
                                                                                                    trigger: "focus"
                                                                                                });
                                                                                                $('.Txt_NoOfPieceFromToVendor2').focus();
                                                                                            }
                                                                                        } else {
                                                                                            check = false;
                                                                                            $('.Txt_NoOfPieceFromToVendor').tooltip({
                                                                                                placement: "top",
                                                                                                title: "Enter No Of Pieces From Or To ",
                                                                                                trigger: "focus"
                                                                                            });
                                                                                            $('.Txt_NoOfPieceFromToVendor').focus();
                                                                                        }
                                                                                    } else {
                                                                                        check = false;
                                                                                        $('.Txt_ChargesPerPieceVendor').tooltip({
                                                                                            placement: "top",
                                                                                            title: "Enter Charges/Pieces",
                                                                                            trigger: "focus"
                                                                                        });
                                                                                        $('.Txt_ChargesPerPieceVendor').focus();
                                                                                    }
                                                                                } else {
                                                                                    check = false;
                                                                                    $('.Txt_NoOfPieceVendor').tooltip({
                                                                                        placement: "top",
                                                                                        title: "Enter No Of Pieces",
                                                                                        trigger: "focus"
                                                                                    });
                                                                                    $('.Txt_NoOfPieceVendor').focus();
                                                                                }
                                                                            } else {
                                                                                check = false;
                                                                                $('.Txt_ChargesPerBoxVendor').tooltip({
                                                                                    placement: "top",
                                                                                    title: "Enter Charges/Boxes",
                                                                                    trigger: "focus"
                                                                                });
                                                                                $('.Txt_ChargesPerBoxVendor').focus();
                                                                            }
                                                                        } else {
                                                                            check = false;
                                                                            $('.Txt_NoOfBoxesVendor').tooltip({
                                                                                placement: "top",
                                                                                title: "Enter No Of Boxes",
                                                                                trigger: "focus"
                                                                            });
                                                                            $('.Txt_NoOfBoxesVendor').focus();
                                                                        }
                                                                    } else {
                                                                        check = false;
                                                                        $('.Txt_VendorKmTo').tooltip({
                                                                            placement: "top",
                                                                            title: "Enter Km To",
                                                                            trigger: "focus"
                                                                        });
                                                                        $('.Txt_VendorKmTo').focus();
                                                                    }
                                                                } else {
                                                                    check = false;
                                                                    $('.Txt_VendorKmFrom').tooltip({
                                                                        placement: "top",
                                                                        title: "Enter Km From",
                                                                        trigger: "focus"
                                                                    });
                                                                    $('.Txt_VendorKmFrom').focus();
                                                                }
                                                            } else {
                                                                check = false;
                                                                $('.Txt_ChargePerKm').tooltip({
                                                                    placement: "top",
                                                                    title: "Enter Charges/Km",
                                                                    trigger: "focus"
                                                                });
                                                                $('.Txt_ChargePerKm').focus();
                                                            }

                                                        } else {
                                                            check = false;
                                                            $('.Ddl_ApplayChargesOfFreightKmKgVendor').tooltip({
                                                                placement: "top",
                                                                title: "Select  Applay Freight",
                                                                trigger: "focus"
                                                            });
                                                            $('.Ddl_ApplayChargesOfFreightKmKgVendor').focus();
                                                        }
                                                    } else {
                                                        check = false;
                                                        $('.Txt_VendorRangeTo').tooltip({
                                                            placement: "top",
                                                            title: "Enter Range To",
                                                            trigger: "focus"
                                                        });
                                                        $('.Txt_VendorRangeTo').focus();
                                                    }
                                                  

                                                } else {
                                                    check = false;
                                                    $('.Txt_VendorRangeFrom').tooltip({
                                                        placement: "top",
                                                        title: "Enter Range From",
                                                        trigger: "focus"
                                                    });
                                                    $('.Txt_VendorRangeFrom').focus();
                                                }
                                            } else {
                                                check = false;
                                                $('.Ddl_UnitsOfFreightOfVendor').tooltip({
                                                    placement: "top",
                                                    title: "Select  Units Of  Freight",
                                                    trigger: "focus"
                                                });
                                                $('.Ddl_UnitsOfFreightOfVendor').focus();
                                            }
                                        } else {
                                            check = false;
                                            $('.Txt_VendorAmount').tooltip({
                                                placement: "top",
                                                title: "Enter Amount",
                                                trigger: "focus"
                                            });
                                            $('.Txt_VendorAmount').focus();
                                        }
                                        
                                    } else {
                                        check = false;
                                        $('.Ddl_ApplayFreightOnVendor').tooltip({
                                            placement: "top",
                                            title: "Select Applay Freight On Vendor",
                                            trigger: "focus"
                                        });
                                        $('.Ddl_ApplayFreightOnVendor').focus();
                                    }

                                } else {
                                    check = false;
                                    $('.Ddl_ApplayChargesOnVendor').tooltip({
                                        placement: "top",
                                        title: "Select Applay Charges On Vendor",
                                        trigger: "focus"
                                    });
                                    $('.Ddl_ApplayChargesOnVendor').focus();
                                }

                            } else {
                                check = false;
                                $('.Txt_BasicFreight').tooltip({
                                    placement: "top",
                                    title: "Enter Basic Freight",
                                    trigger: "focus"
                                });
                                $('.Txt_BasicFreight').focus();
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
                    $('.Ddl_Area').tooltip({
                        placement: "top",
                        title: "Select View Area Scope Type",
                        trigger: "focus"
                    });
                    $('.Ddl_Area').focus();
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

