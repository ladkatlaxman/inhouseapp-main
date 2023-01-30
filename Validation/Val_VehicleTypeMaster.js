function validateVehicleTypeDetails() {
    var check = true;
    if ($('.Txt_VehicleTypeName').val() != '') {
        var check = true;
    }
    else {
        check = false;
        $('.Txt_VehicleTypeName').tooltip({
            placement: "top",
            title: "Enter Vehicle Type Name",
            trigger: "focus"
        });
        $('.Txt_VehicleTypeName').focus();
    }
    if (!check) {
        return false;
    }
    else {
        return true;
    }
}
function validateWaybillStationary() {
    var check = true;  
    if ($('.Txt_FromNumber').val() != '') {
        if ($('.Txt_ToNumber').val() != '') {
            var check = true;
        }
        else {
            check = false;
            $('.Txt_ToNumber').tooltip({
                placement: "top",
                title: "Enter To Series",
                trigger: "focus"
            });
            $('.Txt_ToNumber').focus();
        }
    }
    else {
        check = false;
        $('.Txt_FromNumber').tooltip({
            placement: "top",
            title: "Enter From Series",
            trigger: "focus"
        });
        $('.Txt_FromNumber').focus();
    }
    if (!check) {
        return false;
    }
    else {
        return true;
    }
}

function validateConsigneeDetails() {
    var check = true;
    if ($('.Txt_ConsigneeName').val() != '') {
        if ($('.Txt_ConsigneeContNo').val() != '') {
            if ($('.Txt_DelPin').val() != '') {
                if ($('.Ddl_DelArea').val() != '0') {
                    if ($('.Txt_DelAdd').val() != '') {
                        var check = true;
                    }
                    else {
                        check = false;
                        $('.Txt_DelAdd').tooltip({
                            placement: "top",
                            title: "Enter Address",
                            trigger: "focus"
                        });
                        $('.Txt_DelAdd').focus();
                    }
                }
                else {
                    check = false;
                    $('.Ddl_DelArea').tooltip({
                        placement: "top",
                        title: "Select Area",
                        trigger: "focus"
                    });
                    $('.Ddl_DelArea').focus();
                }
            }
            else {
                check = false;
                $('.Txt_DelPin').tooltip({
                    placement: "top",
                    title: "Enter Pincode",
                    trigger: "focus"
                });
                $('.Txt_DelPin').focus();
            }
        }
        else {
            check = false;
            $('.Txt_ConsigneeContNo').tooltip({
                placement: "top",
                title: "Enter Contact No",
                trigger: "focus"
            });
            $('.Txt_ConsigneeContNo').focus();
        }
    }
    else {
        check = false;
        $('.Txt_ConsigneeName').tooltip({
            placement: "top",
            title: "Enter Consignee Name",
            trigger: "focus"
        });
        $('.Txt_ConsigneeName').focus();
    }
    if (!check) {
        $("#hfSubmit").val(0);
        console.log($("#hfSubmit").val());
        return false;
    }
    else {
        $("#hfSubmit").val(1);
        return true;
        console.log($("#hfSubmit").val());
    }
}

function validateStationary() {
    var check = true;
    if ($('.Ddl_Stationary option:selected').text() != 'SELECT') {
        if ($('.Ddl_AssignBranch option:selected').text() != 'SELECT') {
            var check = true;
        }
        else {
            check = false;
            $('.Ddl_AssignBranch').tooltip({
                placement: "top",
                title: "Select Branch",
                trigger: "focus"
            });
            $('.Ddl_AssignBranch').focus();
        }
    }
    else {
        check = false;
        $('.Ddl_Stationary').tooltip({
            placement: "top",
            title: "Select Stationary",
            trigger: "focus"
        });
        $('.Ddl_Stationary').focus();
    }
    if (!check) {
        return false;
    }
    else {
        return true;
    }
}

function validateWaybillCharges() {
    var check = true;
    if ($('.Txt_SearchWaybillNo').val() != '') {
        if ($('.Ddl_WaybillCharges option:selected').text() != 'SELECT') {
            if ($('.Txt_RateValue').val() != '') {
            var check = true;
        }
        else {
            check = false;
            $('.Txt_RateValue').tooltip({
                placement: "top",
                title: "Enter Value",
                trigger: "focus"
            });
            $('.Txt_RateValue').focus();
        }
    }
    else {
        check = false;
        $('.Ddl_WaybillCharges').tooltip({
            placement: "top",
            title: "Select Waybill Charges",
            trigger: "focus"
        });
        $('.Ddl_WaybillCharges').focus();
    }
    }
    else {
        check = false;
        $('.Txt_SearchWaybillNo').tooltip({
            placement: "top",
            title: "Select Waybill No",
            trigger: "focus"
        });
        $('.Txt_SearchWaybillNo').focus();
    }
    if (!check) {
        return false;
    }
    else {
        return true;
    }
}

function validateWaybillRemark() {
    var check = true;
    if ($('.Txt_SearchWaybillNo').val() != '') {
        if ($('.Txt_Remark').val() != '') {
            var check = true;
        }
        else {
            check = false;
            $('.Txt_Remark').tooltip({
                placement: "top",
                title: "Enter Remark",
                trigger: "focus"
            });
            $('.Txt_Remark').focus();
        }
    }
    else {
        check = false;
        $('.Txt_SearchWaybillNo').tooltip({
            placement: "top",
            title: "Select Waybill No",
            trigger: "focus"
        });
        $('.Txt_SearchWaybillNo').focus();
    }
    if (!check) {
        return false;
    }
    else {
        return true;
    }
}

