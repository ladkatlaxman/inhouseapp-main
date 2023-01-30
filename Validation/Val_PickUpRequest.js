function validatePickupRequestDetails() {
    var check = true;
        if (isDate($('.Txt_PickUpDate').val())) {
            if ($('.Ddl_CustomerType option:selected').text() != 'SELECT') {
                if (($('.Txt_CustCode').is(':visible') && $('.Txt_CustCode').val() != '') || ($('.Txt_CustCode').is(':hidden') && $('.Txt_CustCode').val() == '')) {
                    if (($('.Txt_CCustName').is(':visible') && $('.Txt_CCustName').val() != '') || ($('.Txt_CCustName').is(':hidden') && $('.Txt_CCustName').val() == '')) {
                        if (($('.Txt_WCustName').is(':visible') && $('.Txt_WCustName').val() != '') || ($('.Txt_WCustName').is(':hidden') && $('.Txt_WCustName').val() == '')) {
                            if ($('.Txt_CustMobileNo').val() != '') {
                                if ($('.Txt_CustPin').val() != '') {
                                    if ($('.Ddl_CustArea option:selected').text() != 'SELECT') {
                                        if ($('.Txt_CustAdd').val() != '') {
                                            if ($('.Txt_PickPin').val() != '') {
                                                if ($('.Ddl_PickArea option:selected').text() != 'SELECT') {
                                                    if ($('.Txt_PickAdd').val() != '') {
                                                        check = true;
                                                    }
                                                    else {
                                                        check = false;
                                                        $('.Txt_PickAdd').tooltip({
                                                            placement: "top",
                                                            title: "Enter Pickup Address",
                                                            trigger: "focus"
                                                        });
                                                        $('.Txt_PickAdd').focus();
                                                    }
                                                }
                                                else {
                                                    check = false;
                                                    $('.Ddl_PickArea').tooltip({
                                                        placement: "top",
                                                        title: "Select Pickup Area",
                                                        trigger: "focus"
                                                    });
                                                    $('.Ddl_PickArea').focus();
                                                }
                                            }
                                            else {
                                                check = false;
                                                $('.Txt_PickPin').tooltip({
                                                    placement: "top",
                                                    title: "Select Pickup Pincode",
                                                    trigger: "focus"
                                                });
                                                $('.Txt_PickPin').focus();
                                            }
                                        }
                                        else {
                                            check = false;
                                            $('.Txt_CustAdd').tooltip({
                                                placement: "top",
                                                title: "Enter Customer Address",
                                                trigger: "focus"
                                            });
                                            $('.Txt_CustAdd').focus();
                                        }
                                    }
                                    else {
                                        check = false;
                                        $('.Ddl_CustArea').tooltip({
                                            placement: "top",
                                            title: "Select Customer Area",
                                            trigger: "focus"
                                        });
                                        $('.Ddl_CustArea').focus();
                                    }
                                }
                                else {
                                    check = false;
                                    $('.Txt_CustPin').tooltip({
                                        placement: "top",
                                        title: "Select Customer Pincode",
                                        trigger: "focus"
                                    });
                                    $('.Txt_CustPin').focus();
                                }
                            }
                            else {
                                check = false;
                                $('.Txt_CustMobileNo').tooltip({
                                    placement: "top",
                                    title: "Select Customer Contact No",
                                    trigger: "focus"
                                });
                                $('.Txt_CustMobileNo').focus();
                            }
                        }
                        else {
                            check = false;
                            $('.Txt_WCustName').tooltip({
                                placement: "top",
                                title: "Select Customer Name",
                                trigger: "focus"
                            });
                            $('.Txt_WCustName').focus();
                        }
                    }
                    else {
                        check = false;
                        $('.Txt_CCustName').tooltip({
                            placement: "top",
                            title: "Select Customer Name",
                            trigger: "focus"
                        });
                        $('.Txt_CCustName').focus();
                    }
                }
                else {
                    check = false;
                    $('.Txt_CustCode').tooltip({
                        placement: "top",
                        title: "Select Customer Code",
                        trigger: "focus"
                    });
                    $('.Txt_CustCode').focus();
                }
            }
            else {
                check = false;
                $('.Ddl_CustomerType').tooltip({
                    placement: "top",
                    title: "Select Customer Type",
                    trigger: "focus"
                });
                $('.Ddl_CustomerType').focus();
            }
        }
        else {
            check = false;
            $('.Txt_PickUpDate').tooltip({
                placement: "top",
                title: "Enter Date",
                trigger: "focus"
            });
            $('.Txt_PickUpDate').focus();
        }
    if (!check) {
        return false;
    }
    else {
        $("#hfPickReqSubmit").val(1);
        return true;
    }
}

function validateWarehouseWaybillDetails() {
    var check = true;
    var grdv = $("[id*=GV_WaybillDetail]");
  //  var count = parseInt(grdv.rows.length) - 1;    
   // var rowCount = $("[id*=GV_WaybillDetail] td").closest("tr").length;
    if ($('.Txt_WaybillNo').val() != '') {
       // if (isDate($('.Txt_WaybillDate').val())) {
            //if ($('.Ddl_CustomerType option:selected').text() != 'SELECT') {
               // if ($('.Ddl_PaymentMode option:selected').text() != 'SELECT') {
                    if (($('.Txt_CustCode').is(':visible') && $('.Txt_CustCode').val() != '') || ($('.Txt_CustCode').is(':hidden') && $('.Txt_CustCode').val() == '')) {
                        if (($('.Txt_CCustName').is(':visible') && $('.Txt_CCustName').val() != '') || ($('.Txt_CCustName').is(':hidden') && $('.Txt_CCustName').val() == '')) {
                            if (($('.Txt_WCustName').is(':visible') && $('.Txt_WCustName').val() != '') || ($('.Txt_WCustName').is(':hidden') && $('.Txt_WCustName').val() == '')) {
                                if ($('.Txt_CustMobileNo').val() != '') {
                                   // if ($('.Txt_CustPin').val() != '') {
                                    //    if ($('.Ddl_CustArea option:selected').text() != 'SELECT') {
                                         //   if ($('.Txt_CustAdd').val() != '') {
                                                if ($('.Txt_PickPin').val() != '') {
                                                    if ($('.Ddl_PickArea').val() != 0) {
                                                        if ($('.Txt_PickAdd').val() != '') {
                                                            if ($('.Txt_ConsigneeName').val() != '') {
                                                                if ($('.Txt_ConsigneeContNo').val() != '') {
                                                                    if ($('.Txt_DelPin').val() != '') {
                                                                        if ($('.Ddl_DelArea').val() != 0) {
                                                                            if ($('.Txt_DelAdd').val() != '') {                                                                             
                                                                                if ($("[id*=AutoIncementNo]").val() != 0) {
                                                                                    check = true;
                                                                                }
                                                                                else {
                                                                                    check = false;
                                                                                    alert('Enter the details of Material');
                                                                                    $('.Txt_DelAdd').focus();
                                                                                }
                                                                            }
                                                                            else {
                                                                                check = false;
                                                                                $('.Txt_DelAdd').tooltip({
                                                                                    placement: "top",
                                                                                    title: "Enter Delivery Address",
                                                                                    trigger: "focus"
                                                                                });
                                                                                $('.Txt_DelAdd').focus();
                                                                            }
                                                                        }
                                                                        else {
                                                                            check = false;
                                                                            $('.Ddl_DelArea').tooltip({
                                                                                placement: "top",
                                                                                title: "Select Delivery Area",
                                                                                trigger: "focus"
                                                                            });
                                                                            $('.Ddl_DelArea').focus();
                                                                        }
                                                                    }
                                                                    else {
                                                                        check = false;
                                                                        $('.Txt_DelPin').tooltip({
                                                                            placement: "top",
                                                                            title: "Select Delivery Pincode",
                                                                            trigger: "focus"
                                                                        });
                                                                        $('.Txt_DelPin').focus();
                                                                    }
                                                                }
                                                                else {
                                                                    check = false;
                                                                    $('.Txt_ConsigneeContNo').tooltip({
                                                                        placement: "top",
                                                                        title: "Enter Consignee Contact",
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
                                                        }
                                                        else {
                                                            check = false;
                                                            $('.Txt_PickAdd').tooltip({
                                                                placement: "top",
                                                                title: "Enter Pickup Address",
                                                                trigger: "focus"
                                                            });
                                                            $('.Txt_PickAdd').focus();
                                                        }
                                                    }
                                                    else {
                                                        check = false;
                                                        $('.Ddl_PickArea').tooltip({
                                                            placement: "top",
                                                            title: "Select Pickup Area",
                                                            trigger: "focus"
                                                        });
                                                        $('.Ddl_PickArea').focus();
                                                    }
                                                }
                                                else {
                                                    check = false;
                                                    $('.Txt_PickPin').tooltip({
                                                        placement: "top",
                                                        title: "Enter Pickup Pincode",
                                                        trigger: "focus"
                                                    });
                                                    $('.Txt_PickPin').focus();
                                                }
                                            //}
                                            //else {
                                            //    check = false;
                                            //    $('.Txt_CustAdd').tooltip({
                                            //        placement: "top",
                                            //        title: "Enter Customer Address",
                                            //        trigger: "focus"
                                            //    });
                                            //    $('.Txt_CustAdd').focus();
                                            //}
                                    //    }
                                    //    else {
                                    //        check = false;
                                    //        $('.Ddl_CustArea').tooltip({
                                    //            placement: "top",
                                    //            title: "Select Customer Area",
                                    //            trigger: "focus"
                                    //        });
                                    //        $('.Ddl_CustArea').focus();
                                    //    }
                                    //}
                                    //else {
                                    //    check = false;
                                    //    $('.Txt_CustPin').tooltip({
                                    //        placement: "top",
                                    //        title: "Enter Customer Pincode",
                                    //        trigger: "focus"
                                    //    });
                                    //    $('.Txt_CustPin').focus();
                                    //}
                                }
                                else {
                                    check = false;
                                    $('.Txt_CustMobileNo').tooltip({
                                        placement: "top",
                                        title: "Enter Customer Contact No",
                                        trigger: "focus"
                                    });
                                    $('.Txt_CustMobileNo').focus();
                                }
                            }
                            else {
                                check = false;
                                $('.Txt_WCustName').tooltip({
                                    placement: "top",
                                    title: "Enter Customer Name",
                                    trigger: "focus"
                                });
                                $('.Txt_WCustName').focus();
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
                    }
                    else {
                        check = false;
                        $('.Txt_CustCode').tooltip({
                            placement: "top",
                            title: "Enter Customer Code",
                            trigger: "focus"
                        });
                        $('.Txt_CustCode').focus();
                    }
                //}
                //else {
                //    check = false;
                //    $('.Ddl_PaymentMode').tooltip({
                //        placement: "top",
                //        title: "Select Payment Mode",
                //        trigger: "focus"
                //    });
                //    $('.Ddl_PaymentMode').focus();
                //}
        //    }
        //    else {
        //        check = false;
        //        $('.Ddl_CustomerType').tooltip({
        //            placement: "top",
        //            title: "Select Customer Type",
        //            trigger: "focus"
        //        });
        //        $('.Ddl_CustomerType').focus();
        //    }
        //}
    //    else {
    //        check = false;
    //        $('.Txt_WaybillDate').tooltip({
    //            placement: "top",
    //            title: "Enter Date",
    //            trigger: "focus"
    //        });
    //        $('.Txt_WaybillDate').focus();
    //    }
    }
    else {
        check = false;
        $('.Txt_WaybillNo').tooltip({
            placement: "top",
            title: "Enter WaybillNo.",
            trigger: "focus"
        });
        $('.Txt_WaybillNo').focus();
    }
  //  alert(check)
    //if (!check) {
    //    return false;
    //}
    //else {
    //    if ($("[id*=hfWaybillSubmit]").val() == 0)
    //        $("[id*=Btn_AddWaybillItem]").focus();
    //    else
    //        return true;
    //}

    if (!check) {
        $("#hfWaybillSubmit").val(0);
        console.log($("#hfWaybillSubmit").val());
        return false;
    }
    else {
        $("#hfWaybillSubmit").val(1);
        return true;
        console.log($("#hfWaybillSubmit").val());
    }
}

function validateUpdateWarehouseWaybillDetails() {
    var check = true;  
    if ($('.Txt_WaybillNo').val() != '') {
        if (($('.Txt_CustCode').is(':visible') && $('.Txt_CustCode').val() != '') || ($('.Txt_CustCode').is(':hidden') && $('.Txt_CustCode').val() == '')) {
            if (($('.Txt_CCustName').is(':visible') && $('.Txt_CCustName').val() != '') || ($('.Txt_CCustName').is(':hidden') && $('.Txt_CCustName').val() == '')) {
                if (($('.Txt_WCustName').is(':visible') && $('.Txt_WCustName').val() != '') || ($('.Txt_WCustName').is(':hidden') && $('.Txt_WCustName').val() == '')) {
                    if ($('.Txt_CustMobileNo').val() != '') { 
                        if ($('.Txt_PickPin').val() != '') {
                            if ($('.Ddl_PickArea').val() != 0) {
                                if ($('.Txt_PickAdd').val() != '') {
                                    if ($('.Txt_ConsigneeName').val() != '') {
                                        if ($('.Txt_ConsigneeContNo').val() != '') {
                                            if ($('.Txt_DelPin').val() != '') {
                                                if ($('.Ddl_DelArea').val() != 0) {
                                                    if ($('.Txt_DelAdd').val() != '') {
                                                        check = true;
                                                    }
                                                    else {
                                                        check = false;
                                                        $('.Txt_DelAdd').tooltip({
                                                            placement: "top",
                                                            title: "Enter Delivery Address",
                                                            trigger: "focus"
                                                        });
                                                        $('.Txt_DelAdd').focus();
                                                    }
                                                }
                                                else {
                                                    check = false;
                                                    $('.Ddl_DelArea').tooltip({
                                                        placement: "top",
                                                        title: "Select Delivery Area",
                                                        trigger: "focus"
                                                    });
                                                    $('.Ddl_DelArea').focus();
                                                }
                                            }
                                            else {
                                                check = false;
                                                $('.Txt_DelPin').tooltip({
                                                    placement: "top",
                                                    title: "Select Delivery Pincode",
                                                    trigger: "focus"
                                                });
                                                $('.Txt_DelPin').focus();
                                            }
                                        }
                                        else {
                                            check = false;
                                            $('.Txt_ConsigneeContNo').tooltip({
                                                placement: "top",
                                                title: "Enter Consignee Contact",
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
                                }
                                else {
                                    check = false;
                                    $('.Txt_PickAdd').tooltip({
                                        placement: "top",
                                        title: "Enter Pickup Address",
                                        trigger: "focus"
                                    });
                                    $('.Txt_PickAdd').focus();
                                }
                            }
                            else {
                                check = false;
                                $('.Ddl_PickArea').tooltip({
                                    placement: "top",
                                    title: "Select Pickup Area",
                                    trigger: "focus"
                                });
                                $('.Ddl_PickArea').focus();
                            }
                        }
                        else {
                            check = false;
                            $('.Txt_PickPin').tooltip({
                                placement: "top",
                                title: "Enter Pickup Pincode",
                                trigger: "focus"
                            });
                            $('.Txt_PickPin').focus();
                        }
                      
                    }
                    else {
                        check = false;
                        $('.Txt_CustMobileNo').tooltip({
                            placement: "top",
                            title: "Enter Customer Contact No",
                            trigger: "focus"
                        });
                        $('.Txt_CustMobileNo').focus();
                    }
                }
                else {
                    check = false;
                    $('.Txt_WCustName').tooltip({
                        placement: "top",
                        title: "Enter Customer Name",
                        trigger: "focus"
                    });
                    $('.Txt_WCustName').focus();
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
        }
        else {
            check = false;
            $('.Txt_CustCode').tooltip({
                placement: "top",
                title: "Enter Customer Code",
                trigger: "focus"
            });
            $('.Txt_CustCode').focus();
        }
      
    }
    else {
        check = false;
        $('.Txt_WaybillNo').tooltip({
            placement: "top",
            title: "Enter WaybillNo.",
            trigger: "focus"
        });
        $('.Txt_WaybillNo').focus();
    }
   
    if (!check) {
        $("#hfWaybillUpdate").val(0);
        console.log($("#hfWaybillUpdate").val());
        return false;
    }
    else {
        $("#hfWaybillUpdate").val(1);
        return true;
        console.log($("#hfWaybillUpdate").val());
    }
}

function validatePickupRequestMaterialDetails() {
    var check = true;
    if ($('.Txt_MaterialType').val() != 'SELECT') {
        if ($('.Txt_PackageType').val() != 'SELECT') {
            if ($('.Ddl_Unit option:selected').text() != 'SELECT') {
                if ($('.Txt_Length').val() != '') {
                    if ($('.Txt_Breadth').val() != '') {
                        if ($('.Txt_Height').val() != '') {
                            if ($('.Txt_CFT').val() != '') {
                                if ($('.Txt_ActWeight').val() != '') {
                                    if ($('.Txt_NoOfPackage').val() != '') {
                                        check = true;
                                    }
                                    else {
                                        check = false;
                                        $('.Txt_NoOfPackage').tooltip({
                                            placement: "top",
                                            title: "Enter No Of Package",
                                            trigger: "focus"
                                        });
                                        $('.Txt_NoOfPackage').focus();
                                    }
                                }
                                else {
                                    check = false;
                                    $('.Txt_ActWeight').tooltip({
                                        placement: "top",
                                        title: "Enter Actual Weight",
                                        trigger: "focus"
                                    });
                                    $('.Txt_ActWeight').focus();
                                }
                            }
                            else {
                                check = false;
                                $('.Txt_CFT').tooltip({
                                    placement: "top",
                                    title: "Enter CFT",
                                    trigger: "focus"
                                });
                                $('.Txt_CFT').focus();
                            }
                        }
                        else {
                            check = false;
                            $('.Txt_Height').tooltip({
                                placement: "top",
                                title: "Enter Height",
                                trigger: "focus"
                            });
                            $('.Txt_Height').focus();
                        }
                    }
                    else {
                        check = false;
                        $('.Txt_Breadth').tooltip({
                            placement: "top",
                            title: "Enter Breadth",
                            trigger: "focus"
                        });
                        $('.Txt_Breadth').focus();
                    }
                }
                else {
                    check = false;
                    $('.Txt_Length').tooltip({
                        placement: "top",
                        title: "Enter Length",
                        trigger: "focus"
                    });
                    $('.Txt_Length').focus();
                }
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
            $('.Txt_PackageType').tooltip({
                placement: "top",
                title: "Select Package type",
                trigger: "focus"
            });
            $('.Txt_PackageType').focus();
        }
    }
    else {
        check = false;
        $('.Txt_MaterialType').tooltip({
            placement: "top",
            title: "Select Material type",
            trigger: "focus"
        });
        $('.Txt_MaterialType').focus();
    }

    if (!check) {
        $("#hfAddPickReqItem").val(0);
        console.log($("#hfAddPickReqItem").val());
        return false;
    }
    else {
        $("#hfAddPickReqItem").val(1);
        return true;
        console.log($("#hfAddPickReqItem").val());
    }
}

function validateRate() {
    var check = true;
    if ($('.Txt_RateType').val() != '') {
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
        $('.Txt_RateType').tooltip({
            placement: "top",
            title: "Select Rate Type",
            trigger: "focus"
        });
        $('.Txt_RateType').focus();
    }
    if (!check) {
        $("#hfAddRate").val(0);
        console.log($("#hfAddRate").val());
        return false;
    }
    else {
        $("#hfAddRate").val(1);
        return true;
        console.log($("#hfAddRate").val());
    }

}

function validateWareHouseWaybillMaterialDetails() {
    var check = true;
    if ($('.Txt_MaterialType').val() != '') {
        if ($('.Txt_PackageType').val() != '') {
            if ($('.Ddl_Unit option:selected').text() != 'SELECT') {
                if ($('.Txt_Length').val() != '') {
                    if ($('.Txt_Breadth').val() != '') {
                        if ($('.Txt_Height').val() != '') {
                            if ($('.Txt_CFT').val() != '') {
                                if ($('.Txt_ActWeight').val() != '') {
                                    if ($('.Txt_ChargeWeight').val() != '') {
                                        if ($('.Txt_NoOfPackage').val() != '') {
                                            if ($('.Txt_NoOfInnerPakage').val() != '') {
                                                if ($('.Txt_InvoiceNo').val() != '') {
                                                    if (isDate($('.Txt_InvoiceDate').val())) {
                                                        if ($('.Txt_InvoiceValue').val() != '') {
                                                            if ($('.Txt_EWaybillNo').val() != '') {
                                                                check = true;
                                                            }
                                                            else {
                                                                check = false;
                                                                $('.Txt_EWaybillNo').tooltip({
                                                                    placement: "top",
                                                                    title: "Enter E-WaybillNo",
                                                                    trigger: "focus"
                                                                });
                                                                $('.Txt_EWaybillNo').focus();
                                                            }
                                                        }
                                                        else {
                                                            check = false;
                                                            $('.Txt_InvoiceValue').tooltip({
                                                                placement: "top",
                                                                title: "Enter Invoice Value",
                                                                trigger: "focus"
                                                            });
                                                            $('.Txt_InvoiceValue').focus();
                                                        }
                                                    }
                                                    else {
                                                        check = false;
                                                        $('.Txt_InvoiceDate').tooltip({
                                                            placement: "top",
                                                            title: "Select Invoice Date",
                                                            trigger: "focus"
                                                        });
                                                        $('.Txt_InvoiceDate').focus();
                                                    }
                                                }
                                                else {
                                                    check = false;
                                                    $('.Txt_InvoiceNo').tooltip({
                                                        placement: "top",
                                                        title: "Enter Invoice No",
                                                        trigger: "focus"
                                                    });
                                                    $('.Txt_InvoiceNo').focus();
                                                }
                                            }
                                            else {
                                                check = false;
                                                $('.Txt_NoOfInnerPakage').tooltip({
                                                    placement: "top",
                                                    title: "Enter No Of Inner Package",
                                                    trigger: "focus"
                                                });
                                                $('.Txt_NoOfInnerPakage').focus();
                                            }
                                        }
                                        else {
                                            check = false;
                                            $('.Txt_NoOfPackage').tooltip({
                                                placement: "top",
                                                title: "Enter No Of Package",
                                                trigger: "focus"
                                            });
                                            $('.Txt_NoOfPackage').focus();
                                        }
                                    }
                                    else {
                                        check = false;
                                        $('.Txt_ChargeWeight').tooltip({
                                            placement: "top",
                                            title: "Enter charge Weight",
                                            trigger: "focus"
                                        });
                                        $('.Txt_ChargeWeight').focus();
                                    }
                                }
                                else {
                                    check = false;
                                    $('.Txt_ActWeight').tooltip({
                                        placement: "top",
                                        title: "Enter Actual Weight",
                                        trigger: "focus"
                                    });
                                    $('.Txt_ActWeight').focus();
                                }
                            }
                            else {
                                check = false;
                                $('.Txt_CFT').tooltip({
                                    placement: "top",
                                    title: "Enter CFT",
                                    trigger: "focus"
                                });
                                $('.Txt_CFT').focus();
                            }
                        }
                        else {
                            check = false;
                            $('.Txt_Height').tooltip({
                                placement: "top",
                                title: "Enter Height",
                                trigger: "focus"
                            });
                            $('.Txt_Height').focus();
                        }
                    }
                    else {
                        check = false;
                        $('.Txt_Breadth').tooltip({
                            placement: "top",
                            title: "Enter Breadth",
                            trigger: "focus"
                        });
                        $('.Txt_Breadth').focus();
                    }
                }
                else {
                    check = false;
                    $('.Txt_Length').tooltip({
                        placement: "top",
                        title: "Enter Length",
                        trigger: "focus"
                    });
                    $('.Txt_Length').focus();
                }
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
            $('.Txt_PackageType').tooltip({
                placement: "top",
                title: "Select Package type",
                trigger: "focus"
            });
            $('.Txt_PackageType').focus();
        }
    }
    else {
        check = false;
        $('.Txt_MaterialType').tooltip({
            placement: "top",
            title: "Select Material type",
            trigger: "focus"
        });
        $('.Txt_MaterialType').focus();
    }

    if (!check) {
        $("#hfAddWaybillItem").val(0);
        console.log($("#hfAddWaybillItem").val());
        return false;
    }
    else {
        $("#hfAddWaybillItem").val(1);
        return true;
        console.log($("#hfAddWaybillItem").val());
    }
}

function validateWareHouseWaybillMaterialDetails1() {
    var check = true;
    if ($('.Txt_MatType1').val() != '') {
        if ($('.Txt_PackType1').val() != '') {
            if ($('.Ddl_EditUnit option:selected').text() != 'SELECT') {
                if ($('.Txt_EditLength').val() != '') {
                    if ($('.Txt_EditBreadth').val() != '') {
                        if ($('.Txt_EditHeight').val() != '') {
                            if ($('.Txt_EditCFT').val() != '') {
                                if ($('.Txt_EditActWeight').val() != '') {
                                    if ($('.Txt_EditChrgWeight').val() != '') {
                                        if ($('.Txt_EditNoOfPackage').val() != '') {
                                            if ($('.Txt_EditNoOfInnerPakage').val() != '') {
                                                if ($('.Txt_EditInvoiceNo').val() != '') {
                                                    if (isDate($('.Txt_EditInvoiceDate').val())) {
                                                        if ($('.Txt_EditInvoiceValue').val() != '') {
                                                            if ($('.Txt_EditEWaybillNo').val() != '') {
                                                                check = true;
                                                            }
                                                            else {
                                                                check = false;
                                                                $('.Txt_EditEWaybillNo').tooltip({
                                                                    placement: "top",
                                                                    title: "Enter E-WaybillNo",
                                                                    trigger: "focus"
                                                                });
                                                                $('.Txt_EditEWaybillNo').focus();
                                                            }
                                                        }
                                                        else {
                                                            check = false;
                                                            $('.Txt_EditInvoiceValue').tooltip({
                                                                placement: "top",
                                                                title: "Enter Invoice Value",
                                                                trigger: "focus"
                                                            });
                                                            $('.Txt_EditInvoiceValue').focus();
                                                        }
                                                    }
                                                    else {
                                                        check = false;
                                                        $('.Txt_EditInvoiceDate').tooltip({
                                                            placement: "top",
                                                            title: "Select Invoice Date",
                                                            trigger: "focus"
                                                        });
                                                        $('.Txt_EditInvoiceDate').focus();
                                                    }
                                                }
                                                else {
                                                    check = false;
                                                    $('.Txt_EditInvoiceNo').tooltip({
                                                        placement: "top",
                                                        title: "Enter Invoice No",
                                                        trigger: "focus"
                                                    });
                                                    $('.Txt_EditInvoiceNo').focus();
                                                }
                                            }
                                            else {
                                                check = false;
                                                $('.Txt_EditNoOfInnerPakage').tooltip({
                                                    placement: "top",
                                                    title: "Enter No Of Inner Package",
                                                    trigger: "focus"
                                                });
                                                $('.Txt_EditNoOfInnerPakage').focus();
                                            }
                                        }
                                        else {
                                            check = false;
                                            $('.Txt_EditNoOfPackage').tooltip({
                                                placement: "top",
                                                title: "Enter No Of Package",
                                                trigger: "focus"
                                            });
                                            $('.Txt_EditNoOfPackage').focus();
                                        }
                                    }
                                    else {
                                        check = false;
                                        $('.Txt_EditChrgWeight').tooltip({
                                            placement: "top",
                                            title: "Enter charge Weight",
                                            trigger: "focus"
                                        });
                                        $('.Txt_EditChrgWeight').focus();
                                    }
                                }
                                else {
                                    check = false;
                                    $('.Txt_EditActWeight').tooltip({
                                        placement: "top",
                                        title: "Enter Actual Weight",
                                        trigger: "focus"
                                    });
                                    $('.Txt_EditActWeight').focus();
                                }
                            }
                            else {
                                check = false;
                                $('.EditTxt_CFT').tooltip({
                                    placement: "top",
                                    title: "Enter CFT",
                                    trigger: "focus"
                                });
                                $('.EditTxt_CFT').focus();
                            }
                        }
                        else {
                            check = false;
                            $('.Txt_EditHeight').tooltip({
                                placement: "top",
                                title: "Enter Height",
                                trigger: "focus"
                            });
                            $('.Txt_EditHeight').focus();
                        }
                    }
                    else {
                        check = false;
                        $('.Txt_EditBreadth').tooltip({
                            placement: "top",
                            title: "Enter Breadth",
                            trigger: "focus"
                        });
                        $('.Txt_EditBreadth').focus();
                    }
                }
                else {
                    check = false;
                    $('.Txt_EditLength').tooltip({
                        placement: "top",
                        title: "Enter Length",
                        trigger: "focus"
                    });
                    $('.Txt_EditLength').focus();
                }
            }
            else {
                check = false;
                $('.Ddl_EditUnit').tooltip({
                    placement: "top",
                    title: "Select Unit",
                    trigger: "focus"
                });
                $('.Ddl_EditUnit').focus();
            }
        }
        else {
            check = false;
            $('.Txt_PackType1').tooltip({
                placement: "top",
                title: "Select Package type",
                trigger: "focus"
            });
            $('.Txt_PackType1').focus();
        }
    }
    else {
        check = false;
        $('.Txt_MatType1').tooltip({
            placement: "top",
            title: "Select Material type",
            trigger: "focus"
        });
        $('.Txt_MatType1').focus();
    }

    if (!check) {
        $("#hfMaterialUpdate").val(0);
        console.log($("#hfMaterialUpdate").val());
        return false;
    }
    else {
        $("#hfMaterialUpdate").val(1);
        return true;
        console.log($("#hfMaterialUpdate").val());
    }
}

function validatePickupRequestConsignorDetails() {
    var check = true;
    if ($('.Txt_PopupConsignorName').val() != '') {
        if ($('.Txt_PopupContactNo').val() != '') {
            if ($('.Txt_PopupConsignorPincode').val() != '') {
                if ($('.Txt_PopupConsignorArea').val() != '') {
                    if ($('.Txt_PopupConsignorAddress').val() != '') {
                        if ($('.Txt_PopupConsignorGST').val() != '') {
                            check = true;
                        }
                        else {
                            check = false;
                            $('.Txt_PopupConsignorGST').tooltip({
                                placement: "top",
                                title: "Enter GST No",
                                trigger: "focus"
                            });
                            $('.Txt_PopupConsignorGST').focus();
                        }
                    }
                    else {
                        check = false;
                        $('.Txt_PopupConsignorAddress').tooltip({
                            placement: "top",
                            title: "Enter Address",
                            trigger: "focus"
                        });
                        $('.Txt_PopupConsignorAddress').focus();
                    }
                }
                else {
                    check = false;
                    $('.Txt_PopupConsignorArea').tooltip({
                        placement: "top",
                        title: "Enter Area",
                        trigger: "focus"
                    });
                    $('.Txt_PopupConsignorArea').focus();
                }
            }
            else {
                check = false;
                $('.Txt_PopupConsignorPincode').tooltip({
                    placement: "top",
                    title: "Enter Pincode",
                    trigger: "focus"
                });
                $('.Txt_PopupConsignorPincode').focus();
            }
        }
        else {
            check = false;
            $('.Txt_PopupContactNo').tooltip({
                placement: "top",
                title: "Enter Contact No",
                trigger: "focus"
            });
            $('.Txt_PopupContactNo').focus();
        }
    }
    else {
        check = false;
        $('.Txt_PopupConsignorName').tooltip({
            placement: "top",
            title: "Enter Consignor Name",
            trigger: "focus"
        });
        $('.Txt_PopupConsignorName').focus();
    }

    if (!check) {
        $("#hfPopupConsignorSubmit").val(0);
        console.log($("#hfPopupConsignorSubmit").val());
        return false;
    }
    else {
        $("#hfPopupConsignorSubmit").val(1);
        return true;
        console.log($("#hfPopupConsignorSubmit").val());
    }
}

function validatePickupRequestConsigneeDetails() {
    var check = true;
    if ($('.Txt_PopConsigneeName').val() != '') {
        if ($('.Txt_PopConsigneeContactNo').val() != '') {
            if ($('.Txt_PopConsigneePincode').val() != '') {
                if ($('.Txt_PopConsigneeArea').val() != '') {
                    if ($('.Txt_popConsigneeAddress').val() != '') {
                        if ($('.Txt_PopGSTNoOfConsignee').val() != '') {
                            check = true;
                        }
                        else {
                            check = false;
                            $('.Txt_PopGSTNoOfConsignee').tooltip({
                                placement: "top",
                                title: "Enter GST No",
                                trigger: "focus"
                            });
                            $('.Txt_PopGSTNoOfConsignee').focus();
                        }
                    }
                    else {
                        check = false;
                        $('.Txt_popConsigneeAddress').tooltip({
                            placement: "top",
                            title: "Enter Address",
                            trigger: "focus"
                        });
                        $('.Txt_popConsigneeAddress').focus();
                    }
                }
                else {
                    check = false;
                    $('.Txt_PopConsigneeArea').tooltip({
                        placement: "top",
                        title: "Enter Area",
                        trigger: "focus"
                    });
                    $('.Txt_PopConsigneeArea').focus();
                }
            }
            else {
                check = false;
                $('.Txt_PopConsigneePincode').tooltip({
                    placement: "top",
                    title: "Enter Pincode",
                    trigger: "focus"
                });
                $('.Txt_PopConsigneePincode').focus();
            }
        }
        else {
            check = false;
            $('.Txt_PopConsigneeContactNo').tooltip({
                placement: "top",
                title: "Enter Contact No",
                trigger: "focus"
            });
            $('.Txt_PopConsigneeContactNo').focus();
        }
    }
    else {
        check = false;
        $('.Txt_PopConsigneeName').tooltip({
            placement: "top",
            title: "Enter Consignee Name",
            trigger: "focus"
        });
        $('.Txt_PopConsigneeName').focus();
    }

    if (!check) {
        $("#hfConsigneeSubmit").val(0);
        console.log($("#hfConsigneeSubmit").val());
        return false;
    }
    else {
        $("#hfConsigneeSubmit").val(1);
        return true;
        console.log($("#hfConsigneeSubmit").val());
    }
}

function validateFreeWaybillDetails() {
    var check = true;
    if ($('.Txt_WaybillNo').val() != '') {
        if ($('.Txt_WaybillDate').val() != '') {
            if ($('.Txt_DeliveryBranch').val() != '') {
                if ($('.Txt_Remark').val() != '') {
                    check = true;
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
                $('.Txt_DeliveryBranch').tooltip({
                    placement: "top",
                    title: "Select Branch",
                    trigger: "focus"
                });
                $('.Txt_DeliveryBranch').focus();
            }
        }
        else {
            check = false;
            $('.Txt_WaybillDate').tooltip({
                placement: "top",
                title: "Enter Date",
                trigger: "focus"
            });
            $('.Txt_WaybillDate').focus();
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
        $("#hfWaybillSubmit").val(0);
        console.log($("#hfWaybillSubmit").val());
        return false;
    }
    else {
        $("#hfWaybillSubmit").val(1);
        return true;
        console.log($("#hfWaybillSubmit").val());
    }
}

function validateDEPSDetails() {
    var check = true;
    if ($('.Ddl_WaybillItemID option:selected').text() != 'SELECT') {
        if ($('.Ddl_DepsType option:selected').text() != 'SELECT') {       
                if ($('.Txt_DepsQty').val() != '') {
                    if ($('.Txt_Remark').val() != '') {
                        check = true;
                    }
                    else {
                        check = false;
                        $('.Txt_Remark').tooltip({
                            placement: "top",
                            title: "Enter DEPS Remark",
                            trigger: "focus"
                        });
                        $('.Txt_Remark').focus();
                    }
                }
                else {
                    check = false;
                    $('.Txt_DepsQty').tooltip({
                        placement: "top",
                        title: "Enter DEPS Qty",
                        trigger: "focus"
                    });
                    $('.Txt_DepsQty').focus();
                }
           
        }
        else {
            check = false;
            $('.Ddl_DepsType').tooltip({
                placement: "top",
                title: "Select Type",
                trigger: "focus"
            });
            $('.Ddl_DepsType').focus();
        }
    }
    else {
        check = false;
        $('.Ddl_WaybillItemID').tooltip({
            placement: "top",
            title: "Select Sr.No",
            trigger: "focus"
        });
        $('.Ddl_WaybillItemID').focus();
    }

    if (!check) {
        $("#hfDEPSSubmit").val(0);
        console.log($("#hfDEPSSubmit").val());
        return false;
    }
    else {
        $("#hfDEPSSubmit").val(1);
        return true;
        console.log($("#hfDEPSSubmit").val());
    }
}

function isDate(txtDate) {
    var currVal = txtDate;
    if (currVal == '')
        return false;
    //Declare Regex 
    var rxDatePattern = /^(\d{1,2})(\/|-)(\d{1,2})(\/|-)(\d{4})$/;
    var dtArray = currVal.match(rxDatePattern); // is format OK?
    if (dtArray == null)
        return false;
    //Checks for dd/mm/yyyy format.
    dtDay = dtArray[1];
    dtMonth = dtArray[3];
    dtYear = dtArray[5];
    if (dtDay < 1 || dtDay > 31)
        return false;
    else if (dtMonth < 1 || dtMonth > 12)
        return false;
    else if ((dtMonth == 4 || dtMonth == 6 || dtMonth == 9 || dtMonth == 11) && dtDay == 31)
        return false;
    else if (dtMonth == 2) {
        var isleap = (dtYear % 4 == 0 && (dtYear % 100 != 0 || dtYear % 400 == 0));
        if (dtDay > 29 || (dtDay == 29 && !isleap))
            return false;
    }
    return true;
}