function validatePickDelRoute() {
    var check = true;
    if ($('.txtRouteName').val() != '') {
        if ($('.txtTotalDistance').val() != '') {
            var check = true;
        }
        else {
            check = false;
            $('.txtTotalDistance').tooltip({
                placement: "top",
                title: "Enter Distance",
                trigger: "focus"
            });
            $('.txtTotalDistance').focus();
        }
    }
    else {
        check = false;
        $('.txtRouteName').tooltip({
            placement: "top",
            title: "Enter Route Name",
            trigger: "focus"
        });
        $('.txtRouteName').focus();
    }
    if (!check) {
        return false;
    }
    else {
        return true;
    }
}
function validateManifestTranshipment() {
    var check = true;
    if ($('.Txt_Date').val() != '') {
        if ($('.Ddl_Route option:selected').text() != 'SELECT') {
            if ($('.Ddl_Branch option:selected').text() != 'SELECT') {
            if ($('.Txt_Remark').val() != '') {
                var check = true;
            }
            else {
                check = false;
                $('.Txt_Remark').tooltip({
                    placement: "top",
                    title: "Enter Remark",
                    trigger: "focus"
                });
                $('.Txt_Remark').focus();
            }
            }
            else {
                check = false;
                $('.Ddl_Branch').tooltip({
                    placement: "top",
                    title: "Select Branch",
                    trigger: "focus"
                });
                $('.Ddl_Branch').focus();
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
    }
    else {
        check = false;
        $('.Txt_Date').tooltip({
            placement: "top",
            title: "Enter Date",
            trigger: "focus"
        });
        $('.Txt_Date').focus();
    }
    if (!check) {
        return false;
    }
    else {
        return true;
    }
}

function validateGoodReceiptNote() {
    var check = true;
    if ($('.Txt_GrnNo').val() != '') {
        if ($('.Txt_MaterialName').val() != '') {
            if ($('.Txt_PoNo').val() != '') {
                if ($('.Txt_Qty').val() != '') {
                    if ($('.Ddl_Unit option:selected').text() != 'SELECT') {
                          var check = true;
                        }
                        else {
                            check = false;
                            $('.Ddl_Unit').tooltip({
                                placement: "top",
                                title: "Select Unit",
                                trigger: "focus"
                            });
                            $('.Ddl_Unit').focus();
                        }
                    }
                    else {
                        check = false;
                        $('.Txt_Qty').tooltip({
                            placement: "top",
                            title: "Enter Qty",
                            trigger: "focus"
                        });
                        $('.Txt_Qty').focus();
                    }
                }
                else {
                    check = false;
                    $('.Txt_PoNo').tooltip({
                        placement: "top",
                        title: "Enter PO No",
                        trigger: "focus"
                    });
                    $('.Txt_PoNo').focus();
                    }
                }
                else {
                    check = false;
                    $('.Txt_MaterialName').tooltip({
                        placement: "top",
                        title: "Enter Material Name",
                        trigger: "focus"
                    });
                    $('.Txt_MaterialName').focus();
                }
            }
            else {
                check = false;
                $('.Txt_GrnNo').tooltip({
                    placement: "top",
                    title: "Enter GRN No",
                    trigger: "focus"
                });
                $('.Txt_GrnNo').focus();
            }
    if (!check) {
        return false;
    }
    else {
        return true;
    }
}

function validateReverseCustomer() {
    var check = true;
    if ($('.Txt_CCustName').val() != '') {
        if ($('.Ddl_BranchName option:selected').text() != 'SELECT') {
            var check = true;
        }
        else {
            check = false;
            $('.Ddl_BranchName').tooltip({
                placement: "top",
                title: "Select Branch",
                trigger: "focus"
            });
            $('.Ddl_BranchName').focus();
        }
    }
    else {
        check = false;
        $('.Txt_CCustName').tooltip({
            placement: "top",
            title: "Enter Customer Name",
            trigger: "focus"
        });
        $('.Txt_CCustName').focus();
    }
    if (!check) {
        $("#hfSubmit").val(0);
        console.log($("#hfSubmit").val());
        return false;
    }
    else {
        $("#hfSubmit").val(1);
        return true;
        console.log($("#hfSubmit").val());
    }
}

function validateWaybillCancelled() {
    var check = true;
    if ($('.Txt_WaybillNo').val() != '') {
        if ($('.FileUpload').val() != '') {
            if ($('.Txt_Remark').val() != '') {
                var check = true;
            }
            else {
                check = false;
                $('.Txt_Remark').tooltip({
                    placement: "top",
                    title: "Enter Remark",
                    trigger: "focus"
                });
                $('.Txt_Remark').focus();
            }
        }
        else {
            check = false;
            $('.FileUpload').tooltip({
                placement: "top",
                title: "Choose File",
                trigger: "focus"
            });
            $('.FileUpload').focus();
        }
    }
    else {
        check = false;
        $('.Txt_WaybillNo').tooltip({
            placement: "top",
            title: "Enter Waybill No",
            trigger: "focus"
        });
        $('.Txt_WaybillNo').focus();
    }
    if (!check) {
        return false;
    }
    else {
        return true;
    }
}